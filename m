Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1730FC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE9C21D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="Vx6MN3ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbfKFRBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:23 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:32429 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbfKFRBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573059666;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=U9jpWVAVI4H0QzeOFwQuOzYJ4uhUGMoHYCQ/+t9hVSI=;
        b=Vx6MN3ok8VHhcTcabS4vBasAjw7b4WR8aVXM78TyW1zp3OjvQCJFL+FU54aviONG20
        zcqxagUR4AZvBQj8eS6KKgV+oNUIVfHQmGl648ObsAcvfjjV19/zNoOUhSwiEKCqyW9c
        EiwsohkPk/cDDQXKZ0/OxR/aypMYrVGb4asMjnXu+Ap/Qu7eMoBYi/K/0mGfeiYqXpvn
        UXkpd8jhkaHzRMZJhSepghaQIq9a9Z55oyfVCTnXQGjBGAVC2+JmsLv9TC7SrU4gMB8y
        JzK6k8oEqcDveaouP8sTQnBArxARG+JFxTm20OgukLbcIbQiYZCCpg8CmtVTYltU489w
        vAfw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXs8PvtBNfIQ=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA6H15hLx
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 18:01:05 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 7/7] drm/mcde: Handle pending vblank while disabling display
Date:   Wed,  6 Nov 2019 17:58:35 +0100
Message-Id: <20191106165835.2863-8-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106165835.2863-1-stephan@gerhold.net>
References: <20191106165835.2863-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disabling the display using MCDE currently results in a warning
together with a delay caused by some timeouts:

    mcde a0350000.mcde: MCDE display is disabled
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 20 at drivers/gpu/drm/drm_atomic_helper.c:2258 drm_atomic_helper_commit_hw_done+0xe0/0xe4
    Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
    Workqueue: events drm_mode_rmfb_work_fn
    [<c010f468>] (unwind_backtrace) from [<c010b54c>] (show_stack+0x10/0x14)
    [<c010b54c>] (show_stack) from [<c079dd90>] (dump_stack+0x84/0x98)
    [<c079dd90>] (dump_stack) from [<c011d1b0>] (__warn+0xb8/0xd4)
    [<c011d1b0>] (__warn) from [<c011d230>] (warn_slowpath_fmt+0x64/0xc4)
    [<c011d230>] (warn_slowpath_fmt) from [<c0413048>] (drm_atomic_helper_commit_hw_done+0xe0/0xe4)
    [<c0413048>] (drm_atomic_helper_commit_hw_done) from [<c04159cc>] (drm_atomic_helper_commit_tail_rpm+0x44/0x6c)
    [<c04159cc>] (drm_atomic_helper_commit_tail_rpm) from [<c0415f5c>] (commit_tail+0x50/0x10c)
    [<c0415f5c>] (commit_tail) from [<c04160dc>] (drm_atomic_helper_commit+0xbc/0x128)
    [<c04160dc>] (drm_atomic_helper_commit) from [<c0430790>] (drm_framebuffer_remove+0x390/0x428)
    [<c0430790>] (drm_framebuffer_remove) from [<c0430860>] (drm_mode_rmfb_work_fn+0x38/0x48)
    [<c0430860>] (drm_mode_rmfb_work_fn) from [<c01368a8>] (process_one_work+0x1f0/0x43c)
    [<c01368a8>] (process_one_work) from [<c0136d48>] (worker_thread+0x254/0x55c)
    [<c0136d48>] (worker_thread) from [<c013c014>] (kthread+0x124/0x150)
    [<c013c014>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
    Exception stack(0xeb14dfb0 to 0xeb14dff8)
    dfa0:                                     00000000 00000000 00000000 00000000
    dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
    dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
    ---[ end trace 314909bcd4c7d50c ]---
    [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:32:crtc-0] flip_done timed out
    [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONNECTOR:34:DSI-1] flip_done timed out
    [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:31:plane-0] flip_done timed out

The reason for this is that there is a vblank event pending, but we
never handle it after disabling the vblank interrupts.

Check if there is an vblank event pending when disabling the display,
and clear it by sending a fake vblank event in that case.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/gpu/drm/mcde/mcde_display.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index a3375a974caf..e59907e68854 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -949,12 +949,22 @@ static void mcde_display_disable(struct drm_simple_display_pipe *pipe)
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_device *drm = crtc->dev;
 	struct mcde *mcde = drm->dev_private;
+	struct drm_pending_vblank_event *event;
 
 	drm_crtc_vblank_off(crtc);
 
 	/* Disable FIFO A flow */
 	mcde_disable_fifo(mcde, MCDE_FIFO_A, true);
 
+	event = crtc->state->event;
+	if (event) {
+		crtc->state->event = NULL;
+
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+
 	dev_info(drm->dev, "MCDE display is disabled\n");
 }
 
-- 
2.23.0

