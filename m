Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA7AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E0320651
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="obDt0O3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCNCjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:39:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfCNCjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WrV/l3y03S7xRIJhtjzGGZQ2l0CIcACK9FVzXe701Bc=; b=obDt0O3TpgUPyGNDmJ9iJqqEB
        Ssi+k202lcjhiehZWxX6ofSRKAMJy7HQVlD1/2RP5fR7Q7CL/TD1bvRuRyq7rczg1chAeFMJNxAlp
        bv4J67NCThJ58mI6SQex2asFuz54u3NkLQuRvk6UC55pgP440mcY4M6CTPnBvby6v4fYMaVHg9nX4
        jHgIfYuc6REF//krysmYpyhtl1KElDNpxNnQdoPg9rQrDALsOqKD67dlLYZeQ325LsaGp2kuLjYEk
        ewCWLYjdGa9bFQ7kbQiy+0UDBlnUTflaAyZ6kSby8rTsWBqu0ezgj1XEPVdQdD434VA8aO/UInC3o
        hCCzu11Tg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4GH0-0000H1-AO; Thu, 14 Mar 2019 02:39:10 +0000
Date:   Wed, 13 Mar 2019 19:39:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Using XArray to manage the VMA
Message-ID: <20190314023910.GL19508@bombadil.infradead.org>
References: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
 <20190313210603.fguuxu3otj5epk3q@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313210603.fguuxu3otj5epk3q@linux-r8p5>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 02:06:03PM -0700, Davidlohr Bueso wrote:
> On Wed, 13 Mar 2019, Laurent Dufour wrote:
> > If this is not too late and if there is still place available, I would
> > like to attend the MM track and propose a topic about using the XArray
> > to replace the VMA's RB tree and list.
> > 
> > Using the XArray in place of the VMA's tree and list seems to be a first
> > step to the long way of removing/replacing the mmap_sem.
> 
> So threaded (not as in threads of execution) rbtrees are another
> alternative to deal with the two data structure approach we currently
> have. Having O(1) rb_prev/next() calls allows us to basically get rid of
> the vma list at the cost of an extra check for each node we visit on
> the way down when inserting.

It's probably worth listing the advantages of the Maple Tree over the
rbtree.

 - Shallower tree.  A 1000-entry rbtree is 10 levels deep.  A 1000-entry
   Maple Tree is 5 levels deep (I did a more detailed analysis in an
   earlier email thread with Laurent and I can present it if needed).
 - O(1) prev/next
 - Lookups under the RCU lock

There're some second-order effects too; by using externally allocated
nodes, we avoid disturbing other VMAs when inserting/deleting, and we
avoid bouncing cachelines around (eg the VMA which happens to end up
at the head of the tree is accessed by every lookup in the tree because
it's on the way to every other node).
