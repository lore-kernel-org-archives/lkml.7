Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBFAECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99421218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="qcy2EGDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfJIOHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:07:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39378 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbfJIOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:07:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id v17so2772723wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=qYQ0aamJUDpjyNn4W7oIfsE1QuvOq48dHFv4SQEnUqo=;
        b=qcy2EGDE20dEBGzjflbkOM/+xFeG34FhQ1qYWlJG7PYVZ9C26hOz1qA9bJvGurlYbY
         YeWlVsQss9LVqwBVg0Rfraq5ANlzrz8/gXo7kTuNZmlsSQo3iUa25zUOzzy5FERs2a0c
         DNrBssPk3qiMh3jCXjZAvXoQ2kl7dlzTQ7eQBOLEe0h4MTI82Or08FOuok8vqgfhBGpM
         Jd8eSrOQ/ft2gDunaAQsgt6S5Wy4v2ln4Lo9eLvuUrSclsYZmSYtpfgvH4UPLTNjkbfT
         lbw1mrEan64Ioaj0kJniVgJCdM0LSACc6O8TbvBPYgkfvWY0U8A/ydTpVwp1eB571v3u
         O7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=qYQ0aamJUDpjyNn4W7oIfsE1QuvOq48dHFv4SQEnUqo=;
        b=J3JLF6nnAZJM5J1HOdb0UZTbcLKfGXcVV9nGtqXyheRhvjbxKsAwbLMkHDAqcrMini
         pa3SW7FkW2TPzf4ecOdawmqjEHW4bPNC2GsD8OLLMNWn/MbaGVd6M0EC+qlJSg1bKTSb
         iXq7x4GGeetcRGiEbhTTdMBXeuFR+tPpoUetku9WgS0rtYN/uFBFwdmnjySJUy489Ss+
         dyaHjoYO/Nk6PGE5DaWwJzmp1exSXk2Kiz7Og6Gjj4jrxGk4curx79t5Lw9d4Ygjc4ev
         Ag1yW3BK91li8pr+Gvj6yCuHy5XrZwjJu1tHtsbZNS19HaCgnS2+OraeFo44ck3jNkuF
         +o1Q==
X-Gm-Message-State: APjAAAWd4fFQjE1pK7J8OvQJX5IPTMLBTrvrg7NOxSgwgxg4n+QUQWW2
        m/00G3qgRhzcwBEuhqopnTQRyGpABoVOCg==
X-Google-Smtp-Source: APXvYqxwJvflzApriBt9xCl9Wj4OZv07aiO4YpeggA6M/sAkIqyqUI4JFR/XxMM0BUrXYPwBcITjBw==
X-Received: by 2002:a05:600c:2214:: with SMTP id z20mr2930679wml.10.1570630048024;
        Wed, 09 Oct 2019 07:07:28 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y14sm3341799wrd.84.2019.10.09.07.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 07:07:27 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Zumeng Chen <zumeng.chen@windriver.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u-boot@lists.denx.de
Subject: [PATCH] ARM: dts: zynq: enablement of coresight topology
Date:   Wed,  9 Oct 2019 16:07:22 +0200
Message-Id: <a38ab93d870a3b1b341a5c0da14fc7f3d4056684.1570630040.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zumeng Chen <zumeng.chen@windriver.com>

This patch is to build the coresight topology structure of zynq-7000
series according to the docs of coresight and userguide of zynq-7000.

Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 158 +++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index ca6425ad794c..86430ad76fee 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -59,6 +59,40 @@
 		regulator-always-on;
 	};
 
+	replicator {
+		compatible = "arm,coresight-static-replicator";
+		clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+		clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* replicator output ports */
+			port@0 {
+				reg = <0>;
+				replicator_out_port0: endpoint {
+					remote-endpoint = <&tpiu_in_port>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				replicator_out_port1: endpoint {
+					remote-endpoint = <&etb_in_port>;
+				};
+			};
+		};
+		in-ports {
+			/* replicator input port */
+			port {
+				replicator_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&funnel_out_port>;
+				};
+			};
+		};
+	};
+
 	amba: amba {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -365,5 +399,129 @@
 			reg = <0xf8005000 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		etb@f8801000 {
+			compatible = "arm,coresight-etb10", "arm,primecell";
+			reg = <0xf8801000 0x1000>;
+			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+			in-ports {
+				port {
+					etb_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port1>;
+					};
+				};
+			};
+		};
+
+		tpiu@f8803000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0xf8803000 0x1000>;
+			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+			in-ports {
+				port {
+					tpiu_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port0>;
+					};
+				};
+			};
+		};
+
+		funnel@f8804000 {
+			compatible = "arm,coresight-static-funnel", "arm,primecell";
+			reg = <0xf8804000 0x1000>;
+			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+
+			/* funnel output ports */
+			out-ports {
+				port {
+					funnel_out_port: endpoint {
+						remote-endpoint =
+							<&replicator_in_port0>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* funnel input ports */
+				port@0 {
+					reg = <0>;
+					funnel0_in_port0: endpoint {
+						remote-endpoint = <&ptm0_out_port>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel0_in_port1: endpoint {
+						remote-endpoint = <&ptm1_out_port>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel0_in_port2: endpoint {
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel0_in_port3: endpoint {
+						remote-endpoint = <&itm_out_port>;
+					};
+				};
+				/* The other input ports are not connect to anything */
+			};
+		};
+
+		/* ITM is not supported by kernel, only leave device node here */
+		itm@f8805000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0xf8805000 0x1000>;
+			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+			out-ports {
+				port {
+					itm_out_port: endpoint {
+						remote-endpoint = <&funnel0_in_port3>;
+					};
+				};
+			};
+		};
+
+		ptm@f889c000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0xf889c000 0x1000>;
+			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+			cpu = <&cpu0>;
+			out-ports {
+				port {
+					ptm0_out_port: endpoint {
+						remote-endpoint = <&funnel0_in_port0>;
+					};
+				};
+			};
+		};
+
+		ptm@f889d000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0xf889d000 0x1000>;
+			clocks = <&clkc 27>, <&clkc 46>, <&clkc 47>;
+			clock-names = "apb_pclk", "dbg_trc", "dbg_apb";
+			cpu = <&cpu1>;
+			out-ports {
+				port {
+					ptm1_out_port: endpoint {
+						remote-endpoint = <&funnel0_in_port1>;
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.17.1

