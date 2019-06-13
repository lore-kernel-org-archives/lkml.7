Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F009C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D8F20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441620;
	bh=gvNTGMetgZrxKRD7wjxmPiYEtOnGN4ElSH6eR00rTic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZ7hyI/r4u61hlB0chNITDMGL3aQn3J7skMasBYFrr1NOLpY4QP4M0QZ8k0XLhlAB
	 eklHKzd8cc79bPv6ZTu1JK7XKYQicUHTJXREwFMFnP5iF/6CXTxvd8hEt08jAywItE
	 zDewe7oDSWA516S+FtkeX/XJbAr8QQfLvMPElF7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfFMQAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731473AbfFMIt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:49:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ED1120851;
        Thu, 13 Jun 2019 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415766;
        bh=gvNTGMetgZrxKRD7wjxmPiYEtOnGN4ElSH6eR00rTic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yviVbGCcCyfapYnTHmGyXKYjpK+xtIwxNFkN3PS+OVplUcnyo4o1U4Nsv05d5dMC9
         q0rPN0J2kryHe629cLE5cIdRUqb+j2T8ZblOxWDczCJ1UvY1ih04chPnIjmHyt44ov
         09sXvIgRMWVDvMD67WSCPJNAsv01l+lnepIAqM4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Koo <Anthony.Koo@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 115/155] drm/amd/display: disable link before changing link settings
Date:   Thu, 13 Jun 2019 10:33:47 +0200
Message-Id: <20190613075659.358473914@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 15ae3b28f8ca406b449d36d36021e96b66aedb5d ]

[Why]
If link is already enabled at a different rate (for example 5.4 Gbps)
then calling VBIOS command table to switch to a new rate
(for example 2.7 Gbps) will not take effect.
This can lead to link training failure to occur.

[How]
If the requested link rate is different than the current link rate,
the link must be disabled in order to re-enable at the new
link rate.

In today's logic it is currently only impacting eDP since DP
connection types will always disable the link during display
detection, when initial link verification occurs.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 419e8de8c0f4..6072636da388 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1399,6 +1399,15 @@ static enum dc_status enable_link_dp(
 	/* get link settings for video mode timing */
 	decide_link_settings(stream, &link_settings);
 
+	/* If link settings are different than current and link already enabled
+	 * then need to disable before programming to new rate.
+	 */
+	if (link->link_status.link_active &&
+		(link->cur_link_settings.lane_count != link_settings.lane_count ||
+		 link->cur_link_settings.link_rate != link_settings.link_rate)) {
+		dp_disable_link_phy(link, pipe_ctx->stream->signal);
+	}
+
 	pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =
 			link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 	state->dccg->funcs->update_clocks(state->dccg, state, false);
-- 
2.20.1



