Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DADAC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4307427635
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396396;
	bh=Au6V8N1tGmfWzLGZV8cy65ZWNYgqrGSrVTj21xNZJog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m90d2ebvH8FBACVu6bPP6XY1HmjQXByyCBo2/hlo79FGdBS0qkhXeOlh2WNXOG0nw
	 PsIf0D6/tJO9FkymGGYUTyCDR27qqRkrMhjDVA3niN4J+615QzPoW8g8zRpSPOd29C
	 5VM+NLMjiA4JnWg153Gezn5SGc9e7hyUpiTry0Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFANjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfFANUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:20:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D96272D8;
        Sat,  1 Jun 2019 13:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395250;
        bh=Au6V8N1tGmfWzLGZV8cy65ZWNYgqrGSrVTj21xNZJog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKaFq0dvIUQv1mlHxE/3KOxafivpWZ+gn7EEVeyr0QnxZC+2J5xxMLasbmGFVZamD
         99+VbdH5NkHdIiWKwk+V0NzQRtoN/dJtfYMetz6RvYsWb4NF8YZk1WnOtgJDVQvfw7
         GrbMThKJMmSkhCVy0//pPAGTNtL1c8/zseCu1Ti0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 026/173] drm/nouveau/disp/dp: respect sink limits when selecting failsafe link configuration
Date:   Sat,  1 Jun 2019 09:16:58 -0400
Message-Id: <20190601131934.25053-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 13d03e9daf70dab032c03dc172e75bb98ad899c4 ]

Where possible, we want the failsafe link configuration (one which won't
hang the OR during modeset because of not enough bandwidth for the mode)
to also be supported by the sink.

This prevents "link rate unsupported by sink" messages when link training
fails.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
index 5f301e632599b..818d21bd28d31 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c
@@ -365,8 +365,15 @@ nvkm_dp_train(struct nvkm_dp *dp, u32 dataKBps)
 	 * and it's better to have a failed modeset than that.
 	 */
 	for (cfg = nvkm_dp_rates; cfg->rate; cfg++) {
-		if (cfg->nr <= outp_nr && cfg->nr <= outp_bw)
-			failsafe = cfg;
+		if (cfg->nr <= outp_nr && cfg->nr <= outp_bw) {
+			/* Try to respect sink limits too when selecting
+			 * lowest link configuration.
+			 */
+			if (!failsafe ||
+			    (cfg->nr <= sink_nr && cfg->bw <= sink_bw))
+				failsafe = cfg;
+		}
+
 		if (failsafe && cfg[1].rate < dataKBps)
 			break;
 	}
-- 
2.20.1

