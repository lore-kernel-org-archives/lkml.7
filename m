Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C395C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BBC21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="bkqKlLpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfCVFSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:18:45 -0400
Received: from tomli.me ([153.92.126.73]:58774 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfCVFSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:18:43 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 850ae9bf;
        Fri, 22 Mar 2019 05:18:40 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:dddb:8cda)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Fri, 22 Mar 2019 05:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=/YOP+y4mwY/mZ1yd839sHR8l2fQ1MbG+Eqk+LlXHHuc=; b=bkqKlLpkPAiQKUxYdq+AkiPal4Lq+1lKvYropqHiTAT18PZEbohxnBB+87EkNyAZGZz6zszlq3Vl5PQBbHXOitK0l+Tl+6u9qpXNF5+KZOKd39w4q2gjgsPJaC5Y9yKhpSqqKJcTcUhqkgOm1voVTGFl7Mx47GrKOGvxk583w8weteMK4fcfpJ3ZvW0Ppb5qEfMlI5SFqN6wtCU+iIfaDUPd9kpUyTlAA6RoNm0qIE02SE2hS3XRnKRKZOeRzwy8xC0jP9nZzpnPBtJHFd7WEIPKUPGofGipyvaAqpnR6+wL+4kQbn53EW/oYHwkJuGz2B8sqqB95HTD1mJWEt1Vtg==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Yifeng Li <tomli@tomli.me>
Subject: [PATCH v2 6/7] fbdev: sm712fb: Kconfig: add information about docs.
Date:   Fri, 22 Mar 2019 13:17:58 +0800
Message-Id: <20190322051759.15007-7-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322051759.15007-1-tomli@tomli.me>
References: <20190322051759.15007-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits update the Kconfig description of sm712fb,
and inform the user about the existence of documentation.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 Documentation/fb/sm712fb.txt | 44 ++++++++++++++++++++----------------
 drivers/video/fbdev/Kconfig  |  4 ++++
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
index 906b48aa40e4..c9a8fe059ac7 100644
--- a/Documentation/fb/sm712fb.txt
+++ b/Documentation/fb/sm712fb.txt
@@ -18,9 +18,10 @@ and it was also an inexpensive platform for non-x86 hobbyists to explore.
 How to use it?
 ==============
 
-You should not compile-in vesafb, since SM7xx can be used in a VGA
-compatible mode, resulting conflicts with this driver. In addition,
-the VGA compatible mode was never tested by the maintainers.
+SM7xx can be used in a VGA compatible mode and a native framebuffer mode,
+this driver is a native driver. By default, it has no problem taking over
+the VGA driver automatically, but you should not attempt to use both at
+the same time.
 
 Currently, the driver supports 3 modes: 640x480, 800x600, 1024x768,
 at 16, 24 or 32-bit depth. Switching modes is done using the
@@ -44,30 +45,35 @@ alpha channel, it's otherwise equal to 24-bit color. However, they
 could still be useful. For example, "fbterm" supports 32-bit mode
 but not 24-bit mode.
 
-Notes about Modesetting
+WARNING
 ========================
 
 The modesetting code in sm712fb has major problems.
 
-* Switching to 8-bit color mode will result in a black screen, so
-they are removed from the list of supported graphic modes. But they
-can still be switched to on-the-fly, don't do that then!
+* If you are using a laptop, using a non-native resolution (for example,
+using 640x480 on a 1024x768 screen) may garbled your LCD display, showing
+a white screen.
 
-* Only a refresh rate of 60 Hz is supported.
+* The driver assumes a 1024x768 LCD by default, if you have a rare 800x600,
+or 640x480 screen (e.g. Thinkpad 240X), it may garble your LCD by default.
+
+* The driver will crash/hang on systems with less than 2 MiB of VRAM,
+(e.g. Thinkpad 240X), it cannot be fixed because the maintainers don't
+have the hardware for testing.
 
-* 1024x768 with 16-bit color is not really supported, because the
-registers have been hacked by the original developer to adapt
-the 1024x600 screen on Lemote YeeLoong 8089.
+* Switching to 8-bit color mode will result in a black screen, so they are
+removed from the list of supported graphic modes. But they can still be
+switched to on-the-fly with fbset, don't do that then!
 
-* If you are using a Lemote YeeLoong 8089, please remember that only
-the 1024x768 modes are guaranteed to drive the LCD panel properly.
-Other modes are meant to drive a CRT, and may drive the LCD incorrectly
-and result in a white screen with random garbage. External VGA output is
-unaffected.
+* It is not possible to use different resolutions for LCD and VGA out.
+
+* Only a refresh rate of 60 Hz is supported.
 
 Due to the way registers are hardcoded, it's impossible to fix them
-without a major code rewrite. If you've been hit by these problems badly
-and really need to get them fixed, please contact the driver maintainers.
+without a major code rewrite.
+
+If you've been hit by these problems badly and really need to get them
+fixed, please contact the driver maintainers.
 
 2D acceleration
 ==============
@@ -97,7 +103,7 @@ Missing Features
 
 The following features are not implemented in this driver,
 
-	* 2D acceleration on SM720 and Big-Endian CPUs.
+	* 2D acceleration on Big-Endian CPUs.
 	* More VGA modes.
 	* dual-head support
 	* hardware cursor support
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ae7712c9687a..4f3c0075352a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2302,6 +2302,10 @@ config FB_SM712
 	  called sm712fb. If you want to compile it as a module, say M
 	  here and read <file:Documentation/kbuild/modules.txt>.
 
+	  Warning: this driver has many known problems and limitations,
+	  please make sure you've checked the documentation, at
+	  <file:Documentation/fb/sm712fb.txt>.
+
 source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
-- 
2.20.1

