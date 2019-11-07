Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2631DFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DD5214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlLlhnQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbfKGAQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:16:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37675 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfKGAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:16:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so619405pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0nBZv8FFoKEgL4fsBvxQaUdCsRxc1XVotv1J9YRLLnw=;
        b=KlLlhnQzrZLYcZikdtxcTrY7sQne6JCPy0QN8bUz5EuBMZh8wwD/0fld2egCgIDonA
         nEFruNRrcA4//QYZF5HEFn9d3KTeaRgZfVoBvdDX610t95RTvAYuq5bc/3OrgJS3cvYY
         QV+6Yx2iagsg0yaRhWwaAh+p1AAVTlVfa1BcHioGT+oMCsp67w2724+YyAZ5xVBw29/e
         IIwjBgZl7xk1sDCqRN1J9ImRuwhrZpDfSZELDsI4RkzjRqGn25M/xwKG9LksalvkjlFW
         4+P/1jCX6LgKnuKeILkhZdoCNMANVdOGfrFQwwmr3neU3l6SZQQem0MbywkBO8YnIzc6
         4PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0nBZv8FFoKEgL4fsBvxQaUdCsRxc1XVotv1J9YRLLnw=;
        b=ZfE4DJMQvUJ6keGiS1U83J5e/mWp1pmy50A24SWY05Tr05HevXhLf5IbBj31bITqTr
         k6ccBsvJSSbXstVZxqr5PPbiNoQkGKJnr4obkNcIgkm4JK7mhC+OqmhWennT8/GFQocC
         HFTgkD+X6TlPPe10ym06xV4OdNZ2C5i7VkdfFiklg6vxfebPbkGaxcs5oJSfy/bDeCZK
         lVAEISHTPi498o0S5iAar7vCNZRB0HF2c6i/UCeFwVQ5qkWKc1ghwCcvrrBZOg3OuXZc
         3UZJqurC96Y/NAz8WZFfgVHBYaygfQuPv/zrDe3qjTFMZsyzogx4ER5b/uzMaJyrJeBD
         4Chg==
X-Gm-Message-State: APjAAAWB0IKc8/AfOk5EKiLrZw2QwxLbonl5s/CvYzj8uouxoRhOziG6
        h9Eue5S/xnAVZAh/Tc0Z8yjSRw==
X-Google-Smtp-Source: APXvYqylCS28PWGfQarKLeATMQnlbU/SSpHJ55W+DXbTPWJdbgLGRSTTN/p4Gq9A3Hy0tqLWzVu3KQ==
X-Received: by 2002:a63:65c6:: with SMTP id z189mr714193pgb.433.1573085807945;
        Wed, 06 Nov 2019 16:16:47 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 90sm81044pjz.29.2019.11.06.16.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:16:47 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: PCI: qcom: Add support for SDM845 PCIe
Date:   Wed,  6 Nov 2019 16:16:41 -0800
Message-Id: <20191107001642.1127561-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible and necessary clocks and resets definitions for the
SDM845 PCIe controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Picked up Rob and Vinod's R-b

 .../devicetree/bindings/pci/qcom,pcie.txt     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
index ada80b01bf0c..981b4de12807 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
@@ -11,6 +11,7 @@
 			- "qcom,pcie-ipq4019" for ipq4019
 			- "qcom,pcie-ipq8074" for ipq8074
 			- "qcom,pcie-qcs404" for qcs404
+			- "qcom,pcie-sdm845" for sdm845
 
 - reg:
 	Usage: required
@@ -126,6 +127,18 @@
 			- "master_bus"	AXI Master clock
 			- "slave_bus"	AXI Slave clock
 
+-clock-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "aux"		Auxiliary clock
+			- "cfg"		Configuration clock
+			- "bus_master"	Master AXI clock
+			- "bus_slave"	Slave AXI clock
+			- "slave_q2a"	Slave Q2A clock
+			- "tbu"		PCIe TBU clock
+			- "pipe"	PIPE clock
+
 - resets:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -188,6 +201,12 @@
 			- "pwr"			PWR reset
 			- "ahb"			AHB reset
 
+- reset-names:
+	Usage: required for sdm845
+	Value type: <stringlist>
+	Definition: Should contain the following entries
+			- "pci"			PCIe core reset
+
 - power-domains:
 	Usage: required for apq8084 and msm8996/apq8096
 	Value type: <prop-encoded-array>
-- 
2.23.0

