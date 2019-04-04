Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D74C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F0F2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aKqetnJG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GIRg5BTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfDDHSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:18:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35176 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:18:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38AD4613A8; Thu,  4 Apr 2019 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362323;
        bh=nTZbq6hRF5rjKUh0yPSlnzIEiAgFxyO93W+oBUyfSLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKqetnJG2h5YJRUSmwwFnf5SF4FuIVTp6v346tu02g5Jhs0FtH5MVna1v8EwvRBy7
         RKDpyzk4VqTTOD7CoMw7H+uYx7KaEZ+HCUbZjKvOdO8gpFjqlJc1ZZQ8sn0QNFwz32
         7I6qeJtIVqd/eDT/8c8Ot3JwyzGV6SVUKqg7Qdfg=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AADE36172D;
        Thu,  4 Apr 2019 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362306;
        bh=nTZbq6hRF5rjKUh0yPSlnzIEiAgFxyO93W+oBUyfSLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GIRg5BTFsvAQ1/5eEFTqPmAF4HpFw61di2kzOl5Qt8zSgxKZGrreGC66G88wl3Zp0
         M8c0zrN1DlwXZ0/2/LHGDX+v0A97ABuI/505KqJfpt5rzE02sch/nz+4Rs/gvK49dw
         +VMIYD6buOhBwVc04WgmujszKTnZhbr2gP2JuTWY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AADE36172D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 5/5] Input: ts4800-ts: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:47:23 +0530
Message-Id: <1554362243-2888-6-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
References: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_ioremap_resource() internally have platform_get_resource()
and devm_ioremap_resource() in it. So instead of calling them separately
use devm_platform_ioremap_resource() directly.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 drivers/input/touchscreen/ts4800-ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ts4800-ts.c b/drivers/input/touchscreen/ts4800-ts.c
index fed73ee..5b4f536 100644
--- a/drivers/input/touchscreen/ts4800-ts.c
+++ b/drivers/input/touchscreen/ts4800-ts.c
@@ -148,7 +148,6 @@ static int ts4800_ts_probe(struct platform_device *pdev)
 {
 	struct input_polled_dev *poll_dev;
 	struct ts4800_ts *ts;
-	struct resource *res;
 	int error;
 
 	ts = devm_kzalloc(&pdev->dev, sizeof(*ts), GFP_KERNEL);
@@ -159,8 +158,7 @@ static int ts4800_ts_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ts->base = devm_ioremap_resource(&pdev->dev, res);
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

