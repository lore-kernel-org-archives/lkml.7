Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F509C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB691213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cypYyimQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfCSATZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:19:25 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50264 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfCSATZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:19:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 065EA9B4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jn4oGsSoQamt for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 19:19:23 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id C3292B1F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:19:23 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id m132so2297152ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IerYCDeB9TUNcf3mJgdeuvGQvGHk5l68wN82k8yc5jI=;
        b=cypYyimQ4ouOXbcROqDLMSWIw+DyVB6yiq8FVwsCI7Y4K8q6fvYeCWiB9ETJiKCux1
         p/gVos3+MH1/3czkj+0qB6Z+n34IZ2JG0IYK2nbMEmWs6yKaGTYjEUWrAv/E7Ghknmha
         DSjTdyh6FZyqgPHqIb4r8efEJaqXIisPD7BaV/ayV7xVd972rQDalnwuEJoWZ3AwA316
         TwjgKIVDtvi+CY9Uc6ESlG2gtPktvNkgWmzjVMRhMuvYaeY1wQrGY+xFa8b486QBAcTn
         Ys+Wv9SvQfvTv7rUHuOOmOBAZu7knmqi0rHfUG/Cwmk0HSxqsTx7Y54275LDPOdtfuRE
         LIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IerYCDeB9TUNcf3mJgdeuvGQvGHk5l68wN82k8yc5jI=;
        b=IfrHbDZuBfLueNwFXPo+43RHk7aXZcvcS5AjAkYz/1AZn8S1yWCdzgWJVgyAzswY9r
         Z8xN3jGFYEmktH9hyF1dWFLp2AxCb6fTievggwu64wBmI3XLviocIh0jgP/F12gCpXnw
         WBnGkeoV3eC+2rU8ORIkCGIv6lJGw3eUH9f1D0DrnFnPXm1Pt6QAlL3Xs25/hPsp8kcT
         O7DGDPqQUah36LjAVOA12Oll0sjKJbUYyTBcHNCnf4AMg5ODmvtUca8iY3fYJe/MF893
         rycfqLWQWrnIgWdrxqOOKfbA57RT20BP2GD1XBT+30a5U/FaXyHtLay1UgxXeOgOI9zm
         pTJw==
X-Gm-Message-State: APjAAAVNCR/O69M2ctRrkcBXsz5J2EfiQVfCyBbs2W7ugzQY9NLdXGnp
        mz1EliOmS7Xiuya6BmClAUoxbpdvr8PXpvM3Q8XG7pENdemuFqjQZvaP2C2G0L9GFuPYgFGEEwX
        CWskZciRmOG1hLBAVwrzj6qcl9W24
X-Received: by 2002:a24:2101:: with SMTP id e1mr945168ita.151.1552954763035;
        Mon, 18 Mar 2019 17:19:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxBPih/zzyV1BknGrI0f2gjRWlXtsTcThUiwmT8Y8feEyUfod5kz9QYo3B4WzwiXXTPuS8P5A==
X-Received: by 2002:a24:2101:: with SMTP id e1mr945163ita.151.1552954762836;
        Mon, 18 Mar 2019 17:19:22 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id u14sm570898itb.3.2019.03.18.17.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 17:19:22 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: Fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 19:19:18 -0500
Message-Id: <20190319001918.12042-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_node can fail and return NULL in case no matching structure.
The patches checks for such a scenario and returns -ENXIO.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mmc/host/dw_mmc-exynos.c | 2 ++
 drivers/mmc/host/dw_mmc-k3.c     | 2 ++
 drivers/mmc/host/dw_mmc-pltfm.c  | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index d46c3439b508..8a75d7314606 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -554,6 +554,8 @@ static int dw_mci_exynos_probe(struct platform_device *pdev)
 	int ret;
 
 	match = of_match_node(dw_mci_exynos_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	pm_runtime_get_noresume(&pdev->dev);
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 89cdb3d533bb..cc50b7546a20 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -459,6 +459,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
 	drv_data = match->data;
 
 	return dw_mci_pltfm_register(pdev, drv_data);
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 58c13e21bd5a..b1948989f617 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -82,6 +82,8 @@ static int dw_mci_pltfm_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		match = of_match_node(dw_mci_pltfm_match, pdev->dev.of_node);
+		if (!match)
+			return -ENXIO;
 		drv_data = match->data;
 	}
 
-- 
2.17.1

