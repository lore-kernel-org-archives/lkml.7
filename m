Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC01C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11F205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370709;
	bh=CEjMWr6Q8Cdtn5OH+1kS76ZifgJR0JatV5uLD6HRk1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fFenLWuZglIV9C13b9zSIJjhW2h75/CuuxVRavKiJWYTR1ZbsHvFRjieOsVaX8q6H
	 rFS73q4I0sg1hfKXlmvlq/pyvf7vXkygFEbYLb8NVDlatkbNsU4lGOGyJA1bsrXOic
	 F6vL0A39T/YRLVTAjJ/9xz1VGySIOXrd/nyJ0cZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfDDJES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730646AbfDDJEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2DE82147C;
        Thu,  4 Apr 2019 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368654;
        bh=CEjMWr6Q8Cdtn5OH+1kS76ZifgJR0JatV5uLD6HRk1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HbBE8YcINrjlcwTFvZUW4ofGbysJUye3XfQtcQRjYf6eMaNNCmZJTfv0pjTuau31
         OzSgApnyfCmSvreirj4N74qPzW+MPyrz2TtM4skkSM56R7NIAzZ/GobL+r//r1D7TR
         p4n92m/3HI+c9CflFdqrn90iX9XEGmnJAfyuyZD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 119/187] fbdev: fbmem: fix memory access if logo is bigger than the screen
Date:   Thu,  4 Apr 2019 10:47:36 +0200
Message-Id: <20190404084608.854117571@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 77cee99fc36c..c48f083d522a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -427,6 +427,9 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
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



