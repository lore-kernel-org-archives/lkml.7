Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD866C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8286A20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfE0SAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 14:00:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54649 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE0SAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 14:00:50 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hVJvU-0005Dw-Cj; Mon, 27 May 2019 20:00:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hVJvT-0008G3-Vv; Mon, 27 May 2019 20:00:47 +0200
Date:   Mon, 27 May 2019 20:00:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to
 MISC_CLK_SEL_MASK
Message-ID: <20190527180047.nfsjfqs22coyqmvp@pengutronix.de>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
 <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
 <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 07:46:43PM +0200, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, May 27, 2019 at 2:26 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > > MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
> > > a bit-mask. Rename and change the macro to be a bit-mask so that
> > > conversion is not needed anymore. No functional changes intended.
> > >
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> > >  drivers/pwm/pwm-meson.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > > index c62a3ac924d0..84b28ba0f903 100644
> > > --- a/drivers/pwm/pwm-meson.c
> > > +++ b/drivers/pwm/pwm-meson.c
> > > @@ -33,7 +33,7 @@
> > >  #define MISC_A_CLK_DIV_SHIFT 8
> > >  #define MISC_B_CLK_SEL_SHIFT 6
> > >  #define MISC_A_CLK_SEL_SHIFT 4
> > > -#define MISC_CLK_SEL_WIDTH   2
> > > +#define MISC_CLK_SEL_MASK    0x3
> >
> > NIT I would have used GENMASK here
> that was my initial idea but I decided against it.
> the variant I came up with was: #define MISC_CLK_SEL_MASK    GENMASK(1, 0)
> 
> however, the actual offset is either 4 or 6 (depending on the PWM channel)
> and I felt that duplicating the macro would just make it more complicated
> so instead I chose to be consistent with MISC_CLK_DIV_MASK

An option would be:

	#define MISC_CLK_SEL_MASK(hwid)		GENMASK(1 + 4 * (hwid), 0 + 4 * (hwid))

(Note I didn't check a manual to the 4 above is probably wrong.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
