Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D91C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79003258C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191123;
	bh=X+M34Of9+XS9yLB9PcXbJYs5GWQNKdBWPGagIpDaQ/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JC7unGmD+Wvv7OwKPx104qR2SQRd8WH6uajfviAq131iYKZWr6ugXaIeFh9pc2TZx
	 EGN/+BVBz/kIfSA3jLN+hh7mdWkhpFVSBTqnkXB2JzKZz74CnwTyIaU/No8qpWSXGb
	 uoojXi2WelY0KkXp7gA7MGZX6lhRd8ofMU96rNnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbfE3Eim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfE3DMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:43 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3A121BE2;
        Thu, 30 May 2019 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185963;
        bh=X+M34Of9+XS9yLB9PcXbJYs5GWQNKdBWPGagIpDaQ/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7ETZwkEn3+uvsdQ/vGYAuSIgbbAB4vvZs3SMS6r0eOZoUjpkWuty/JBV8OCf1fS2
         OUzie5cbs2GkUifRilCs9L2fO2sV/ytXu05WIII3BV+fUI6hdBoB7Pn5NNnjaKLzU1
         kXFiWt03oWJYR5rjPbsaQx5N8U4PRqJqk/w81N/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samson Tam <Samson.Tam@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 331/405] drm/amd/display: Link train only when link is DP and backend is enabled
Date:   Wed, 29 May 2019 20:05:29 -0700
Message-Id: <20190530030557.480084620@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 66acd4418d7de131ef3831e52a8af3d2480e5b15 ]

[Why]
In certain cases we do link training when we don't have a backend.

[How]
In dc_link_set_preferred_link_settings(), store preferred link settings
first and then verify that the link is DP and the link stream's backend is
enabled.  If either is false, then we will not do any link retraining.

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a6cda201c964c..c1a308c1dcbea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -524,6 +524,14 @@ void dc_link_set_preferred_link_settings(struct dc *dc,
 	struct dc_stream_state *link_stream;
 	struct dc_link_settings store_settings = *link_setting;
 
+	link->preferred_link_setting = store_settings;
+
+	/* Retrain with preferred link settings only relevant for
+	 * DP signal type
+	 */
+	if (!dc_is_dp_signal(link->connector_signal))
+		return;
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		if (pipe->stream && pipe->stream->link) {
@@ -538,7 +546,10 @@ void dc_link_set_preferred_link_settings(struct dc *dc,
 
 	link_stream = link->dc->current_state->res_ctx.pipe_ctx[i].stream;
 
-	link->preferred_link_setting = store_settings;
+	/* Cannot retrain link if backend is off */
+	if (link_stream->dpms_off)
+		return;
+
 	if (link_stream)
 		decide_link_settings(link_stream, &store_settings);
 
-- 
2.20.1



