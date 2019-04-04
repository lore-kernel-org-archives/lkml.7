Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4139F214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369358;
	bh=7oG/zkV8JLr5pnAutFtVseolLo+zN8u4D3ZJJcnVSOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rt/plX9Pe9O84lTUYoj7I0haTdQVKnne/c6TxRoGBrEo/kORX0RVcBsrH8KQIn4DN
	 96IVZOedCnw6OQs/KjgAYanYeods70CvJIyO/sZ7Ka7eHi/rzR60e2TgR8xEPBIDAo
	 yxHEoyk9MzJyq131bde5iqi71CvPwxiZriGI0+MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733280AbfDDJP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387728AbfDDJPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996D2214AF;
        Thu,  4 Apr 2019 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369350;
        bh=7oG/zkV8JLr5pnAutFtVseolLo+zN8u4D3ZJJcnVSOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWV7ejDSjh7YJfp2i5espNGACAyRjngRoyu5jpaG/Q4LiYDpFkOyK/osADKKry27g
         l5BKKsr7M+fLwT5R9q+FGoOd2oj/M3pyDbfkFxFbGWFwNeSvSMZ0C2uV5QtqxVWnMW
         d4WGYOx8S2gV57s8ppPIjVI0cSnKKjsWO6kC4dpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shayenne Moura <shayenneluzmoura@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 178/246] drm/vkms: Bugfix extra vblank frame
Date:   Thu,  4 Apr 2019 10:47:58 +0200
Message-Id: <20190404084625.411787184@linuxfoundation.org>
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
index 00d961862d77..1054f535178a 100644
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



