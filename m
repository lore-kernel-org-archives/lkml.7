Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBEC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3DC20815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4yDI2nT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389323AbfJAOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:55:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33999 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfJAOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:55:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so8200368pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Sn9Zfn+XhULxHVCD81RfCVoZrivT06JVI9E5/FBOWiM=;
        b=j4yDI2nTwT2Cgc79IjkCT0/2mH4FjvELE85s/xf0MfVHY3aisg4o85vfihFmdM4e10
         zb6aKwrfsrEpu3HFEJ/AfK2R2Qp24gh432aljuykgZbcLHX0vINWSW/CfPx2JXLV34BC
         MK2Tm93cZxSNwwKu2+i9nMXoF+i8NvjwYtLYHOhnrFxzIbKuFuAMOdPm9qZlCyLrT08v
         tAip/I4DUATMO6N0p1IoF2WpYHX2RTZNffK0cGF82KlC3ElUe21UdGu+ylop2XiqSe4B
         268oFTLJREkZUaEc6eBxzYcKsWpt9cU/c74x4c3h0ETfKn+bl5QtMOaIwPR32ZQT0307
         PbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sn9Zfn+XhULxHVCD81RfCVoZrivT06JVI9E5/FBOWiM=;
        b=s0QgBpDutEjQp79lLf0BwLLAjFTNfjLzxWS0qC3qXuvDhufIfjbtx39jKMwUDxszNh
         n1UwLDsYzJfaBhWjk411KUqcLvRuxeTi60fpGxy2t7OCHNAjJHJ6IMF/YlnZTAzVbs+x
         VgNxhApgIKzEPugOZhBrC7tq4Q6LvO47brpIbJJzBpKn3tc/uXP0qymabbgN0EdvtK16
         7PIAZ4gS6jo0dyzv1Zzf3OApA7fZ4sLCg3r3dMnKiYCZquLtqmst4llMLshA6kcR3oA+
         XQ7z8wK7jPoOV2vomPxH9L6B/IBg3HeCAjymtA/BwvgcibJRFjHQGioxJmrN0JLmqjXn
         2OGg==
X-Gm-Message-State: APjAAAW5LTkEWnV3JLQ0GnvMa9ObC2I6pjNHRiB2tunbsp/6jzBn+Lvh
        l1YPrfeJzkFnwrKq8YSiMi7G
X-Google-Smtp-Source: APXvYqytjxnXlEfgN5g4cVgsr0bfkseqn3HCY4tDoIp5KYTwVSF2SrMY3ghvmweQ/gXi+bqtz9EKug==
X-Received: by 2002:a63:8c52:: with SMTP id q18mr4520549pgn.284.1569941723896;
        Tue, 01 Oct 2019 07:55:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:631a:1d56:6a:8714:31a4:1f8])
        by smtp.gmail.com with ESMTPSA id k93sm3333433pjh.3.2019.10.01.07.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 07:55:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        niklas.soderlund+renesas@ragnatech.se, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] media: i2c: max9286: Pass default bus type when parsing fwnode endpoint
Date:   Tue,  1 Oct 2019 20:25:03 +0530
Message-Id: <20191001145503.5170-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller of v4l2_fwnode_endpoint_alloc_parse() is expected to pass a
valid bus_type parameter for proper working of this API. Hence, pass
V4L2_MBUS_CSI2_DPHY as the bus_type parameter as this driver only supports
MIPI CSI2 for now. Without this commit, the API fails on 96Boards
Dragonboard410c connected to MAX9286 deserializer.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

This patch depends on the latest "MAX9286 GMSL Support" series posted
by Kieran Bingham.

 drivers/media/i2c/max9286.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 9390edf5ad9c..6e1299f15493 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -976,7 +976,9 @@ static int max9286_parse_dt(struct max9286_device *max9286)
 
 		/* For the source endpoint just parse the bus configuration. */
 		if (ep.port == MAX9286_SRC_PAD) {
-			struct v4l2_fwnode_endpoint vep;
+			struct v4l2_fwnode_endpoint vep = {
+				.bus_type = V4L2_MBUS_CSI2_DPHY
+			};
 			int ret;
 
 			ret = v4l2_fwnode_endpoint_alloc_parse(
-- 
2.17.1

