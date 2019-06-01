Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00BAC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF882613B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395379;
	bh=mzRhmXuI4ZWTSvCv+QrJuuMfqNv47a8FqXXXnGcwYpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=txrqhNtFCENZnKIhgWz2vvUa9xaqYC868zw+cqFyw1YBkLxnIQHUKKuc0N0vdvp1M
	 tcN8wCWLriit4LxN5rLAkmKw+m48aQ53qaiq8v2ZOf4n/rNq0GkU31bER8bRQulOzX
	 gx762/v4hNUQPpsGYUxFPUHECJx00hWTtBgV4YYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfFANW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfFANWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:22:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077E22613B;
        Sat,  1 Jun 2019 13:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395374;
        bh=mzRhmXuI4ZWTSvCv+QrJuuMfqNv47a8FqXXXnGcwYpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjhUVA12LOGbjhZe+znJiI+iESJeK++MWO6ImWALEvemw/3aVjS3dSI3++v4VfhsL
         Hz7ELAJLdrkD9LtG1TwMIStvbCTtSi9MyDrib/R/aM3J72vVu/wpqAqNLQIPS7ybHU
         W1S6X2PPg795/f+iYGKLphioVH98wajJL8dvXgQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 024/141] drm/nouveau/kms/gf119-gp10x: push HeadSetControlOutputResource() mthd when encoders change
Date:   Sat,  1 Jun 2019 09:20:00 -0400
Message-Id: <20190601132158.25821-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit a0b694d0af21c9993d1a39a75fd814bd48bf7eb4 ]

HW has error checks in place which check that pixel depth is explicitly
provided on DP, while HDMI has a "default" setting that we use.

In multi-display configurations with identical modelines, but different
protocols (HDMI + DP, in this case), it was possible for the DP head to
get swapped to the head which previously drove the HDMI output, without
updating HeadSetControlOutputResource(), triggering the error check and
hanging the core update.

Reported-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/head.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 4f57e53797968..d81a99bb2ac31 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -306,7 +306,7 @@ nv50_head_atomic_check(struct drm_crtc *crtc, struct drm_crtc_state *state)
 			asyh->set.or = head->func->or != NULL;
 		}
 
-		if (asyh->state.mode_changed)
+		if (asyh->state.mode_changed || asyh->state.connectors_changed)
 			nv50_head_atomic_check_mode(head, asyh);
 
 		if (asyh->state.color_mgmt_changed ||
-- 
2.20.1

