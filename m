Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E8520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="OJHuatp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfEBIKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:10:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10358 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbfEBIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:10:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42828JO023659;
        Thu, 2 May 2019 10:10:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=znP6MuezR8h50yNvDKE3YfX4j0A9PVjb37XPJEMCwbU=;
 b=OJHuatp2xrdeg8+qugcJrJ67kI+rH6UoWzukJgyz7kVOnFXLq2v/AYNHU1H6YFAeV6pR
 Q1j0QRnAuhFy5hLFZnKdJuhT+ue6DfmoBOS00aSARGCb47HJBiD4HUJ/0/v91wpqkKuw
 bVPGB1r/ZE9ZTwb4HXmV7U/DknaquIjx33ckC6yWzyKr9/O8ZZIqy0/AGayqhXDY+u2P
 MUHY///UWAM+8kI7cRnsAPD5Gw0gtDOul6U/pQICssUSBFKDYsA3wQzfhjxn1ZODIgP+
 2LN7CZZMZGGuoAJh1W2HX7wGw4AH95WZl13UoANBD24JlKxnqB2ZrNi31bhHcbUo8iny zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2s6xhbf3q9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 02 May 2019 10:10:20 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2152B3F;
        Thu,  2 May 2019 08:10:19 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2EB3FD8;
        Thu,  2 May 2019 08:10:18 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 2 May 2019
 10:10:18 +0200
Received: from localhost (10.129.4.86) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 May 2019 10:10:18 +0200
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
Subject: [PATCH v3 2/8] dt-bindings: remoteproc: add bindings for stm32 remote processor driver
Date:   Thu, 2 May 2019 10:10:00 +0200
Message-ID: <1556784606-3016-3-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556784606-3016-1-git-send-email-fabien.dessenne@st.com>
References: <1556784606-3016-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.4.86]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_03:,,
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
index 0000000..a495757
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
+- st,auto_boot:	If defined, when remoteproc is probed, it loads the default
+		firmware and starts the remote processor.
+
+Example:
+	m4_rproc: m4@38000000 {
+		compatible = "st,stm32mp1-m4";
+		reg = <0x00000000 0x10000>,
+		      <0x10000000 0x40000>,
+		      <0x30000000 0x40000>;
+		resets = <&rcc MCU_R>;
+		st,syscfg-holdboot = <&rcc 0x10C 0x1>;
+		st,syscfg-tz = <&rcc 0x000 0x1>;
+	};
-- 
2.7.4

