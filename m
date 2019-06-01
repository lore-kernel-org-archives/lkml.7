Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6A8C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DA024937
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395703;
	bh=SdmJgg9i0oL99XPrS1akKU3rtqQfDrOm2qN4nOR7m84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jtbIr/PUuTJIMqPR4U1XmMtvBxEY/k4t5D0CRg5hSasC47sbkKKGWrqN9e7CM68cQ
	 LnpcAL2jtEYXGCw+0tHnOuKYqg4pP0t175XIpqz3wzmD8bffFhpyDOBjrYzrf9Ussz
	 94m3v/tcizfYho4vHi1zBnRRffdGhut77XLtGhBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfFAN2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbfFAN1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:27:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2640212F5;
        Sat,  1 Jun 2019 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395643;
        bh=SdmJgg9i0oL99XPrS1akKU3rtqQfDrOm2qN4nOR7m84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0Th5bWYQvQH6AWBbdmjQ1Z3egJigRkN3umzDTQ5bYZz7jj8bB1omLREUuz2I1fXn
         gmOODybTaiGVEL+PTbtRgwvkgyt8kw2LXr8w343UYqAx/RnK+n3DTWLTiovz87r/KX
         XB98wvjBt4dCL43ro70y1mKuJfLDBDj8gxX1IADY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 47/56] fbdev: sm712fb: fix white screen of death on reboot, don't set CR3B-CR3F
Date:   Sat,  1 Jun 2019 09:25:51 -0400
Message-Id: <20190601132600.27427-47-sashal@kernel.org>
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

[ Upstream commit 8069053880e0ee3a75fd6d7e0a30293265fe3de4 ]

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
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sm712fb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 3f5840aaa1dd0..5148765f007cf 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1182,8 +1182,12 @@ static void sm7xx_set_timing(struct smtcfb_info *sfb)
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

