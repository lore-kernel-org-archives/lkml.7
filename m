Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B3C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52412087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfHLGJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:09:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLGJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:09:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx3WD-0003Fq-Nx; Mon, 12 Aug 2019 08:09:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx3WD-00015j-2b; Mon, 12 Aug 2019 08:09:21 +0200
Date:   Mon, 12 Aug 2019 08:09:21 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] pwm: jz4740: Drop dependency on MACH_INGENIC
Message-ID: <20190812060921.7iz4cmwp5awtqhwz@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-4-paul@crapouillou.net>
 <20190809164143.2p573g7wlx43hero@pengutronix.de>
 <1565386860.2091.5@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565386860.2091.5@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:40:59PM +0200, Paul Cercueil wrote:
> 
> 
> Le ven. 9 août 2019 à 18:41, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Fri, Aug 09, 2019 at 02:30:27PM +0200, Paul Cercueil wrote:
> > >  Depending on MACH_INGENIC prevent us from creating a generic kernel
> > > that
> > >  works on more than one MIPS board. Instead, we just depend on MIPS
> > > being
> > >  set.
> > > 
> > >  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > >  ---
> > >   drivers/pwm/Kconfig | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > >  diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > >  index d2557c6fcf65..82a75e0b72e5 100644
> > >  --- a/drivers/pwm/Kconfig
> > >  +++ b/drivers/pwm/Kconfig
> > >  @@ -224,7 +224,7 @@ config PWM_IMX_TPM
> > > 
> > >   config PWM_JZ4740
> > >   	tristate "Ingenic JZ47xx PWM support"
> > >  -	depends on MACH_INGENIC
> > >  +	depends on MIPS
> > 
> > If this isn't actually useful on MIPS without MACH_INGENIC this is
> > better expressed using:
> > 
> > 	depends on MIPS
> > 	depends on MACH_INGENIC || COMPILE_TEST
> > 
> > This way some configuring a mips kernel without INGENIC isn't bothered
> > by this question.
> 
> As said in the commit message, it is useful on MIPS without MACH_INGENIC,
> if you want to create a generic kernel that works on more than one MIPS
> board.

Ah, mips is different than arm here. If you configure a generic kernel
that supports arm/imx and some others the Kconfig settings for imx are still
available. Would it make more sense to do:

	depends on MACH_INGENIC || MIPS_GENERIC || COMPILE_TEST

then? Or switch mips to the (IMHO) more intuitive approach that is taken
by arm, too? (i.e. ensure that MACH_INGENIC is =y for both a generic
kernel that supports this machine type among others and a tailored
kernel that only supports Ingenic.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
