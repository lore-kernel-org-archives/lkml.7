Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD36C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97FF21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfICV5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfICV5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:57:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 023A73082133;
        Tue,  3 Sep 2019 21:57:16 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00C161001947;
        Tue,  3 Sep 2019 21:57:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/dp_mst: Combine redundant cases in drm_dp_encode_sideband_req()
Date:   Tue,  3 Sep 2019 17:57:02 -0400
Message-Id: <20190903215702.16984-1-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-7-lyude@redhat.com>
References: <20190903204645.25487-7-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 03 Sep 2019 21:57:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this while working on adding a drm_dp_decode_sideband_req().
DP_POWER_DOWN_PHY/DP_POWER_UP_PHY both use the same struct as
DP_ENUM_PATH_RESOURCES, so we can just combine their cases.

Changes since v2:
* Fix commit message

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 6f7f449ca12b..1c862749cb63 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -271,6 +271,8 @@ static void drm_dp_encode_sideband_req(struct drm_dp_sideband_msg_req_body *req,
 
 	switch (req->req_type) {
 	case DP_ENUM_PATH_RESOURCES:
+	case DP_POWER_DOWN_PHY:
+	case DP_POWER_UP_PHY:
 		buf[idx] = (req->u.port_num.port_number & 0xf) << 4;
 		idx++;
 		break;
@@ -358,12 +360,6 @@ static void drm_dp_encode_sideband_req(struct drm_dp_sideband_msg_req_body *req,
 		memcpy(&buf[idx], req->u.i2c_write.bytes, req->u.i2c_write.num_bytes);
 		idx += req->u.i2c_write.num_bytes;
 		break;
-
-	case DP_POWER_DOWN_PHY:
-	case DP_POWER_UP_PHY:
-		buf[idx] = (req->u.port_num.port_number & 0xf) << 4;
-		idx++;
-		break;
 	}
 	raw->cur_len = idx;
 }
-- 
2.21.0

