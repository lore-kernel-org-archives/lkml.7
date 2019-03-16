Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56163C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE3B21906
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="KY+kvyrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfCPWZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:50 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfCPWZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:46 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id f9903af6;
        Sat, 16 Mar 2019 22:25:44 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=zaPmx2P9sp2l6lKZmqFZnN7sS9/qfOX6rKU66Ngc6M8=; b=KY+kvyrwDrHbJVq3GFTuSoMlx/1ppzbobQLE0UnvvSF9dZko/att7OVONpNff2JvrT/A5HRzj19FGt5/6yyyAG0kWSj6sVDmGqxBvvGvp8E3NwGU+mQnHDKHUeHfL8NViwbcdBuLNvcV1RVWdPAZ2i8h8s81soJ+CtXlYBu49pJmU+JCIKiFetvjfyHNqfQ5eOh4+eSKRgrrnMRCajxxUGuYh8WXqiTzzvAvmo2Zc+wJI5jjJGKN9037ryqUTt46JNJpBqxl+VhCdUzVziPYbi4nHf2PeQif3gWqWxuslVcWEtCg0WrszZt/ykEsaqWWyCUrNFkmVgMH3ggbJqfpNw==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 6/8] fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting.
Date:   Sun, 17 Mar 2019 06:25:02 +0800
Message-Id: <20190316222504.27170-7-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), blanking the display
or starting the X server will crash and freeze the system, or garble the
display.

Experiments showed this problem can mostly be solved by adjusting the
order of register writes. Also, sm712fb failed to consider the difference
of clock frequency when unblanking the display, and programs the clock for
SM712 to SM720.

Fix them by adjusting the order of register writes, and adding an
additional check for SM720 for programming the clock frequency.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 64 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 52234c57be02..a40d0ae7cb66 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -827,67 +827,79 @@ static inline unsigned int chan_to_field(unsigned int chan,
 
 static int smtc_blank(int blank_mode, struct fb_info *info)
 {
+	struct smtcfb_info *sfb = info->par;
+
 	/* clear DPMS setting */
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
 		/* Screen On: HSync: On, VSync : On */
+
+		switch (sfb->chip_id) {
+		case 0x710:
+		case 0x712:
+			smtc_seqw(0x6a, 0x16);
+			smtc_seqw(0x6b, 0x02);
+		case 0x720:
+			smtc_seqw(0x6a, 0x0d);
+			smtc_seqw(0x6b, 0x02);
+			break;
+		}
+
+		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
 		smtc_seqw(0x01, (smtc_seqr(0x01) & (~0x20)));
-		smtc_seqw(0x6a, 0x16);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) & 0x77));
 		smtc_seqw(0x22, (smtc_seqr(0x22) & (~0x30)));
-		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
-		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
 		smtc_seqw(0x31, (smtc_seqr(0x31) | 0x03));
+		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
 		break;
 	case FB_BLANK_NORMAL:
 		/* Screen Off: HSync: On, VSync : On   Soft blank */
+		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
 		smtc_seqw(0x01, (smtc_seqr(0x01) & (~0x20)));
+		smtc_seqw(0x22, (smtc_seqr(0x22) & (~0x30)));
 		smtc_seqw(0x6a, 0x16);
 		smtc_seqw(0x6b, 0x02);
-		smtc_seqw(0x22, (smtc_seqr(0x22) & (~0x30)));
-		smtc_seqw(0x23, (smtc_seqr(0x23) & (~0xc0)));
-		smtc_seqw(0x24, (smtc_seqr(0x24) | 0x01));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
 		/* Screen On: HSync: On, VSync : Off */
+		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0x20));
 		smtc_seqw(0x01, (smtc_seqr(0x01) | 0x20));
-		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
-		smtc_seqw(0x6a, 0x0c);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) | 0x88));
+		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
 		smtc_seqw(0x22, ((smtc_seqr(0x22) & (~0x30)) | 0x20));
-		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0x20));
-		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		smtc_seqw(0x34, (smtc_seqr(0x34) | 0x80));
+		smtc_seqw(0x6a, 0x0c);
+		smtc_seqw(0x6b, 0x02);
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		/* Screen On: HSync: Off, VSync : On */
+		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
 		smtc_seqw(0x01, (smtc_seqr(0x01) | 0x20));
-		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
-		smtc_seqw(0x6a, 0x0c);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) | 0x88));
+		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
 		smtc_seqw(0x22, ((smtc_seqr(0x22) & (~0x30)) | 0x10));
-		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
-		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		smtc_seqw(0x34, (smtc_seqr(0x34) | 0x80));
+		smtc_seqw(0x6a, 0x0c);
+		smtc_seqw(0x6b, 0x02);
 		break;
 	case FB_BLANK_POWERDOWN:
 		/* Screen On: HSync: Off, VSync : Off */
+		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
+		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
+		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
 		smtc_seqw(0x01, (smtc_seqr(0x01) | 0x20));
-		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
-		smtc_seqw(0x6a, 0x0c);
-		smtc_seqw(0x6b, 0x02);
 		smtc_seqw(0x21, (smtc_seqr(0x21) | 0x88));
+		smtc_seqw(0x20, (smtc_seqr(0x20) & (~0xB0)));
 		smtc_seqw(0x22, ((smtc_seqr(0x22) & (~0x30)) | 0x30));
-		smtc_seqw(0x23, ((smtc_seqr(0x23) & (~0xc0)) | 0xD8));
-		smtc_seqw(0x24, (smtc_seqr(0x24) & (~0x01)));
-		smtc_seqw(0x31, ((smtc_seqr(0x31) & (~0x07)) | 0x00));
 		smtc_seqw(0x34, (smtc_seqr(0x34) | 0x80));
+		smtc_seqw(0x6a, 0x0c);
+		smtc_seqw(0x6b, 0x02);
 		break;
 	default:
 		return -EINVAL;
-- 
2.20.1

