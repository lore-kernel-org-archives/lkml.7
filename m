Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB6C28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55AD5276E8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396603;
	bh=3AxVhhfeTwP/UIeayUxSzq1J3kA3JwnFmCZfJ9onbEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9HylrjR2kHQYP4IBuuS7P/Jo0tdjD9u9pIK6ueSwf+uP1DsNuUzvYjTZ7k6cKsnX
	 fnPmFHg3OXMmRKlqfx5hoooX0jxZKXkR2sV2978rk0XxueAZg3ifRinKwcLf1FOT08
	 /kRHjXTvwzm8EWAvYqObgetoxWWlPjzxRHrJctu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfFANSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfFANSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:18:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F71229EB;
        Sat,  1 Jun 2019 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395096;
        bh=3AxVhhfeTwP/UIeayUxSzq1J3kA3JwnFmCZfJ9onbEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LCw2KpJxmuTo/9IBnSEa1BC8GFJaweFK+D5gcnuD4hgCK+RL8u8IlN3yL5+uBqugu
         Z33xzqf22MWXjdg6b7ba2fDsP/ZqAEYj9MmntK8Dn9kqaJfozsp+GTk4eAwg1SBXOb
         y1MlnIEzq9EVvHY7cvP8sxWQSUPEKE0qP3oaFWc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 031/186] drm/nouveau/kms/gf119-gp10x: push HeadSetControlOutputResource() mthd when encoders change
Date:   Sat,  1 Jun 2019 09:14:07 -0400
Message-Id: <20190601131653.24205-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
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
index 2e7a0c347ddbe..8efb778a3b207 100644
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

