Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9EAC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA652075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ntZt3ItW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfC0XQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:16:51 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58242 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfC0XQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728605; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=7BJ4f6f4KSXZ2UB72pVKzoiNiNiDKzYQfLyTLCI0a94=;
        b=ntZt3ItW3sK8UFQ2SOk3B6wUW4M7nlEaO++UJP0lYPkntRN9pP00q0WaEnsoEo6949ptY+
        H1VDZ5Dg7cV4PUVwychNTTtCFkyyo5KAs0pXWoDKCf5AJ5vSeMwxZeza1PC+AkZoWK5GdK
        DPU8iZVrATScTrdsYW5pgd4yJNUIg/8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>, od@zcrc.me,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v11 00/27] Ingenic JZ47xx TCU pachset v11
Date:   Thu, 28 Mar 2019 00:16:04 +0100
Message-Id: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v11 of my patchset that adds support to the Timer/Counter
Unit (TCU) present in the JZ47xx SoCs from Ingenic.

Changes from v10:

[03/27]: Fix info about default value of ingenic,pwm-channels-mask

[04/27]: - Change prototype of exported function
           ingenic_tcu_pwm_can_use_chn(), use a struct device * as first
	   argument.
	 - Read clocksource using the regmap instead of bypassing it.
	   Bypassing the regmap makes sense only for the sched_clock where
	   the read operation must be as fast as possible.
	 - Fix incorrect format in pr_crit() macro

[05/27]: Use regmap inside the clocksource read functions. Keep bypassing the
         regmap inside the sched_clock read functions.

[12/27]: Add note about abrupt shutdown

[13/27]: - Use pwm_set_chip_data() to hold the clock pointers
         - Remove unused variable 'jz' in jz4740_pwm_request()

[14/27]: - Use proper block-comment style.
         - Modify commit message to fit the new algorithm used.

[15/27]: Use new version of ingenic_tcu_pwm_can_use_chn()

The other patches have not been modified since v10.

If this patchset passes review, I'd like it to be merged in the MIPS
tree.

Thanks,
-Paul

