Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50383C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2126A20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8KoeW3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDDFJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:09:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfDDFJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:09:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so603209pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQdCIQWz2/OSkRD/KWHO1VP+gkavuY4twT+b1yBYoCM=;
        b=A8KoeW3LQ8IeBLIEjTe8gdpRfup7E9tSobKG3ChSpGgnRBLLI5S+oASEFkZJ/OnO/C
         +YqVgGk3jFkYaub4hwjTph4fLbE58mc+ewR0ghD19ZGrWHBPmQMFLJQEmaVSirgnQmSi
         Daf4++Fy0ofkTw0yTeu1/t+YonjdUc++ptCaWDXfn5hcldU489IJOlP6PobXPjVT+0xq
         ZkS0lbXx+8YDEYrVbpFLcvjvKkdE90MWz96O6DB+ts4aSfuotARcwZj8BgADd29q553o
         +C9PP65zBS+OEox1on2LaJDtRBXq3RUpT9mCNsW7R4VeeDrUNrI0UsNdri43GKbkkwqT
         Blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQdCIQWz2/OSkRD/KWHO1VP+gkavuY4twT+b1yBYoCM=;
        b=SfVP84OjQzmR5j2ov1mKl1B2mMuN0gBpTFCSLAy/bMziazw/P2H+BM+wgy9Dfs/JoT
         F8XFnNqoAgrX1EXKM97HSkoNIEyyJ35zk2mr01FCO6jEYMOetfaOx4sX1CulnROlAOTJ
         yOpUW0sivzlP8aWtuFW0nNTjgY0rPLXOCL1Ud+YIBj+5lLchpHewn0QbhkVA21a6Ojnl
         iSOjuAU/45hI/2CjxbVaeg2euh9bL4XeNaAZScndQLZy3IYb8pLcvMw7AAA/P/PpTBRG
         LAHFTbo7qmuqzZBR1SFDzijtvYYhGT6oayzkAzr8wXhZtX8ijO17/piMiMJjQDWuzLCK
         9naw==
X-Gm-Message-State: APjAAAUJvQkODlWjjPe5s8/gCXrjVbLR5y7HHGniPFjO/tCg4EEDleMw
        0idhXzX6OZ8mve9BP+wkWYDLIQ==
X-Google-Smtp-Source: APXvYqwbWvfS2aBlcMdxnTCzBmhLTdLeiyB70yBFkM/2Lyd7wwzZjCvNwQPvU/6DQQHnYfL+v+nDnQ==
X-Received: by 2002:a63:4750:: with SMTP id w16mr3765472pgk.256.1554354586830;
        Wed, 03 Apr 2019 22:09:46 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id a129sm50589089pfa.152.2019.04.03.22.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:09:46 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/9] drivers: regulator: qcom_spmi: enable linear range info
Date:   Thu,  4 Apr 2019 07:09:22 +0200
Message-Id: <20190404050931.9812-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 3193506eac6f..f2edf510b0df 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1907,6 +1907,7 @@ MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
 static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 {
 	const struct spmi_regulator_data *reg;
+	const struct spmi_voltage_range *range;
 	const struct of_device_id *match;
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
@@ -1996,6 +1997,12 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 			}
 		}
 
+		if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_HFS430) {
+			/* since there is only one range */
+			range = spmi_regulator_find_range(vreg);
+			vreg->desc.uV_step = range->step_uV;
+		}
+
 		config.dev = dev;
 		config.driver_data = vreg;
 		config.regmap = regmap;
-- 
2.20.1

