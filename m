Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24DCC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF552177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PbNod2a6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfCMSBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:01:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCMSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FLtnEhcZitgPrumTgx6A1mOi4wgkfJ/JfwJzueYQV10=; b=PbNod2a6s0twimut9yz4LCuuG
        3Gkxl2AugBv1zrAJBE2wrCq/aw6tUjEciElAs2Nv0Z88sh1Eed8kxDyRCrbrsEAS+LiA2gUwSBmyH
        bZTbGpAx15k1rx6tkVKl0aLfnwJrWMKAmJh5GZaAWI5QGFY+Dks2ss7DT1cFoEHodWNH7MWUFi3XF
        eFPenKgy/SJSph/gqVQlBkszagqB7svzNjQy5Mt5XYtTCbE/svYZQfC6KtBBhAjbcKDUNN+Tto4HN
        h7VSmL9pOJFpT4QT2e6gaU7/owcrnfk9q59XmTbDltmoJRJ1KMEiryCyzNUtMMnGptq5rY6WqZzWo
        SDddJUKgg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h48CF-0005k5-Cu; Wed, 13 Mar 2019 18:01:43 +0000
Date:   Wed, 13 Mar 2019 11:01:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: Re: [LSF/MM TOPIC] Using XArray to manage the VMA
Message-ID: <20190313180142.GK19508@bombadil.infradead.org>
References: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:10:14PM +0100, Laurent Dufour wrote:
> If this is not too late and if there is still place available, I would like
> to attend the MM track and propose a topic about using the XArray to replace
> the VMA's RB tree and list.

If there isn't room on the schedule, then Laurent and I are definitely
going to sneak off and talk about this ourselves at some point.  Having a
high-bandwidth conversation about this is going to be really important
for us, and I think having other people involved would be good.

If there're still spots, it'd be good to have Liam Howlett join us.
He's doing the actual writing-of-code for the Maple Tree at the moment
(I did some earlier on, but recent commits are all him).

> Using the XArray in place of the VMA's tree and list seems to be a first
> step to the long way of removing/replacing the mmap_sem.
> However, there are still corner cases to address like the VMA splitting and
> merging which may raise some issue. Using the XArray's specifying locking
> would not be enough to handle the memory management, and additional fine
> grain locking like a per VMA one could be studied, leading to further
> discussion about the merging of the VMA.
> 
> In addition, here are some topics I'm interested in:
> - Test cases to choose for demonstrating mm features or fixing mm bugs
> proposed by Balbir Singh
> - mm documentation proposed by Mike Rapoport
> 
> Laurent.
> 
