Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C0E206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cfEoOfws";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nHOC/vZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfC1P3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:29:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfC1P3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:29:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD5CD619CE; Thu, 28 Mar 2019 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786946;
        bh=Mmp1jfuc1zu5FoGaNthCHKPchoSMms/QsUzlv8N/jIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfEoOfwsYynhQfsEiy1myFmiDEt+AS3cPH09T5HblP27Qzm55ZRggS8IhLrCQbj9G
         SNf8kI7a3iJVtkftpcZIT8jeSb9HmYrkL2U3uGln7kx9qcDL0gNT98OSJADpVOCGw/
         gXL/pdtMN3PGzoEC1fKB9jvI6x3VmssPdrUF6jWg=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7361B619AE;
        Thu, 28 Mar 2019 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553786945;
        bh=Mmp1jfuc1zu5FoGaNthCHKPchoSMms/QsUzlv8N/jIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHOC/vZWKi8b/zp3WzqXoVjFp+aI1KvtlJlDuJ4KQ5SIvB9vM0N4zc8n2C5BCnrvp
         F9csCUKiUnQgJHhGVG8WNihFiUy7vRuYozHzFvZPM+8VgPPg2Sd2wXScAFhDHh7W3B
         IJNHku7Xw1liBrL5WMT0JArkNKcZlCfzi5UhzEHA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7361B619AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, cw00.choi@samsung.com,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 4/9] dt-bindings: devfreq: Add bindings for devfreq dev-icbw driver
Date:   Thu, 28 Mar 2019 20:58:17 +0530
Message-Id: <20190328152822.532-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings support for a generic interconnect bandwidth voting
devfreq driver.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 .../devicetree/bindings/devfreq/icbw.txt      | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt

diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt b/Documentation/devicetree/bindings/devfreq/icbw.txt
new file mode 100644
index 000000000000..389aa77a2363
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
@@ -0,0 +1,146 @@
+Interconnect bandwidth device
+
+icbw is a device that represents an interconnect path that connects two
+devices. This device is typically used to vote for BW requirements between
+two devices. Eg: CPU to DDR, GPU to DDR, etc. This device is expected to
+use passive govenor by default.
+
+Required properties:
+- compatible:		Must be "devfreq-icbw"
+- interconnects:	Pairs of phandles and interconnect provider specifier
+			to denote the edge source and destination ports of
+			the interconnect path. See also:
+		Documentation/devicetree/bindings/interconnect/interconnect.txt
+- operating-points-v2:	A phandle to an OPP v2 table that holds frequency,
+			bandwidth values (in MB/s) and required-opp's populated
+			with phandles pointing to the required per cpu opp. The
+			bandwidth (in MB/s) values depend on multiple properties
+			of the interconnect path like frequency, interconnect
+			width, etc.
+
+Example:
+
+cpus {
+	...
+
+	CPU0: cpu@0 {
+		...
+		operating-points-v2 = <&cpu0_opp_table>;
+		...
+	};
+
+	CPU1: cpu@100 {
+		...
+		operating-points-v2 = <&cpu0_opp_table>;
+		...
+	};
+
+	CPU2: cpu@200 {
+		...
+		operating-points-v2 = <&cpu0_opp_table>;
+		...
+	};
+
+	CPU3: cpu@300 {
+		...
+		operating-points-v2 = <&cpu0_opp_table>;
+		...
+	};
+
+	CPU4: cpu@400 {
+		...
+		operating-points-v2 = <&cpu4_opp_table>;
+		...
+	};
+
+	CPU5: cpu@500 {
+		...
+		operating-points-v2 = <&cpu4_opp_table>;
+		...
+	};
+
+	CPU6: cpu@600 {
+		...
+		operating-points-v2 = <&cpu4_opp_table>;
+		...
+	};
+
+	CPU7: cpu@700 {
+		...
+		operating-points-v2 = <&cpu4_opp_table>;
+		...
+	};
+};
+
+cpu0_opp_table: cpu0_opp_table {
+	compatible = "operating-points-v2";
+	opp-shared;
+
+	cpu0_opp1: opp-300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+	};
+
+	...
+
+	cpu0_opp16: opp-1612800000 {
+		opp-hz = /bits/ 64 <1612800000>;
+	};
+
+	...
+};
+
+cpu4_opp_table: cpu4_opp_table {
+	compatible = "operating-points-v2";
+	opp-shared;
+
+	...
+
+	cpu4_opp4: opp-1056000000 {
+		opp-hz = /bits/ 64 <1056000000>;
+	};
+
+	cpu4_opp5: opp-1209600000 {
+		opp-hz = /bits/ 64 <1209600000>;
+	};
+
+	...
+};
+
+bw_opp_table: bw-opp-table {
+	compatible = "operating-points-v2";
+
+	opp-200  {
+		opp-hz = /bits/ 64 < 200000000 >; /* 200 MHz */
+		required-opps = <&cpu0_opp1>;
+		/* 0 MB/s average and 762 MB/s peak bandwidth */
+		opp-bw-MBs = <0 762>;
+	};
+
+	opp-300 {
+		opp-hz = /bits/ 64 < 300000000 >; /* 300 MHz */
+		/* 0 MB/s average and 1144 MB/s peak bandwidth */
+		opp-bw-MBs = <0 1144>;
+	};
+
+	...
+
+	opp-768 {
+		opp-hz = /bits/ 64 < 768000000 >; /* 768 MHz */
+		/* 0 MB/s average and 2929 MB/s peak bandwidth */
+		opp-bw-MBs = <0 2929>;
+		required-opps = <&cpu4_opp4>;
+	};
+
+	opp-1017 {
+		opp-hz = /bits/ 64 < 1017000000 >; /* 1017 MHz */
+		/* 0 MB/s average and 3879 MB/s peak bandwidth */
+		opp-bw-MBs = <0 3879>;
+		required-opps = <&cpu0_opp16>, <&cpu4_opp5>;
+	};
+};
+
+cpubw {
+	compatible = "devfreq-icbw";
+	interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
+	operating-points-v2 = <&bw_opp_table>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

