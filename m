Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7714BC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0A821903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="kFdLQ9pC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfCPWZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:30 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPWZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:28 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 5a6ff48d;
        Sat, 16 Mar 2019 22:25:25 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=J3Zu68lei65LuVr4EvjuobGl91PV3ls+f1YA92lZbMs=; b=kFdLQ9pChcJkummX5GBbjYrO8y6dStSzfSNvFKjsToqLUV05PYfvimcDkm5ZcEWh5r2qoL7L5yUZvznLlxzIf21C3VMKxNRNw6L8vVGCQhXV2XAp9j19TRliIMbti1HiXLqYV/qZHE+7tZnBZP9ecREDHgKb3Bk32eORtguYonDNBMgdb8EMllBRQ8TWmbfUtxa4DKZOUPSYr6x13xfcfnZAB5hBRWeQpjWCTOOeL/O53lpKPM0Dw/t3vUP88ojoB+1D4ZMKaqqta1QynUmarl3ujJijODjLMd2ME4PswySN7GvPNvNXUHhPtppWWGO5A6hipGHl5pwx579yYPFNtA==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 2/8] fbdev: sm712fb: fix brightness control on reboot, don't set SR30.
Date:   Sun, 17 Mar 2019 06:24:58 +0800
Message-Id: <20190316222504.27170-3-tomli@tomli.me>
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
sm712fb framebuffer driver would cause the role of brightness up/down
button to swap.

Experiments showed the FPR30 register caused this behavior. Moreover,
even if this register don't have side-effect on other systems, over-
writing it is also highly questionable, since it was originally
configurated by the motherboard manufacturer by hardwiring pull-down
resistors to indicate the type of LCD panel. We should not mess with
it.

Stop writing to the SR30 (a.k.a FPR30) register.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index d05379affa32..a19655babf67 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1145,8 +1145,8 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 
 		/* init SEQ register SR30 - SR75 */
 		for (i = 0; i < SIZE_SR30_SR75; i++)
-			if ((i + 0x30) != 0x62 && (i + 0x30) != 0x6a &&
-			    (i + 0x30) != 0x6b)
+			if ((i + 0x30) != 0x30 && (i + 0x30) != 0x62 &&
+			    (i + 0x30) != 0x6a && (i + 0x30) != 0x6b)
 				smtc_seqw(i + 0x30,
 					  vgamode[j].init_sr30_sr75[i]);
 
-- 
2.20.1

