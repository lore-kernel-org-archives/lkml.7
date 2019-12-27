Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C4C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FDD20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhk+hAze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfL0FdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 00:33:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39993 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfL0FdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 00:33:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so13915681pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 21:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2t+7hHUDAIU6/kyzomS9lXUD4GOc2eozdJ6K0tO6DWM=;
        b=bhk+hAzeEOHKNO2859YUefgWnGGBXpUyN4CwlLzABkWSCsX8q3qDA7MoR6Ms5A5F7G
         vXvdmYgbJkkKbGwOKbq3gtmK8Nw/1yuS9ZbUVdpzHcaVWvdtn5awQoyalQ93l69wmIc/
         m5eHsN0l1ItVxKNS6aNfmkoJ0ID31OYow4zXRxnC0VO2V0SD1ZpHEQmfPvdLXoOB2zU2
         P0AnIxEHr8jvGlAgfVv0lCaptgUMCp42oN0uh6nR0NkhZR6G2n+9QxIgzo34MVYrHhB4
         3kbEU6MKw5DKwE6whoObsx00RNvgQpqFHnFKlzcXP4iNCTjQWI8sqPc1MJjw+0M+HHTj
         8Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2t+7hHUDAIU6/kyzomS9lXUD4GOc2eozdJ6K0tO6DWM=;
        b=gmcQA8aHwGV8bcUg9xSWe3hXeLOiMAqOtCXYXc4b8w0mXu4c+lEPHtE9LSsnllxlIy
         deSov6jp+srqY2Dp88jUdXIKo/6G6qS67v96rO0eaSoWxvH28+CSt4o6bkUz70xYCDz7
         0FcnXUgwU6V4hLmloK1e7OyLz6vNy1ATaFgbiGg0mYVUt323a2XPbKe6hd+XwKFhegUM
         hiuGsPzgW3Qnih5igrYP6ffEZIZtOThvtGoIyBWWGcpobVpvW7s1PhEuZcriFi0Rd4xa
         9VhOVNYCPXs8LfxkivMWfcQB5lI1S+huMyk2WL8c30XQmQuK/PWlNyfBH16JSAJb7lHN
         mvxA==
X-Gm-Message-State: APjAAAWt0l+MBUh5pmRs1ldrpEd1aCicaDjZjKLSboKbSStLedKfwMF5
        MW70UPU6JbPOmzLGpkkxQinNRw==
X-Google-Smtp-Source: APXvYqwCHtL65F4klQ7nfvCMnlbMC2Fw7n/B+CQK0brIPIgwIsnUim4YYHskacOMviBgFuA91mTWSA==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr49662731pgc.19.1577424781257;
        Thu, 26 Dec 2019 21:33:01 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c22sm16789196pfo.50.2019.12.26.21.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 21:33:00 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 8/8] remoteproc: qcom: Introduce panic handler for PAS and ADSP
Date:   Thu, 26 Dec 2019 21:32:15 -0800
Message-Id: <20191227053215.423811-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191227053215.423811-1-bjorn.andersson@linaro.org>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the PAS and ADSP/CDSP remoteproc drivers implement the panic
handler that will invoke a stop to prepare the remoteprocs for post
mortem debugging.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/remoteproc/qcom_q6v5_adsp.c | 8 ++++++++
 drivers/remoteproc/qcom_q6v5_pas.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 1a942c92d974..4189d22531f4 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -291,12 +291,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
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
index 4dcdf1301e50..547d012cf2db 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -242,12 +242,20 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
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
2.24.0

