Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA54C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819C620657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369771;
	bh=TVpYoRwqP//PnvcsWAv6NGtEpoLgzlXMyHD28shlvn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SzGFN7GXRUjwpyzecAQkPaZjNMV3IdhNpaYjNhHzjIKAnmX/zYl2h3WkZQYlCjFjs
	 +JOSWIAMgHgvpcv0ZCxmtfBhmGUON3rEnK4pR97J09tnpkrQ5alBzApl4jgQw2yuT1
	 4VvaVVtSyKjgzBF7WI0J8p3lDC1bmQMUTMYEnL00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfDDJWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387538AbfDDJPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F7021734;
        Thu,  4 Apr 2019 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369347;
        bh=TVpYoRwqP//PnvcsWAv6NGtEpoLgzlXMyHD28shlvn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8Crgzql0TlZJr6DPwKkymu8nHKBB4svSUABRuU8NzJO0bYnoTf0tL7iAXWhEml6R
         jA01SWLXq+9utp33kUNZSJE3KH8DXlE+nlG6je5z0SnwzlJDJAyAYaP3dsvebbc6c4
         lqVzRovY5MYOk5T2gcqlcJTje8VGHeCn26jlbT9w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shayenne Moura <shayenneluzmoura@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 177/246] drm/vkms: Bugfix racing hrtimer vblank handle
Date:   Thu,  4 Apr 2019 10:47:57 +0200
Message-Id: <20190404084625.376610155@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ba420afab565bdc7b028ddd4f222260f2de7a1db ]

When the vblank irq happens, kernel time subsystem executes
`vkms_vblank_simulate`. In parallel or not, it prepares all stuff
necessary to the next vblank with arm, and it must flush these stuff
before the next vblank irq. However, vblank counter is ahead when arm is
executed in parallel with handle vblank.

CPU 0:					CPU 1:
 |					 |
atomic_commit_tail is ongoing		 |
 |					 |
 |					hrtimer: vkms_vblank_simulate()
 |					 |
 |					drm_crtc_handle_vblank()
 |					 |
drm_crtc_arm_vblank()			 |
 |					 |
->get_vblank_timestamp()		 |
 |					 |
 |					hrtimer_forward_now()

Then, we should guarantee that the vblank interval time is correct (not
changed) before finish the vblank handle.

Fix the bug including the call to `hrtimer_forward_now()` in the same
lock of `drm_crtc_handle_vblank()` to ensure that the timestamp update
is correct when finish the vblank handle.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/e2e4b8f3a5cab7b2dba75bf1930f86b0a4ee08c9.1548856186.git.shayenneluzmoura@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index e747a7d16739..00d961862d77 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -4,13 +4,17 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 
-static void _vblank_handle(struct vkms_output *output)
+static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 {
+	struct vkms_output *output = container_of(timer, struct vkms_output,
+						  vblank_hrtimer);
 	struct drm_crtc *crtc = &output->crtc;
 	struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
+	int ret_overrun;
 	bool ret;
 
 	spin_lock(&output->lock);
+
 	ret = drm_crtc_handle_vblank(crtc);
 	if (!ret)
 		DRM_ERROR("vkms failure on handling vblank");
@@ -31,19 +35,9 @@ static void _vblank_handle(struct vkms_output *output)
 			DRM_WARN("failed to queue vkms_crc_work_handle");
 	}
 
-	spin_unlock(&output->lock);
-}
-
-static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
-{
-	struct vkms_output *output = container_of(timer, struct vkms_output,
-						  vblank_hrtimer);
-	int ret_overrun;
-
-	_vblank_handle(output);
-
 	ret_overrun = hrtimer_forward_now(&output->vblank_hrtimer,
 					  output->period_ns);
+	spin_unlock(&output->lock);
 
 	return HRTIMER_RESTART;
 }
-- 
2.19.1



