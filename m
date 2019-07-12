Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D785C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC252166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934460;
	bh=9MWdcpkxAacvmKVTodvhTNoixEDyeUkjLGEYDcsjwRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ktUswIhwSwcIDMaKkD1iRjg39mksVFIGH7hpJt0C0EBpYtRsw3UQoyR3B1Lkblqtr
	 vm04HWYtk9BVcFn7GtpzwTJGtRZY5yigpe0D7Z3LDKMVpsOxa1OEMVzsQO4yrY8CMJ
	 Pq7/7r9CMTEC1cujy1RJ/Q3+NqjtSrCo6n7Qlkhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfGLM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728644AbfGLM1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:27:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B65321670;
        Fri, 12 Jul 2019 12:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934453;
        bh=9MWdcpkxAacvmKVTodvhTNoixEDyeUkjLGEYDcsjwRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LyyhgG1ugqzwwpE9VNaW7QXqRyl7pFvPb8w5EscBTJrUcA9Gh2hLxsBZRSDvsjWoO
         NupT9z8vWzTmma59n7mr5LB5PAg5cUhUeY9XAcYAqAy+VjY38KECBCFDjdjXm0k5/P
         g47YD8m3NjuiV5YVSlyOaXixGcsy2cPbte3eulrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 059/138] gpu: ipu-v3: image-convert: Fix image downsize coefficients
Date:   Fri, 12 Jul 2019 14:18:43 +0200
Message-Id: <20190712121630.943854642@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 912bbf7e9ca422099935dd69d3ff0fd62db24882 ]

The output of the IC downsizer unit in both dimensions must be <= 1024
before being passed to the IC resizer unit. This was causing corrupted
images when:

input_dim > 1024, and
input_dim / 2 < output_dim < input_dim

Some broken examples were 1920x1080 -> 1024x768 and 1920x1080 ->
1280x1080.

Fixes: 70b9b6b3bcb21 ("gpu: ipu-v3: image-convert: calculate per-tile
resize coefficients")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 19d3b85e0e98..e9803e2151f9 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -409,12 +409,14 @@ static int calc_image_resize_coefficients(struct ipu_image_convert_ctx *ctx,
 	if (WARN_ON(resized_width == 0 || resized_height == 0))
 		return -EINVAL;
 
-	while (downsized_width >= resized_width * 2) {
+	while (downsized_width > 1024 ||
+	       downsized_width >= resized_width * 2) {
 		downsized_width >>= 1;
 		downsize_coeff_h++;
 	}
 
-	while (downsized_height >= resized_height * 2) {
+	while (downsized_height > 1024 ||
+	       downsized_height >= resized_height * 2) {
 		downsized_height >>= 1;
 		downsize_coeff_v++;
 	}
-- 
2.20.1



