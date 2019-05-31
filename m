Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262EC28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF3726274
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtlXPcbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfEaDBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:01:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39206 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfEaDBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:01:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so5222549pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JAKPz5HiR/M9MZ5W/93Y/2txxEly1u4ytdsXz4IxAZM=;
        b=PtlXPcbo4dDcpE3ipqToSLUoiilw4pslHUCPpdqU/uIDE7SUrNvYRFtCTnOlm2fXY0
         BShSdoX0WGnvbEaKEqfwcb4pe1BxeQ26RXIFoCw+BW6J6AZjSZytxIZhJUt5VjO3sRGB
         j5oVWGZ2grZPKi0Fgg8fXd8HqsnrI/n/muxZ1oltqKE2YP4r8B1ZzPUkbdDp4hSSF4WQ
         1XKLSeWq8fAeEJFzSCGTqND1dT8a6TuRI79Y8wprv+O3wfRnvh7qes5T+YsbeLz22sTd
         JXKlvtHx4/DknPQmlq7f3Vx52sxO3IAR0RDFCRKGrWSR5/2WoR9vAOAyTLJNVPkCNtlT
         fsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JAKPz5HiR/M9MZ5W/93Y/2txxEly1u4ytdsXz4IxAZM=;
        b=ggAEs7U73EzvSpz80XlK4a3t2cw44CdA50U4Ve95uj8LtJkATRMUxfLSf3BtEhdNH6
         H85X0ziTol38Otfn5yQUxuIfUzFV2FoZu3W3YjG3V8qM9yQvzDj2feT8ATDJmqmi11My
         5bvGEF0SjTAw8AmhCX0GeRzObnEpjROPkmrOUxjJtXh5/vQZsdnKq1dkFvSvVYvxNlRc
         d9crZyjOzhAqhNOxgHht9+Afta/N3hlqA4HhwD8VCC5YdUKsC3LzmklISJLhyELqPoBw
         gkU0d/9F17AQfLbfd++iN/ALlBGG9QFcZFNh9PgKCpmFf6vQ80SaovjVHqSXAmnRw4UK
         32eA==
X-Gm-Message-State: APjAAAUtGXjAasfaKdulOJxSGc1MGkyiu5y5DVM1uFuHkDqSGWSK/j36
        sQi3wuubxE6tujqLiY+ejOs2Kg==
X-Google-Smtp-Source: APXvYqwrGyHTCH17O/nwl7MWLe1y4Oxo9vddlZfVF9wdT/6qMhZs33fSBtqL8w9g2aIpoxN6vjZpXA==
X-Received: by 2002:a17:90a:9b8b:: with SMTP id g11mr6297449pjp.103.1559271662688;
        Thu, 30 May 2019 20:01:02 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m8sm6991549pff.137.2019.05.30.20.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:01:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] dt-bindings: soc: qcom: Add AOSS QMP binding
Date:   Thu, 30 May 2019 20:00:54 -0700
Message-Id: <20190531030057.18328-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531030057.18328-1-bjorn.andersson@linaro.org>
References: <20190531030057.18328-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the QMP based side-channel communication mechanism to
the AOSS, which is used to control resources not exposed through the
RPMh interface.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v7:
- Fix spelling of "Messaging"

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 81 +++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     | 14 ++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
new file mode 100644
index 000000000000..954ffee0a9c4
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
+Messaging Protocol (QMP)
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

