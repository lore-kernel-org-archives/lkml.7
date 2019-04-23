Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7275C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED1A218CD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfCNfDiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfDWN2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36669 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfDWN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id l23so2931551lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3r+b8+ekNVHte2QeCZMZAWdkAU7CdygGrtvnF2S4meU=;
        b=lfCNfDiQGJnwV59072TgSQ/QI0Z22D8koaXNkdIjyMEzEPlQgEmHSAJSJkTSafGn/5
         giGeB/hmkrFAmAPPNycokb+0Ds1tdk66Bbbdt5LDNso09R37cP9YqBmcqN4pg3ExcM7O
         rrOnBQLJT/B/auJOE/0fAjshwXn+mN0IHe22TUkmKy6MQHLE9HOfKLEqwnz44Fd9mhhY
         FFHUbj8SN6LXo4m51LYKVmGdaqLDbFFlYarUWbUQ6tXdFywNb7hIyfwTT7K8eVyRE8l4
         NG60sR2bSizrP7APx+c31+9Sax/MyyYkRLHimkZoBkdm6OjnoHSuU55AhNquY90FDcTJ
         juJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3r+b8+ekNVHte2QeCZMZAWdkAU7CdygGrtvnF2S4meU=;
        b=n3bzhW9HuUPp+Rp3dv4hBsP/9q1sE9B942GlhU/+DwU4oB4MWDx8R7yUYPtwCzhIP2
         1gzhmzcTQETcKUiwIT7+pFZVLbVRmRaXj61aM5iPuajx2q21ZCFCtJC4ScGEuu43qaO1
         QJVX97W35kweY7kqZbWn/CncNzReowfov9zds0V6QF5R6kys9a9YtKD9QfAqq+msiBMD
         LgeckdDgsMDKa0we1pJB6hz25eBYtNS6ERBxrV75971UbpjFf+QBrYvNAdy7cahVDIJU
         0hEAP9U5gJQGyMxcJGtUs9ZkH9mV8WJI8ahQVvv0bKEgBmV8hPm/zjvxPIrnfZ5vjsRp
         lJRg==
X-Gm-Message-State: APjAAAV2/cM/MDo0pXgcsUptq125cJWaiqOEep7Xhvv/lCcIxZRjG5/R
        5idGIFMMcyIjiGd2BBY7fLls3Q==
X-Google-Smtp-Source: APXvYqxcThCJ9co/aWID+yA6D6uqJUhZ5RwV+8mms/Umltv4wn/p5ZH/93HikDYzo6iztlgRRsk5fw==
X-Received: by 2002:a2e:9348:: with SMTP id m8mr14019864ljh.23.1556026108454;
        Tue, 23 Apr 2019 06:28:28 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:27 -0700 (PDT)
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
Subject: [PATCH v2 1/5] dt-bindings: opp: Introduce bandwidth-MBps bindings
Date:   Tue, 23 Apr 2019 16:28:19 +0300
Message-Id: <20190423132823.7915-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
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
 Documentation/devicetree/bindings/opp/opp.txt | 38 +++++++++++++++++++
 .../devicetree/bindings/property-units.txt    |  4 ++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79604a5..830f0206aea7 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -132,6 +132,9 @@ Optional properties:
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
+- bandwidth-MBps: The interconnect bandwidth is specified with an array containing
+  the two integer values for average and peak bandwidth in megabytes per second.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
@@ -546,3 +549,38 @@ Example 6: opp-microvolt-<name>, opp-microamp-<name>:
 		};
 	};
 };
+
+Example 7: bandwidth-MBps:
+Average and peak bandwidth values for the interconnects between CPU and DDR
+memory and also between CPU and L3 are defined per each OPP. Bandwidth of both
+interconnects is scaled together with CPU frequency.
+
+/ {
+	cpus {
+		CPU0: cpu@0 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			...
+			operating-points-v2 = <&cpu_opp_table>;
+			/* path between CPU and DDR memory and CPU and L3 */
+			interconnects = <&noc MASTER_CPU &noc SLAVE_DDR>,
+					<&noc MASTER_CPU &noc SLAVE_L3>;
+		};
+	};
+
+	cpu_opp_table: cpu_opp_table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			/* CPU<->DDR bandwidth: 457 MB/s average, 1525 MB/s peak */
+			 * CPU<->L3 bandwidth: 914 MB/s average, 3050 MB/s peak */
+			bandwidth-MBps = <457 1525>, <914 3050>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			/* CPU<->DDR bandwidth: 915 MB/s average, 3051 MB/s peak */
+			 * CPU<->L3 bandwidth: 1828 MB/s average, 6102 MB/s peak */
+			bandwidth-MBps = <915 3051>, <1828 6102>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index bfd33734faca..9c3dbefcdae8 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -41,3 +41,7 @@ Temperature
 Pressure
 ----------------------------------------
 -kpascal	: kiloPascal
+
+Throughput
+----------------------------------------
+-MBps		: megabytes per second
