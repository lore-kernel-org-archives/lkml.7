Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED5EC06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AE62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z8VprxYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405688AbfFKQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:42:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37413 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391963AbfFKQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:42:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so12345833ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lo0w8ORpojy0mdsY2IhEVYR4gGoYMJicUiUW6QNhLjU=;
        b=z8VprxYWtPyZvs14c4WgQ7kwAMpQiYI13AlJF5SCdemHhl95dbunusF4KC/ewEFfJK
         08A/6nHkeK+yxZpi3esrt1Bwh1PTYoh3/hDY5euqI9HuAC7iEADWQ9IVAzXXZyVsYZRi
         se6N26A+HHn4XzQ7OdH3Y1k8b255Lqs7EWLXMdrnpQRtj2P3mTWSL5KjOV1Rt/IHAFZ7
         3gVCklZhJh7sbDCv69LuFPiMp1nK/hkdeTCnF16fTZTNRicYCmLxXZNX2KTc2gOsQVPp
         KNwMrtI5KZRgiSSs0r0wCAszTm7foocK1UsFoeuLzihTKxPYTTiz7uUwkM9BnO+fV3Np
         dQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lo0w8ORpojy0mdsY2IhEVYR4gGoYMJicUiUW6QNhLjU=;
        b=ML+/r1imAhQ25nHC0TqpN0gM8wuCcqEX5P15zs0hb/vAu709wN21jrkCS6a1wD24+v
         YLhPky2PEv9CS2lTl0Ephp5Q7HXrL03hoLy6V1mwIatZE6VCSS/rsK+i2okIuvZBJ2az
         jKzPz8abgGjO1nwGNoQSNOiecQCAXytFDapzKoyHjQUd1tLIcIvupgSJHdcY+4W+43o7
         zAfZYnylxyhGnpDbW8n42wAH8QdXKPhrfSjtpE0coAuPRoiBjmums5P7Y/f8P66/7HHU
         Hh+rj1Dow+vwgEWyxUEoHoqbuxP9mif7VV3RY/6OB+Yuq8uLIxJH7bMyArQq7fvQsDDh
         DBbQ==
X-Gm-Message-State: APjAAAWYZpHH+pSIYlDAEZsJEjFmj4910PdHbRbB2obi+S7Voi+trIOv
        oatv2SrJIAICywsgLXFGZut8Lg==
X-Google-Smtp-Source: APXvYqx5FlDmX+QRpIzUXD8P7FpkyiRLnSLEnScd/+oD5wG/eVT874CN6QVvlXgjoJvc/WjYLNaayQ==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr40619506lji.195.1560271326886;
        Tue, 11 Jun 2019 09:42:06 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r14sm2616772lff.44.2019.06.11.09.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 09:42:06 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
Date:   Tue, 11 Jun 2019 19:41:53 +0300
Message-Id: <20190611164157.24656-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611164157.24656-1-georgi.djakov@linaro.org>
References: <20190611164157.24656-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm QCS404 platform has several buses that could be controlled
and tuned according to the bandwidth demand.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v3:
- Add a reg property and move the interconnect nodes under the "soc" node.

v2:
- No changes.

 .../bindings/interconnect/qcom,qcs404.txt     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
new file mode 100644
index 000000000000..14a827268dda
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
@@ -0,0 +1,46 @@
+Qualcomm QCS404 Network-On-Chip interconnect driver binding
+-----------------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,qcs404-bimc"
+			"qcom,qcs404-pcnoc"
+			"qcom,qcs404-snoc"
+- #interconnect-cells : should contain 1
+
+Optional properties :
+reg : specifies the physical base address and size of registers
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+
+Example:
+
+soc {
+	...
+	bimc: interconnect@400000 {
+		reg = <0x00400000 0x80000>;
+		compatible = "qcom,qcs404-bimc";
+		#interconnect-cells = <1>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+			<&rpmcc RPM_SMD_BIMC_A_CLK>;
+	};
+
+	pnoc: interconnect@500000 {
+		reg = <0x00500000 0x15080>;
+		compatible = "qcom,qcs404-pcnoc";
+		#interconnect-cells = <1>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+			<&rpmcc RPM_SMD_PNOC_A_CLK>;
+	};
+
+	snoc: interconnect@580000 {
+		reg = <0x00580000 0x23080>;
+		compatible = "qcom,qcs404-snoc";
+		#interconnect-cells = <1>;
+		clock-names = "bus_clk", "bus_a_clk";
+		clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+			<&rpmcc RPM_SMD_SNOC_A_CLK>;
+	};
+};
