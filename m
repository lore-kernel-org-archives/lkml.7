Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8B5C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3319921E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VxaiY8HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfHGFj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:39:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40088 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfHGFj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so38877753pla.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/HptULj1ZkwXqtKtnx9KrZAoKYoT1D4MPjQTFSgnOE=;
        b=VxaiY8HUkDhAJK5OgMj/acEOEgWXyEaHjVYNOdw1Hci6Y4sEt+drKbkvjpYDtH9KV0
         3BEfBbpJCoFTh72TNpLRW8ZWifVynAXWjfY6sUAiMiqJKT9tLty9vJCR1YNJzFr/NIBW
         UUM6JWhYW7Ehntlr86XA3il2jvwRb/3IMVJ97+UQihBCQTf/eOKHrxE2DL/Ol0AP3ews
         35YHA/qZ+9AxgOiNzRKa4YvGB437AL0RuTDL/YjdfnLxKpGoyq0Id7izZ7NBHXxurj0v
         Onjldxfpe6qOvoAQFjAcFFpic3OWRLTg35c3GXLxAufgxgfV1BNINACjeAjiflGAu6tD
         ELFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/HptULj1ZkwXqtKtnx9KrZAoKYoT1D4MPjQTFSgnOE=;
        b=jGFz/+oWQDBe1NCr2bGMZLWvohj0p77h95HKkgvsErj2EjENyv++jynv8a30re5AcV
         wykXVvMzNY+HuM23ylYxblvisYMvsjnFKdq//wUxa+TCXGFeRzycNZWQukDxoaH/xq2f
         3f1iCef9d5zWa0KbpN1s2UBHBnfUTMuXRGH9Oixhx0E4McHZtsaxfq+ruZ9kR+Ykf29W
         AOlAqUGpCc273ZrmXfbN835RxP9IT2ZLAZoRFHU0U3CCpa9SSfBz4tEOj/LUJSdOjonU
         V5b5OcsSkn2BKoA6kU4J6Zh2loSzajEpE7LDCVnPiVPaYQ0TCl6ks3ESdSNHYzQpc5GA
         V6mA==
X-Gm-Message-State: APjAAAVNigaNGqkJkt50Qedhy+qj5WpFG76GaF4eMKO4Osn8VeUjggGT
        zOTnzIXCeQatxpvwQCXFQ6W2KQ==
X-Google-Smtp-Source: APXvYqwttlgTM1Ho7Jfwf4iaKjnCWr2MGVOw6C7n3fYbk8Bd7mv+IC8hWlxN2qTtA0SQh54WjIETKw==
X-Received: by 2002:aa7:98da:: with SMTP id e26mr7570022pfm.34.1565156396240;
        Tue, 06 Aug 2019 22:39:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:55 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 9/9] remoteproc: qcom: Introduce panic handler for PAS and ADSP
Date:   Tue,  6 Aug 2019 22:39:42 -0700
Message-Id: <20190807053942.9836-10-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807053942.9836-1-bjorn.andersson@linaro.org>
References: <20190807053942.9836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the PAS and ADSP/CDSP remoteproc drivers implement the panic
handler that will invoke a stop to prepare the remoteprocs for post
mortem debugging.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 8 ++++++++
 drivers/remoteproc/qcom_q6v5_pas.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index e953886b2eb7..3de1683903db 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -282,12 +282,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
 	return adsp->mem_region + offset;
 }
 
+static void adsp_panic(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+
+	qcom_q6v5_panic(&adsp->q6v5);
+}
+
 static const struct rproc_ops adsp_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.parse_fw = qcom_register_dump_segments,
 	.load = adsp_load,
+	.panic = adsp_panic,
 };
 
 static int adsp_init_clock(struct qcom_adsp *adsp, const char **clk_ids)
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index bfb622d36cb3..31ff09bcd3ee 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -179,12 +179,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
 	return adsp->mem_region + offset;
 }
 
+static void adsp_panic(struct rproc *rproc)
+{
+	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
+
+	qcom_q6v5_panic(&adsp->q6v5);
+}
+
 static const struct rproc_ops adsp_ops = {
 	.start = adsp_start,
 	.stop = adsp_stop,
 	.da_to_va = adsp_da_to_va,
 	.parse_fw = qcom_register_dump_segments,
 	.load = adsp_load,
+	.panic = adsp_panic,
 };
 
 static int adsp_init_clock(struct qcom_adsp *adsp)
-- 
2.18.0

