Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C063DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9252D217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 04:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPfwc2D5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfEJEeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 00:34:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfEJEee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 00:34:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id l132so2498960pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iX3tMXHfmXAFXgezY0ndg+xouFZG1EouvpxfWVnQyEI=;
        b=wPfwc2D5OF/jIrQh6ZiDhbghVvEWi/KSKgRlbqnjQdVSy1tBYJ/ow053Yrs0CJfGRH
         0LybhQkgMUqXokj+6NjwjduqZqgutOyy0QX9GcL8zyspz4T+Bt9pGDhSF57RQaNGLY+M
         cVLmvrlpp7Qz1hO6bALHejmw8tpzUXStqxX3W1Iip0hFVhB4z1p/1FS0J4Cy+nTbGJtP
         lfaDV6tyBANfmTO3J8s0WwMFJEI3NfTxbXYbcKnwoJORsYhUVtHglzjpo6wJDiaxm/g6
         Ajqb+Thj3C1/9Mn4zOaHND+I0qL1LYR3KXR5tkXTclDP4XRG/JML+XFhOFPhBrCsdjtw
         Duow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iX3tMXHfmXAFXgezY0ndg+xouFZG1EouvpxfWVnQyEI=;
        b=f+xCX6GOCpw7bgfrMXgQ0+d6RR5H0w7fOTsdVDDTgBWoVB2c/hlqj3VH9aF+jIGF0e
         rMRIoJBMeDhngYZWOkHM8tO8QDempuE9ODXM7JLSDRaqK3bXS/vd09y28j+zg3aCUVhw
         P6TuA8RfF4x3khBdscM9IUX4D0TC/9zeLPrfJ72714pHBn2qAduBs7dGXuE5jPFiTO5I
         Iu3+eo5ncJBc0wXsYJ1/3M+eMF8GORv/Uv6vtg9UCw/LFJL5KhYNPePQV/iteQ/HtwZY
         O1VKPqS7o6w9W/+9Pdl6PddK6pAvDH6KEXeDUKAt6s1gqsRigFduRMpFH8DF1mZgO+gO
         KelA==
X-Gm-Message-State: APjAAAUIBas2ARNrUCsQsRGGrXxXItoEbtOlBBCLA0wi7fgGk6VECATN
        HbXDf+njsU4bLdRyMRCKjxI+JQ==
X-Google-Smtp-Source: APXvYqz+VCrGwz0F1OeNQEiRJZyZwGUfV3b04q0MFLWKiNqRgZb4ye/bbEOX7ZRjTy+HIpkkBqHGmw==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr11006230pgi.7.1557462873882;
        Thu, 09 May 2019 21:34:33 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s17sm4785317pfm.149.2019.05.09.21.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 21:34:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: qcom: qcs404: Add fastrpc nodes
Date:   Thu,  9 May 2019 21:34:21 -0700
Message-Id: <20190510043421.31393-9-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190510043421.31393-1-bjorn.andersson@linaro.org>
References: <20190510043421.31393-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Escande <thierry.escande@linaro.org>

The ADSP fastrpc provides 3 context banks and are assigned to IOMMU
context banks 23, 24 and 25; using SIDs 0x804, 0x805 and 0x806.  The
CDSP fastrpc provides 5 context banks and are assigned to IOMMU context
banks 5, 6, 7, 8 and 9; using SIDs 0x1001 through 0x1005. Add these to
their respective remoteproc.

The lower 4 bits of the SID is used to identify the context bank when
communicating with the fastrpc firmware, so this gives the reg values.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
[bjorn: Added SMMU linkage and extend commit message]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 66 ++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index fcde4f0334c2..858a53160564 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -243,6 +243,45 @@
 				mboxes = <&apcs_glb 12>;
 
 				label = "cdsp";
+
+				fastrpc_cdsp: fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_iommu 5>;
+					};
+
+					cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_iommu 6>;
+					};
+
+					cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_iommu 7>;
+					};
+
+					cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_iommu 8>;
+					};
+
+					cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_iommu 9>;
+					};
+				};
 			};
 		};
 
@@ -928,6 +967,33 @@
 				mboxes = <&apcs_glb 8>;
 
 				label = "adsp";
+
+				fastrpc_adsp: fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_iommu 23>;
+					};
+
+					cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_iommu 24>;
+					};
+
+					cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_iommu 25>;
+					};
+				};
 			};
 		};
 	};
-- 
2.18.0

