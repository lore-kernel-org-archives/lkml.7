Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18212173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfHXAhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:37:10 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHXAhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:37:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1K38-00066C-KH; Sat, 24 Aug 2019 02:36:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1K38-0000SH-4s; Sat, 24 Aug 2019 02:36:58 +0200
Date:   Sat, 24 Aug 2019 02:36:58 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v5 08/13] dt-bindings: pwm: update bindings for MT7628 SoC
Message-ID: <20190824003658.66hisfvhkbkc3pub@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
 <1566461540.16302.4.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566461540.16302.4.camel@mtksdaap41>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 04:12:20PM +0800, Yingjoe Chen wrote:
> On Thu, 2019-08-22 at 14:58 +0800, Sam Shih wrote:
> > This updates bindings for MT7628 pwm controller.
> > 
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index ea95b490a913..93980e3da261 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -21,6 +21,10 @@ Required properties:
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> >   - num-pwms: the number of PWM channels.
> > +
> > + Optional properties:
> > + - clock-frequency: fix clock frequency, this is only used in MT7628 SoC
> > +                    for period calculation. This SoC has no complex clock tree.
> 
> I'm sorry if this has been discussed before. 
> 
> Would it be simpler if you just provide a fixed-clock as clock in device
> tree? This way you don't need this optional properties and don't need to
> special handle it in driver code. 
> 
> After all, the hw is still connected to a simple clock tree.

This is what I just wrote in reply to patch 3 (which implements handling
the clock-frequency property) even before reading your feedback. So I
fully agree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
