Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B4C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCED62075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clEtWmbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAFKXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:23:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41011 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFKXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:23:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so50411459ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 02:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B0/5oZmpyMpvoGdHibbnECdx+O3YaUpB8rzrVDmAk5M=;
        b=clEtWmbh+qaBqe+He2QKgbhvUT/cLCZyyQvw1JRHZwX93MLJhhwpKITQs2A86cqhDK
         R1FVH3Ul0Epai3TWrb4TBgeDApCtrRqtdL5z8uviLVawFn6h7LD1wEOhyhOIhlJoZWyG
         buJC+IMocTB2ZqduPh8Ae++DtZq6endywr62f5VL1SbHV1XCSI2dyK8w4+9Yk9uG5WDb
         1Obk37dnPqbEtjqDAQgg0HhbuiXjnk6PYm+xXNoz2bL+jcHaEC3T00YId8Qw8DL5WOMP
         xsY5IV8vtZQBkiunVu9CGDBU3/AYduXDd5o+PUcvSUcIKORFetRxY32ZvJswqfqff3ns
         sqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B0/5oZmpyMpvoGdHibbnECdx+O3YaUpB8rzrVDmAk5M=;
        b=NIuc2OTell3ZXpwBWaNuYImHcvA7/Oq++w1DZZ0L5C/eOM5S7IM0Tad9dKF532pVGs
         wPQ5Q9Fhs1K3XOxh/YzlEF0eIgvPrz/7KC/utXN0lZ0ZAwoKsfCK8LgJ5dk6YA1aJe5a
         7E4vHHbNM7DMbeBZgKoXdZkHLTvveDZ6BLr3+UdUJKEyR3/wIRLW539PzKPQEvDb4qUG
         7m29HQyhW8bDw793VQBMxq6jnKZuPghSlPcLEmPtj8bkZcS26Ej7Vqqzn/MThutV0QCd
         FQxvrGN8fhZM7F2bNQTJaYIPsmrzspXocmkdw46VCZWPkeM110OMcaJhr+mTrZJPT2fY
         hEyw==
X-Gm-Message-State: APjAAAUdreMdShlczDX8ycukUUgtUe9JwT4rpIywOEVUJscsWotfrWDa
        eWMocGel4xFbCl1/aWkwn9ICRw==
X-Google-Smtp-Source: APXvYqylp5NiLHXERz7acxYKyV5J6DD2bC3iTYDcgMA9NVOGybslb4wcRBjNRaJF/9+lKu8tR223bA==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr44715875ljk.27.1578306202203;
        Mon, 06 Jan 2020 02:23:22 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id u25sm28836745lfk.46.2020.01.06.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 02:23:21 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] arm64: dts: qcom: msm8996: Fix venus iommu nodename error
Date:   Mon,  6 Jan 2020 12:23:05 +0200
Message-Id: <20200106102305.27059-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following error/warn seen with make dtbs_check

arm,smmu-venus@d40000: $nodename:0: 'arm,smmu-venus@d40000' does not match '^iommu@[0-9a-f]*'
arm,smmu-venus@d40000: clock-names:0: 'bus' was expected
arm,smmu-venus@d40000: clock-names:1: 'iface' was expected

by rename nodename to "iommu".

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 4ca2e7b44559..9bbcee31f28b 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2267,7 +2267,7 @@
 			};
 		};
 
-		venus_smmu: arm,smmu-venus@d40000 {
+		venus_smmu: iommu@d40000 {
 			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
 			reg = <0xd40000 0x20000>;
 			#global-interrupts = <1>;
-- 
2.17.1

