Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7918E20652
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 04:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y713F90O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfEAEhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:37:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43250 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfEAEhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:37:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so4829058pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CtH/Vn4WPiwe6wcK50aezzc3xrR7S8mKnOtvGN8/o3U=;
        b=y713F90Ov+gyYmZ/GXtso9igUmuFdjqwIJy5UcCsSoywAPnidTZeVknXDqJYkH76kd
         x/0zGr49lq4V+NYD76w+fQAG9icsxEV0KBiGe4eKEHZmyffEtScqUoOPvLL1B26k1h1y
         ZXTlbCT2VTQ9VtkZ/s+N9AMUtHP4eiXtP9i+klLtUsHsaDh+Kb8CSnnFc/wIUySrBoqS
         BxbrcAuFuNx4EP7pu9Y4DqEQlDKALNSrGqKJKtEhfNQa9oF/mFFf38NahqWyXbX+76dy
         AU/nQJw4CAJ91SWnOBkB4FpXwJK9bEhfmUACh3UXw0LMEeDN8VB8gc+b6JACS5FPkSkE
         yXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CtH/Vn4WPiwe6wcK50aezzc3xrR7S8mKnOtvGN8/o3U=;
        b=bpkRQzSNnyrDY85+xXGi7depvjqiQGYlJG8c80l1qQupa64YlDpgYx+tfINnoFhld8
         eTastP5cf22pvIlNO4OQYp7lwsYorqfK1e0mI3ytUcf1cu0MPAEZwOgZ2G0Oh/qO8ad0
         TgQ48gJgkpk9mSX1sHXG57NMkvJAA1B1gfJ8xEroW9P1joTn1t7HcuIACUIU/1c8HU4P
         v+/4yMjL9nro5lO0b6qRuv6vuwJY7Lt9KmxhQHDVIG1sKfQlUUkAzUI1Y9SAkYyZsD9M
         cBcRhbjqDd6hvmU+qQMOBGQtHeu29+FrRp3RR799vALbLKspjaMS6CQQY9ebhkNLJjvJ
         ktww==
X-Gm-Message-State: APjAAAUXXHFbopfDKmwpKSxlYOd0N/S8RvEzADp7l3Lx/OooYRC7y8pL
        FREWeHBNvurOYUoqtn5cqk/kNQ==
X-Google-Smtp-Source: APXvYqwmlp8f6M2Xig57Ew8tHF3wEQaIb9c90LDRy8qnTgHv9DZu4EbEbuYBmg3qRiVOi7AfAEVl+A==
X-Received: by 2002:a65:500d:: with SMTP id f13mr33222664pgo.250.1556685459501;
        Tue, 30 Apr 2019 21:37:39 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q128sm55912865pga.60.2019.04.30.21.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 21:37:38 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] dt-bindings: soc: qcom: Add AOSS QMP binding
Date:   Tue, 30 Apr 2019 21:37:31 -0700
Message-Id: <20190501043734.26706-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190501043734.26706-1-bjorn.andersson@linaro.org>
References: <20190501043734.26706-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the QMP based side-channel communication mechanism to
the AOSS, which is used to control resources not exposed through the
RPMh interface.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v6:
- Added #clock-cells

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 81 +++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     | 14 ++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
new file mode 100644
index 000000000000..14a45b3dc059
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -0,0 +1,81 @@
+Qualcomm Always-On Subsystem side channel binding
+
+This binding describes the hardware component responsible for side channel
+requests to the always-on subsystem (AOSS), used for certain power management
+requests that is not handled by the standard RPMh interface. Each client in the
+SoC has it's own block of message RAM and IRQ for communication with the AOSS.
+The protocol used to communicate in the message RAM is known as Qualcomm
+Messagin Protocol (QMP)
+
+The AOSS side channel exposes control over a set of resources, used to control
+a set of debug related clocks and to affect the low power state of resources
+related to the secondary subsystems. These resources are exposed as a set of
+power-domains.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm845-aoss-qmp"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the base address and size of the message RAM for this
+		    client's communication with the AOSS
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the AOSS message IRQ for this client
+
+- mboxes:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the mailbox representing the outgoing doorbell
+		    in APCS for this client, as described in mailbox/mailbox.txt
+
+- #clock-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 0
+		    The single clock represents the QDSS clock.
+
+- #power-domain-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 1
+		    The provided power-domains are:
+		    CDSP state (0), LPASS state (1), modem state (2), SLPI
+		    state (3), SPSS state (4) and Venus state (5).
+
+= SUBNODES
+The AOSS side channel also provides the controls for three cooling devices,
+these are expressed as subnodes of the QMP node. The name of the node is used
+to identify the resource and must therefor be "cx", "mx" or "ebi".
+
+- #cooling-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 2
+
+= EXAMPLE
+
+The following example represents the AOSS side-channel message RAM and the
+mechanism exposing the power-domains, as found in SDM845.
+
+  aoss_qmp: qmp@c300000 {
+	  compatible = "qcom,sdm845-aoss-qmp";
+	  reg = <0x0c300000 0x100000>;
+	  interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+	  mboxes = <&apss_shared 0>;
+
+	  #power-domain-cells = <1>;
+
+	  cx_cdev: cx {
+		#cooling-cells = <2>;
+	  };
+
+	  mx_cdev: mx {
+		#cooling-cells = <2>;
+	  };
+  };
diff --git a/include/dt-bindings/power/qcom-aoss-qmp.h b/include/dt-bindings/power/qcom-aoss-qmp.h
new file mode 100644
index 000000000000..ec336d31dee4
--- /dev/null
+++ b/include/dt-bindings/power/qcom-aoss-qmp.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Linaro Ltd. */
+
+#ifndef __DT_BINDINGS_POWER_QCOM_AOSS_QMP_H
+#define __DT_BINDINGS_POWER_QCOM_AOSS_QMP_H
+
+#define AOSS_QMP_LS_CDSP		0
+#define AOSS_QMP_LS_LPASS	1
+#define AOSS_QMP_LS_MODEM	2
+#define AOSS_QMP_LS_SLPI		3
+#define AOSS_QMP_LS_SPSS		4
+#define AOSS_QMP_LS_VENUS	5
+
+#endif
-- 
2.18.0

