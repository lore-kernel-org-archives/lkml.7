Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47032C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157182083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A73YNgB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDKI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:28:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37660 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfDKI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:28:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so3173089pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fs9k/ofObdjUeCTYkQB8LCaYi1pDWe1mex0AK1YWiFM=;
        b=A73YNgB9Tlzp9/1ThMjQJzZ0XzoiY6z0aCZiR9tfQL7lugFQtA5YSHA12G0l9wcrhN
         g1I06uRFoajRwB8nN2WVL7pacMNFhyJLNnAjvUCS/yMky9IPQcSw6KzlzVOisnSy5wJg
         SRztDTZh1UXWXh6RfYhhZpWe0bx18XLeTwRm1fsZgUkja3ESOHwaF+eOtdYZT9W4Jif1
         e5JivajHWeGWsBrxbHAHZqRVPt3i9WxGNAvJ+DSIdUoI+U+4yfXmo8pM/0ZCfIhnoy/o
         bInuPxH3WxGVPmWYSowlA48Qx4zxLHhBhNXJCrhLIvA4nUbPisLN2FuqZdrEm+S6lD35
         kNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fs9k/ofObdjUeCTYkQB8LCaYi1pDWe1mex0AK1YWiFM=;
        b=dVgeqVEdayUnz7EyqqZZGpUsfUDI6/HYaiOR99ZrziYH4T83UlwdSJuZ9mCkxd0796
         Af4Az/eVsCyqQbJfzJ4BdXQwbfLpwUdVHAkiW6y7i0PSEEpH9SMsQCwvzzvePsF8yUCY
         pfqIjC6eors1OZG8x45NYSSPohaJXnuHxtQOqg9BgbqPLtgrXH2WgFaiUdwOi1a0WVtp
         PTWuOC5fa3ds14vFVWV5bRqklFqRuHAYnHujesE3GKAL7Ow1UKdFP9JffJYRqgxFX+uN
         Scdi7rbS/z91hNfS9O1qt1eDIzuhIzCCwZ1pPOvC02NW55eEoZ6U+mhVKJ+LxXRSkquu
         JFZg==
X-Gm-Message-State: APjAAAUwUxqFIQNvmmuIe97WTPpr5qcpBwB0TvB4nbfXMvTaUWluvn+z
        YMs42IkjUIHCyxkcwHA4uwQhKFPfPZ8=
X-Google-Smtp-Source: APXvYqzUVRFPufaj+05dU9sy/fCHaliilqvViAD6XI3gLfNv0DolX8Rzu1wfYKffz2EBgaRfSABbhQ==
X-Received: by 2002:aa7:8609:: with SMTP id p9mr48274019pfn.166.1554971291183;
        Thu, 11 Apr 2019 01:28:11 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x28sm41043430pgl.38.2019.04.11.01.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:28:10 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
Subject: [PATCH v3 2/3] dt-bindings: clk: add documentation for the SiFive PRCI driver
Date:   Thu, 11 Apr 2019 01:27:34 -0700
Message-Id: <20190411082733.3736-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411082733.3736-2-paul.walmsley@sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Linux driver for the SiFive
PRCI clock & reset control IP block, as found on the SiFive
FU540 chip.

This version includes changes requested by Stephen Boyd
<sboyd@kernel.org> and Rob Herring <robh@kernel.org>, and
fixes some errors in the initial version.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Megan Wachs <megan@sifive.com>
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../bindings/clock/sifive/fu540-prci.txt      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt

diff --git a/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
new file mode 100644
index 000000000000..349808f4fb8c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sifive/fu540-prci.txt
@@ -0,0 +1,46 @@
+SiFive FU540 PRCI bindings
+
+On the FU540 family of SoCs, most system-wide clock and reset integration
+is via the PRCI IP block.
+
+Required properties:
+- compatible: Should be "sifive,<chip>-prci".  Only one value is
+	supported: "sifive,fu540-c000-prci"
+- reg: Should describe the PRCI's register target physical address region
+- clocks: Should point to the hfclk device tree node and the rtcclk
+          device tree node.  The RTC clock here is not a time-of-day clock,
+	  but is instead a high-stability clock source for system timers
+	  and cycle counters.
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock via the clock ID
+macros defined in include/dt-bindings/clock/sifive-fu540-prci.h.
+These macros begin with PRCI_CLK_.
+
+The hfclk and rtcclk nodes are required, and represent physical
+crystals or resonators located on the PCB.  These nodes should be present
+underneath /, rather than /soc.
+
+Examples:
+
+/* under /, in PCB-specific DT data */
+hfclk: hfclk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <33333333>;
+	clock-output-names = "hfclk";
+};
+rtcclk: rtcclk {
+	#clock-cells = <0>;
+	compatible = "fixed-clock";
+	clock-frequency = <1000000>;
+	clock-output-names = "rtcclk";
+};
+
+/* under /soc, in SoC-specific DT data */
+prci: clock-controller@10000000 {
+	compatible = "sifive,fu540-c000-prci";
+	reg = <0x0 0x10000000 0x0 0x1000>;
+	clocks = <&hfclk>, <&rtcclk>;
+	#clock-cells = <1>;
+};
-- 
2.20.1

