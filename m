Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C70AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CEA22313
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcPAOz4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfKSBS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:18:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35495 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKSBS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:18:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so10802132plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq5TX+U7APVzVaoaAOIejhIYqLJqIfb0addUNvfV3EY=;
        b=QcPAOz4T+S3x+pR/AFPvhDB6vy0xUDa3hIedvCIdddoG1hKBw/R/jdvu2y1vaQ5NBt
         F6E7e3jrjAcAA7KKuBlewxII6CBHoHBQfEqhs+ZedoTgRtzbcKwrUeZRsUs+jZvU7LMa
         +JzdPX07A1xwXRNBMMKUB2P4DQS/xey81RybmRPdchxIF2EbNWi3nfusbJjXvw2t6vgX
         RE2uYTKJQ+lkQPxvNMpvuNWgoS5VrYZlTLo9BcvInCyXb7gSqYfF4Yuo0LOP93HkaHO0
         dMYivO/7n1qj8MJln6KZz9yt5yvdowh3pbjlKXkCr26wQtZubCu+eL4Su+UBmlOtREAR
         A+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hq5TX+U7APVzVaoaAOIejhIYqLJqIfb0addUNvfV3EY=;
        b=k0fMaLVd2+wG0mtSPsWTUSboPAzzCjLcxzMeokxSNhK1eZyXFVVWc8qQd6V3sWHEre
         3yAkfCDmVTLdh+dpZ2QaAWcKh+1bJlE1boxlPkQIMOF0Wc31qCIlCt4asm8r5RKgWaqg
         ziem+yPlmMcQi78YvvaIQPr8S/d4S1qFtMwBiuTllzEMrhm/qiU7cqrf5kv7UeSIRIts
         b7H45QzLFpGCOS46sxZpYtvvQ/3zmoEdf1wzCYsNtzUy+rTlCGdrfVkMK2Dzo5GCPgDB
         5G23fk0j96D8VY1KQWW0KAWy0LypM6060PhExEqgcH/n/gJkS1kcXGg+k1gzxkXr0elK
         Gikw==
X-Gm-Message-State: APjAAAU5dJygjh7Wdm2Jhg46WJiNeBrz2TQtor3ngBIDjKZ2xqpp6eBE
        8f/0p4fyjQZ3upbBTa5qeau8+Q==
X-Google-Smtp-Source: APXvYqx2qcau9xuLewpvhhxmVyJe8cNx/r8C6kPKS6U7KeCXUsr34SI0cHzxo4FWWbJtyN5gp8OahA==
X-Received: by 2002:a17:90a:4d8f:: with SMTP id m15mr2705487pjh.71.1574126307097;
        Mon, 18 Nov 2019 17:18:27 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x13sm22929055pfc.46.2019.11.18.17.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 17:18:26 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: msm8998-mtp: Add alias for blsp1_uart3
Date:   Mon, 18 Nov 2019 17:18:23 -0800
Message-Id: <20191119011823.379100-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msm_serial driver has a predefined set of uart ports defined, which
is allocated either by reading aliases or if no match is found a simple
counter, starting at index 0. But there's no logic in place to prevent
these two allocation mechanism from colliding. As a result either none
or all of the active msm_serial instances must be listed as aliases.

Define blsp1_uart3 as "serial1" to mitigate this problem.

Fixes: 4cffb9f2c700 ("arm64: dts: qcom: msm8998-mtp: Enable bluetooth")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Rewrote commit message

 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 5f101a20a20a..e08fcb426bbf 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -9,6 +9,7 @@
 / {
 	aliases {
 		serial0 = &blsp2_uart1;
+		serial1 = &blsp1_uart3;
 	};
 
 	chosen {
-- 
2.23.0

