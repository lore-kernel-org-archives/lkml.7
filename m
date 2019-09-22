Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3430C4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3A7208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179298;
	bh=6S6liaXX2aTAXYB0LKjqkt2TfZpwFkYA323VNy4+mj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BhnsSznJCVesa1fpgIbLw95iU3IJ/4Sf+4VdFH6N1Bquq9ky3Twe+CbftyBpz9qCu
	 yPv/4RodVJkuPsPPF5s95DvuKy2dm8RAvu1xf4ZaJAo569dIOM2td3qhAsNMMh9dqa
	 Bb38ViNJ1mizHoLUNSG7Yw7Ug5picgBkzYV18eWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438906AbfIVS7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395082AbfIVS7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:59:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64A7821479;
        Sun, 22 Sep 2019 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178783;
        bh=6S6liaXX2aTAXYB0LKjqkt2TfZpwFkYA323VNy4+mj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkdcGNMWBP+H3hQnKOsNz+psvxrC6VXDvyJMDzBQ4mdSZFD6oivoxMvujYrPxXAOJ
         xNNt8elXvWCO+KNTIBdMLCUqILEJPakwbdzztdukomIWSM6ajJO+CT9Df7KzqYw5vB
         rhio+uU6a+nA2Y5plNuDZVPzf19oUB8EV32LwP80=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/60] media: exynos4-is: fix leaked of_node references
Date:   Sun, 22 Sep 2019 14:58:40 -0400
Message-Id: <20190922185934.4305-7-sashal@kernel.org>
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

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit da79bf41a4d170ca93cc8f3881a70d734a071c37 ]

The call to of_get_child_by_name returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
drivers/media/platform/exynos4-is/fimc-is.c:813:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 807, but without a corresponding object release within this function.
drivers/media/platform/exynos4-is/fimc-is.c:870:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 807, but without a corresponding object release within this function.
drivers/media/platform/exynos4-is/fimc-is.c:885:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 807, but without a corresponding object release within this function.
drivers/media/platform/exynos4-is/media-dev.c:545:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 541, but without a corresponding object release within this function.
drivers/media/platform/exynos4-is/media-dev.c:528:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 499, but without a corresponding object release within this function.
drivers/media/platform/exynos4-is/media-dev.c:534:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 499, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/exynos4-is/fimc-is.c   | 1 +
 drivers/media/platform/exynos4-is/media-dev.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index 7f92144a1de3a..f9456f26ff4fa 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -819,6 +819,7 @@ static int fimc_is_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	is->pmu_regs = of_iomap(node, 0);
+	of_node_put(node);
 	if (!is->pmu_regs)
 		return -ENOMEM;
 
diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index 1a1154a9dfa49..ef6ccb5b89525 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -494,6 +494,7 @@ static int fimc_md_register_sensor_entities(struct fimc_md *fmd)
 			continue;
 
 		ret = fimc_md_parse_port_node(fmd, port, index);
+		of_node_put(port);
 		if (ret < 0) {
 			of_node_put(node);
 			goto rpm_put;
@@ -527,6 +528,7 @@ static int __of_get_csis_id(struct device_node *np)
 	if (!np)
 		return -EINVAL;
 	of_property_read_u32(np, "reg", &reg);
+	of_node_put(np);
 	return reg - FIMC_INPUT_MIPI_CSI2_0;
 }
 
-- 
2.20.1

