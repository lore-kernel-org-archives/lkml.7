Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A80EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E2D2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF1BYIQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfLJUBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:01:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40337 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfLJUBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:01:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so4574902wmi.5;
        Tue, 10 Dec 2019 12:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmiFtfH4zmI+d20vCYAm1VeLBaZ07Zt3ioT6CWVzqDc=;
        b=bF1BYIQWLFMMrcr24viNLkeckeUBHH/F4yPVsqbPK8jlmb9fsdBmdSJsAvlBFrj+8X
         bRK5OhSveg1c4CMNErYEBv9hSSfW67mHi0GMvz0ZTX6kZ9PS4OX/UlqTsMoFdYsdYS4m
         J1NDuHX00Vr3dreTnl8ciWn0MEh8hE3Rzqcf75YWVnRHhm4rK8bv1ZxdLpjZonbT/Otz
         WOBOwkGPQ9XeYLZDHPZWWeHdZS6HE24WrU1paJYZYlBVmWPZGPe4vHTPJMaSr1r31jnt
         foDxA6RpcP0K2doYXZp6POoqIqed98X+8hIxGNoad+DqwooUjXFGRk7OtpiqbFgdmes/
         E9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmiFtfH4zmI+d20vCYAm1VeLBaZ07Zt3ioT6CWVzqDc=;
        b=Ox45uzfT3WK10DQ5SSMJJJp29q+z3VIsQofFM5CpmdB8Uk3tQ+8yQvZztjMKl+LoI4
         t9PBVNLiB5p9/SbnmmhBTjvwmJ6YaZis+c0rWhilJrBa1tpTMeuAFfMYlkA8Dbt4STIZ
         affRn9KpAjf2g26Q1aI1CMsSBGs2Qcy4kTuIMWGIhdemLHyb6zdIcN0Ncp/5skQr4I3K
         Ma+YZjxiP2OrTNo2KthOlmKZJ9/oNtoAPhUMEdE2o9+6W/GHOc8kNPsL9PfYAquPphpa
         POp/dwg3lhTgdsR8U2XiadDBZ7q70lxS6QCh/MBgnccpZc/wXzrsxzKXrpBh9LMDzivi
         AmNQ==
X-Gm-Message-State: APjAAAWPkUAhv0g+5TJGE+Q7mbI5TGMk/A1FfIUmmrKE+Rtn8VqyjdK7
        pku4oQncwpA+2iO/y2EnarIA5Gci
X-Google-Smtp-Source: APXvYqyxTzQiISiyiySr5mOjJCeNCRcQVLWQj/qvpaAyrCdmqRhSRsupu8PvYO1Bny3Pj3g+m/FjVg==
X-Received: by 2002:a1c:4008:: with SMTP id n8mr6720483wma.121.1576008099430;
        Tue, 10 Dec 2019 12:01:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z6sm4352255wmz.12.2019.12.10.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:01:38 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 1/2] dt-bindings: reset: Document BCM7216 RESCAL reset controller
Date:   Tue, 10 Dec 2019 11:59:02 -0800
Message-Id: <20191210195903.24127-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210195903.24127-1-f.fainelli@gmail.com>
References: <20191210195903.24127-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

BCM7216 has a special purpose RESCAL reset controller for its SATA and
PCIe0/1 instances. This is a simple reset controller with #reset-cells
set to 0.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../reset/brcm,bcm7216-pcie-sata-rescal.txt   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.txt

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.txt b/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.txt
new file mode 100644
index 000000000000..ceaf7ee58726
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.txt
@@ -0,0 +1,26 @@
+BCM7216 RESCAL reset controller
+===============================
+
+This document describes the BCM7216 RESCAL reset controller which is
+responsible for controlling the reset of the SATA and PCIe0/1 instances on
+BCM7216.
+
+Please also refer to reset.txt in this directory for common reset controller
+binding usage.
+
+Required properties:
+- compatible: should be brcm,bcm7216-pcie-sata-rescal
+- reg: register base and length
+- #reset-cells: must be set to 0
+
+Example:
+
+rescal: reset {
+	compatible = "brcm,bcm7216-pcie-sata-rescal";
+	reg = <0x8b2c800>;
+	#reset-cells = <0>;
+};
+
+&pcie0 {
+	resets = <&rescal>;
+};
-- 
2.17.1

