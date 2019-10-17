Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03AAFA3737
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D4A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SBcX2tI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502146AbfJQLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:49:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36248 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502101AbfJQLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:49:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so2227287ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+GxmprIIlivls+xiiE2BlDUBLKsv4nmlWzvKE4aR9Y=;
        b=SBcX2tI4x4/1Q7OpymRwhlxB/kdYjwCirEuibHX7DawgeJTuPaHyxNMLNh4W9MVyBF
         letoHX64UHC4ruCNszUwvKalaZpVG78M22y3d3Vq8FVk+S+V7nQJVOE9LlNTM/rcST4N
         OLyB3dRj3YA71fYRagSSWlZZTUNlAHC7+YCZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+GxmprIIlivls+xiiE2BlDUBLKsv4nmlWzvKE4aR9Y=;
        b=QycPx1lMYd22rJr5aO3wX/8T8fZS5jVKMrJrAzxC+WBpWSIhu07y516haUfxx7xcOx
         NGXH789jj+7QYzx4sxs0gkiETkczFSgcV3ExJIyrFl0+66J7i0MkfbISA7n3GM0X5z9Q
         9lr53ZvErrF1ZQg4TaZezj9oOJaD3Q3DDoPQ2uZrJk3FJh/Ay0aP/+1WGq3tFmvgftlB
         EwTwQG9f4slb1Ssnyl7Pe3QhY65gl8G68tLRc1yjSCGgRc/4zA81MCRqubNBcM6EFc6C
         GYYOcMHHm39LR0P1fEHx5G0WxOcgjbzXLf/jsg1GWm8hY5qR+ZaQUmjnUB5beTF0x12s
         46Mw==
X-Gm-Message-State: APjAAAWrfsl1LGi9svLLCS6HUCLuwKMmVoFIZSEriFdQOrHkmzZnsXmx
        xPP0w4Xdnh5kVid+CLbCeZsm0g==
X-Google-Smtp-Source: APXvYqxGLJtJkNX4m2MxleJ2gGPlrbCblZIvrattCDK3O6KMUbntqKBn9afoSuGTNTeqmCY1Gi1qOw==
X-Received: by 2002:a05:651c:8b:: with SMTP id 11mr2229402ljq.98.1571312956132;
        Thu, 17 Oct 2019 04:49:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x30sm920772ljd.39.2019.10.17.04.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:49:15 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel@pengutronix.de, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 3/3] decompress/keepalive.h: add config option for toggling a set of bits
Date:   Thu, 17 Oct 2019 13:49:06 +0200
Message-Id: <20191017114906.30302-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's quite common to have an external watchdog which is serviced via
flipping a GPIO, with the value of that GPIO being settable directly
in a memory-mapped register. So add kconfig options defining the
physical address of such a register as well as a mask to have the
decompressor periodically xor into that register.

If and when other decompress_keepalive methods are added, this can be
made into a "choice DECOMPRESS_KEEPALIVE".

Since only LZ4 is wired up currently, this is "depends on KERNEL_LZ4"
for now. Also, prevent this option from being shown to the average
user.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/decompress/keepalive.h |  8 +++++++
 init/Kconfig                         | 33 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/decompress/keepalive.h b/include/linux/decompress/keepalive.h
index 39caa7693624..c62e49bee7cf 100644
--- a/include/linux/decompress/keepalive.h
+++ b/include/linux/decompress/keepalive.h
@@ -5,6 +5,14 @@
 
 #ifdef PREBOOT
 
+#ifdef CONFIG_DECOMPRESS_KEEPALIVE_TOGGLE
+#define decompress_keepalive() do {					\
+		long addr = CONFIG_DECOMPRESS_KEEPALIVE_TOGGLE_REG;	\
+		volatile unsigned *reg = (volatile unsigned *)addr;	\
+		*reg ^= CONFIG_DECOMPRESS_KEEPALIVE_TOGGLE_MASK;	\
+} while (0)
+#endif
+
 #endif
 
 #ifndef decompress_keepalive
diff --git a/init/Kconfig b/init/Kconfig
index b4daad2bac23..8a894d9fdd77 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -289,6 +289,39 @@ config KERNEL_UNCOMPRESSED
 
 endchoice
 
+config DECOMPRESS_KEEPALIVE_TOGGLE
+	depends on KERNEL_LZ4
+	depends on EXPERT
+	bool "Toggle some bits while decompressing"
+	help
+	  Some embedded boards have an always-running hardware
+	  watchdog with a timeout short enough that the board is reset
+	  during decompression, thus preventing the board from ever
+	  booting.
+
+	  Enable this to toggle certain bits in a memory register
+	  while decompressing the kernel. This can for example be used
+	  in the common case of an external watchdog serviced via a
+	  memory-mapped GPIO.
+
+	  Say N unless you know you need this.
+
+if DECOMPRESS_KEEPALIVE_TOGGLE
+
+config DECOMPRESS_KEEPALIVE_TOGGLE_REG
+	hex "Address of register to modify while decompressing"
+	help
+	  Set this to a physical address of a 32-bit memory word to
+	  modify while decompressing.
+
+config DECOMPRESS_KEEPALIVE_TOGGLE_MASK
+	hex "Bit mask to toggle while decompressing"
+	help
+	  The register selected above will periodically be xor'ed with
+	  this value during decompression.
+
+endif
+
 config DEFAULT_HOSTNAME
 	string "Default hostname"
 	default "(none)"
-- 
2.20.1

