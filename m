Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC76AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A376218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258174;
	bh=CAxtnxRaOMvu5+W7q0jORA+g72ah8fojxNoPC9XNal4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rkP2Zjylw1emm+Yy2TcAMvLN5ZRVMLsandwAuIE0NRQzXf453B1W8/k+htua3CX2X
	 yVaeZaqQLmN45GTJNWcnBg+BaEEZx9OfsZ7pzHCby26DHI+xmKcSqyVIwQZgP6UPJI
	 TvnqpTkK7oLLb3sXxOVEXLlJlhhaqw7IvG2Bcry8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389514AbfCVMLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389165AbfCVMLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:11:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DBF21929;
        Fri, 22 Mar 2019 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256683;
        bh=CAxtnxRaOMvu5+W7q0jORA+g72ah8fojxNoPC9XNal4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWQgV3nFy5G8x/CpM8+Cyu8rUhBijh8sq7AUGrR+zjhM55BMKfpi0kQfIAD7PlPBj
         xCJCJ25wCLh5Z2oTnMyFXThhT1eE7eWbrGPN2NsmZJBGYlmMjrKXtUlWS13TgWNXyY
         IzPxo0yoJD8NI5HT13PC60p7NvKnblvTiHEXXwWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4.19 269/280] drm/fb-helper: generic: Fix drm_fbdev_client_restore()
Date:   Fri, 22 Mar 2019 12:17:02 +0100
Message-Id: <20190322111345.760929298@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

From: Noralf Trønnes <noralf@tronnes.org>

commit 78de14c23e031420aa5f61973583635eccd6cd2a upstream.

If fbdev setup has failed, lastclose will give a NULL pointer deref:

[   77.794295] [drm:drm_lastclose]
[   77.794414] [drm:drm_lastclose] driver lastclose completed
[   77.794660] Unable to handle kernel NULL pointer dereference at virtual address 00000014
[   77.809460] pgd = b376b71b
[   77.818275] [00000014] *pgd=175ba831, *pte=00000000, *ppte=00000000
[   77.830813] Internal error: Oops: 17 [#1] ARM
[   77.840963] Modules linked in: mi0283qt mipi_dbi tinydrm raspberrypi_hwmon gpio_backlight backlight snd_bcm2835(C) bcm2835_rng rng_core
[   77.865203] CPU: 0 PID: 527 Comm: lt-modetest Tainted: G         C        5.0.0-rc1+ #1
[   77.879525] Hardware name: BCM2835
[   77.889185] PC is at restore_fbdev_mode+0x20/0x164
[   77.900261] LR is at drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0x9c
[   78.002446] Process lt-modetest (pid: 527, stack limit = 0x7a3d5c14)
[   78.291030] Backtrace:
[   78.300815] [<c04f2d0c>] (restore_fbdev_mode) from [<c04f4708>] (drm_fb_helper_restore_fbdev_mode_unlocked+0x54/0x9c)
[   78.319095]  r9:d8a8a288 r8:d891acf0 r7:d7697910 r6:00000000 r5:d891ac00 r4:d891ac00
[   78.334432] [<c04f46b4>] (drm_fb_helper_restore_fbdev_mode_unlocked) from [<c04f47e8>] (drm_fbdev_client_restore+0x18/0x20)
[   78.353296]  r8:d76978c0 r7:d7697910 r6:d7697950 r5:d7697800 r4:d891ac00 r3:c04f47d0
[   78.368689] [<c04f47d0>] (drm_fbdev_client_restore) from [<c051b6b4>] (drm_client_dev_restore+0x7c/0xc0)
[   78.385982] [<c051b638>] (drm_client_dev_restore) from [<c04f8fd0>] (drm_lastclose+0xc4/0xd4)
[   78.402332]  r8:d76978c0 r7:d7471080 r6:c0e0c088 r5:d8a85e00 r4:d7697800
[   78.416688] [<c04f8f0c>] (drm_lastclose) from [<c04f9088>] (drm_release+0xa8/0x10c)
[   78.431929]  r5:d8a85e00 r4:d7697800
[   78.442989] [<c04f8fe0>] (drm_release) from [<c02640c4>] (__fput+0x104/0x1c8)
[   78.457740]  r8:d5ccea10 r7:d96cfb10 r6:00000008 r5:d74c1b90 r4:d8a8a280
[   78.472043] [<c0263fc0>] (__fput) from [<c02641ec>] (____fput+0x18/0x1c)
[   78.486363]  r10:00000006 r9:d7722000 r8:c01011c4 r7:00000000 r6:c0ebac6c r5:d892a340
[   78.501869]  r4:d8a8a280
[   78.512002] [<c02641d4>] (____fput) from [<c013ef1c>] (task_work_run+0x98/0xac)
[   78.527186] [<c013ee84>] (task_work_run) from [<c010cc54>] (do_work_pending+0x4f8/0x570)
[   78.543238]  r7:d7722030 r6:00000004 r5:d7723fb0 r4:00000000
[   78.556825] [<c010c75c>] (do_work_pending) from [<c0101034>] (slow_work_pending+0xc/0x20)
[   78.674256] ---[ end trace 70d3a60cf739be3b ]---

Fix by using drm_fb_helper_lastclose() which checks if fbdev is in use.

Fixes: 9060d7f49376 ("drm/fb-helper: Finish the generic fbdev emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190125150300.33268-1-noralf@tronnes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fb_helper.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -3156,9 +3156,7 @@ static void drm_fbdev_client_unregister(
 
 static int drm_fbdev_client_restore(struct drm_client_dev *client)
 {
-	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
-
-	drm_fb_helper_restore_fbdev_mode_unlocked(fb_helper);
+	drm_fb_helper_lastclose(client->dev);
 
 	return 0;
 }


