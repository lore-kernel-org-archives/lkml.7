Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D7BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40CC206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy/OpaLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfG3PYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:24:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40231 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfG3PYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:24:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so63402289qtn.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/t4nyA1Q5Ire67bzt1cmZdzjlm5dY9UznxFZlUXgxs=;
        b=Oy/OpaLgFDIl3Ho9McyAVLGL+eOwG/Nb5xH4IwHyDPX2I0P3C74EQUIty8j0aZM2qo
         QhVKHBa3BNey7q6HFjovwuHmrYTAHL6wXvX1vFs6T2tbiep4xqaaFCX0wIrrgVlpQ09R
         ZIwX7eFrvkds0vdWy9VV87a3STHK+RwqtBxubT19kppdZCk7e4sgfV2ekW4LZja6Dcj6
         AtRAHG2BRPQahofXl9ztc7tIFqXkVxY0xS9NRQ6vO3VL834ArmywoTV5u7f/8uUwm1xL
         p9MevdZpy/3K0TWQg+1prqlCdNlR6iHgiKOhu9DbXGhp5a6TNlbFEYx+96Mn4PzMtbr3
         RUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/t4nyA1Q5Ire67bzt1cmZdzjlm5dY9UznxFZlUXgxs=;
        b=dFiqDnmx9FCZ3OQuyEcSYdm3sqxnuHeqr4IcSYjK4NI6voGJ/W2k+tdsEX8hIWA1Ec
         lo+2jGJK5vXbQ7gEQxf3mzD0TIPIvhgVMgbEKXnU9djmk2lSKYUTL+SUrykgIaUuCrRt
         aQzppgyjd2MmHrUiS15Snmz4Pw5XT6fSQh3OXK8Z/zDBC7lvsP3xfoINDCzFtuV2b5+L
         Gogm9oEdHLLOCNEe6rkm0vwdqClYrjn7kgvaQsYZ+BjdIEA3NGOLwDVN8BFO26AJk+9f
         zPbr7lpTIEqAfx6Qm+1g04kTAH+uM9ekyk2+mcuh6g0QNxohqMFO6NyGRPjVNjSN16Qj
         ayng==
X-Gm-Message-State: APjAAAXMJRgh6i4mycKxJD7s8BuFwl+sDlFBXL2TO5yWoHppOMB4DMSg
        pd/rN0GgHrmyNU4anHQ6Z/5pLA==
X-Google-Smtp-Source: APXvYqx94Ov7Y1nbCbkAGqV/v3t1tnEO2PycbrrXn68BGCtCdHxwCjJWcu+t1wo1xR/RxzXC20qszg==
X-Received: by 2002:ac8:72d7:: with SMTP id o23mr74071688qtp.98.1564500287809;
        Tue, 30 Jul 2019 08:24:47 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id r14sm27251082qkm.100.2019.07.30.08.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Jul 2019 08:24:47 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        vinod.koul@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 2/2] arm64: dts: qcom: Extend AOSS QMP node
Date:   Tue, 30 Jul 2019 11:24:43 -0400
Message-Id: <1564500283-16038-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1564500283-16038-1-git-send-email-thara.gopinath@linaro.org>
References: <1564500283-16038-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AOSS hosts resources that can be used to warm up the SoC.
Add nodes for these resources.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 4babff5..d0c0d4f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2411,6 +2411,14 @@
 
 			#clock-cells = <0>;
 			#power-domain-cells = <1>;
+
+			cx_cdev: cx {
+				#cooling-cells = <2>;
+			};
+
+			ebi_cdev: ebi {
+				#cooling-cells = <2>;
+			};
 		};
 
 		spmi_bus: spmi@c440000 {
-- 
2.1.4

