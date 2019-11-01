Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403D5208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 02:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h06R/0w/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfKACol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 22:44:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39235 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKACok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 22:44:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id x28so2749573pfo.6;
        Thu, 31 Oct 2019 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0tVrAmrERsoSt+7rvxULMwxjRb7DGBkYT/cGct46m0=;
        b=h06R/0w/hcnwPbFU8IE7PfPmLBTx2clX4OQlykuSfy+6xmH7Vu5sN85N09Tp3VqKx2
         BEZtCuRRoGwq7UJncs/qYnJjXn6s2kH+gJoxSP+1HeoKs7jUgG0UL26uVVp0vvoEohkX
         AusveXNwjuAhRRm822U+jDdKuv/6+uQBu7O81R/Xxt58HZgRVjdYyk/E0xgEJdQ+6hlm
         MQvO2HjABiBrYwvr/Q9bHBhEW0/sHYJ6P5RzJo+TiuC642i8hOKVw/dy9UFjeHbM1iZS
         bFU+NA+zkpCfbqfeAOEeBxtOZFqee+0V6rQ+PIdY3lvMCsKkh7dEIwgFJBybuhmvLUUc
         4UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0tVrAmrERsoSt+7rvxULMwxjRb7DGBkYT/cGct46m0=;
        b=BH4XfJ38zTDzki6CHI8LbzOAvngLqohnKAWgruxT0vDSJzc2ab7KOuJUwLtWkwdiyn
         OJHwi7PmHYUIOEpQCXNS0/QZ/uhlG7hifF5F/e97j/mDZ7cVDP88qwA8oUnhfAkNVMYX
         /NdOlA9CwJ4Ayx4ECVlxeBF29qZRJ4KsZuwGSdl3Pqc5LlfXsVDGUkGuqXijLdYF35+F
         4Xy0BCFYON3oHnhIUxzVTBAxOOFAx0tYhRHO/uHQCw+mmk97cZYBVFZvZm291Bl9tg0B
         M2v+oaFZsQ9pyL6W2JaksJgLpqZwlcZF8fxpnULqw0p9n0+LRpr9ZoF7EF6Kw7aO0d0d
         eQUA==
X-Gm-Message-State: APjAAAW7dgvG5TmKKc44txEZqjXvZDtUV8iwGoujmzY69ilicerSPTn6
        HBjC1Yp+eMeiHz0BV/WGq6k=
X-Google-Smtp-Source: APXvYqxzmqx4e1CjTuVyZlnM6Qi0Y0wXJWfMb6JdSyDhXZnyks5RMFFWT+7JrmMN9dXkJQ/R5Pyf/A==
X-Received: by 2002:a62:90:: with SMTP id 138mr10686184pfa.209.1572576280180;
        Thu, 31 Oct 2019 19:44:40 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a29sm6891774pfr.49.2019.10.31.19.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 19:44:39 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     agross@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH 1/2] dt-bindings: remoteproc: qcom: Add Q6v5 Modem PIL binding for MSM8998
Date:   Thu, 31 Oct 2019 19:44:35 -0700
Message-Id: <20191101024435.21975-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101024301.21919-1-jeffrey.l.hugo@gmail.com>
References: <20191101024301.21919-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for Qualcomm MSM8998 SoCs.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index 41ca5df5be5a..c416746f93cf 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -12,6 +12,7 @@ on the Qualcomm Hexagon core.
 		    "qcom,msm8916-mss-pil",
 		    "qcom,msm8974-mss-pil"
 		    "qcom,msm8996-mss-pil"
+		    "qcom,msm8998-mss-pil"
 		    "qcom,sdm845-mss-pil"
 
 - reg:
@@ -41,6 +42,7 @@ on the Qualcomm Hexagon core.
 	qcom,msm8974-mss-pil:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack"
 	qcom,msm8996-mss-pil:
+	qcom,msm8998-mss-pil:
 	qcom,sdm845-mss-pil:
 		    must be "wdog", "fatal", "ready", "handover", "stop-ack",
 		    "shutdown-ack"
@@ -70,6 +72,9 @@ on the Qualcomm Hexagon core.
 	qcom,msm8996-mss-pil:
 		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
 		    "snoc_axi", "mnoc_axi", "pnoc", "qdss"
+	qcom,msm8998-mss-pil:
+		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
+		    "snoc_axi", "mnoc_axi", "qdss"
 	qcom,sdm845-mss-pil:
 		    must be "iface", "bus", "mem", "xo", "gpll0_mss",
 		    "snoc_axi", "mnoc_axi", "prng"
@@ -137,6 +142,7 @@ For the compatible string below the following supplies are required:
 	qcom,msm8974-mss-pil:
 		    no power-domain names required
 	qcom,msm8996-mss-pil:
+	qcom,msm8998-mss-pil:
 		    must be "cx", "mx"
 	qcom,sdm845-mss-pil:
 		    must be "cx", "mx", "mss", "load_state"
-- 
2.17.1

