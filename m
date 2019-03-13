Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB1DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2A921850
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWswKAHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfCMJAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:00:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44447 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfCMJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:00:17 -0400
Received: by mail-lj1-f196.google.com with SMTP id q128so793995ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lHcJMM6FgDLebAlEnMgFQKA5Nq+Rlf4DODywjzeWXvs=;
        b=vWswKAHXEEdZwuDu2xor1PGDVaWEP4TgY2ZFWfmaxFp8U9sbe7V5+ynpf2FEkxOffF
         fzRH362M2E8yK3bvtYNY65ARdTaqH6/YGa3TGbJox/M5l0ij+LYweaJRhX+3yLQ1ke0V
         bEV+u87ZwbD2DttsshVum+KH1khwKlMIVVDYvIApnvP18HwRqLAuU7eZU0YDGyN/UUyG
         RjHy9PolSrw/sbY+B57Yc0hqZmXwGEO1j4I5a0YtIxZDEHQAaohrRFoB/LRnLD0IiV2Y
         cH4ntM4wukNeLnPtyvmcZ7Rw8alTqdnCPmst8u9LTO2Z/+GEjK8vuYKeeczSG+wZ2Tw/
         Cydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHcJMM6FgDLebAlEnMgFQKA5Nq+Rlf4DODywjzeWXvs=;
        b=MZfujK9Jp7bb+NcjnL9pOLpFAZuLGKLPodzLm/P7i3ExdHIsGaOEKU3Yubk+U8R4FO
         nMxRVT1t1cGjAxl3T6X4n3pCw4YHuc4lo6ZgNmzc/xnzgP/zR5QMNKaf6bs3PhbyOAgc
         taNzI5p63djgjPn+d1meZIE5Y15QyopLW085/LsgMljREPq2k+0hRejgTKVkha+8JInv
         iybO0bnf5Yab9+HV2bBUR2bouwPkWzXxpWIKyd28YHfcRQMGdBXGHU7DMhsqajOEBnpc
         7mU4IsZlzuIFDjJz+FJe7S8hSX/BkdjtvrM2B6rcNSCt/QoB1GWHB7M5sbr5J96dCyGr
         xwyQ==
X-Gm-Message-State: APjAAAW/3QirTGcG8jcCoytKjx/LAM0X5TU8aZaGOu9PgXMPlCbVgGsf
        tXuyheOdTPuVCxLrAEISawTFjA==
X-Google-Smtp-Source: APXvYqwIVCUShTBhRuD7dAo4SFoLQqkhxG95gQNOa4aZODMLn5oya3Zoh6vETGzXkhXQMHXdPisr/g==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr22380772lji.152.1552467615852;
        Wed, 13 Mar 2019 02:00:15 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u15sm1701986lja.73.2019.03.13.02.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 02:00:14 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 1/4] dt-bindings: opp: Introduce opp-bw-MBs bindings
Date:   Wed, 13 Mar 2019 11:00:07 +0200
Message-Id: <20190313090010.20534-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to frequency and voltage, some devices may have bandwidth
requirements for their interconnect throughput - for example a CPU
or GPU may also need to increase or decrease their bandwidth to DDR
memory based on the current operating performance point.

Extend the OPP tables with additional property to describe the bandwidth
needs of a device. The average and peak bandwidth values depend on the
hardware and its properties.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp.txt | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79604a5..fa598264615f 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -129,6 +129,9 @@ Optional properties:
 - opp-microamp-<name>: Named opp-microamp property. Similar to
   opp-microvolt-<name> property, but for microamp instead.
 
+- opp-bw-MBs: The interconnect bandwidth is specified with an array containing
+  the two integer values for average and peak bandwidth in megabytes per second.
+
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
@@ -546,3 +549,45 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 		};
 	};
 };
+
+Example 7: opp-bw-MBs:
+(example: average and peak bandwidth values are defined for each OPP and the
+interconnect between CPU and DDR memory is scaled together with CPU frequency)
+
+/ {
+	cpus {
+		CPU0: cpu@0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			...
+			operating-points-v2 = <&cpu_opp_table>;
+			/* path between the CPU and DDR memory */
+			interconnects = <&rpm_bimc MASTER_AMPSS_M0
+					&rpm_bimc SLAVE_EBI_CH0>;
+		};
+	};
+
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			/* 457 MB/s average and 1525 MB/s peak bandwidth */
+			opp-bw-MBs = <457 1525>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			/* 915 MB/s average and 3051 MB/s peak bandwidth */
+			opp-bw-MBs = <915 3051>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			/* 1830 MB/s average and 6103 MB/s peak bandwidth */
+			opp-bw-MBs = <1830 6103>;
+		};
+		opp-998400000 {
+			opp-hz = /bits/ 64 <998400000>;
+			/* 2282 MB/s average and 7614 MB/s peak bandwidth */
+			opp-bw-MBs = <2284 7614>;
+		};
+	};
