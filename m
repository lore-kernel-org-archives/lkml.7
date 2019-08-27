Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D528C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502A20673
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq7XwNmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfH0MOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:14:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37327 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfH0MOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:14:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id bj8so11706300plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MENoYed9rPqZPrA/Y9pbBbNZ42AOAV3KIOD7B7ZsAOc=;
        b=Cq7XwNmGxqr7lr5trrx9ocRa44nCu9QhvrPVh5dNxZaAVhX1OpBPNNP/TCUY8kFCPr
         LROr7UEXZisxC78xT4MiD4QsQChM2LeUr3sFojd2GcIWX9z7YJjJv1UuPBZBW0XQh4ct
         CmPFVoPGO/CnLnoyJByGD9s0EKGNnX/BU4n1E0zQM8Mq91ArN62gwWnWGa2Otfov94Sn
         foErxHZ1+wo0vi16MsiugF1tg8vBR8qdJXXlAiRV/TEjIuJYLNe1UPxfbPe3GUhy7d9r
         XFzy6SKWzH+M8mq/zwqJe2xhIyiaaXNK5IBfkSxSSp/Jg+/AXTHSWec/DOSvl4QoGnRw
         0SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MENoYed9rPqZPrA/Y9pbBbNZ42AOAV3KIOD7B7ZsAOc=;
        b=PD4Z6PEpWJezigqV8luR4GDsU6dZHugOYivdb9pcMtrGyR3DsIbbdT8tmLXz0ahsyo
         AIIes+UUVO5oRMCxfby3KPYTR0+a6X3NKS1u2r2Nyld6pqorLEbRlxujQPluVFxgh6Ew
         gwDp1PLSu+nkRJP4ypAZTpdZLEKA2kLWtwUHwqoqjniQ+dC1MeTRs3rjCLMuGHdl4myy
         W4qfMaENdzqwmacYuI7vWCBagWOorn5fNeI0Lm8z22yVPbIo3tB3byRRo+CGhOXTaAA7
         Di/08CvJQ56yI5q8qT9Tcjj/sY4ES5R4zG0pcuwIIqq67Ftv78Hrlhgmj3niHi1iwNlo
         /pOg==
X-Gm-Message-State: APjAAAWV/2h0vJnJ6FaPE8muktBpj8s0mtpDVLsEORyCpRvugEjkyuA9
        e/Sce1ZEM9wJtNolG+ZzmLE2zxlHcpLReQ==
X-Google-Smtp-Source: APXvYqyoVLxV/7/C1jDKjqsyEfHbZJMqr7/JRSBha1sEDQYQIgnFuHfjrAh6k/oHz5HdLFlyZ4Y7Zg==
X-Received: by 2002:a17:902:183:: with SMTP id b3mr11517976plb.210.1566908088645;
        Tue, 27 Aug 2019 05:14:48 -0700 (PDT)
Received: from localhost ([49.248.54.193])
        by smtp.gmail.com with ESMTPSA id u69sm13289069pgu.77.2019.08.27.05.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 05:14:47 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        sboyd@kernel.org, masneyb@onstation.org, marc.w.gonzalez@free.fr,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org
Subject: [PATCH v2 06/15] arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
Date:   Tue, 27 Aug 2019 17:44:02 +0530
Message-Id: <f32c05c08669a9a886935149ac40423cd7001dfb.1566907161.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm8916 uses sensors 0, 1, 2, 4 and 5. Sensor 3 is NOT used. Fixup the
device tree so that the correct sensor ID is used and as a result we can
actually check the temperature for the cpu2_3 sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 5ea9fb8f2f87d..8686e101905cc 100644
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

