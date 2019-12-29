Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E30DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AE020409
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640631;
	bh=qyHC4jeylRdcxBNCIKlXdMH7QVEsolNOOXqFGbohzO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TueO2BFf+Cfns0a/mBuE2jeGYoLdjfNHXLZ6pai2aeU8J30DEDc8Pg8zbfBeQcZkT
	 JfOi+qMVav7+JRccQR3wzrqk1dlNqv+Lj46xOqQnU4uCd3cxe6AHS+c6N8pIFJEUAD
	 rDIG0XZzPdf2q3NImMJnezLejKthkw/7UDd2lfHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfL2Raa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbfL2Ra0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:30:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0479C20722;
        Sun, 29 Dec 2019 17:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640625;
        bh=qyHC4jeylRdcxBNCIKlXdMH7QVEsolNOOXqFGbohzO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBsfW5vQroXEWPxu6cE7WV6okKSdoLbwnSbRImfQpEWeQFRJIHAz5Wvn4iQzZGpv5
         tlYXFWY/2vsRlm73acukcKyyTuRXM6PV8BdOwPHAi9De3ZV64d0Aecrrv/1upfxelq
         WOg60fIoF8L+JZVLsZM8QpKRpNmKxVrzAy3J8+x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Galiffi <david.galiffi@amd.com>,
        Jun Lei <Jun.Lei@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/219] drm/amd/display: Fix dongle_caps containing stale information.
Date:   Sun, 29 Dec 2019 18:17:54 +0100
Message-Id: <20191229162517.127551237@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Galiffi <david.galiffi@amd.com>

[ Upstream commit dd998291dbe92106d8c4a7581c409b356928d711 ]

[WHY]

During detection:
function: get_active_converter_info populates link->dpcd_caps.dongle_caps
only when dpcd_rev >= DPCD_REV_11 and DWN_STRM_PORTX_TYPE is
DOWN_STREAM_DETAILED_HDMI or DOWN_STREAM_DETAILED_DP_PLUS_PLUS.
Otherwise, it is not cleared, and stale information remains.

During mode validation:
function: dp_active_dongle_validate_timing reads
link->dpcd_caps.dongle_caps->dongle_type to determine the maximum
pixel clock to support. This information is now stale and no longer
valid.

[HOW]
dp_active_dongle_validate_timing should be using
link->dpcd_caps->dongle_type instead.

Signed-off-by: David Galiffi <david.galiffi@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 23a7ef97afdd..c6f7c1344a9b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1950,7 +1950,7 @@ static bool dp_active_dongle_validate_timing(
 		break;
 	}
 
-	if (dongle_caps->dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER ||
+	if (dpcd_caps->dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER ||
 		dongle_caps->extendedCapValid == false)
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 05840f5bddd5..122249da03ab 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2172,6 +2172,7 @@ static void get_active_converter_info(
 	uint8_t data, struct dc_link *link)
 {
 	union dp_downstream_port_present ds_port = { .byte = data };
+	memset(&link->dpcd_caps.dongle_caps, 0, sizeof(link->dpcd_caps.dongle_caps));
 
 	/* decode converter info*/
 	if (!ds_port.fields.PORT_PRESENT) {
-- 
2.20.1



