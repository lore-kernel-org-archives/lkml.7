Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E929C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428002064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714335;
	bh=U4FrbHQVU5pAAR6QFdkGVBhH645KpOhMaj1MOvfwEtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RiZiFhi722AkhPbiu7F9CrfWejuh22iVnVniwX4O96/V2l0NHhXJywHdLV6EiPwyh
	 dTzQcmYKTNqO8BFmqiBY1a7dfaJw25q8MBruirclp98jmjkEOnwuETurH/EvC2r1th
	 4cqQPLUO0sGU2MtEM1IUqCEpF+IecpGxr0G3GCn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbfC0TSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388275AbfC0SH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C147D2184D;
        Wed, 27 Mar 2019 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710078;
        bh=U4FrbHQVU5pAAR6QFdkGVBhH645KpOhMaj1MOvfwEtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhR3/Ad59opa0n03f0euYNt6oZmXB7ecQCk1fP4PMSPTJdASoCrGvWCdv5YKTpR3j
         HIbnT3dUUzgL2149pWPCD1D1wzZUpuGpsN/RDnOn0le0yGgMCn+kmFe9rb3XmykekR
         hBXI7Gh4uSmERzqDXO5EyUl8n93RrMgVzhxv7sgU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 188/262] drm/vkms: Bugfix racing hrtimer vblank handle
Date:   Wed, 27 Mar 2019 14:00:43 -0400
Message-Id: <20190327180158.10245-188-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shayenne Moura <shayenneluzmoura@gmail.com>

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
index eb56ee893761..53ab49408a98 100644
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

