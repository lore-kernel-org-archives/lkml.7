Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AE3205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713021;
	bh=XASugdvVtICuJHDzVetcNT8cTDu32mye90I5beYVLZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hvD9X4c4lvBduPMlbkXRwootxB+7lu/zhO4sLPf1ooC9BE7bF/fBtdY2z+6LD+wiU
	 lQOdz1rAInS6hztC8K7+hDyc+KuE2Z+OojN7iTnpU7XipxIGjU5j2pNEHKP6BjBUUc
	 SjvNbruziht8Ebzrzbl65d+WjDghuXM3j59mn52U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbfC0S5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:57:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390000AbfC0SQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B54B02184C;
        Wed, 27 Mar 2019 18:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710574;
        bh=XASugdvVtICuJHDzVetcNT8cTDu32mye90I5beYVLZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3tlHX3/qRm3SyLFqetWmMPqtTZxp0NWjE6TJ/eUlQ0jpIEO6RKEPWkwNPMogCNJU
         SXMI5XL0XquUMmJgvzkvJci5c59aetEcHWDGWBg7B9u1kUeprFV4PVrO6sWH+FVzD/
         ZnyRAE8sLnAcyFet3RV3ZRp76OcRNHsJt3KLOPEU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Wu <peter@lekensteyn.nl>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 183/192] drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup
Date:   Wed, 27 Mar 2019 14:10:15 -0400
Message-Id: <20190327181025.13507-183-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Wu <peter@lekensteyn.nl>

[ Upstream commit 00eb5b0da8d27b3c944bfc959c3344d665caae26 ]

After drm_fb_helper_fbdev_setup calls drm_fb_helper_init,
"dev->fb_helper" will be initialized (and thus drm_fb_helper_fini will
have some effect). After that, drm_fb_helper_initial_config is called
which may call the "fb_probe" driver callback.

This driver callback may call drm_fb_helper_defio_init (as is done by
drm_fb_helper_generic_probe) or set a framebuffer (as is done by bochs)
as documented. These are normally cleaned up on exit by
drm_fb_helper_fbdev_teardown which also calls drm_fb_helper_fini.

If an error occurs after "fb_probe", but before setup is complete, then
calling just drm_fb_helper_fini will leak resources. This was triggered
by df2052cc922 ("bochs: convert to drm_fb_helper_fbdev_setup/teardown"):

    [   50.008030] bochsdrmfb: enable CONFIG_FB_LITTLE_ENDIAN to support this framebuffer
    [   50.009436] bochs-drm 0000:00:02.0: [drm:drm_fb_helper_fbdev_setup] *ERROR* fbdev: Failed to set configuration (ret=-38)
    [   50.011456] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 2
    [   50.013604] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x280/0x2a0
    [   50.016175] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 4.20.0-rc7 #1
    [   50.017732] EIP: drm_mode_config_cleanup+0x280/0x2a0
    ...
    [   50.023155] Call Trace:
    [   50.023155]  ? bochs_kms_fini+0x1e/0x30
    [   50.023155]  ? bochs_unload+0x18/0x40

This can be reproduced with QEMU and CONFIG_FB_LITTLE_ENDIAN=n.

Link: https://lkml.kernel.org/r/20181221083226.GI23332@shao2-debian
Link: https://lkml.kernel.org/r/20181223004315.GA11455@al
Fixes: 8741216396b2 ("drm/fb-helper: Add drm_fb_helper_fbdev_setup/teardown()")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20181223005507.28328-1-peter@lekensteyn.nl
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index e65596617239..a0663f44e218 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2877,7 +2877,7 @@ int drm_fb_helper_fbdev_setup(struct drm_device *dev,
 	return 0;
 
 err_drm_fb_helper_fini:
-	drm_fb_helper_fini(fb_helper);
+	drm_fb_helper_fbdev_teardown(dev);
 
 	return ret;
 }
-- 
2.19.1

