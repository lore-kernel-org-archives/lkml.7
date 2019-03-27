Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B359C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427FD206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714031;
	bh=01VqPdlFPIK6RNZX2Ff987mTB+xR27JBA6daZlddGLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VgTbQiSWpss+jimA+0GcvLN4PIb+WfGCh1eLm9N9H+0Rsv4GR7i4cIeoiIZef5DQ/
	 mm+4jeSjlJLwmtJEM7pmrsHc9n8t8QdbFm6Hyk204es3DduTtWPvFGrOMNgHZYMJ7q
	 EL46f63MLOpdVntMSL+L0KavWOS0Dwz4+awtjEic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388871AbfC0TNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbfC0SKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F32B2184C;
        Wed, 27 Mar 2019 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710203;
        bh=01VqPdlFPIK6RNZX2Ff987mTB+xR27JBA6daZlddGLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZWpmB1D0u9jThXdFuZtEKrWZb5ZAnlEjD7gkaM7yOz47VpNq4taxePQQjGKm++O1
         aFcEq9eYA25k0SkUeJhLn0CWqdiqQX3BRHBZRmu15oDPqz1lMjlI2+0LfssXNSZ/J2
         VB05hi9cPY52Q4iSjlls4BPVzoMVW2jsbC1CjH1o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Wu <peter@lekensteyn.nl>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 248/262] drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup
Date:   Wed, 27 Mar 2019 14:01:43 -0400
Message-Id: <20190327180158.10245-248-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 70fc8e356b18..edd8cb497f3b 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2891,7 +2891,7 @@ int drm_fb_helper_fbdev_setup(struct drm_device *dev,
 	return 0;
 
 err_drm_fb_helper_fini:
-	drm_fb_helper_fini(fb_helper);
+	drm_fb_helper_fbdev_teardown(dev);
 
 	return ret;
 }
-- 
2.19.1

