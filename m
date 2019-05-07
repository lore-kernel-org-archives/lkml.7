Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E39CC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34573214AE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207616;
	bh=HeUEZ4EShkEDGQAY7rwzP+ZLsb5wZJcbmnVnt73gLow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Na1WsYTldhjsnemFYmHO7dVCk2UeDQowdOfZ7nx9/aajrDedYqXAVvpzNnK83xV4i
	 KauwfjGXYSb+0WXeudOOhwsFdw2lGEwRcmw+GGaJKUl7AzaI3ujHNHgpY6gy8/PwyX
	 +ahOYb86i1FGW78MiqS5nKPx0euHOlt9W4JUO1xA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfEGFkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfEGFkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC0DA20B7C;
        Tue,  7 May 2019 05:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207611;
        bh=HeUEZ4EShkEDGQAY7rwzP+ZLsb5wZJcbmnVnt73gLow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SeGZPjJHMW7Ehi4/0hwbjnWFIEIy9HLKjxkh/wCe9TztuUle/iiQSafqz9WKjejqB
         56YAHMp5TYdKvvLd60OkU0RF64icVsrH2Sz3nHf4wM+pta7DGYoEbIt0fAIXusgJ6c
         lh5W5db25aQZznMPihUh+b4tIWKlPZqY2oSj9Vt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 55/95] drm/i915: Downgrade Gen9 Plane WM latency error
Date:   Tue,  7 May 2019 01:37:44 -0400
Message-Id: <20190507053826.31622-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit 86c1c87d0e6241cbe35bd52badfc84b154e1b959 ]

According to intel_read_wm_latency() it is perfectly legal for one WM
and all subsequent levels to be 0 (and the deeper powersaving states
disabled), so don't shout *ERROR*, over and over again.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180726161527.10516-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/i915/intel_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 96a5237741e0..cb377b003321 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -2934,8 +2934,8 @@ static void intel_print_wm_latency(struct drm_i915_private *dev_priv,
 		unsigned int latency = wm[level];
 
 		if (latency == 0) {
-			DRM_ERROR("%s WM%d latency not provided\n",
-				  name, level);
+			DRM_DEBUG_KMS("%s WM%d latency not provided\n",
+				      name, level);
 			continue;
 		}
 
-- 
2.20.1

