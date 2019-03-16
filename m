Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A7EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125BB218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="Nj6NsDsp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCPWZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:34 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPWZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:32 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id d58028c4;
        Sat, 16 Mar 2019 22:25:29 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=4NWBd3Ia346Cajmo+kDBGhGRvuiTuYQgNlRiz0JnB94=; b=Nj6NsDspA6ghIdTmqBt6/yGdH4GCF7YlrSaMClTWthphTL5CLeKE5jWTtJ3k3bFXfSy5n0Ej15NbnSV/9gFpYCFw28k17ECV4ZJ0R7P5RgjyaXTPxVPVHb2g+5xPH5vOkDRhssFVgyh0XtyjeeFW1ep6zLQk83B4i2e/LyzYB5mHLffvyVZmqjbgtymnR3Qm/FmRbjlYssYp2Ryt1jPWirIYJgJ7hq/I5mGSh8y97BRz02NWkybBhtKZrXjoMlrblhvRr+CGbYZGhwwmCdSFCR1blJwnj/qxFLR2yuyNv58AYHGzKGtTMgFsWw8IL+mU/b/qSfKQl+lzXXcyxMBF/A==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 3/8] fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75.
Date:   Sun, 17 Mar 2019 06:24:59 +0800
Message-Id: <20190316222504.27170-4-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), the amount of Video
RAM is not detected correctly by the xf86-video-siliconmotion driver.
This is because sm712fb overwrites the GPR71 Scratch Pad Register, which
is set by BIOS on x86 and used to indicate amount of VRAM.

Other Scratch Pad Registers, including GPR70/74/75, don't have the same
side-effect, but overwriting to them is still questionable, as they are
not related to modesetting.

Stop writing to SR70/71/74/75 (a.k.a GPR70/71/74/75).

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index a19655babf67..1a3d232c2916 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1146,7 +1146,9 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 		/* init SEQ register SR30 - SR75 */
 		for (i = 0; i < SIZE_SR30_SR75; i++)
 			if ((i + 0x30) != 0x30 && (i + 0x30) != 0x62 &&
-			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b)
+			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b &&
+			    (i + 0x30) != 0x70 && (i + 0x30) != 0x71 &&
+			    (i + 0x30) != 0x74 && (i + 0x30) != 0x75)
 				smtc_seqw(i + 0x30,
 					  vgamode[j].init_sr30_sr75[i]);
 
-- 
2.20.1

