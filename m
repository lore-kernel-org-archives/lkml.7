Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD614C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DCA216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WOySg19u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfFXNOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbfFXNOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so13854712wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1AJwx99L7FOyjXOzW3yVuzHOgblADWD2c7KtmC/N3c=;
        b=WOySg19uwixtLJcA34iXOVTAvsO3Qw7eg/4J7JqNLGkwewilaFe1+y+jlxscwDQ876
         dvRwKZ5JZPTB1yoVLftIgMN4jeQxDtptUtHagZ/Et6tO1ycxiGn/CmruZsmIMiCoLJEY
         KTF0zwd9AuaAEFxQXQvEWMLHJVFKEhZ0GoW7lyU4ff+JznxNQdHHPTfTStIOZ0/13f+G
         op9eMVHrXho9xnud3GO6aHei8hY9xVc5CDtPT/Tt2fdm8jiY9TK15aHkdVK8yt/ZiYV8
         qV/DurgpQw7hQLCbJDdVjfec/B0KNnKik9bfIZOOp9Xm7ErXTj3MDQleBuixVzAK5KI1
         b/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1AJwx99L7FOyjXOzW3yVuzHOgblADWD2c7KtmC/N3c=;
        b=rpZpfhlZOT3u1l5MITlZmf5+dKUtbvSj0a+Me8xdtYRl+UMhzAlFH5sgZR6HH76XSN
         UhzPJSmoaq1bZljAR59T4An3jUdwsoOBEMTKfZ6dKT8WHplIXqSUvf7S1D5PsqDWRN3+
         lxb/TYANokBvDsYlSiI8bz0M+djhWOwNkx8Sg5OHWvGti335EzIaQAKjRy8cHbTuRU9N
         AMetHoPh2SSyraRztbMqZbhYixTdFqsjk4gOuEFt4T0yNjjGTf6gd37IiPN+d+tpVHOK
         qt+r1S3dIxhH3V9PbUbj0b70UDfFyEss9eJsGY6V4tYItEiL91Ol6JNcFsghf18LeBxw
         lvOQ==
X-Gm-Message-State: APjAAAViDQCZTY33O78eHQajKDqTDb7cbURyvcOmwJIggSXQDoSp20lM
        acRCgzfPQdIYToM8FoJRsKm24g==
X-Google-Smtp-Source: APXvYqwMrGE/b2UQOnAjqoPXTMcUtRBbxCyCrQMb4pPMV12KOWmxfAgxSMS2EEyzVVZXU67ssEcvPA==
X-Received: by 2002:a05:6000:d1:: with SMTP id q17mr58315452wrx.40.1561382046572;
        Mon, 24 Jun 2019 06:14:06 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 05/10] ARM: davinci: move timer definitions to davinci.h
Date:   Mon, 24 Jun 2019 15:13:46 +0200
Message-Id: <20190624131351.3732-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624131351.3732-1-brgl@bgdev.pl>
References: <20190624131351.3732-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Boards from the dm* family rely on register offset definitions from
arch/arm/mach-davinci/include/mach/time.h. We'll be removing this file
soon, so move the required defines to davinci.h where the rest of such
constants live.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/davinci.h           | 3 +++
 arch/arm/mach-davinci/include/mach/time.h | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 56c1835c42e5..208d7a4d3597 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -60,6 +60,9 @@ void davinci_map_sysmod(void);
 #define DAVINCI_GPIO_BASE 0x01C67000
 int davinci_gpio_register(struct resource *res, int size, void *pdata);
 
+#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
+#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
+
 /* DM355 base addresses */
 #define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
 #define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
diff --git a/arch/arm/mach-davinci/include/mach/time.h b/arch/arm/mach-davinci/include/mach/time.h
index 1c971d8d8ba8..ba913736990f 100644
--- a/arch/arm/mach-davinci/include/mach/time.h
+++ b/arch/arm/mach-davinci/include/mach/time.h
@@ -11,9 +11,7 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_TIME_H
 #define __ARCH_ARM_MACH_DAVINCI_TIME_H
 
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
 #define DAVINCI_TIMER1_BASE		(IO_PHYS + 0x21800)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
 
 enum {
 	T0_BOT,
-- 
2.21.0

