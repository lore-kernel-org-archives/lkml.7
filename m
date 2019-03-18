Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8845920879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KupBVptH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfCRML4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:11:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfCRMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:11:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so16286591wre.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33HPIiJ1xn7gSPPKGm5upaCUrdFSVFtH5Uv/YxnmZAo=;
        b=KupBVptHUCrwtmS27D5ZtqrIHcvOcGLmo54YcQypQUE1BcrAXVfMRZNAoFPm1ANuo9
         mtdZbh64anxQczl7mYe+c+DVhSghjDqb7Afizrti0EQJ4YWvzfEAQgTSAhAOolqk1rgZ
         A9nJ7QiBDdrwA37Woiewh9xw7Oigvv6gvasdMklR/Aq8OmR3eoxZGHhwIIxGMg5l7T4e
         IL/CQD7yd4LQkV0lxuVG1J5D5kUgvQKCmMKdUtF/UzyrzBDNrY1cAU9OzdKXT3FmsGbL
         Ok8LuEUcyvIiLaDgBvl9xLayx/QcNCs6laJnmBIVuv+DccN+p89nllc17JVh4UmR5cVF
         VRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33HPIiJ1xn7gSPPKGm5upaCUrdFSVFtH5Uv/YxnmZAo=;
        b=qhmM4g4a43L1CngN7fvNPZr15Cz+aJW3aZygiYMwWSJMCqTDFEUqUR2LlYsIoBoNDt
         QERTTj4J4Xv6j5fj0L+lL/GJcwCb/XIQTOiASDvsUg+M1YncfZw+7VHQOc99FMfiK8qu
         F06hW1jvYn/Uh46UrWbX4QbH4DhA9MfGx6zXjERjITU/KZV+M0j+tS/+McVQoqWHfNo7
         tygHbdzqPE6rn1zNSfCdcEf25I7eHYPw+ZmgBBekPTt9buPSrp1Vm+yYDLAlVOxmsqLk
         CGqvRs3fVpyBVgBgnS8CuZkWlxnuu8TJqRdyrCE3qyFKPuR7S4viWegJrKhUIdqQXch/
         fewQ==
X-Gm-Message-State: APjAAAW+1y63ew6aUFSh47oEILlb0+2t8qk90CprO80rDWFcjRGtPzij
        Y/qEvaLk5Nd09ajEBlsP/DZUrDhfMFs=
X-Google-Smtp-Source: APXvYqy15uASYC0i/Ub2/LYjetNCxw7DHTLvkpKWePw8QCvnG0j963NtpAr5lq2gRHHTESxJb42rIQ==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr11553647wrx.26.1552911081296;
        Mon, 18 Mar 2019 05:11:21 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n13sm8220132wrw.67.2019.03.18.05.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:11:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 06/11] ARM: davinci: move timer definitions to davinci.h
Date:   Mon, 18 Mar 2019 13:10:55 +0100
Message-Id: <20190318121100.28132-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318121100.28132-1-brgl@bgdev.pl>
References: <20190318121100.28132-1-brgl@bgdev.pl>
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
2.20.1

