Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1EEC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775AA21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852625;
	bh=5ijT1jUu9ZqPC/geATW0kvljukGndQ23vREkYKI1Lnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8j6SJN3Ar5inmh7htvQg+CdI4per0BvxJqpNgaoe3oFDOhXXv2Gqdb3KTawXD8/g
	 l4xsnfnX7JpnTKHUm01toSDicNIzOv6JZjZHwUPIzywNb3BMKD4fCJNKwZTJCb471i
	 OtBDCGIQRuZr24mIqd7WOra0RDfaA84A1/9GUqDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfLTOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbfLTOel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:34:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68E82468A;
        Fri, 20 Dec 2019 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852480;
        bh=5ijT1jUu9ZqPC/geATW0kvljukGndQ23vREkYKI1Lnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fsPiBXB8IZKC9rre19jrEwtGB343RFvtnxXmnsjzl2eJGDnOF0VGsdBIxLR0VnrC
         I7N9INjRaLpaA86zKNBVDDEE2nXc3tfXU2ymULhWOsMyxgLsw29vuukpWVCFvPy+JY
         zBcarWRpkZzprPNKaunXnCZNu2ClsFGDhZhI7A9k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Galiffi <David.Galiffi@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 05/34] drm/amd/display: Fixed kernel panic when booting with DP-to-HDMI dongle
Date:   Fri, 20 Dec 2019 09:34:04 -0500
Message-Id: <20191220143433.9922-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220143433.9922-1-sashal@kernel.org>
References: <20191220143433.9922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Galiffi <David.Galiffi@amd.com>

[ Upstream commit a51d9f8fe756beac51ce26ef54195da00a260d13 ]

[Why]
In dc_link_is_dp_sink_present, if dal_ddc_open fails, then
dal_gpio_destroy_ddc is called, destroying pin_data and pin_clock. They
are created only on dc_construct, and next aux access will cause a panic.

[How]
Instead of calling dal_gpio_destroy_ddc, call dal_ddc_close.

Signed-off-by: David Galiffi <David.Galiffi@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 23a7ef97afdd2..33c8eda97457f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -348,7 +348,7 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 
 	if (GPIO_RESULT_OK != dal_ddc_open(
 		ddc, GPIO_MODE_INPUT, GPIO_DDC_CONFIG_TYPE_MODE_I2C)) {
-		dal_gpio_destroy_ddc(&ddc);
+		dal_ddc_close(ddc);
 
 		return present;
 	}
-- 
2.20.1

