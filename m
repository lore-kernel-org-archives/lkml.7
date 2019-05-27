Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF01C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28642133F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QjMR7B6E";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QjMR7B6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE0K02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:26:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0K02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:26:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF0FF6087D; Mon, 27 May 2019 10:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558952787;
        bh=XSljrn9KDqKTIUNGpy8kHPqFJpqJPYruTEJmjtqHBIs=;
        h=From:To:Cc:Subject:Date:From;
        b=QjMR7B6ErfMHcKJ+RIA67MABL5bx97vFiabqkj0HiG+mdP5TapL3QfuWvnDZXDVrI
         0rfHG8LPocC75zAltZaZrzOfOUebB35/PSxoenQpAGJ5iyGFE7G/FVVCOPEcF+89n1
         4z7JYbpOt2qWg2k5unJo8XjQyr0aOCpf233W7eMU=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACFFC60252;
        Mon, 27 May 2019 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558952787;
        bh=XSljrn9KDqKTIUNGpy8kHPqFJpqJPYruTEJmjtqHBIs=;
        h=From:To:Cc:Subject:Date:From;
        b=QjMR7B6ErfMHcKJ+RIA67MABL5bx97vFiabqkj0HiG+mdP5TapL3QfuWvnDZXDVrI
         0rfHG8LPocC75zAltZaZrzOfOUebB35/PSxoenQpAGJ5iyGFE7G/FVVCOPEcF+89n1
         4z7JYbpOt2qWg2k5unJo8XjQyr0aOCpf233W7eMU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACFFC60252
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     airlied@linux.ie, thierry.reding@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] drm/panel: truly: Add additional delay after pulling down reset gpio
Date:   Mon, 27 May 2019 15:56:16 +0530
Message-Id: <20190527102616.28315-1-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTP SDM845 panel seems to need additional delay to bring panel
to a workable state. Running modetest without this change displays
blurry artifacts.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/gpu/drm/panel/panel-truly-nt35597.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index fc2a66c53db4..aa7153fd3be4 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -280,6 +280,7 @@ static int truly_35597_power_on(struct truly_nt35597 *ctx)
 	gpiod_set_value(ctx->reset_gpio, 1);
 	usleep_range(10000, 20000);
 	gpiod_set_value(ctx->reset_gpio, 0);
+	usleep_range(10000, 20000);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

