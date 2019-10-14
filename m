Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D7ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648E120673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 12:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dv0NGmFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfJNMJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 08:09:58 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41829 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfJNMJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:09:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id r2so11609894lfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ParE+ZmbB2ikn5nxND/RLYbU3JushIxT3oO/rX9DYCk=;
        b=dv0NGmFNdslQbFptZG0RiJoj1wUM+esqZI+vuDRF87P688gTVJcoTadce6o/7aXEwc
         iRDxqEEbmTLiqF4mAMPoF6+qgFoOyVYyxge8vVLfdjqbFkQOtvSMfv5DjaWWaBKqqDUb
         kPemtJ4Oa5GcQDi6keS1R0I4VKQsM6Jv9Mp9t4O2nv4vDtRbCbuPEW3RZfQAe7Rh76Ls
         s+AsuLPaCx0qlZ6wmBRRal+MKJGIy/uRLQ8o/2aTmHlKupNAJycHmXI8E3PZygodLCLD
         xAMQX7X+wjsb7gO+5mpK6Yk2HlkJY5CFxaiWO9Uqvj8RY/eA/VD6KF4suixqx95LcMQI
         0KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ParE+ZmbB2ikn5nxND/RLYbU3JushIxT3oO/rX9DYCk=;
        b=WXTh4ua5UNN6MxgTv+8Z3JFo8bp2HCzmlzJT15uVU8RaRq5f3/8qi8c5xQsBWfi9qH
         dip2uzCqvehn4qy3DjNxoh2v6X7hP+TSlYYRNMFsXc7FcyarTKCQcmQ4a6UikTd7J3tN
         veV47mBMiJWBhEwl0QqcyT/6DRXT7Y5bZduwD+L1NONBW8lQkFhcTZT8zYJiNTDYhG6A
         GYM9LlI8ZQJpOqeWFXOZIqTH1wbVhYiLbDhgwwzDxEWMkLKeVx4TBZbJO5UiSGA8xe98
         I4i8OtXM+aOqHX491vJ2YCUORy4fc1pL0M9WI/1SohwXjo+ETLxDz26tn/tHfsEeASv6
         Fj1A==
X-Gm-Message-State: APjAAAXjgkfx0q3SFkYiHHPQ3zGRlZJeV2GkfAREQoeOeib/S0T/uryH
        aYrjormRb2yVt67q2VbktBuy/Q==
X-Google-Smtp-Source: APXvYqx+L4Cg6HwU5uud5ULkqS844eRSs2NSHhQOhqaaM/hSd11sq+52EA8MQlHp/zaEQoNdvqEq3A==
X-Received: by 2002:ac2:5486:: with SMTP id t6mr18155056lfk.183.1571054996170;
        Mon, 14 Oct 2019 05:09:56 -0700 (PDT)
Received: from localhost.localdomain (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id l7sm4137597lji.46.2019.10.14.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 05:09:55 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: qcs404-evb: Set vdd_apc regulator in high power mode
Date:   Mon, 14 Oct 2019 14:09:20 +0200
Message-Id: <20191014120920.12691-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdd_apc is the regulator that supplies the main CPU cluster.

At sudden CPU load changes, we have noticed invalid page faults on
addresses with all bits shifted, as well as on addresses with individual
bits flipped.

By putting the vdd_apc regulator in high power mode, the voltage drops
during sudden load changes will be less severe, and we have not been able
to reproduce the invalid page faults with the regulator in this mode.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 501a7330dbc8..522d3ef72df5 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -73,6 +73,7 @@
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-name = "vdd_apc";
+		regulator-initial-mode = <1>;
 		regulator-min-microvolt = <1048000>;
 		regulator-max-microvolt = <1384000>;
 	};
-- 
2.21.0

