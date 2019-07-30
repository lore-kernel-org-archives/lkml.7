Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0F6C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE0E206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="II2UQgX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfG3LCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:02:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56952 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3LCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Evoy48nmtUEP14ctAQrisi69YEAvFPcmML655E68VU=; b=II2UQgX8QgyPk2rVNFmil7JY1
        uB8ScT1LS9EKcqeuufjFZPGQHBCGq5NDRxZBJBaXqCQ/bj016eTD91oTWLkSHmPkt2E0CxcGMeSDz
        N0AdSJpiaJScXQ2RHpOC6IvlTccsnrPmLDIeRV9p5zbcqo5SCAK6EwczYqHP2xplWOv4qUo3B/G63
        4dCpkKJGFvdkWcv2wNtpJJN3F6hinOlBNxC3vPVeIgvSdvZsqTAbTookueqlGysXz2k8FKBcGmf2w
        7pNNW7qAA8ApAhs/2AiMWi+lKlNabz9p0vFBn+RqJzsalZBwUuJ4yYSR29yC4uI635Pns124FYkGE
        QRyuhmejw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:38834)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hsPtR-0004nx-SN; Tue, 30 Jul 2019 12:02:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hsPtM-00029s-Tn; Tue, 30 Jul 2019 12:02:04 +0100
Date:   Tue, 30 Jul 2019 12:02:04 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lvqiang Huang <lvqiang.huang@unisoc.com>
Subject: Re: [PATCH] ARM: check stmfd instruction using right shift
Message-ID: <20190730110204.GB1330@shell.armlinux.org.uk>
References: <20190722071122.22434-1-zhang.lyra@gmail.com>
 <20190722071419.22535-1-zhang.lyra@gmail.com>
 <CAAfSe-tPVsMjmu0CoUATGRGevCpgqk999-rpfMuXqZ-V9ft7gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfSe-tPVsMjmu0CoUATGRGevCpgqk999-rpfMuXqZ-V9ft7gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 03:18:31PM +0800, Chunyan Zhang wrote:
> Gentle ping
> 
> probably this patch was missed or entered into spam?

Please submit it to the patch system, thanks.

> 
> On Mon, 22 Jul 2019 at 15:14, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
> >
> > In the commit ef41b5c92498 ("ARM: make kernel oops easier to read"),
> > -               .word   0xe92d0000 >> 10        @ stmfd sp!, {}
> > +               .word   0xe92d0000 >> 11        @ stmfd sp!, {}
> > then the shift need to change to 11.
> >
> > Fixes: ef41b5c92498 ("ARM: make kernel oops easier to read")
> > Signed-off-by: Lvqiang Huang <Lvqiang.Huang@unisoc.com>
> > Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> > ---
> >  arch/arm/lib/backtrace.S |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/lib/backtrace.S b/arch/arm/lib/backtrace.S
> > index 7d7952e..926851b 100644
> > --- a/arch/arm/lib/backtrace.S
> > +++ b/arch/arm/lib/backtrace.S
> > @@ -70,7 +70,7 @@ for_each_frame:       tst     frame, mask             @ Check for address exceptions
> >
> >  1003:          ldr     r2, [sv_pc, #-4]        @ if stmfd sp!, {args} exists,
> >                 ldr     r3, .Ldsi+4             @ adjust saved 'pc' back one
> > -               teq     r3, r2, lsr #10         @ instruction
> > +               teq     r3, r2, lsr #11         @ instruction
> >                 subne   r0, sv_pc, #4           @ allow for mov
> >                 subeq   r0, sv_pc, #8           @ allow for mov + stmia
> >
> > --
> > 1.7.9.5
> >
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
