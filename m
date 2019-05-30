Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9ECC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EE62522D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189719;
	bh=20NGHh9hI3pUhV5NSLVTioijjfVOpQ0vS7J9QaqBhV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WMI9SF8zH3wXdKA6YTuWzjKGssYNt6AMB0J7t7HowDGFJgUa85wkG2VJf5BkrC6MN
	 ZDwUZxZx0pXfnctYszyKjcwsQFqtA1RWvvskoFrJPzcnSH92+ivKHXagyuXoQ6D+t8
	 JLinXO5ikXiENxLBMT0UsOjPVhU4+zgjRhShFV1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfE3EPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbfE3DQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:01 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E5D245C1;
        Thu, 30 May 2019 03:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186161;
        bh=20NGHh9hI3pUhV5NSLVTioijjfVOpQ0vS7J9QaqBhV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UywvA7QHTbDSYpMbZIjBUHIv664sXm6AMkFu8ONfBTAmgIiz7Dh1CFtvrBq7VUTmG
         e+4z+JGDZqgitqpWeo88YjUGghtDQLW2mYy52TfBR42P+LEhUypSG/JOHvkUQuuOqb
         ji2SaB5zFl5AC2ogB4w42XNzq2PTC08nkrmDal58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Murton Liu <murton.liu@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Sivapiriyan Kumarasamy <Sivapiriyan.Kumarasamy@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 302/346] drm/amd/display: Fix Divide by 0 in memory calculations
Date:   Wed, 29 May 2019 20:06:15 -0700
Message-Id: <20190530030556.144657707@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 59979bf8be1784ebfc44215031c6c88ca22ae65d ]

Check if we get any values equal to 0, and set to 1 if so.

Signed-off-by: Murton Liu <murton.liu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Sivapiriyan Kumarasamy <Sivapiriyan.Kumarasamy@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 4a863a5dab417..321af9af95e86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -406,15 +406,25 @@ void dpp1_dscl_calc_lb_num_partitions(
 		int *num_part_y,
 		int *num_part_c)
 {
+	int lb_memory_size, lb_memory_size_c, lb_memory_size_a, num_partitions_a,
+	lb_bpc, memory_line_size_y, memory_line_size_c, memory_line_size_a;
+
 	int line_size = scl_data->viewport.width < scl_data->recout.width ?
 			scl_data->viewport.width : scl_data->recout.width;
 	int line_size_c = scl_data->viewport_c.width < scl_data->recout.width ?
 			scl_data->viewport_c.width : scl_data->recout.width;
-	int lb_bpc = dpp1_dscl_get_lb_depth_bpc(scl_data->lb_params.depth);
-	int memory_line_size_y = (line_size * lb_bpc + 71) / 72; /* +71 to ceil */
-	int memory_line_size_c = (line_size_c * lb_bpc + 71) / 72; /* +71 to ceil */
-	int memory_line_size_a = (line_size + 5) / 6; /* +5 to ceil */
-	int lb_memory_size, lb_memory_size_c, lb_memory_size_a, num_partitions_a;
+
+	if (line_size == 0)
+		line_size = 1;
+
+	if (line_size_c == 0)
+		line_size_c = 1;
+
+
+	lb_bpc = dpp1_dscl_get_lb_depth_bpc(scl_data->lb_params.depth);
+	memory_line_size_y = (line_size * lb_bpc + 71) / 72; /* +71 to ceil */
+	memory_line_size_c = (line_size_c * lb_bpc + 71) / 72; /* +71 to ceil */
+	memory_line_size_a = (line_size + 5) / 6; /* +5 to ceil */
 
 	if (lb_config == LB_MEMORY_CONFIG_1) {
 		lb_memory_size = 816;
-- 
2.20.1



