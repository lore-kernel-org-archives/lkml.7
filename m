Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47829C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCBD218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="dmrVyiud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCPWZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:24 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPWZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:24 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id d0a56cb4;
        Sat, 16 Mar 2019 22:25:21 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=sdEYzi168v0ooyHOHjtL9/15xn+aib8VYH833HeR7gI=; b=dmrVyiudHdKSa8MFMwGG+09kG+rtclZmMdRbgOH9tQkSf9rsV577nvv7+IeJyvdNzm3HGACKEUZfIugQpVat77EVPLcjosMeHkoR7xjQug01UwyvBw3SDvy59Q6GJajLopJOAXbBA6oxscc0PHOSVXYe6egSYs9Z84wyw6HKD36gjtW0ILhNizee868RxgfHguFfpWybmnxl4uUxfbScgMEsceUm2qY0Qvh53e5vrnGHP3ult9SjaSUBFQ5OUTEoGsa/pKNXN4T1kUg2xQKyKpnH3BXbPP49Ph+hxc3ED3rppn8tzOlqces+hMBkLg42bYGlsaQEj1Up8i2/wlerLQ==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 1/8] fbdev: sm712fb: fix white screen of death on reboot, don't set CR3B-CR3F.
Date:   Sun, 17 Mar 2019 06:24:57 +0800
Message-Id: <20190316222504.27170-2-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
sm712fb framebuffer driver would cause a white screen of death on
the next POST, presumably the proper timings for the LCD panel was
not reprogrammed properly by the BIOS.

Experiments showed a few CRTC Scratch Registers, including CRT3D,
CRT3E and CRT3F may be used internally by BIOS as some flags. CRT3B is
a hardware testing register, we shouldn't mess with it. CRT3C has
blanking signal and line compare control, which is not needed for this
driver.

Stop writing to CR3B-CR3F (a.k.a CRT3B-CRT3F) registers. Even if these
registers don't have side-effect on other systems, writing to them is
also highly questionable.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 502d0de2feec..d05379affa32 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1171,8 +1171,12 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 			smtc_crtcw(i, vgamode[j].init_cr00_cr18[i]);
 
 		/* init CRTC register CR30 - CR4D */
-		for (i = 0; i < SIZE_CR30_CR4D; i++)
+		for (i = 0; i < SIZE_CR30_CR4D; i++) {
+			if ((i + 0x30) >= 0x3B && (i + 0x30) <= 0x3F)
+				/* side-effect, don't write to CR3B-CR3F */
+				continue;
 			smtc_crtcw(i + 0x30, vgamode[j].init_cr30_cr4d[i]);
+		}
 
 		/* init CRTC register CR90 - CRA7 */
 		for (i = 0; i < SIZE_CR90_CRA7; i++)
-- 
2.20.1

