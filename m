Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47461218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfCNQnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:43:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbfCNQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C784AD78;
        Thu, 14 Mar 2019 16:43:49 +0000 (UTC)
Date:   Thu, 14 Mar 2019 09:43:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Using XArray to manage the VMA
Message-ID: <20190314164343.owsgnldxk7qr363q@linux-r8p5>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
References: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
 <20190313210603.fguuxu3otj5epk3q@linux-r8p5>
 <20190314023910.GL19508@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190314023910.GL19508@bombadil.infradead.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, Matthew Wilcox wrote:

>It's probably worth listing the advantages of the Maple Tree over the
>rbtree.

I'm not familiar with maple trees, are they referred to by another name?
(is this some sort of B-tree?). Google just shows me real trees.

>
> - Shallower tree.  A 1000-entry rbtree is 10 levels deep.  A 1000-entry
>   Maple Tree is 5 levels deep (I did a more detailed analysis in an
>   earlier email thread with Laurent and I can present it if needed).

I'd be interested in reading on that.

> - O(1) prev/next
> - Lookups under the RCU lock
>
>There're some second-order effects too; by using externally allocated
>nodes, we avoid disturbing other VMAs when inserting/deleting, and we
>avoid bouncing cachelines around (eg the VMA which happens to end up
>at the head of the tree is accessed by every lookup in the tree because
>it's on the way to every other node).

How would maple trees deal with the augmented vma tree (vma gaps) trick
we use to optimize get_unmapped_area?

Thanks,
Davidlohr
