Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5DC4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7622086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="DRS+s+mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfCBXeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:34:31 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:60526 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCBXea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551569666; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=QVQst8EK/PLgJUiLMusS3TTp/grRh57aTCc3Y4+nxow=;
        b=DRS+s+mMTaz+z61e1VoVE0VgrH+2cUs3Tt1IbgUOxZ2j71NZIVrdEAn58BJXoHD+ggB3Sb
        Fj0OKsUt8IkUUzW7sqr3Z94k+3TnE29zb2xAzYOnSdgJNGMn+Rist+x9mpkqfxgnn77Yoy
        RDrh+dF/2Lqf6wbv/BVUYWnU8pEvNqw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [5.2][PATCH v10 00/27] Ingenic TCU patchset
Date:   Sat,  2 Mar 2019 20:33:46 -0300
Message-Id: <20190302233413.14813-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the Ingenic JZ47xx TCU patchset version 10.

Changes from v9:
- [04/27]: - The clocksource is now created unconditionally, even if the
             SoC has the better OS Timer. This gives the choice back to
	     the user.
	   - Simplify the set_rate/set_parent callbacks for the clocks
	   - Probe platform driver at subsys_initcall() instead of
	     using builtin_platform_driver_probe(), to ensure that the
	     devices are populated before the children drivers (e.g. OS
	     Timer driver) are probed.
- [05/27]: Fix incorrect mask used with regmap_update_bits, which caused
           the clocksource to be unstable on JZ4770 and JZ4780.
- [13/27]: Update commit message to reflect why "select REGMAP" was
           removed.
- [14/27]: Use a new algorithm that does not use clk_round_rate().
- [23/27] and [25/27]: Revert behaviour to what was in V8.

It has been tested and reported to be working, on the JZ4725B by me,
on the JZ4740 by Artur Rojek, and on the JZ4780 by Mathieu Malaterre.

I'd like this patchset to go through the MIPS tree, that will allow other
unrelated cleanups to follow.

Thanks,
- Paul

