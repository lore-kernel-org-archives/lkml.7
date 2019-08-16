Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402F2C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177EA206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lHz/ftXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfHPHDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:03:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60984 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPHDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RiKMgeFFBMknWAE5Nu1DMr6YvjPNtVHyNTev2PNm+yw=; b=lHz/ftXALZz1au8/ITd1rigxY
        Wb1Fol8/WiW9eKEENJu5jAcC9TpHvsBPzscJAhfuSSqIb+t68bGQShJohuQ7ITj/7qJaX3FpuG1y8
        2UtWm++Xs6WVNYVof/Wn/mQW+bnnjqowpiDExca6WxuYbWdiwWeVyXuQaTzUuucsY/cPxPD+dhhm/
        M3qtRkv5Q7XOTlq1CRvPP/BCNuri+TEnaGI2q/9fbWcXYIj3jPymWLw9pa/ER+vYUG9I2owBEwcdk
        75nP00P8Xa56jwJXjOdoz4//Ih9HKLn3stGTWuHkGQG5OWsgIP6TMPX4xB290rsqYeLwJB4Y+vWN2
        v1MMS/2Og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hyWH6-0003f7-95; Fri, 16 Aug 2019 07:03:48 +0000
Date:   Fri, 16 Aug 2019 00:03:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Message-ID: <20190816070348.GA13766@infradead.org>
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565868537-17753-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 07:28:57PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> Implement the following apis to meet usage in different scenarios.
> 
>  - ioremap          (NonCache + StrongOrder)
>  - ioremap_nocache  (NonCache + StrongOrder)
>  - ioremap_wc       (NonCache + WeakOrder  )
>  - ioremap_cache    (   Cache + WeakOrder  )
> 
> Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.

Looks generally fine, but two comments:

 - do you have a need for ioremap_cache?  We are generally try to
   phase it out in favour of memremap, and it is generally only used
   by arch specific code.
 - I have a big series pending to clean up the mess with our
   ioremap_* functions, including adding a generic implementation
   that csky should be able to use.  Unless this patch is urgent it
   might make sense to rebase it on top.  Here is my current tree, I
   plan to post it soon:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
