Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEE4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00C02070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179181;
	bh=9xj/IygZkiSrQY5ZhHFgDvpKtojt7eZBxnzxtv4bORo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b23zT6WtGb1h5rlqStdI/1hmf5Zdox5MQDvCnfuuDD1il0tDu3PrAAIWLGii7EYPr
	 6XGcdRGP8g+6+Jte10FBIPJTwYkAt8hOVb4Nj4UrURxR9/n0gL2k1ls0bR/qSFZnvK
	 fIYGi8JI9wJmFLNuuv6nyMF3HDTsWZGAMb7h4lok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436511AbfIVTAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395171AbfIVTAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:00:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A1721BE5;
        Sun, 22 Sep 2019 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178825;
        bh=9xj/IygZkiSrQY5ZhHFgDvpKtojt7eZBxnzxtv4bORo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbbxWKCOyUyKFqDI67ByPoA1hnmYtHTrRih00RDw8Bh2iXtM8O68aklhBpFjzUq1v
         zDM+oH8ZLdsTs+VZrnYEcjTy+OFitq++m1ynBQhC7H2/QqM0shFqyCUsKRk/U3+iFX
         6q90DAYE/76zab1mio2mjF1S6jEEU+7uJIOE2wpM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 36/60] media: ov9650: add a sanity check
Date:   Sun, 22 Sep 2019 14:59:09 -0400
Message-Id: <20190922185934.4305-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185934.4305-1-sashal@kernel.org>
References: <20190922185934.4305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

[ Upstream commit 093347abc7a4e0490e3c962ecbde2dc272a8f708 ]

As pointed by cppcheck:

	[drivers/media/i2c/ov9650.c:706]: (error) Shifting by a negative value is undefined behaviour
	[drivers/media/i2c/ov9650.c:707]: (error) Shifting by a negative value is undefined behaviour
	[drivers/media/i2c/ov9650.c:721]: (error) Shifting by a negative value is undefined behaviour

Prevent mangling with gains with invalid values.

As pointed by Sylvester, this should never happen in practice,
as min value of V4L2_CID_GAIN control is 16 (gain is always >= 16
and m is always >= 0), but it is too hard for a static analyzer
to get this, as the logic with validates control min/max is
elsewhere inside V4L2 core.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov9650.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
index 502c72238a4a5..db962e2108adf 100644
--- a/drivers/media/i2c/ov9650.c
+++ b/drivers/media/i2c/ov9650.c
@@ -708,6 +708,11 @@ static int ov965x_set_gain(struct ov965x *ov965x, int auto_gain)
 		for (m = 6; m >= 0; m--)
 			if (gain >= (1 << m) * 16)
 				break;
+
+		/* Sanity check: don't adjust the gain with a negative value */
+		if (m < 0)
+			return -EINVAL;
+
 		rgain = (gain - ((1 << m) * 16)) / (1 << m);
 		rgain |= (((1 << m) - 1) << 4);
 
-- 
2.20.1

