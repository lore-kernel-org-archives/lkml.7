Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B786C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A1B214DE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921333;
	bh=TA8Ib/PAXrfuG0ERBmHA7nW7Qdqb2UTASotXuegXicU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bgw+zH0125kuTCxuxG0D0YZZuXLvFZ/zlMocz8K3i7cGAf8VR0OpnECRNrj9HkaFK
	 SD21Zynfwxqhr1GuTaf/QeOVDtofCOLH6AlTqcyEtLOAxRI/M4ns7rArMbR6zMvqq2
	 4YFstx017yh9z1ogG0K7WGETBjoke+CdXEhhcNAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfKPQWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:22:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfKPPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:20 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2C0F2075B;
        Sat, 16 Nov 2019 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919000;
        bh=TA8Ib/PAXrfuG0ERBmHA7nW7Qdqb2UTASotXuegXicU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhgb9XqnkZTFenWD4ODvP7D1Ctel3w+mHNL7wtz73MYTq0RR7YiG+t37oBhomn2p1
         gLEiyxcpKDMwSWdxdNZxQy+MS33pflGoLmnTS9csYhacM+LsWZhW0fg13Kdg2UQe5L
         ZhGVNQETU5QTxuZn7ZtcoAm9kG01EUO/CaNK/4x0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 103/237] thermal: armada: fix a test in probe()
Date:   Sat, 16 Nov 2019 10:38:58 -0500
Message-Id: <20191116154113.7417-103-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d1d2c290b3c04b65fa6132eeebe50a070746d8f6 ]

The platform_get_resource() function doesn't return error pointers, it
returns NULL on error.

Fixes: 3d4e51844a4e ("thermal: armada: convert driver to syscon register accesses")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/armada_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index e16b3cb1808c5..1c9830b2c84da 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -526,8 +526,8 @@ static int armada_thermal_probe_legacy(struct platform_device *pdev,
 
 	/* First memory region points towards the status register */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(res))
-		return PTR_ERR(res);
+	if (!res)
+		return -EIO;
 
 	/*
 	 * Edit the resource start address and length to map over all the
-- 
2.20.1

