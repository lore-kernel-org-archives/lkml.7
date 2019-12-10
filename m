Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001DDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B905D24683
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012017;
	bh=d1/7Kds7v+ai1CEyfO3dNe/acNmNrUZKjnSwFaYm9G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lspfxR3fbLZ+XO/K2JDmb3DBOv4g8Vt/BrsLE26nXgG/YJ9jz79CjJ6mswOyvUfGe
	 eshu6vzH9/toq6acpUZkut3k6lNdAX9C99245b4eF7jiVpYh75jjoiaMA1Qx4dTdqR
	 Rdsjsnony9j4M+uJgFfBlKhsJhJM+P+5Fb/SdXxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfLJVEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbfLJVEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5605121556;
        Tue, 10 Dec 2019 21:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011847;
        bh=d1/7Kds7v+ai1CEyfO3dNe/acNmNrUZKjnSwFaYm9G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El+nUov5hUp5pNedX2Mfb5oOpo+u60kAV4k4gyCEq41/PPocwW/ZMvFAsWhGgSMO1
         4j1fTlgLK8mlm7rgZpsxLnUHUYZk4hkkM7LFpbbIcigTnfDIqaXhVC/XC+IHfOo1gQ
         pKlOJNBudJaWbe8gtSnAZsgdMXNADxacW1MDR/ts=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>, Lyude Paul <lyude@redhat.com>,
        Todd Previte <tprevite@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 003/350] drm: mst: Fix query_payload ack reply struct
Date:   Tue, 10 Dec 2019 15:58:15 -0500
Message-Id: <20191210210402.8367-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 268de6530aa18fe5773062367fd119f0045f6e88 ]

Spec says[1] Allocated_PBN is 16 bits

[1]- DisplayPort 1.2 Spec, Section 2.11.9.8, Table 2-98

Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: Lyude Paul <lyude@redhat.com>
Cc: Todd Previte <tprevite@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190829165223.129662-1-sean@poorly.run
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_dp_mst_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index 2ba6253ea6d3f..fc349204a71bd 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -334,7 +334,7 @@ struct drm_dp_resource_status_notify {
 
 struct drm_dp_query_payload_ack_reply {
 	u8 port_number;
-	u8 allocated_pbn;
+	u16 allocated_pbn;
 };
 
 struct drm_dp_sideband_msg_req_body {
-- 
2.20.1

