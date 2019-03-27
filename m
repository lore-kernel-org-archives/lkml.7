Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0285EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37052075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="YXcP/R4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfC0XRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 19:17:52 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:59276 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732572AbfC0XRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 19:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553728668; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NjQ2F08kMImKzahKxPvopZlS77+2wWI9m9V/KZlaiA0=;
        b=YXcP/R4GPbq8hsKtPtul+l1iPGHFyzdOQgOZzDZThZtuIlXjq0H0XkkA5Tnhn6mhSgNbDf
        MwJo/8BtxoL4BJN2N0kvWAQZOy+SCVhf8ZNcLuCBQ2Szet5JB0yj0QypSRRwV65vhq2sqe
        DJWgRXs5erMmL/tpBjZs1NB9CzRKr4Q=
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
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v11 19/27] MIPS: Kconfig: Select TCU timer driver when MACH_INGENIC is set
Date:   Thu, 28 Mar 2019 00:16:23 +0100
Message-Id: <20190327231631.15708-20-paul@crapouillou.net>
In-Reply-To: <20190327231631.15708-1-paul@crapouillou.net>
References: <20190327231631.15708-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot boot to userspace (not even initramfs) if the timer driver is
not present; so it makes sense to enable it unconditionally when
MACH_INGENIC is set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a5f5b0ee9a9..eca480d43d93 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -393,6 +393,7 @@ config MACH_INGENIC
 	select BUILTIN_DTB if MIPS_NO_APPENDED_DTB
 	select USE_OF
 	select LIBFDT
+	select INGENIC_TIMER
 
 config LANTIQ
 	bool "Lantiq based platforms"
-- 
2.11.0

