Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89820C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5880A2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWl+Jh9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfCTNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:20:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41920 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfCTNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:19:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so1789186pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J8JlGYbgg/zRqWjBOjDxf78JZ4BdingiWMKoRwZVd2w=;
        b=iWl+Jh9lxol2sN66KVe+2+jJwlqM+v2Sl2GnWQwxNRv4PVDX1DEtKSrsoBB6Qch0rH
         U/qFwGXqMkbG58fzPYfTKEbpF6tSLb7kRg38a9BZ0gVI9NpkhqBLScgb5YStrLtHyWpw
         VFFCsZFJAy6xi3tPGWeP8b2FBGh5SRMcSGHg30bhWomsAHb0R/mdTGkq38HBicgImpZd
         LUYhfTvq+l4i5X9wxDekvm5AdK9tFHKfXUkA9z7v+Aca/dIrfsiNLB6EBl7FdRM32CHB
         UsWnoRlfC3oIwiAAv+1J0eAtkfGqaxCZpd2vhMYyZNR0rseJUguKhiSVXe7//ZSOTIEt
         iHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J8JlGYbgg/zRqWjBOjDxf78JZ4BdingiWMKoRwZVd2w=;
        b=e6txFnTOhTkO+ZnU4qvXUvz68u/qmprhrFVaRAaX3bHn05j0Ev+ckKPxjBsZ86/Knj
         cv08wKrNjgoimz3JfJOytuj0Sw7IsnbEcmXlvF4baf9QPZhEy4GFA3ObCtL73VDD7fDt
         PVmbbYA/Z95Q8URRnxDeR8TuzGV3oStrgQPI8fVLd9lb2dacJQxmi9ixu6o8mg5m497+
         j/eV1CSNSvog6CECuJPSik5ceDqtbLgCl8EQRFzdhvq2Vc0ZiLAXxUOLuK9CDV6CaNgC
         a0ZI58H1OUXzyGrmGQevfnJ8uMAR5zvWoygtup3QggbA1jpBELJYYYSK9Vwf6PUo3/1a
         HQSw==
X-Gm-Message-State: APjAAAXknjLuDild6x+qu1EQA3mekIof9m8+Q+jd/iBvqljpFoJ7d84x
        ich9o1I79JVMmX6yEVrq+7KYdNImuRk=
X-Google-Smtp-Source: APXvYqyF/+1HkBB1QB7ygp+WXkTaNQqkPdgEA+ShZBrkQC8wxak16xOQmLL/X9K2HCCUruBt3J/BvA==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61mr8037789plb.158.1553087957020;
        Wed, 20 Mar 2019 06:19:17 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id j6sm3801719pfe.79.2019.03.20.06.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:19:16 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 12/23] drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
Date:   Wed, 20 Mar 2019 18:47:52 +0530
Message-Id: <71817f920176103fa387cad14e8d7d38b3636e6a.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We print a calibration failure message on -EPROBE_DEFER from
nvmem/qfprom as follows:
[    3.003090] qcom-tsens 4a9000.thermal-sensor: version: 1.4
[    3.005376] qcom-tsens 4a9000.thermal-sensor: tsens calibration failed
[    3.113248] qcom-tsens 4a9000.thermal-sensor: version: 1.4

This confuses people when, in fact, calibration succeeds later when
nvmem/qfprom device is available. Don't print this message on a
-EPROBE_DEFER.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b91a0b88d33c..057b33353ba3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -159,7 +159,8 @@ static int tsens_probe(struct platform_device *pdev)
 	if (priv->ops->calibrate) {
 		ret = priv->ops->calibrate(priv);
 		if (ret < 0) {
-			dev_err(dev, "tsens calibration failed\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "tsens calibration failed\n");
 			return ret;
 		}
 	}
-- 
2.17.1

