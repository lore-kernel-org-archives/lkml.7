Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E2ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E217C208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGuurnjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfKBA12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:27:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41718 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfKBA11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:27:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id l3so7445664pgr.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abIxfgc9fnK9AD2iU1nPxC91Bq9pACN+MgDiw3wopZA=;
        b=IGuurnjl4UUmE2MIpNzi4yc1Xq0voatd5HcWslq5OxsHLpMjf9QshCggMb3dZeE+E9
         wCQ1iVUDzlQqODnJ+CbhQ2MPDmf2m3Ls9xdOiff+v8I33micCp2BKoLBscEML0IvUugy
         CtL7sje3+8FKtTnKc/iV+ENMbpCU1CilE22WSSOc+e9uW3miPfdBTZGxw/CNkvYIXMmg
         CkX5yxVP0QOKtOMmXJbBn4dCUkVEAaTK7O0u1be/u7wACFHwbmQCw86Ngn/yZzw2dkti
         eyRoh9QVtelhrg8b526tPQySNDciS3rV5lgv5V0imvIvsiyCAH6/YhfFdEFT04gNLrxe
         4Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abIxfgc9fnK9AD2iU1nPxC91Bq9pACN+MgDiw3wopZA=;
        b=oA+l9K7+DXVaP+wRKrklwxhesMNQ/c5B3KCuviPDlqg5L/QhbKCuh/WrpJgvIcjRjb
         y5ntzA+pSPMrVdPS4VLYd1/9kpDcMWPFdfp5nTaQa8Vk4L/zp/NT2K9Fjnwj0lVuIzI2
         lvIWFHiW+7EAwPe8Z5O+A1M2viaO3Hvh0m3Dnk2ysud9GPebvtAUNGfHXZkASqdaQRZC
         Yjl2RCxeonNJiopqG6lixK5T5RQLIJVKE/DrbxG+8UR2vwVpKd+7eXoTATu4Go1NgFVT
         I0AETWBuk0CavpL3wwAEAyNn4FMcuis1MBWLYlBeVbYV23qT9QqwMoedWT/EiFH0wsGt
         Nx5g==
X-Gm-Message-State: APjAAAXOfbbWvKQz8nn9xCV5MK1oi3WYXzBFK9qDzxegSP4982np3bch
        rxTLI3LjswAMzTwbTZ8r5NT5CX2bzew=
X-Google-Smtp-Source: APXvYqzLVtsJ1+fsQ8wcZPN8Jupl4afEmh9yjGDk6FOTJl6qSh/nEobh8X0ZvvPxM2UgV++BqVxE3A==
X-Received: by 2002:a62:2e44:: with SMTP id u65mr16597100pfu.103.1572654446194;
        Fri, 01 Nov 2019 17:27:26 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e8sm9395910pga.17.2019.11.01.17.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:27:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom: Add support for SDM845 PCIe
Date:   Fri,  1 Nov 2019 17:27:20 -0700
Message-Id: <20191102002721.4091180-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
References: <20191102002721.4091180-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible and necessary clocks and resets definitions for the
SDM845 PCIe controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Split out binding in separate patch

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

