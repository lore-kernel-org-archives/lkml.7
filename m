Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF85C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C64249FD
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395711;
	bh=6KEatwgCvVAkHGuPNRxzrXAG3gR/1g0GB9QnkBKzGMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l6gFPhtEELmS/gKH9sDyoQKa3jvXcklfpreHh89NUwskwOINh+nnmA0ycx9kLb/cY
	 BZOxHqmXePDQ6X5Z764B1evQBp6nMV6MHWDm6xd9ebZraJxlbKgS7hMG30Nr00w5z1
	 BDq9hfujulL9nSkY4nmjlbDkLDQi9rnZ0xLS11Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfFAN2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbfFAN1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:27:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEAD4273CD;
        Sat,  1 Jun 2019 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395638;
        bh=6KEatwgCvVAkHGuPNRxzrXAG3gR/1g0GB9QnkBKzGMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UA/wMMN0Fh5lcRVCCP12o+hfiNtKtj6saNa+Nqg6mxWwEHLfjgpd8fdmt5SZJ1JuN
         mIy40TN1QbmQxaAsWQ+u0iw9ayGP3H9hzUQmYH1uC7B50TT71NSnStrXQqTUxd07Pa
         2c1MGOXrwjG7SShcVnLKdGwwxEljpiE2PtPB4WqY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 45/56] fbdev: sm712fb: fix brightness control on reboot, don't set SR30
Date:   Sat,  1 Jun 2019 09:25:49 -0400
Message-Id: <20190601132600.27427-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Li <tomli@tomli.me>

[ Upstream commit 5481115e25e42b9215f2619452aa99c95f08492f ]

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
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sm712fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6a30714a18632..3f5840aaa1dd0 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1156,8 +1156,8 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
 
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

