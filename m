Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9519620651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711254;
	bh=XE08yZ348PsFqqowFmR1SfyWqAgmpKzl36yM7xjkuXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9GujrMkdumwhsHA/p1Lyuru3QL8WeEAS+zjXp+v70I2+q597cHy0L6cwIHozCkAk
	 FGmBu9qve8ELFTtiROa3Lqu3buiATMDWBQQyLrmoS9vSLYs8zYj4Oh9f2jealq81em
	 0r2KItT7mv6oTmKFF2Q7cTl6YXzYf2IJncrpbDSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391704AbfC0S0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391675AbfC0S0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D29F20651;
        Wed, 27 Mar 2019 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711172;
        bh=XE08yZ348PsFqqowFmR1SfyWqAgmpKzl36yM7xjkuXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFm4eWAB2UpNVsdWB8xE6953u+PLwkE3jgtY41C3tp17UnwY7VU80QXOogUZ5TnAF
         /1Nz1JlAPBbUlmZbBnUc/QqsdDvbYJqn/zuvFdgn9Jc3NCWAK2VrfhmTDWb5MRvhBb
         dz0RArrRJdTpNXPOtfQZ7xb0YxWsJY+eXkLq03e0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 27/41] fbdev: fbmem: fix memory access if logo is bigger than the screen
Date:   Wed, 27 Mar 2019 14:25:04 -0400
Message-Id: <20190327182518.19394-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

[ Upstream commit a5399db139cb3ad9b8502d8b1bd02da9ce0b9df0 ]

There is no clipping on the x or y axis for logos larger that the framebuffer
size. Therefore: a logo bigger than screen size leads to invalid memory access:

[    1.254664] Backtrace:
[    1.254728] [<c02714e0>] (cfb_imageblit) from [<c026184c>] (fb_show_logo+0x620/0x684)
[    1.254763]  r10:00000003 r9:00027fd8 r8:c6a40000 r7:c6a36e50 r6:00000000 r5:c06b81e4
[    1.254774]  r4:c6a3e800
[    1.254810] [<c026122c>] (fb_show_logo) from [<c026c1e4>] (fbcon_switch+0x3fc/0x46c)
[    1.254842]  r10:c6a3e824 r9:c6a3e800 r8:00000000 r7:c6a0c000 r6:c070b014 r5:c6a3e800
[    1.254852]  r4:c6808c00
[    1.254889] [<c026bde8>] (fbcon_switch) from [<c029c8f8>] (redraw_screen+0xf0/0x1e8)
[    1.254918]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:c070d5a0 r5:00000080
[    1.254928]  r4:c6808c00
[    1.254961] [<c029c808>] (redraw_screen) from [<c029d264>] (do_bind_con_driver+0x194/0x2e4)
[    1.254991]  r9:00000000 r8:00000000 r7:00000014 r6:c070d5a0 r5:c070d5a0 r4:c070d5a0

So prevent displaying a logo bigger than screen size and avoid invalid
memory access.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ea2bd6208a2f..9eae191728d2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -425,6 +425,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 {
 	unsigned int x;
 
+	if (image->width > info->var.xres || image->height > info->var.yres)
+		return;
+
 	if (rotate == FB_ROTATE_UR) {
 		for (x = 0;
 		     x < num && image->dx + image->width <= info->var.xres;
-- 
2.19.1

