Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAFF2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560774155;
	bh=tgZsHVbNLcoLLQMpm8YjGpkR8Z8fD1Ui+K8OiDs0s6s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IWegRPSaVoV28yjj/yJyLdu1LJL+pGxqaMY1QYW97axhNhgzlP/2dlnl+GNTs4Lta
	 ZsObD0Rk4LHFohMS7DUQZ2Xzwbns2rLKLL0fAwHzjngCvkHmIb5zBqYTyVOhPDvhK/
	 BJLkx9rx2wNKDnbN0ofkwO8HqmdUHeU32F1wYuhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfFQMWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfFQMWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:22:33 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A7F20657;
        Mon, 17 Jun 2019 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560774153;
        bh=tgZsHVbNLcoLLQMpm8YjGpkR8Z8fD1Ui+K8OiDs0s6s=;
        h=From:To:Cc:Subject:Date:From;
        b=x5cqyCrkuzEzrPAfDR+MhZxDNHPD/8QeH6qyO0oFG2BaD6r3HaQrHGIMpEvB1SmKP
         efbcJlQKdfAeWSWAgni++3TMSzpbNsGLvvP8A27xW94PSZ1rB7iOK9wyql9RE1sw31
         T1Vor4UjLD4TPAJ2TberYVFxromn/dxQkrI+LahI=
From:   guoren@kernel.org
To:     robh+dt@kernel.org, guoren@kernel.org, han_mao@c-sky.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: csky: Add csky PMU bindings
Date:   Mon, 17 Jun 2019 20:21:39 +0800
Message-Id: <1560774099-8808-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

This patch adds the documentation to describe that how to add pmu node in
dts.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/csky/pmu.txt | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

diff --git a/Documentation/devicetree/bindings/csky/pmu.txt b/Documentation/devicetree/bindings/csky/pmu.txt
new file mode 100644
index 0000000..728d05c
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/pmu.txt
@@ -0,0 +1,38 @@
+===============================
+C-SKY Performance Monitor Units
+===============================
+
+C-SKY Performance Monitor is designed for ck807/ck810/ck860 SMP soc and
+it could count cpu's events for helping analysis performance issues.
+
+============================
+PMU node bindings definition
+============================
+
+	Description: Describes PMU
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,csky-pmu"
+	- interrupts
+		Usage: required
+		Value type: <u32 IRQ_TYPE_XXX>
+		Definition: must be pmu irq num defined by soc
+	- count-width
+		Usage: optional
+		Value type: <u32>
+		Definition: the width of pmu counter
+
+Examples:
+---------
+#include <dt-bindings/interrupt-controller/irq.h>
+
+	pmu: performace-monitor {
+		compatible = "csky,csky-pmu";
+		interrupts = <23 IRQ_TYPE_EDGE_RISING>;
+		interrupt-parent = <&intc>;
+		count-width = <48>;
+        };
-- 
2.7.4

