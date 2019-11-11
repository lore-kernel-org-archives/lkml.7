Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24BCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62452075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1fwr7sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfKKDqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:46:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39286 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfKKDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:46:05 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so9720773pfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 19:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iYNb5KlZBapqLqV3fFy3XFyweS3E7oV4r+7sy3tLLo0=;
        b=z1fwr7srPfOHKcCg+EB7uGeAeLy/NhL9Tzjpgo5imxvgvf37LONrCOJqX/U0K86hMp
         qnk3FqLXTLBO2rgeszt051whLIcBOYVcceZRrv21NU7yH3/rXLiGjsgQ/aJPr3UxzHss
         VXsYOVSbzwJ/c3wSHSalVkDvDgDuBZPeCzUGDkUaKueUV+bKTSmA+326air3MYjNQmDX
         dva6B0twiEqteRjfd4dgHRp4kOdUV2J6RqiXZFTJSmMTWvOYcrXbPJ4+PD0arSKwhT1V
         1ePoa/KfaTrSV1F2GJ2PBerQafNuvbt4Je8+uQ+qeCUOreQdLq4BqiBcgf9g/BNNG0uq
         cF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iYNb5KlZBapqLqV3fFy3XFyweS3E7oV4r+7sy3tLLo0=;
        b=kPagXq3lKXz4vXnN7EIqZ4/XzDHknWfIqbn1GRM6dy2XSefqpP6+PFTV6HFSQxP7Re
         DRC5kuSD9uteztaldthgX5fXdVJrqdnH2++J4BdvewmIw1DxPkF5KCUMm5uoB+SB0DsI
         QQ5rwKGPQ9pf9xpN60B+6mPjjN8OhjP4N1E4GP6usbbCPpVFAq/k3LWl+qKLt7PMMFzT
         IHiagYVqc2DdznlcP9fuLkhfSDgP7R2j20CmYdBcfUl6MJxKuYqWN8j1xp29/f0DZ7D7
         6VzVci/k+sIZvj3iti1GF0RQTlkgZdmBrWkV5SfimrgR+eXqgoEj5/eed/Q+BWBJwGUD
         Kj4w==
X-Gm-Message-State: APjAAAXwQ81Qd5OpcSnhUe80lIee/qe17B8OCu2nIt8wTKigXoBIhlDY
        9NYTSN6KN8WPFDWXN9hHkxSyMA==
X-Google-Smtp-Source: APXvYqzPwtwWe6U5LaR+jWjJT393R1J93ZH74/gikt4zSpAt4fCvDBJwfyVRChm5DeYMUufJb6ftZw==
X-Received: by 2002:a65:6418:: with SMTP id a24mr27407571pgv.260.1573443962707;
        Sun, 10 Nov 2019 19:46:02 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y3sm11707945pgl.78.2019.11.10.19.45.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Nov 2019 19:46:01 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()
Date:   Mon, 11 Nov 2019 11:44:55 +0800
Message-Id: <df20147329f4f1521107d20da92559a187494b04.1573443694.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().

Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add fixes tag.
---
 drivers/clk/sprd/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 3718696..c0af477 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -45,7 +45,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
-		if (IS_ERR_OR_NULL(regmap)) {
+		if (IS_ERR(regmap)) {
 			pr_err("%s: failed to get syscon regmap\n", __func__);
 			return PTR_ERR(regmap);
 		}
-- 
1.7.9.5

