Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE6ECE587
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 01:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DAA20818
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 01:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pth6mtN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfJBBRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 21:17:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36894 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJBBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 21:17:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so10961134pgg.4;
        Tue, 01 Oct 2019 18:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cCPpIXwTTzCl7iuvpAsaiH8IIiFwQFVgIh4mGvjHgKc=;
        b=pth6mtN/O1kCQWnaDAc9gJ8Yz53fBmFaBBj+KGMPaI7AZfqcqivi9TJtUn9u1tfb+d
         EUx6cO3izmZ1HNma4mewv6WsyCt+c0TJk15Tmufh1n28wfzgqdPFc4ARj0GxBPCJhCBS
         NTeIdVLo2RmfGAgh9OiNJDS3u8PUi3QIzUi9B8AycxhbfZeXwPjv311gMPDI9a1/+WYu
         LEPtWz2HeRP0CI6+Do72iKaW4Yyik6QD+kB4/MP+zbYtGWanjIur7GqXwmiPjJIwCRmr
         c+wfiCwOe2UHVAhMLa1+ZPcIF39IhH37jzxp9b15yR5IgA447n3pK6Cys41fa0rgHqVR
         Mcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cCPpIXwTTzCl7iuvpAsaiH8IIiFwQFVgIh4mGvjHgKc=;
        b=kkSom4qfngqL+mAq+SL8Ki//WDK7BBGHfcpI3DLeNtVJs+46PKwEHGKQY/QgB7sJuK
         2vS+UgyFsNoxBGWp+iTz2JdRvSO11xlmRpM1KA6celW1X4As1k2o+zbJlMoBnEjwKQfJ
         D/a8zjqn8tPI6e0+Oplx7CjuuLUCOKc4KLcMdY2Jvj2MsCugcvB1cKqBJG8s07WTE1Tv
         ix0tm1HR3jF0lsTujo4uNM5Yz1wN7n+JrMG1HQoGmEMDftMaL81BHjghQMIfHeM+XLW3
         JNBCqLJnf1HSRBPn4r+lx+8yuXrHXuQ8MmZGJ1WCmlBImQA3+L2N13rHMdUbjfwUa1yI
         RP7Q==
X-Gm-Message-State: APjAAAWh4z8nq/Q9nCje09noi0FS26QvD1ntfbsKaQnn0XpVFcs7beSr
        w5v53JVibN7m+EotKUB1ldw=
X-Google-Smtp-Source: APXvYqxqkdoby+o+sRr/vfblT8sSWmSv4tglKRjcJExnFD3acGUtjxZzxR6SBSbaL/7zpGhphwwXug==
X-Received: by 2002:a17:90a:3209:: with SMTP id k9mr1329341pjb.14.1569979026485;
        Tue, 01 Oct 2019 18:17:06 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a13sm20414018pfg.10.2019.10.01.18.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 18:17:06 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        marc.w.gonzalez@free.fr, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v4 2/2] arm64: dts: qcom: msm8998: Add gpucc node
Date:   Tue,  1 Oct 2019 18:17:02 -0700
Message-Id: <20191002011702.36678-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002011555.36571-1-jeffrey.l.hugo@gmail.com>
References: <20191002011555.36571-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSM8998 GPU Clock Controller DT node.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 5a9efd749fa6..896f37c936ee 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+#include <dt-bindings/clock/qcom,gpucc-msm8998.h>
 #include <dt-bindings/clock/qcom,mmcc-msm8998.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -951,6 +952,19 @@
 			#interrupt-cells = <0x2>;
 		};
 
+		gpucc: clock-controller@5065000 {
+			compatible = "qcom,gpucc-msm8998";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x05065000 0x9000>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GPLL0_OUT_MAIN>;
+			clock-names = "xo",
+				      "gpll0";
+		};
+
 		spmi_bus: spmi@800f000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg =	<0x0800f000 0x1000>,
-- 
2.17.1

