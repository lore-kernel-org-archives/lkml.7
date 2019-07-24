Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED56C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9029D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000326;
	bh=xPh9hZ4D2KzU9QsTw+RRvyIX/frDF/JzpZJPjwEQ9Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2SK0GbvwsFpc4CudptDJY29+8Y5bd6DN9wguRe/2jix2+1W+QPq6cw8TW4es/9/82
	 qxrUNh7M3CNvi7P8WoV+L2WweK9KTXAs3hhjxEQXAC7zhuNTzxuwJ/HL7nxUcedN+r
	 P9coNKcr+aV0gOE9hBj5/mlqrsBiqW9FjobX6vv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfGXUcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388361AbfGXT31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:29:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084B6229F4;
        Wed, 24 Jul 2019 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996566;
        bh=xPh9hZ4D2KzU9QsTw+RRvyIX/frDF/JzpZJPjwEQ9Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ueqD7TUyI5w4pHXmZUyTWpHegp0a6OhwycOTCRFzAW/XQlQqC87Qk7JaNR/qHR3NH
         tTxEhc4odE9P2j0x5zVDT4CnUCUIyVyjekXfQDFP7z2BSdqf+Da6kfb49Kl/81j0zR
         crOWPk8BQpPJUvlpkKLRdMGCoE7Yp7ev2qKSAapo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 141/413] media: s5p-mfc: Make additional clocks optional
Date:   Wed, 24 Jul 2019 21:17:12 +0200
Message-Id: <20190724191745.084539991@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e08efef8fe7db87206314c19b341612c719f891a ]

Since the beginning the second clock ('special', 'sclk') was optional and
it is not available on some variants of Exynos SoCs (i.e. Exynos5420 with
v7 of MFC hardware).

However commit 1bce6fb3edf1 ("[media] s5p-mfc: Rework clock handling")
made handling of all specified clocks mandatory. This patch restores
original behavior of the driver and fixes its operation on
Exynos5420 SoCs.

Fixes: 1bce6fb3edf1 ("[media] s5p-mfc: Rework clock handling")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
index 2e62f8721fa5..7d52431c2c83 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_pm.c
@@ -34,6 +34,11 @@ int s5p_mfc_init_pm(struct s5p_mfc_dev *dev)
 	for (i = 0; i < pm->num_clocks; i++) {
 		pm->clocks[i] = devm_clk_get(pm->device, pm->clk_names[i]);
 		if (IS_ERR(pm->clocks[i])) {
+			/* additional clocks are optional */
+			if (i && PTR_ERR(pm->clocks[i]) == -ENOENT) {
+				pm->clocks[i] = NULL;
+				continue;
+			}
 			mfc_err("Failed to get clock: %s\n",
 				pm->clk_names[i]);
 			return PTR_ERR(pm->clocks[i]);
-- 
2.20.1



