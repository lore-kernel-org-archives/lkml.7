Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961142083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOyjeR8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfB1M1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39916 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731300AbfB1M1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so21739109wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J8JlGYbgg/zRqWjBOjDxf78JZ4BdingiWMKoRwZVd2w=;
        b=dOyjeR8ZWcjQDTxl4nMMhZXXfodN/nAUp69zBcpmH3re2VKK+OphctBrYXp32q76Wz
         Qztyf30CuMRyIUPnFNN2ZYqPpXmjDsXLA/AdalLU/kJqcBJg/3ngx7K/A+j+w0wHTbXO
         kKd1tBL5FS6flTIRYzNFMGTqZHjD0oZxMyaswcY2am7JLWdA+Vt/uCJLZXG0ktr5AVYg
         TP/nIeMXGQoQgFU67iVGoA00B7I3+IjaRPmtQ4IlBdhBLGDqWrgk5Awtd9SFPCFaflBE
         soZw+RU177sBlwOLTH6RAafbjVF8CGWv9yDr7Ib4mtp9I+fR2SKADZMQgfcvBrKeC6Ik
         RsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J8JlGYbgg/zRqWjBOjDxf78JZ4BdingiWMKoRwZVd2w=;
        b=cnVD4d3xsc3k3C6bJEcvgQX2WSPBXx72aY9WZzUMLv2pIysRu4O05Q9iyTQHCEECtI
         YzPi7brl2ETV0iF2omar38DiXx4oOSsSmj5j7UtXN6cmniUVPh9+jSYW/qXICB4rhrzB
         JB+YJViSsqt1cNNah4rSN7hPTC7e2kB4uzRbbOBJgxcF2BjY9BcLeIlOVZnmre+VDhCM
         XKB33J8UBLs3oqgo53u/PBkkm7QS2M8F+nsxtpk/QdTc/7FX96Zl6VIxbh4e9CfLzi15
         m2LjKKzh8glJ2YOhdvpetslDJW/t42RnTGHqqj0jGj4/hsvQ/lyu2DrWNmc6BMjPE8kE
         6d5g==
X-Gm-Message-State: APjAAAVQlUaSSYbCs5tMD4beXdkQShNNAapMTDJ+ukFExBvviEW5gQMl
        NmMpkYFRzslgtz/EUsXJS99tS52FgWk=
X-Google-Smtp-Source: APXvYqxAyR4cIO3XEV5v+iMHEy0Wi29hy8vhUtDP9w2vuiDB/p0HbHOCEt8yCXuymiWUcwFhN7lXNA==
X-Received: by 2002:adf:f543:: with SMTP id j3mr5890814wrp.220.1551356827946;
        Thu, 28 Feb 2019 04:27:07 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id i13sm18710218wrm.86.2019.02.28.04.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:07 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 12/24] drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
Date:   Thu, 28 Feb 2019 17:51:02 +0530
Message-Id: <d5ca6c7f3ab156cbb0ed57a4bcaed6b45fbdbcb5.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
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

