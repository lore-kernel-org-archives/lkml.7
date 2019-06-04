Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB472067C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ThlZP82o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFDW3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:29:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfFDW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:29:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so11199065pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6uE/vL/AC4uqE6b1DA3SJoV5lcu+xB0dTnx7ipoYpvg=;
        b=ThlZP82odSOJMRtuP5KlQfAGXd08O5cSrIkgolnq6lpnCAH2tNpZTGqPgQMuzncV02
         RjfNVxjYH6HeKZOvuPE/YS94Jw1KmLj6BYkoCrGgAxYvH4FNfOzymv/1y4Ex6w242IhN
         2AVOoGjYcut1rdGtRBhVydhEXdj0+HiRRs9QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6uE/vL/AC4uqE6b1DA3SJoV5lcu+xB0dTnx7ipoYpvg=;
        b=hfE2HzedjVJDBNef/8csV95IZY/ekbEfekjkawtD/7auonvmLvIOTAn4w9FjJsV72F
         lw473n9wFABMDQNwZgJuX6lOP4AhPZXbWJRszMf8knuC3UDEvF/SEREpTIirEu7tT6Sf
         LCK/mrPcIx16Pu/6XZFuvt1xOFVTIaFGyPIDH8xlOMj/FEabHQ3m7X9Lxj2YSagQv/E2
         h/gfFcasi/FyTxtF1fCXpX8FAMrzGSuZlfG55HsQLYK5xRaZErQRiLYDatyWtRFUKjDy
         HiZdWg+sPc6IHY6c/SMU6ORxhbdbedA2lfdK1jSe78OarCcmv7hjbatzNKGbaaVbC5dC
         gXfw==
X-Gm-Message-State: APjAAAUZJ2jx6ShuThRGTONZ/odcvlxc7oXx7znbvVwC6ilMUdwi7Z4c
        OkrWHKOXq1Yr0aeqzzD2OmcWFA==
X-Google-Smtp-Source: APXvYqxj1ArdUEzLJARGRA5oIt6nAw4LfskkjatYOZKNGhHdl2uqFQV8wBZAi/NcC6V7qYlnrRiKIQ==
X-Received: by 2002:a63:545a:: with SMTP id e26mr205701pgm.162.1559687380982;
        Tue, 04 Jun 2019 15:29:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v4sm22224251pfe.180.2019.06.04.15.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 15:29:40 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] arm64: dts: sdm845: Add iommus property to qup1
Date:   Tue,  4 Jun 2019 15:29:39 -0700
Message-Id: <20190604222939.195471-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMMU that sits in front of the QUP needs to be programmed properly
so that the i2c geni driver can allocate DMA descriptors. Failure to do
this leads to faults when using devices such as an i2c touchscreen where
the transaction is larger than 32 bytes and we use a DMA buffer.

 arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
 arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000006c0, GFSYNR2 0x00000000

Add the right SID and mask so this works.

Cc: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index fcb93300ca62..2e57e861e17c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -900,6 +900,7 @@
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
+			iommus = <&apps_smmu 0x6c0 0x3>;
 			status = "disabled";
 
 			i2c8: i2c@a80000 {
-- 
Sent by a computer through tubes

