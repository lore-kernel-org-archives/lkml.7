Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB38C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144AD2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MaFg+t0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfENI1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:27:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbfENI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:27:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E8Q9Ds029568;
        Tue, 14 May 2019 10:27:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=hTa76nRNRMkv1ckIc9VVEOKQQcki8xxfiPP+Sm6Rw5E=;
 b=MaFg+t0u7M5BzxABiLyT70EPJG4ERisibtvW7Zy/Fyi+uqdE/Ah+KCMGZAzdCFdyqoOp
 m14OO5ipEnGIMd+YEk+MXPOhl8sqvhQWymQi9XnnzOt5GXkNrjEs9qc+LAfGXdUmJ7Eg
 JdSw+W9twMMuD0Dwy43FP+q18PrWvo+3H76Pru2epe5rZPxCgKV7gJOhaNkK7Mem1iWg
 Z1c8dQglTGUQDFBuJtC/3JiQjxbcHlS77QOQHGA+eQt613BcUvnMPPsXkSzYOjb1vSYH
 CgJyL/3RkrB/t8uPVTSJaXPkuxSLAE0yaMkYdYyAN31MNemCfuhVmqjO9ixr64mVBLTW CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2sdkuyqnn0-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 14 May 2019 10:27:10 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A2F4B34;
        Tue, 14 May 2019 08:27:09 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 79B091551;
        Tue, 14 May 2019 08:27:09 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May
 2019 10:27:09 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 14 May 2019 10:27:09
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        "Ludovic Barre" <ludovic.barre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v4 2/8] dt-bindings: remoteproc: add bindings for stm32 remote processor driver
Date:   Tue, 14 May 2019 10:26:57 +0200
Message-ID: <1557822423-22658-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557822423-22658-1-git-send-email-fabien.dessenne@st.com>
References: <1557822423-22658-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree bindings document for the stm32 remoteproc devices.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 .../devicetree/bindings/remoteproc/stm32-rproc.txt | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
new file mode 100644
index 0000000..5fa915a
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/stm32-rproc.txt
@@ -0,0 +1,63 @@
+STMicroelectronics STM32 Remoteproc
+-----------------------------------
+This document defines the binding for the remoteproc component that loads and
+boots firmwares on the ST32MP family chipset.
+
+Required properties:
+- compatible:	Must be "st,stm32mp1-m4"
+- reg:		Address ranges of the RETRAM and MCU SRAM memories used by the
+		remote processor.
+- resets:	Reference to a reset controller asserting the remote processor.
+- st,syscfg-holdboot: Reference to the system configuration which holds the
+		remote processor reset hold boot
+	1st cell: phandle of syscon block
+	2nd cell: register offset containing the hold boot setting
+	3rd cell: register bitmask for the hold boot field
+- st,syscfg-tz: Reference to the system configuration which holds the RCC trust
+		zone mode
+	1st cell: phandle to syscon block
+	2nd cell: register offset containing the RCC trust zone mode setting
+	3rd cell: register bitmask for the RCC trust zone mode bit
+
+Optional properties:
+- interrupts:	Should contain the watchdog interrupt
+- mboxes:	This property is required only if the rpmsg/virtio functionality
+		is used. List of phandle and mailbox channel specifiers:
+		- a channel (a) used to communicate through virtqueues with the
+		  remote proc.
+		  Bi-directional channel:
+		      - from local to remote = send message
+		      - from remote to local = send message ack
+		- a channel (b) working the opposite direction of channel (a)
+		- a channel (c) used by the local proc to notify the remote proc
+		  that it is about to be shut down.
+		  Unidirectional channel:
+		      - from local to remote, where ACK from the remote means
+		        that it is ready for shutdown
+- mbox-names:	This property is required if the mboxes property is used.
+		- must be "vq0" for channel (a)
+		- must be "vq1" for channel (b)
+		- must be "shutdown" for channel (c)
+- memory-region: List of phandles to the reserved memory regions associated with
+		the remoteproc device. This is variable and describes the
+		memories shared with the remote processor (eg: remoteproc
+		firmware and carveouts, rpmsg vrings, ...).
+		(see ../reserved-memory/reserved-memory.txt)
+- st,syscfg-pdds: Reference to the system configuration which holds the remote
+		processor deep sleep setting
+	1st cell: phandle to syscon block
+	2nd cell: register offset containing the deep sleep setting
+	3rd cell: register bitmask for the deep sleep bit
+- st,auto-boot:	If defined, when remoteproc is probed, it loads the default
+		firmware and starts the remote processor.
+
+Example:
+	m4_rproc: m4@10000000 {
+		compatible = "st,stm32mp1-m4";
+		reg = <0x10000000 0x40000>,
+		      <0x30000000 0x40000>,
+		      <0x38000000 0x10000>;
+		resets = <&rcc MCU_R>;
+		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
+		st,syscfg-tz = <&rcc 0x000 0x1>;
+	};
-- 
2.7.4

