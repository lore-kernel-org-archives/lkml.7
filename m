Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8790AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5537B214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7Vx7SQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfEHWn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:43:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfEHWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:43:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id l132so191723pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5q9dsjY3DBzndr7wkuvZRTHnczHf4Q/fpKRsCx+qJwI=;
        b=N7Vx7SQnonpq06ayiMuPXO0+ovJ9IYasbzcwhbTme1cqt6g2l9EAJqV0qhEcQK1LXZ
         8RsHpt092gP2klW+DYNIce8SMCQbCIbM2mAaR/ePnQcJby/DDVcuFak875Y4u9bTLuCY
         ZF4KHTOQnu5/Y00nHE9tsG4FY4ZC9vyUPgEylDJ+iqA34If3nZZP23+P8+WcOnk90U6Z
         GCB5qzKAGTplbpCxsI2zSlBk1z63A99GOru/9uItbbTCs3V7fRcMgbjRDswQ4CLZV5mn
         9I9yvTxeEwUs9yr0dEmFXyJrdPlhs5VBxj/lOiIlznABbisQ3pZ2hLvUfQbZ18G0j1Du
         UAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5q9dsjY3DBzndr7wkuvZRTHnczHf4Q/fpKRsCx+qJwI=;
        b=K372C0XSt1RuP45yU5Oe4qWR3K5wfIhD1CDeiQ2O6K564O2YNLmhGO1lnMHH0moerD
         ELYkfG7PDeQSD8iTKNwMsbNfExJZUR7HUA6Na0dt3lEshYDOoa2cyJoHGgkt0OOvKG1L
         2EoZ611CSXmBl7IZJp3P8EbsPxXEKFPdsqSLuWsYWjxxnumF6rr/+gtk832rMX8QCwPQ
         O6hbSooHS/ICGnjOR0VwkMNPmXpT47wZq1htUpz/mWRlNA+qUdI3CNmYQFsch+Y2QOsj
         t+BhsLl/7G3gIica1jAmDNJk82SdiAiM9uueMdu16QT+GM6sMCdGg4GfxUYbIrdJxOFo
         W+oQ==
X-Gm-Message-State: APjAAAUZ/EdsgVnu/AOHp7liY/EX1m7S3CBVpft3s4Ra5ZLUzp7RiP08
        UYA3BnsK61R+rUECwtMkuzHwsw==
X-Google-Smtp-Source: APXvYqzOx+Ty15Ki0fJrGT+TPqPGOflDSOwh2gjGYsH4NMh4u336RZkfTJHnFY5wiuyJ+fbYEByX3Q==
X-Received: by 2002:a65:48ca:: with SMTP id o10mr900894pgs.136.1557355394400;
        Wed, 08 May 2019 15:43:14 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 25sm320494pfo.145.2019.05.08.15.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 15:43:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] arm64: dts: qcom: qcs404: Make gcc as reset-controller
Date:   Wed,  8 May 2019 15:43:07 -0700
Message-Id: <20190508224309.5744-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190508224309.5744-1-bjorn.andersson@linaro.org>
References: <20190508224309.5744-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC is a reset-controller, so define #reset-cells.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Split single patch, no functional change

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ffedf9640af7..65a2cbeb28be 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -383,6 +383,7 @@
 			compatible = "qcom,gcc-qcs404";
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 
 			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
 			assigned-clock-rates = <19200000>;
-- 
2.18.0

