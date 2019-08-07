Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48471C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C1521C38
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN1iYmX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfHGFkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:40:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37740 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfHGFjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so38973107plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LuR1ky4R+W8DnJlClr7ItKCcIJSpq5BHTgJG+rP0wz4=;
        b=BN1iYmX3VS7iNjW36GRLTazm6lrD0RRsFwt3TRZMMqbhiC7X6+9Uzi4RYwPKB60hQn
         4nS2QQ4CVKBocbEcvJEM7OOGQcV7THez5IHf0FQiGx7UInJSEoH3dELsSjvHwx0Jg2JJ
         eJgm6W9JJfX0M5zOEKyX3dQj5qdXRl6ruoNTm2zdwPcLNEq4xOoe7o3FKadQa8TJZRHv
         dFFgTWSlwiRuxq20DKWLdBaPUkkHgfoyJrhSienE5+enZLqZzBFOdQGx/z7+54x9dfFP
         llaWNYh0YsFjxuK9DISr6aso0211Ps+SesAbVPKLemIq78WkV4K1X++La0IY9sSuR84O
         QkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LuR1ky4R+W8DnJlClr7ItKCcIJSpq5BHTgJG+rP0wz4=;
        b=FrAD//5QWnP9CLYVuR7SmLOi+KuBYGZObGj+5oxFMOIIB8/4y0B8TBjco85lbq1jPz
         Zn+b8U5Xii3+KL9Pn9c8pCBInOFUIHigTc/X6dP4pSNmUzFG6bgS74PUMCOY9sLBNLos
         4Tpc37Kyxn0KuK1TM9ESvIFYC8weu7CYd0dV8oZOYKG1eAcTRFp/zrpUfZgtgZS44OwO
         sMJivG2hDUCm4ThLJGp+pnNCj+xkYaM5TIFsj1hXgDAq1YQG3I4p2eGs7nwQhmCVBs29
         1PrYM0AhO3qj+lrwUDwdVkgvaHx0RX0qPckcRzUaZz1x5c2Mvk1wWyzWH66pci50obes
         7zxQ==
X-Gm-Message-State: APjAAAXFkuYVm8TtAR7qQd/Kd6lDa+OLNnBfSTqRduj2niGz4FTj8cuj
        41cHNXn0hQJhnpjWovl8YkScGQ==
X-Google-Smtp-Source: APXvYqwteeE9q8f83hjRPGYATCdDy8cEXcbkYjbkT24pE6lGFv27jx/C08Js6EVAX5W6MsCH9hmiMA==
X-Received: by 2002:a17:902:7612:: with SMTP id k18mr6498473pll.48.1565156391829;
        Tue, 06 Aug 2019 22:39:51 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 5/9] arm64: dts: qcom: qcs404: Add IMEM and PIL info region
Date:   Tue,  6 Aug 2019 22:39:38 -0700
Message-Id: <20190807053942.9836-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807053942.9836-1-bjorn.andersson@linaro.org>
References: <20190807053942.9836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple-mfd representing IMEM on QCS404 and define the PIL
relocation info region, so that post mortem tools will be able to locate
the loaded remoteprocs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 3d0789775009..1604a9697832 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -845,6 +845,16 @@
 			status = "disabled";
 		};
 
+		imem@8600000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x08600000 0x1000>;
+
+			pil-reloc {
+				compatible ="qcom,pil-reloc-info";
+				offset = <0x94c>;
+			};
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.18.0

