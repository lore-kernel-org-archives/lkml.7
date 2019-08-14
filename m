Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6521CC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB92214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802291;
	bh=+Vmb9IamE77TGDyT4IHgDRj2Pbc9meitggKVzXt6uVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UYD9yvxJgS1J1T5sHJtXgHonGm8sw6Ad9f6Pr3Kk2sGaPciNLpWu1JJUtNjvKx/bt
	 H0np/sa2IhXnUz3lUjncUCdC7bkEt2EGAWLk+wYeLJhzoYSuV3Hm7NN9u9AzyPT+7y
	 WjjzRVtVXysggaOAEVZZbeKPmhs2cjl4+tx8KmG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfHNREu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbfHNREr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:04:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF5D2084D;
        Wed, 14 Aug 2019 17:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802286;
        bh=+Vmb9IamE77TGDyT4IHgDRj2Pbc9meitggKVzXt6uVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMw9UQPLnNOXeBWU4HGVczLMEs3lz9hxQK8AWm+tpWxm2d8bXu28EvusD41KFDuAH
         1yT9NRoHs3HjeZJyNix+r3KOV24zrP3fMkeutAfgyQ8qFs7cL88fllPern1w+nOG2D
         ApX/j/5ha/LayYvm/I+ng2LX5g/9gKiDOys9l34U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zi Yu Liao <ziyu.liao@amd.com>,
        Eric Yang <eric.yang2@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 067/144] drm/amd/display: fix DMCU hang when going into Modern Standby
Date:   Wed, 14 Aug 2019 19:00:23 +0200
Message-Id: <20190814165802.645888536@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



