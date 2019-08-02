Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8330BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9A721849
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752028;
	bh=jv1eVo24L+RI8/jG57GNMt//FucVNI5ykIC/Cwrx+a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/f0ug4sgw3nR1zrDe0Ko8wwQzQvY6BOVWXpPFKPWVIGcc5WMOcQlX1w4XW3+7sB6
	 wBz6Kr3Wf4K4dOYHDTRybcDe2/s2r3Iv0QhLyhf0VtqqbLTOzmregOZZGWxgngd0JY
	 iRBoLJ+1oygfovN2xDC+JeVqrtV4/HXbl6nR14+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393371AbfHBNU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393318AbfHBNUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:20:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D642173E;
        Fri,  2 Aug 2019 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752016;
        bh=jv1eVo24L+RI8/jG57GNMt//FucVNI5ykIC/Cwrx+a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zv4wlJd39KtgiQHfGXBLeic+AFwwpCPDqDy6Hyagf8DmvkQM5sPEvQel8PRPm5ntv
         IkxNANLSXleXem8Y41TR3JJoiAiz+WUOFrURjz3Niya+ArUkZ1GksDd0WYE4TLWqQv
         rIyx54XwZ069NnuETLQG//Ueg6ianIVyU+EQnJdU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zi Yu Liao <ziyu.liao@amd.com>, Eric Yang <eric.yang2@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 19/76] drm/amd/display: fix DMCU hang when going into Modern Standby
Date:   Fri,  2 Aug 2019 09:18:53 -0400
Message-Id: <20190802131951.11600-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yu Liao <ziyu.liao@amd.com>

[ Upstream commit 1ca068ed34d6b39d336c1b0d618ed73ba8f04548 ]

[why]
When the system is going into suspend, set_backlight gets called
after the eDP got blanked. Since smooth brightness is enabled,
the driver will make a call into the DMCU to ramp the brightness.
The DMCU would try to enable ABM to do so. But since the display is
blanked, this ends up causing ABM1_ACE_DBUF_REG_UPDATE_PENDING to
get stuck at 1, which results in a dead lock in the DMCU firmware.

[how]
Disable brightness ramping when the eDP display is blanked.

Signed-off-by: Zi Yu Liao <ziyu.liao@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a3ff33ff6da16..adf39e3b8d29d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2284,7 +2284,7 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 			if (core_dc->current_state->res_ctx.pipe_ctx[i].stream) {
 				if (core_dc->current_state->res_ctx.
 						pipe_ctx[i].stream->link
-						== link)
+						== link) {
 					/* DMCU -1 for all controller id values,
 					 * therefore +1 here
 					 */
@@ -2292,6 +2292,13 @@ bool dc_link_set_backlight_level(const struct dc_link *link,
 						core_dc->current_state->
 						res_ctx.pipe_ctx[i].stream_res.tg->inst +
 						1;
+
+					/* Disable brightness ramping when the display is blanked
+					 * as it can hang the DMCU
+					 */
+					if (core_dc->current_state->res_ctx.pipe_ctx[i].plane_state == NULL)
+						frame_ramp = 0;
+				}
 			}
 		}
 		abm->funcs->set_backlight_level_pwm(
-- 
2.20.1

