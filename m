Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E51C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7182F27CDA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enpEKMCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFCHfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:35:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43788 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfFCHfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:35:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so1532124plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WeJByq3I424RHBGjH32sFcsG6B+iqGeZ0ID7b3v4bBs=;
        b=enpEKMCrOjQNrqE7jiuWbbNkwP0ud8MaKH14i8OrVQdQkjM6brJwG40pVUfM0RwkKL
         68yUG4qsPrqXI0ArlfjwfzSjkInEtjsdwuEpLzFD7D0MCnIrzjmPf6dgC3zWZaaJmwPv
         h/NbUExPFELpfROE1t7Dotty0yv+AcU7ZYMTzb1s8XITgy/13vWxGI9wDHzD4BiD81J+
         simnyIg13cGrzldq0M4tWWC9TyQwrqIW8+pGo127SxZaAGaMY8gdHl5BwNe3RjYRv/bK
         kyBXyTjAOFMxQSFlNPo5i8qODbxsOZHG7GrrqsU0LqvYW1hldrqVhIW/rE67QlIL5yI9
         V+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WeJByq3I424RHBGjH32sFcsG6B+iqGeZ0ID7b3v4bBs=;
        b=pXVOiGGKgcx6TTj4We49PozxlhmFXGUDA7gkrbtndfkdxedtYgatJIfmbxC3asO62w
         gEmbOkxaBxBQrNb6oYV9KFNeGmVeLV9dA4J8TIm1ol/yPi9PVYxnBVTVNmOKPbfeBFAe
         UR+AZu5BrSmADYZGysyVRpwY5Dsbaq4vApznpXzcQ4+Nl4Pl62SqYkbbUY66/H09R2cu
         nEyYaMYtcwh48+7E9dX2lzeFUtwG917QttafhwveNwN1Zpb/ZzDfDp7pLzQ3deDidBhZ
         TnTqdP+eTMGrS8ST1GvMe7YCQLL4RWfv7b24Zr7cy49rrrw8KWgkHDdNKPO2ZYoRVZtH
         7mGg==
X-Gm-Message-State: APjAAAUNe0UBsTz0fSW0rHaGgIKdpxWQSLMCCVn3jDooGAg3Qw6yzmsl
        U5UPclqgb0Ojzul2IkcWDXvX
X-Google-Smtp-Source: APXvYqyxseq8SM9ECcOqRnX6oty4StRUPv4eRvJ1hr3jIJdHE4lBzanEiyCyn5lhDdUKP5FuE34oGA==
X-Received: by 2002:a17:902:b084:: with SMTP id p4mr29165367plr.59.1559547305839;
        Mon, 03 Jun 2019 00:35:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:716:e714:cd5e:23ab:e451:ee6a])
        by smtp.gmail.com with ESMTPSA id r64sm17547366pfr.58.2019.06.03.00.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 00:35:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: pinctrl: Document drive strength settings for BM1880 SoC
Date:   Mon,  3 Jun 2019 13:04:20 +0530
Message-Id: <20190603073421.10314-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document drive strength settings for Bitmain BM1880 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/pinctrl/bitmain,bm1880-pinctrl.txt       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
index 4eb089bcb5f3..4980776122cc 100644
--- a/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
@@ -100,6 +100,17 @@ Optional Properties:
                   Valid values are:
                   <0>  - Slow
                   <1>  - Fast
+- drive-strength: Integer. Selects the drive strength for the specified
+                  pins in mA.
+                  Valid values are:
+                  <4>
+                  <8>
+                  <12>
+                  <16>
+                  <20>
+                  <24>
+                  <28>
+                  <32>
 
 Example:
         pinctrl: pinctrl@400 {
-- 
2.17.1

