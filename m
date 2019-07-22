Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B1DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECEA217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pIoC9oM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfGVNSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:18:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34572 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfGVNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:17:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so39436563wrm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i1AJwx99L7FOyjXOzW3yVuzHOgblADWD2c7KtmC/N3c=;
        b=pIoC9oM2SJ5bTQ+eRC7d6ReZipWlFuv8mhyOuLWGmoiM8hihjKDbcYzk6hANScrgJN
         rW05dvNGO4vHZr4dMUEDVyGjjjkB2g5tV8ivnNDEywzlkYWYyP/3Vlq6BTNwMjUcC6DY
         stoKLsBEJ9Kpf12vzhujsvcYIhPxHMZfEuKIPQBcLMVeL32Lml1EKxjHmsp6ic+ayM0X
         R6xwxui+6Mp9JKkkz1/pKDBpveHOE12dVpW70c1oXe+UbW+C4k8HFEDPISpAj+uiGS1i
         BpS1re/U9WlWq6XGrylr1Xep7OvA/lahP+EhtkjgH1pAZ3T4a+2opzxxmr/W+wrv/oCB
         QmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i1AJwx99L7FOyjXOzW3yVuzHOgblADWD2c7KtmC/N3c=;
        b=ctRP2Ooi/khCtt4xkEDNOFflduNcL4umOANip2Z1bdT77v8Cf4gslzWHjnBvaA278N
         qnps7C28VKBUlEQz7qYvXt2sOHHx5TvGx+aQOFMH/wC1Zv/6NhESxbbVymu3lTuNoHx4
         jB50JpjkMmxFWM6MsG6VQTMr5xPxgf7KT/SwaPfoW7ou+SPdQ+Z6GLAYyt4ioxDzrAMk
         0+L6klEl+5GKPwdIAkI+9U9Nr5i1TMzMwEeJ9duYTJW3oKVlY7V2dABAJ002GC4m4mZB
         9kp8qQBh8qj8Mjz6yHVvA7/huqvV3w8LeCs1+EFT450WrScxGFMVbHgmkdcLxGY3l0qp
         fy5Q==
X-Gm-Message-State: APjAAAXHtqXCD6l91dEdTfLSDhJowDnvDvJC9XECkU9ahwXeBlAjCu8d
        fWCIb4xLeywNKvsUiRSJg2Q=
X-Google-Smtp-Source: APXvYqz3On9bPHv79/RsBc+0dwicwKP6apaQW2ZmacAnsdUnKzLS+lJLsX2BS/W4UpcSrcRApRCn9g==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr25919456wrt.295.1563801477023;
        Mon, 22 Jul 2019 06:17:57 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id z6sm34156657wrw.2.2019.07.22.06.17.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:17:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [RESEND PATCH 05/10] ARM: davinci: move timer definitions to davinci.h
Date:   Mon, 22 Jul 2019 15:17:43 +0200
Message-Id: <20190722131748.30319-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722131748.30319-1-brgl@bgdev.pl>
References: <20190722131748.30319-1-brgl@bgdev.pl>
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

