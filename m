Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F244BECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED6A218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlwUaK99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394512AbfJPThs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:37:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33433 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394493AbfJPThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:37:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so23941088qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97s95T4wB8D9WrZ0/COnoxS/a+SRIAWB8dyFC3vn+tQ=;
        b=GlwUaK9975uKLB3Il8iCJWGw/WsurZbpXrfmvB0+cOiSlTw33tqB9UabOx9UJXv+Py
         Ysh/dTg6ZIn4vamzHcJM6xAi+ICquA2136RhPwyUOL8hSeVjsNtkt7Sl7oRNq6Xpm7OZ
         fsofHsRW4JP2sDrS9ml6JUy5xcCUNdSnzWE+RwqfZYdptSJEF9AvxmqycZAFKSflbzNd
         /HKCAjlNMVxg1QsA7M4yAJyT0hrPGZ1lc89+aXpqKYp7sJ/p7JNvrSqYz7DKG3yclS6O
         YNjQ6KcDd7F1Yxc0kARpql5np+oJ3Nj+EhLex92Qsd2OkJm1dXy7GUXDMMDIuH2X3Wdq
         jfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97s95T4wB8D9WrZ0/COnoxS/a+SRIAWB8dyFC3vn+tQ=;
        b=MmGZrowbhOPSdpKrXyubprHDtcjPgsbxXt06nk8XlqnB0Fb6nGKX4WXYRcgiT2y05W
         4EfAzTwy0HFFz9ONTc2vURHYQM3aA4WO/ZLwJEIESmYcZl+nZhSgLEXSLzd4ZegjtOnw
         M3gFARLxspmaqRs4QzkqFSlJCqD44n8kxTox7hjTcuHBxp7GtrhFwbuDBcb6GkTg205K
         D14qcDNV3habtHewQdf69oU+t6U2bwzZwb5BRFQt0R3Pl3ahIYiCMkra9/xTZIQrS97C
         mBeuKnYA7C5prXl1S33ef05coYAqPiHeByhKQZ09PbAsv/FcyDYN1nMXw4REhfnRGsHC
         Vucg==
X-Gm-Message-State: APjAAAU/CO9A7GZqx3TMhJrOguv9stfIEPFaGKCk6MSTqWwl1rREcLdm
        WTWOkyFxe5U46oMDkuPmYEtEfg==
X-Google-Smtp-Source: APXvYqxix4EGuSLyW4lz+Vd5S9/hkoP/Kwx8aDCIGHmO8XLmv+D/JG/TETbJaTMwknuMZ1ioIcVHig==
X-Received: by 2002:a37:4146:: with SMTP id o67mr28594780qka.23.1571254659370;
        Wed, 16 Oct 2019 12:37:39 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:38 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] arm64: dts: qcom: Add mx power domain as thermal warming device.
Date:   Wed, 16 Oct 2019 15:37:21 -0400
Message-Id: <1571254641-13626-8-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh hosts mx power domain that can be used to warm up the SoC.
Add sub-node to rpmhpd node for mx to be recognized
as thermal warming device on sdm845.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0222f48..0671c8a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3788,6 +3788,11 @@
 						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					};
 				};
+
+				mx_cdev: mx {
+					#cooling-cells = <2>;
+					.name = "mx";
+				};
 			};
 
 			rsc_hlos: interconnect {
-- 
2.1.4

