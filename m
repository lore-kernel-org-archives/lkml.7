Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF94208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+V8mfJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfJaSiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:38:18 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39861 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbfJaSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:38:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id x28so1738435pfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3aqllZnhirWen18NJ9rLavBCP+/YOWA9zZa8CCtZyTg=;
        b=o+V8mfJnGcNRBIysUz3ogBIYyeQLpvCAokFHFk3CcXJmiW1VMtm8jwXgA9ITcdbOCI
         dpipZiut4ELq+5dqxkkwzdTUrXo7h8QuxnXI7Gk9WFX9dM0I01JlXFDJ26LjFH/S9WFm
         0OpbVc819QkOksWL7iNk56Dz0bIIFCZHmNaCURmU4P6hhV839a0frnrjNgJBdQxEqJI0
         L98/m2btd3eRB44eNjWZcgdA89ZGW1DpgTK8oZ3bImEfQmqlBIL/h74wiRaJWWgUspXO
         qrXrNDh7dmNhxFZzL8ZmQcDW/K9VCUYJ4Wd/NbDhtvguNXKWvXIbKRbCvsVDTcKKhCH8
         hSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3aqllZnhirWen18NJ9rLavBCP+/YOWA9zZa8CCtZyTg=;
        b=q3NPsPdFODQGyMdF16y1CLt2U5oDGSSzGNqFq1kOaHklWTY5NZfl7xQ+5RkWHguKaC
         xClMDL8se4vMI+dPDruUaGaDV76CN/r/PeQv0Bl0Vt2vCUmUnsNVC3n06sxFY2mmceXP
         76moGJNwR6HO0J/pJKzENbTaOdYow8+A7CJouJ6IUNmjqm6NhydFRVayNvTCBbL+TrbC
         70RpcPVUCQt0kCc63aeveuzJmzJYxf+837n/L0/KSafL/bCRtvkB08fARY4qvLtDKMpn
         G7LM99wbvR8TV1bxPcvKIKLj+iFPr64SxovRivk1R0MiMfeXH+rRkfePiWqfxx+oGf2x
         w6VQ==
X-Gm-Message-State: APjAAAVdC7lckXR5hGNrqojBaWMguvwIe7hcOk2DKuIG8ZY79oLSAAC/
        tdi8I4gHTHCw/spIs5gKnNVtGxIocpqmcQ==
X-Google-Smtp-Source: APXvYqzaApqXtEra28Hi9Be4UqLrpLV/oQdr7G+MWkAtzVgUBjSh8sBzdugn282PcVCuk+CWFPHaJA==
X-Received: by 2002:a17:90a:9201:: with SMTP id m1mr9657985pjo.42.1572547095176;
        Thu, 31 Oct 2019 11:38:15 -0700 (PDT)
Received: from localhost ([49.248.58.234])
        by smtp.gmail.com with ESMTPSA id c34sm4206329pgb.35.2019.10.31.11.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Oct 2019 11:38:14 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v7 06/15] arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
Date:   Fri,  1 Nov 2019 00:07:30 +0530
Message-Id: <1726fdbf7cf7200ac5dc2a4c811aaee7edc47fd5.1572526427.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1572526427.git.amit.kucheria@linaro.org>
References: <cover.1572526427.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8916 uses sensors 0, 1, 2, 4 and 5. Sensor 3 is NOT used. Fixup the
device tree so that the correct sensor ID is used and as a result we can
actually check the temperature for the cpu2_3 sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87..8686e101905c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -179,7 +179,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens 4>;
+			thermal-sensors = <&tsens 5>;
 
 			trips {
 				cpu0_1_alert0: trip-point@0 {
@@ -209,7 +209,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-			thermal-sensors = <&tsens 3>;
+			thermal-sensors = <&tsens 4>;
 
 			trips {
 				cpu2_3_alert0: trip-point@0 {
-- 
2.17.1

