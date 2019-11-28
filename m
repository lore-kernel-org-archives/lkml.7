Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F0DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4CA20880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574938521;
	bh=CN39nBjgwL1sGAX9H9ax1d+qIEngSDEVglyUab6WBl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYbV3hcykhtwkFND3G3hfqASK8yBMGb15D8vBBJ8oTlRRM38hGaUvkF/Icv0l1Us1
	 AHW+ked6Lp44hhInruCsa65/m+LZrh/43aSXPyrDBWm1mSu4hbysY5GTuQyCHnCAaq
	 9BQvXMmzSMmFYND2jDvVRLygTkJYz5T/WyUNnc8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfK1KzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1KzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 05:55:18 -0500
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7389921775;
        Thu, 28 Nov 2019 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574938517;
        bh=CN39nBjgwL1sGAX9H9ax1d+qIEngSDEVglyUab6WBl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5DLnzHC8j3ZAJ+jjwzKLfWvnHs+HPva2GsOX77t4uNP2naQHv48s0de8YcDS9gOB
         Vwz7i7nfXW/g1j+4pqvGq0ixs/Y1slxBIe9X9gvlCKWklsZvukdvG/seP1nNiJvchM
         jskrTEy8uh7F84cRvpSK83jPo+NeoVaqpFDG38JY=
From:   kbingham@kernel.org
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Simon Goda <simon.goda@doulos.com>
Cc:     Kieran Bingham <kbingham@kernel.org>
Subject: [PATCH 2/3] dt-bindings: auxdisplay: Add JHD1313 bindings
Date:   Thu, 28 Nov 2019 10:55:07 +0000
Message-Id: <20191128105508.3916-3-kbingham@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128105508.3916-1-kbingham@kernel.org>
References: <20191128105508.3916-1-kbingham@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kbingham@kernel.org>

The JHD1313 is used in the Grove RGB LCD controller [0] and provides
an I2C interface to control the LCD.

The implementation is based upon the datasheet for the JHD1214 [1], as
this is the only datasheet referenced by the documentation for the Grove
part.

[0] http://wiki.seeedstudio.com/Grove-LCD_RGB_Backlight/
[1] https://seeeddoc.github.io/Grove-LCD_RGB_Backlight/res/JHD1214Y_YG_1.0.pdf

Signed-off-by: Simon Goda <simon.goda@doulos.com>
Signed-off-by: Kieran Bingham <kbingham@kernel.org>
---
 .../bindings/auxdisplay/jhd,jhd1313.yaml      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml b/Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml
new file mode 100644
index 000000000000..b799a91846d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/jhd,jhd1313.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/jhd,jhd1313.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DT bindings for the JHD1313 Character LCD Controller
+
+description:
+  The JHD1313 Character LCD Controller is used by the widely available Grove
+  LCD RGB Backlight display. This currently supports only 16x2 LCD Modules. The
+  reg property specifies the I2C address of the module, and is expected to be
+  0x3e.
+
+maintainers:
+  - Kieran Bingham <kbingham@kernel.org>
+
+properties:
+  compatible:
+    const: jhd,jhd1313
+
+  reg: true
+
+required:
+ - compatible
+ - reg
+
+examples:
+ - |
+    auxdisplay: lcd@3e {
+        compatible = "jhd,jhd1313";
+        reg = <0x3e>;
+    };
-- 
2.20.1

