Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA221903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="kfVAcznf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCPWZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:54 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfCPWZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:51 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id dafde181;
        Sat, 16 Mar 2019 22:25:48 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=k/TYcbEZv2yXL5XRt+I2zZm3Zf3gdAbAA8/cjqHfLWk=; b=kfVAcznflvcRkMAYK7sNF4U48SHE+W8FHsyqcCBVTyyHvXo5tAsP539wXT7xXU5sYrVLdarvUyycEqeBfRWEXrT+6NKMTdVV4x4iU2NQIczWoXdLFziq2zpGKk1ELa06vVylrZX5NAOFJw6bWpiS6kS5lWVojB/d281bgyZ8SvdNXHfSAR8Z5/Z/X3tsAeMvpxuA5iUiRMeAp6mpTW0HYlHH4xwhqr4bQKlx74gtitfIffHt+XBTKCV01qNi6SgLJiwZrg8WNBBJDs6j36hOpPxsZlHHyeNh60cjvMlqK5luaF8APXIMOv/wg/pW3Di1Q9mMllZv8pCygKbu4bb0/Q==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 7/8] fbdev: sm712fb: fix support for 1024x768-16 mode.
Date:   Sun, 17 Mar 2019 06:25:03 +0800
Message-Id: <20190316222504.27170-8-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the 1024x600 panel on Yeeloong Loongson MIPS
laptop, the original 1024x768-16 table was modified to 1024x600-16,
without leaving the original. It causes problem on x86 laptop as
the 1024x768-16 support was still claimed but not working.

Fix it by introducing the 1024x768-16 mode.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index a40d0ae7cb66..c39a2641182a 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -530,6 +530,65 @@ static const struct modeinit vgamode[] = {
 			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
 		},
 	},
+	{	/*  1024 x 768  16Bpp  60Hz */
+		1024, 768, 16, 60,
+		/*  Init_MISC */
+		0xEB,
+		{	/*  Init_SR0_SR4 */
+			0x03, 0x01, 0x0F, 0x03, 0x0E,
+		},
+		{	/*  Init_SR10_SR24 */
+			0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
+			0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0xC4, 0x30, 0x02, 0x01, 0x01,
+		},
+		{	/*  Init_SR30_SR75 */
+			0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
+			0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
+			0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+			0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
+			0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+			0x0F, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
+			0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+			0x50, 0x03, 0x74, 0x14, 0x3B, 0x0D, 0x09, 0x02,
+			0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
+		},
+		{	/*  Init_SR80_SR93 */
+			0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+			0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+			0x00, 0x00, 0x00, 0x00,
+		},
+		{	/*  Init_SRA0_SRAF */
+			0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+			0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+		},
+		{	/*  Init_GR00_GR08 */
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+			0xFF,
+		},
+		{	/*  Init_AR00_AR14 */
+			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+			0x41, 0x00, 0x0F, 0x00, 0x00,
+		},
+		{	/*  Init_CR00_CR18 */
+			0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+			0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+			0xFF,
+		},
+		{	/*  Init_CR30_CR4D */
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+			0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+			0xA3, 0x7F, 0x00, 0x86, 0x15, 0x24, 0xFF, 0x00,
+			0x01, 0x07, 0xE5, 0x20, 0x7F, 0xFF,
+		},
+		{	/*  Init_CR90_CRA7 */
+			0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+			0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+		},
+	},
 	{	/*  mode#5: 1024 x 768  24Bpp  60Hz */
 		1024, 768, 24, 60,
 		/*  Init_MISC */
-- 
2.20.1

