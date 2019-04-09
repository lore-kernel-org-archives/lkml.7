Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52918C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAA9217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hOW48xxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDIGQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:16:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3046 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbfDIGQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:16:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3969JFD007579;
        Tue, 9 Apr 2019 08:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=+YUQsafyios1XcWijrkQqfoS9SF9RCXHu+2dDYipNK8=;
 b=hOW48xxjOoBe6MTFmYglsNXYwTnzHzdycKB5kTrnx9007oJDPOMREcV2JffcgZt3+djm
 uTcROeSX5VrssUqDPNGNpI6FS++/sFcuGMj5KN0mC0rRGRVccMD1K0scvC/kjdWzf16Q
 jtZpawXHxgs3v1K0oyHYffSf/miFiak0h6sS86ehkYb2/4Iux465kBneS5KgvBxJTgyb
 Lll6HlH+3aLOWjDD6QFWRX/jMcJoUtaQfrpER9Mpbkqg7LjjV7W1fle6imt7bmGuMiRy
 jcCku+9Swvh0fmU+GL70m27hkK9qTwCIxPSJdBcVhgFYFc1FEyRE9C9nWk+lv3kA8RYw sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprkdep55-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Apr 2019 08:15:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1F0B13A;
        Tue,  9 Apr 2019 06:15:58 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ED1892411;
        Tue,  9 Apr 2019 06:15:57 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.44) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 9 Apr 2019
 08:15:57 +0200
Received: from localhost (10.129.172.100) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 9 Apr 2019 08:15:57
 +0200
From:   Mickael Guene <mickael.guene@st.com>
To:     <linux-media@vger.kernel.org>
CC:     <hugues.fruchet@st.com>, Mickael Guene <mickael.guene@st.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>
Subject: [PATCH v5 2/3] dt-bindings: Document MIPID02 bindings
Date:   Tue, 9 Apr 2019 08:15:48 +0200
Message-ID: <1554790549-795-3-git-send-email-mickael.guene@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554790549-795-1-git-send-email-mickael.guene@st.com>
References: <1554790549-795-1-git-send-email-mickael.guene@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.172.100]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation of device tree for MIPID02 CSI-2 to PARALLEL
bridge.

Reviewed-by: Rob Herring <robh@kernel.org>

Signed-off-by: Mickael Guene <mickael.guene@st.com>
---

Changes in v5:
- Typo

Changes in v4:
- Fix and clarify endpoints properties documentation

Changes in v3: None
Changes in v2:
- Add precision about first CSI-2 port data rate
- Document endpoints supported properties
- Rename 'mipid02@14' into generic 'csi2rx@14' in example

 .../bindings/media/i2c/st,st-mipid02.txt           | 82 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
new file mode 100644
index 0000000..7976e6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
@@ -0,0 +1,82 @@
+STMicroelectronics MIPID02 CSI-2 to PARALLEL bridge
+
+MIPID02 has two CSI-2 input ports, only one of those ports can be active at a
+time. Active port input stream will be de-serialized and its content outputted
+through PARALLEL output port.
+CSI-2 first input port is a dual lane 800Mbps per lane whereas CSI-2 second
+input port is a single lane 800Mbps. Both ports support clock and data lane
+polarity swap. First port also supports data lane swap.
+PARALLEL output port has a maximum width of 12 bits.
+Supported formats are RAW6, RAW7, RAW8, RAW10, RAW12, RGB565, RGB888, RGB444,
+YUV420 8-bit, YUV422 8-bit and YUV420 10-bit.
+
+Required Properties:
+- compatible: shall be "st,st-mipid02"
+- clocks: reference to the xclk input clock.
+- clock-names: shall be "xclk".
+- VDDE-supply: sensor digital IO supply. Must be 1.8 volts.
+- VDDIN-supply: sensor internal regulator supply. Must be 1.8 volts.
+
+Optional Properties:
+- reset-gpios: reference to the GPIO connected to the xsdn pin, if any.
+	       This is an active low signal to the mipid02.
+
+Required subnodes:
+  - ports: A ports node with one port child node per device input and output
+	   port, in accordance with the video interface bindings defined in
+	   Documentation/devicetree/bindings/media/video-interfaces.txt. The
+	   port nodes are numbered as follows:
+
+	   Port Description
+	   -----------------------------
+	   0    CSI-2 first input port
+	   1    CSI-2 second input port
+	   2    PARALLEL output
+
+Endpoint node required property for CSI-2 connection is:
+- data-lanes: shall be <1> for Port 1. for Port 0 dual-lane operation shall be
+<1 2> or <2 1>. For Port 0 single-lane operation shall be <1> or <2>.
+Endpoint node optional property for CSI-2 connection is:
+- lane-polarities: any lane can be inverted or not.
+
+Endpoint node required property for PARALLEL connection is:
+- bus-width: shall be set to <6>, <7>, <8>, <10> or <12>.
+Endpoint node optional properties for PARALLEL connection are:
+- hsync-active: active state of the HSYNC signal, 0/1 for LOW/HIGH respectively.
+LOW being the default.
+- vsync-active: active state of the VSYNC signal, 0/1 for LOW/HIGH respectively.
+LOW being the default.
+
+Example:
+
+mipid02: csi2rx@14 {
+	compatible = "st,st-mipid02";
+	reg = <0x14>;
+	status = "okay";
+	clocks = <&clk_ext_camera_12>;
+	clock-names = "xclk";
+	VDDE-supply = <&vdd>;
+	VDDIN-supply = <&vdd>;
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port@0 {
+			reg = <0>;
+
+			ep0: endpoint {
+				data-lanes = <1 2>;
+				remote-endpoint = <&mipi_csi2_in>;
+			};
+		};
+		port@2 {
+			reg = <2>;
+
+			ep2: endpoint {
+				bus-width = <8>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				remote-endpoint = <&parallel_out>;
+			};
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index c6c15de..fbcbdf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14667,6 +14667,13 @@ S:	Maintained
 F:	drivers/iio/imu/st_lsm6dsx/
 F:	Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 
+ST MIPID02 CSI-2 TO PARALLEL BRIDGE DRIVER
+M:	Mickael Guene <mickael.guene@st.com>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
+
 ST STM32 I2C/SMBUS DRIVER
 M:	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.7.4

