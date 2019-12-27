Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9366CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FE220828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 05:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylrRXdCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfL0FdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 00:33:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46420 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfL0Fc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 00:32:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so11287714pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 21:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CACSvkGQXTdbudbrDCr3GVf27K5HI0XInZ9uwni3MXE=;
        b=ylrRXdCYJxPFdRcRwT43YU9htEJXb3RZq6jzea19OthZoBfBd4m9/gGbj4femDTUv9
         KuHvQ1v0+LGkzmPlgXvWU7wHnTpPl0y44bxs+RtiWMm9fZ1ZzxaCPIC+3ueLS5NsksXo
         lExY7XfeYQ1d4pHEXWPRCzBhgaFLJ0FYq/24nd33ipvfzcmOmxessAFWP8ki5PzrQi+z
         wvJ8T//luOhE3WHswVoW8CxcF3xrwCvJRWWm5/6FwIdkW4qzkPTNIZm/IOoAu0ll8/4F
         CNZprkIcdhzbDBj0VccAJpBfZc/0WSl0tCd5Jnp9ljcIrqoX7W0Ujo+pL3dADh5IOv0M
         gfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CACSvkGQXTdbudbrDCr3GVf27K5HI0XInZ9uwni3MXE=;
        b=SgNgKuPqvsUpXxHKLUvavp9dYgSHHUG9iRKxMGbP8MUWRzK+xHdrwZIXfV3oOF67gP
         YYPbR/9+OP7f1HVNSUAIEPBhINBVDVte2awdNYh7WXHSg6qaRn3yfwEDfmhPUePJo5r7
         c9GrMvTpmGI3O5TkFuYFa8f8LvEG81M8SBYt6xopDTiMPOtIc0vn73i3hKzPhsErfs0V
         +xKih+fADSSppalOG3cmLgSL6tevTl/1TKL/xm/nh8NsiTIyKuxumRYDjxn8nB2H8CGD
         sKlJuHhr9foFanhiXMdFe692+IzNi+2+aIjGRH5PTTGT1q7yeExN79655YHyOQ60oglE
         SDvA==
X-Gm-Message-State: APjAAAVtU5dK6u/GVsht8cGHYkPE/yG8UjkvSW7dWNnXcYPEGtUVx+i9
        eY14uJ6+TN6LyACcv4xTunw6JA==
X-Google-Smtp-Source: APXvYqwDC4IXipZ7ZUqmtRfUXBo5/Wl/A9WtrtL7RUaMcfUiAMm6gLsuotO/cQTVmLuhTHt1j7S+SQ==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr23852528pjn.64.1577424777538;
        Thu, 26 Dec 2019 21:32:57 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c22sm16789196pfo.50.2019.12.26.21.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 21:32:56 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v2 5/8] arm64: dts: qcom: sdm845: Add IMEM and PIL info region
Date:   Thu, 26 Dec 2019 21:32:12 -0800
Message-Id: <20191227053215.423811-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191227053215.423811-1-bjorn.andersson@linaro.org>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on SDM845 and define the PIL
relocation info region, so that post mortem tools will be able to locate
the loaded remoteprocs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 407d26e92fcc..e1e13d5bfeb3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3020,6 +3020,16 @@ spmi_bus: spmi@c440000 {
 			cell-index = <0>;
 		};
 
+		imem@146bf000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x146bf000 0 0x1000>;
+
+			pil-reloc {
+				compatible ="qcom,pil-reloc-info";
+				offset = <0x94c>;
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sdm845-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x80000>;
-- 
2.24.0

