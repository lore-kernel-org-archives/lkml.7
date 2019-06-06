Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF8C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2C20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qd9d1msb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFFBC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:02:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40117 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfFFBC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:02:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so198014pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 18:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JrcbvKOldgWkH50kiW0a4HfpMKXomzEmet187F9e9WI=;
        b=Qd9d1msbSQb53Iq2KqsHsAFxY5JW7/DojKA2+N32CgI93O94JHubPZWVlC4T3bAMJr
         ZrvFCj/RzF+FbICJpj5JCH4CSTEAarhBE+BW5cjaT/fhsuBRzHh4R4kg+eUsJkXcmelb
         aJRZaXGTdAXba/9Zyk31ploH6ku4OjM3HOI4G79WyWiadhcA/+hLyoyLuNP/7hmImK4s
         yj7Wm+GpGOxYDWvhRDlGg18PZFunPptfjzeUCnWdgmaLkwE47/RuxkhrxK4Na8bGlHe6
         qFcEbErPiIJsSTnCUmMVu7jomRuNUC1mBrKGUgXmeBtTMd8nZ9ibn65B24CxyjbksXiS
         yxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JrcbvKOldgWkH50kiW0a4HfpMKXomzEmet187F9e9WI=;
        b=UKsI9dXIh/cRrc0gW9mgEZx+07f9nQXR795BlPTrHa36ban6EQ1DPas0yDselANM1d
         3HkbhOECVaEE0JHaQo8zs6/5w2hk+3gxUswxET8IQeGTLlwVz4/GfY+P0EqDx/y1V+II
         TkgbFjFY3iVqMIiMcmtgbb2lurAKZovR/86lXEpbslFWtn5c4NGbJjjK6tOrPmGkDq1N
         sAhgHf/bCxXZxVPaiLTOCFrstswCvwfCqCBCS7PSpxbxCP2oAiVhnTV0KKvwU5OeKqq9
         kCzk2PNRsD0dhW9ksX0EVzhNCefZhMiQn6jJyXVijtrptT9291VxttJvtTjHSJ1BDKYe
         YeXQ==
X-Gm-Message-State: APjAAAXTkv0WrktgqJFldlXhTaSy7b7WcGaIXU+OnsBhCi7epr+5vAkv
        DGjRmri4HekhhRIW0B9iBIsbqw==
X-Google-Smtp-Source: APXvYqzxPgy34UUwtKp+qsxEzAqNHyHrYFZnGo1PhXfMwMDzdB7H5vaW7x7ustTZPxvF+bd24ZmJYA==
X-Received: by 2002:a17:902:a716:: with SMTP id w22mr47239553plq.270.1559782976660;
        Wed, 05 Jun 2019 18:02:56 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm170856pfy.54.2019.06.05.18.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 18:02:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm845-mtp: Specify UFS device-reset GPIO
Date:   Wed,  5 Jun 2019 18:02:49 -0700
Message-Id: <20190606010249.3538-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190606010249.3538-1-bjorn.andersson@linaro.org>
References: <20190606010249.3538-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the UFS device-reset gpio, so that the controller will issue a
reset of the UFS device.

Tested-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 2e78638eb73b..d116a0956a9c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -388,6 +388,8 @@
 &ufs_mem_hc {
 	status = "okay";
 
+	device-reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
+
 	vcc-supply = <&vreg_l20a_2p95>;
 	vcc-max-microamp = <600000>;
 };
-- 
2.18.0

