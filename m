Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EE32064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714329;
	bh=U99Mo/Q91e3RNz7SrxPPvitkAUQH/eUfMXyKA0WCGrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2RQnMHyTV3dXQEw4UwJY5pxQOvkHZzmILUTEpWx88t2M9eZMmChjw6orjwZ+vTEMD
	 GIOOC8eKWZjr7/iUtVDFa3eMutplZs7UNZDf8FJvNrgIOIc8jQAVg8Bgl5yVzVwyVL
	 ETaD1uqgXIDTUHX45otIFpGltm7Dfew5DOxYyIoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfC0TSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388278AbfC0SIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED3FF2183F;
        Wed, 27 Mar 2019 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710079;
        bh=U99Mo/Q91e3RNz7SrxPPvitkAUQH/eUfMXyKA0WCGrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MydxmlNCWcVyFeVwC7BeUuH7PjD+TtDK9oG6eYs9nwmkijM3qwOaOpTjLG9tvZios
         gEZ9aACF8o/+49CIC5MBib2VDPSs8eM3d/pppodjMpWnb6IFRhYB+O/FuTRR9R15yp
         6a2tyIgyfA0vlzYLukeqP2UNd3DdDzCojP/EI6/M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shayenne Moura <shayenneluzmoura@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 189/262] drm/vkms: Bugfix extra vblank frame
Date:   Wed, 27 Mar 2019 14:00:44 -0400
Message-Id: <20190327180158.10245-189-sashal@kernel.org>
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

[ Upstream commit def35e7c592616bc09be328de8795e5e624a3cf8 ]

kms_flip tests are breaking on vkms when simulate vblank because vblank
event sequence count returns one extra frame after arm vblank event to
make a page flip.

When vblank interrupt happens, userspace processes the vblank event and
issues the next page flip command. Kernel calls queue_work to call
commit_planes and arm the new page flip. The next vblank picks up the
newly armed vblank event and vblank interrupt happens again.

The arm and vblank event are asynchronous, then, on the next vblank, we
receive x+2 from `get_vblank_timestamp`, instead x+1, although timestamp
and vblank seqno matches.

Function `get_vblank_timestamp` is reached by 2 ways:

  - from `drm_mode_page_flip_ioctl`: driver is doing one atomic
    operation to synchronize planes in the same output. There is no
    vblank simulation, the `drm_crtc_arm_vblank_event` function adds 1
    on vblank count, and the variable in_vblank_irq is false
  - from `vkms_vblank_simulate`: since the driver is doing a vblank
    simulation, the variable in_vblank_irq is true.

Fix this problem subtracting one vblank period from vblank_time when
`get_vblank_timestamp` is called from trace `drm_mode_page_flip_ioctl`,
i.e., is not a real vblank interrupt, and getting the timestamp and
vblank seqno when it is a real vblank interrupt.

The reason for all this is that get_vblank_timestamp always supplies the
timestamp for the next vblank event. The hrtimer is the vblank
simulator, and it needs the correct previous value to present the next
vblank. Since this is how hw timestamp registers work and what the
vblank core expects.

Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/171e6e1c239cbca0c3df7183ed8acdfeeace9cf4.1548856186.git.shayenneluzmoura@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 53ab49408a98..a0bef7de9df7 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -75,6 +75,9 @@ bool vkms_get_vblank_timestamp(struct drm_device *dev, unsigned int pipe,
 
 	*vblank_time = output->vblank_hrtimer.node.expires;
 
+	if (!in_vblank_irq)
+		*vblank_time -= output->period_ns;
+
 	return true;
 }
 
-- 
2.19.1

