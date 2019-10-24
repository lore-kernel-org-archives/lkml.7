Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE895CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815A521655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muXJTiUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437851AbfJXHDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:03:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXHDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CgLjd+bfjE9VsjFb6HX1AhNT+XQoqxuPeqHBkIlr6Mw=; b=muXJTiUy0SyVcz+NhNkswl/+C
        sfZJK0tqqKyzKPyiJLdLo3VpXIMPBMWohxvChk7p1dtklD2KwcX3I0A8Ya4GrFDMsPM5aW/jrsWL/
        /zUUNla1wdPgRVIWCCnhzP13SPz2fDfFwxi2/4TPs26OAbbGb38aLxXjuJOSNKiMKe1iqkWKwRixz
        RBrn23N25+UDvEM/gAurdR4U4F0OTBGcmiZIy4YgzzrEdHqrUhrONgrw84pTvQ6S9duAiGu0jiR31
        ckrGNOSysflO6RrugO2DQSvQS9Y4+DgAW4rWF+9qbRL+Hwyc2tCLPC7w+2JS6ASoK08AuijS9t6Il
        /Oa2zbA8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNX9L-0004MN-If; Thu, 24 Oct 2019 07:03:11 +0000
Date:   Thu, 24 Oct 2019 00:03:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        alan.mikhak@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net
Subject: Re: [PATCH] irqchip: Skip contexts other supervisor in plic_init()
Message-ID: <20191024070311.GA16652@infradead.org>
References: <alpine.DEB.2.21.9999.1910231152580.16536@viisi.sifive.com>
 <mhng-aefb3209-29c4-46db-8cf2-e12db46d9a6e@palmer-si-x1c4>
 <20191024013019.GA675@infradead.org>
 <20191024075116.48055961@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024075116.48055961@why>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 07:51:16AM +0100, Marc Zyngier wrote:
> > > > Will this need to change for RISC-V M-mode Linux support?
> > > > 
> > > > https://lore.kernel.org/linux-riscv/20191017173743.5430-1-hch@lst.de/  
> > > 
> > > Yes.  
> > 
> > For M-mode we'll want to check IRQ_M_EXT above.  So we should just
> > merge this patch ASAP and then for my rebased M-mode series I'll
> > fix the check to do that for the M-Mode case, which is much cleaner
> > than my hack.
> 
> Does this need to be taken as a fix, potentially Cc to stable? Or is
> that 5.5 material?

So I though that the S-mode context were kinda aways to be sorted before
M-mode, but I can't find anything guranteeing it.  So I think this
actually is a fix, and getting this queued up in the next -rc would
really help me with the nommu stuff - otherwise we'd need to take it
through the riscv tree for 5.5 to avoid conflicts.

Btw, here is my:

Reviewed-by: Christoph Hellwig <hch@lst.de>

for the patch.
