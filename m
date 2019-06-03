Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F28C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132BB27D83
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFCI2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:28:33 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50626 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbfFCI2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:28:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C1C8B1A03A4;
        Mon,  3 Jun 2019 10:28:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 200A31A03C4;
        Mon,  3 Jun 2019 10:28:22 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DEBEA402DD;
        Mon,  3 Jun 2019 16:28:13 +0800 (SGT)
From:   peng.fan@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, jassisinghbrar@gmail.com,
        sudeep.holla@arm.com, f.fainelli@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, shawnguo@kernel.org,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        andre.przywara@arm.com, van.freenix@gmail.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] DT: mailbox: add binding doc for the ARM SMC mailbox
Date:   Mon,  3 Jun 2019 16:30:04 +0800
Message-Id: <20190603083005.4304-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603083005.4304-1-peng.fan@nxp.com>
References: <20190603083005.4304-1-peng.fan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The ARM SMC mailbox binding describes a firmware interface to trigger
actions in software layers running in the EL2 or EL3 exception levels.
The term "ARM" here relates to the SMC instruction as part of the ARM
instruction set, not as a standard endorsed by ARM Ltd.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
Introduce interrupts as a property.

V1:
arm,func-ids is still kept as an optional property, because there is no
defined SMC funciton id passed from SCMI. So in my test, I still use
arm,func-ids for ARM SIP service.

 .../devicetree/bindings/mailbox/arm-smc.txt        | 101 +++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt

diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
new file mode 100644
index 000000000000..401887118c09
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
@@ -0,0 +1,101 @@
+ARM SMC Mailbox Interface
+=========================
+
+This mailbox uses the ARM smc (secure monitor call) instruction to trigger
+a mailbox-connected activity in firmware, executing on the very same core
+as the caller. By nature this operation is synchronous and this mailbox
+provides no way for asynchronous messages to be delivered the other way
+round, from firmware to the OS, but asynchronous notification could also
+be supported. However the value of r0/w0/x0 the firmware returns after
+the smc call is delivered as a received message to the mailbox framework,
+so a synchronous communication can be established, for a asynchronous
+notification, no value will be returned. The exact meaning of both the
+action the mailbox triggers as well as the return value is defined by
+their users and is not subject to this binding.
+
+One use case of this mailbox is the SCMI interface, which uses shared memory
+to transfer commands and parameters, and a mailbox to trigger a function
+call. This allows SoCs without a separate management processor (or when
+such a processor is not available or used) to use this standardized
+interface anyway.
+
+This binding describes no hardware, but establishes a firmware interface.
+Upon receiving an SMC using one of the described SMC function identifiers,
+the firmware is expected to trigger some mailbox connected functionality.
+The communication follows the ARM SMC calling convention[1].
+Firmware expects an SMC function identifier in r0 or w0. The supported
+identifiers are passed from consumers, or listed in the the arm,func-ids
+properties as described below. The firmware can return one value in
+the first SMC result register, it is expected to be an error value,
+which shall be propagated to the mailbox client.
+
+Any core which supports the SMC or HVC instruction can be used, as long as
+a firmware component running in EL3 or EL2 is handling these calls.
+
+Mailbox Device Node:
+====================
+
+This node is expected to be a child of the /firmware node.
+
+Required properties:
+--------------------
+- compatible:		Shall be "arm,smc-mbox"
+- #mbox-cells		Shall be 1 - the index of the channel needed.
+- arm,num-chans		The number of channels supported.
+- method:		A string, either:
+			"hvc": if the driver shall use an HVC call, or
+			"smc": if the driver shall use an SMC call.
+
+Optional properties:
+- arm,func-ids		An array of 32-bit values specifying the function
+			IDs used by each mailbox channel. Those function IDs
+			follow the ARM SMC calling convention standard [1].
+			There is one identifier per channel and the number
+			of supported channels is determined by the length
+			of this array.
+- interrupts		SPI interrupts may be listed for notification,
+			each channel should use a dedicated interrupt
+			line.
+
+Example:
+--------
+
+	sram@910000 {
+		compatible = "mmio-sram";
+		reg = <0x0 0x93f000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0x93f000 0x1000>;
+
+		cpu_scp_lpri: scp-shmem@0 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x200>;
+		};
+
+		cpu_scp_hpri: scp-shmem@200 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x200 0x200>;
+		};
+	};
+
+	smc_mbox: mailbox {
+		#mbox-cells = <1>;
+		compatible = "arm,smc-mbox";
+		method = "smc";
+		arm,num-chans = <0x2>;
+		/* Optional */
+		arm,func-ids = <0xc20000fe>, <0xc20000ff>;
+	};
+
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&mailbox 0 &mailbox 1>;
+			mbox-names = "tx", "rx";
+			shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
+		};
+	};
+
+
+[1]
+http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0028a/index.html
-- 
2.16.4

