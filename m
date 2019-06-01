Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F05C28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C4126FAA
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395737;
	bh=h1UnrCnk/5MnPPaNdmSoBK/0X7X3BZNxYU/PcbGSPbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vnx3eV2KDoa/42AVMHY5Zj7HlB022IEWDSt3KBOSFAA+5oAtN00K5d0nYSPoIJLC1
	 o036vpMMOMr2Ol6IFtIYx76D9Mh1e57NAgukTOGQE10BqJGO0CwLUngvXndbmF5dg0
	 fz/oCNlrOWGOKfOsOzUn6/OQemnzARCTrNqpa/Wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfFAN2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729921AbfFAN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:27:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F27273CD;
        Sat,  1 Jun 2019 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395632;
        bh=h1UnrCnk/5MnPPaNdmSoBK/0X7X3BZNxYU/PcbGSPbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vAHRjfKiAYcVruuLNis7zO748d8ur1qKB1koqGIzrDBdGyxSYjFHXS+bWDfHhvmzo
         BleaS4m7H/raQBWrHUoyXMj3hY+yV2Tbfkn5CvJxY1wnet2fOH5KACM4GAr99g9DXO
         ZIxLkr5wFbzS8+57kLdJ94wRc3VDBblCmOLtvu98=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.4 42/56] fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA
Date:   Sat,  1 Jun 2019 09:25:46 -0400
Message-Id: <20190601132600.27427-42-sashal@kernel.org>
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

[ Upstream commit ec1587d5073f29820e358f3a383850d61601d981 ]

When the machine is booted in VGA mode, loading sm712fb would cause
a glitch of random pixels shown on the screen. To prevent it from
happening, we first clear the entire framebuffer, and we also need
to stop calling smtcfb_setmode() during initialization, the fbdev
layer will call it for us later when it's ready.

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
index 2539c1e6facb4..6a30714a18632 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1498,7 +1498,11 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 	if (err)
 		goto failed;
 
-	smtcfb_setmode(sfb);
+	/*
+	 * The screen would be temporarily garbled when sm712fb takes over
+	 * vesafb or VGA text mode. Zero the framebuffer.
+	 */
+	memset_io(sfb->lfb, 0, sfb->fb->fix.smem_len);
 
 	err = register_framebuffer(info);
 	if (err < 0)
-- 
2.20.1

