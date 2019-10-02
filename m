Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6288CECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F65215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4UzvH8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfJBEQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 00:16:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41622 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfJBEQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 00:16:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so11166631pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 21:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yB6EANp2Gq2nUYi0fb1/BMw/e2qObJRACvpr+KuVRDo=;
        b=H4UzvH8s1D6iyBib4zTgN4lMKIc7Ddl66kGBgRvUt2vZCz0fN3PgY5MeWjfW5WNtOv
         XBqf2xOjig9aRUTTluZryXiJBTonzxGvntVT6u/hSOnQGbDbh4h6x8w+/eJ6ip72tROs
         614tDITQjEweLmuhU79n/mvp75x6Xph8oSsP1HxnkBGg1CHM3tsvzx7RF7oqh+E2FkCj
         NBpgLewGFWwp1Hb4mZerIFkZz6DvyTUDJoigib5+rscmJgC0xKCSoWwkNQhSmmvSU3tD
         YvINPYlznif8X8fb7oxhzKpjnUeySO8ObwJSz41MU+1T1icieqSgzuebgLQRuAQSq1QB
         el5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yB6EANp2Gq2nUYi0fb1/BMw/e2qObJRACvpr+KuVRDo=;
        b=TSb53my5JsrVXZiqa0yijgSgEhRE69PrFxhAO2vHmj+JqTsz67aN9Gswdf3nuTXhC0
         RJyfst631DfeI+MYKWK8PNB+XxJzLRnYJO6sJUZWbVrr/qo90jJBifzK35zq8E/BynOt
         Zvhc9h7g6LLcbENS2MJ5UwgXOQeH0zb1/co/N1TEN6bRuv2+SLC+c0BGquRgI5cDMUQp
         q7M4oFPEd/UcnVKCH1wikDkxJ5OzTphtXPZjIC2ZLuW68I/ArCV3YqR7UJBUYfNU6mk4
         qZndGeW6ancp95/xbaz40DlQeZLEVDYoPdgt6sITbbXnJDyFkkrNIx3tIlgLaLzhwvOT
         r4Ug==
X-Gm-Message-State: APjAAAXQldFZGZ90WAR0Sjp70Rs63Fj2dCbCA73ih2setqy5tShEXfuq
        Hu3+00QIajl67qiwk2CKGPag+g==
X-Google-Smtp-Source: APXvYqwBVvw6q508G5o3bf3yw4tBbE/PmtZBiLhL99mw7fwFWisBT9Caa+zDSh/1LGrKgk4EGRcVwg==
X-Received: by 2002:a62:d14c:: with SMTP id t12mr2223538pfl.185.1569989818127;
        Tue, 01 Oct 2019 21:16:58 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 37sm18013315pgv.32.2019.10.01.21.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 21:16:57 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: db845c: Enable LVS 1 and 2
Date:   Tue,  1 Oct 2019 21:16:54 -0700
Message-Id: <20191002041654.3620-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vreg_lvs1a_1p8 and vreg_lvs2a_1p8 are both feeding pins in the low speed
connectors and should as such alway be on, so enable them.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c314b5d55796..6e97ae7f7a08 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -312,6 +312,18 @@
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_lvs1a_1p8: lvs1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
 	};
 
 	pmi8998-rpmh-regulators {
-- 
2.18.0

