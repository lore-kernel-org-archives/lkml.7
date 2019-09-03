Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00709C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C8238C4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527964;
	bh=rsK/26JHP6dw/JKoiZY1zzQkRQGxmrL23SyTuBKBINY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qnCYNmGNQ4+B9rkYCAvrtmpRcY0YzFnrMgpgI4CaSc9xleYXunEuBSPeMlH1v/RdE
	 cSuHZSO49kkntGjYLp0VOutTzdrSFZAyZl3AoN9aebJJgHsOeB1Ed0YpaPTK4bPH13
	 VXt8zJnblhbsisWta8gEw4nPS7Mcm5VWchkVh/aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbfICQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbfICQZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C092343A;
        Tue,  3 Sep 2019 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527949;
        bh=rsK/26JHP6dw/JKoiZY1zzQkRQGxmrL23SyTuBKBINY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSN5SPKZx1M8rpSjnl5/YDpUT3hw8zOI9YcSAnxn4/7JJU6coR8X0c1b0+NVPbFEZ
         viAv6/OhmbaFo8205hKFi6PSME7VAvBmLjpUXQKlYJkjLqVoBQy92tWv3CalKl9QdW
         tnBKFF91huhR6sJFKMiLK6/PHUJvmWgj50e4wT0s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 016/167] drm/i915: Fix intel_dp_mst_best_encoder()
Date:   Tue,  3 Sep 2019 12:22:48 -0400
Message-Id: <20190903162519.7136-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit a9f9ca33d1fe9325f414914be526c0fc4ba5281c ]

Currently, i915 appears to rely on blocking modesets on
no-longer-present MSTB ports by simply returning NULL for
->best_encoder(), which in turn causes any new atomic commits that don't
disable the CRTC to fail. This is wrong however, since we still want to
allow userspace to disable CRTCs on no-longer-present MSTB ports by
changing the DPMS state to off and this still requires that we retrieve
an encoder.

So, fix this by always returning a valid encoder regardless of the state
of the MST port.

Changes since v1:
- Remove mst atomic helper, since this got replaced with a much simpler
  solution

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20181008232437.5571-6-lyude@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index 1fec0c71b4d95..58ba14966d4f1 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -408,8 +408,6 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
 
-	if (!READ_ONCE(connector->registered))
-		return NULL;
 	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
 
-- 
2.20.1

