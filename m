Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84521C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D932070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ey4hlv9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfC2KMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:12:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32846 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2KMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:12:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so1898574wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+TYtSQVH2QGKxuvpbRnS7W6hHgOIHYvxh6y+HNRyviU=;
        b=Ey4hlv9NkuLcAMge47eh2MgZLE/ZAhUcJW3vteVwHV9CdE/I3Fn8mh2zYtUxUh/jn7
         lsNANyD/GLLLsGjgBKeTHR4AhZxK1s2OO8+L++84vvmN1xvJPkJ9/dYXjmx9qDccsDvZ
         X3zQQHf0EPOBRP6hfJxGYc48/usdTnc9AyHO32engsqayS+/yJv7Yy2RYaBF8lQr5ZHS
         Tm8dKV85wfToe+JUgl+BUTO7ufj2i/8FrC2vWzvO6nesj7DMgRg1uXxwuXpcUO9ufRWo
         xVdp2ihtNb1LF+GYLGT1FBtlohypH6HuHbaY9o5b0cklgheOMfGV/NiH3B9sa3XOHF5r
         GIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+TYtSQVH2QGKxuvpbRnS7W6hHgOIHYvxh6y+HNRyviU=;
        b=UsPj9nYpwe0hW9pdL2qUpoxCCrcguV78p5Zfed3VDh8VakRhmj8Sx/9rR/FO+Jqb63
         HdM2dSQO/giSXv08MD6E9bz5fY7dYcoVc5MmFqligtxQYyVzHlHG/yfMWuMjdUKkotmV
         YgcPHT7ycb5tbhviGP2T/RYX8cwqFYonOe61G2NQiMaPUkqoav3jp7f9i2fsdZA+/kii
         I67J/vcXN3MvAu8HNwM4kX4sf8b4kANWYqrBzteay4sx2DnO229bQqjppbQpGyylJqte
         jG3XrYDpnIdZHZXO7hWpcm2HdFC+Zdw348mNTsfodgai3wFKlsyU1n+ojBmz1/7JZApX
         P0IA==
X-Gm-Message-State: APjAAAVZTxmDUtNtuS9B0VvAQKruhOZYFQjbzgmVHdA+4XXEErAef7Xd
        sCUxYgMWtO1ryUekZchLc77fTKna2uk=
X-Google-Smtp-Source: APXvYqz9dPAwQCuGX+Po7XfwBzw/6cuI1fbOif/xWG0iLplG6IwuqZvNHP4rqozRSXDEccc7WMsB6g==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr29398866wrn.120.1553854354201;
        Fri, 29 Mar 2019 03:12:34 -0700 (PDT)
Received: from localhost ([49.248.196.175])
        by smtp.gmail.com with ESMTPSA id l12sm1912888wrt.31.2019.03.29.03.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 03:12:33 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 01/13] arm64: dts: msm8998: thermal: split address space into two
Date:   Fri, 29 Mar 2019 15:42:07 +0530
Message-Id: <e1f41103b412b6809fe43124256e4968c8fae9fd.1553853990.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553853990.git.amit.kucheria@linaro.org>
References: <cover.1553853990.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've earlier added support to split the register address space into TM
and SROT regions. Split up the regmap address space into two for msm8998
that has a similar register layout.

The order is important (TM before SROT) because we make an assumption
that SROT is always the second address space in order to support legacy
DTs.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3fd0769fe648..ac25e9142cbd 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -590,17 +590,19 @@
 			cell-index = <0>;
 		};
 
-		tsens0: thermal@10aa000 {
+		tsens0: thermal@10ab000 {
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
-			reg = <0x10aa000 0x2000>;
+			reg = <0x10ab000 0x1000>, /* TM */
+			      <0x10aa000 0x1000>; /* SROT */
 
 			#qcom,sensors = <12>;
 			#thermal-sensor-cells = <1>;
 		};
 
-		tsens1: thermal@10ad000 {
+		tsens1: thermal@10ae000 {
 			compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
-			reg = <0x10ad000 0x2000>;
+			reg = <0x10ae000 0x1000>, /* TM */
+			      <0x10ad000 0x1000>; /* SROT */
 
 			#qcom,sensors = <8>;
 			#thermal-sensor-cells = <1>;
-- 
2.17.1

