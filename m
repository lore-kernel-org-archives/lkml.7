Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF15C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FE02184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oW0tE8g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbfC2PKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:10:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34476 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2PK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:10:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id j1so1690431pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=m5+J7r1VBfrdcP6uJuO95LQiwCpHc/yHDQw72h3urf8=;
        b=oW0tE8g7ZZYFlvGBzbeDQ35ncg7nPur8tnhSblujfZrrjXj+k+T4Po0LE9LQgtVKLw
         n7yCMvCuf9IrJ39nPEKxH9TW5HiGNRMPxiBQ86iLa8Zp/fy/k1Zip7S3cahBB3z9kfUo
         mioZoWhsgoCARoMbHAIKwzUM/G0EUPOVIEsbeoVI5kqrUVx3d4QqrkFP0ZFNjCF0Ij3s
         A9s67r6jDTHOQkfq+D8DGwTUzzVzo3EkDYBTRBF7X7YJ1i3HCJpKlE67H//LIlHgQHEP
         FTBbJw3ZCN8RwwJtTFmvVX9GPY9IN+hw7S6DKRVFndIgwP0dqJrveDyYiNxoI34aKwmB
         pL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=m5+J7r1VBfrdcP6uJuO95LQiwCpHc/yHDQw72h3urf8=;
        b=j+/ctJuEpb+MaUe56FrlbY9RlwUDV+c7esuDHu1Budd5HCYIKtUxDCYuFCJxRLOqWz
         HNbr2YbdYARLCdypVq7zz0w8IzPy4mDaXnSGMEu1gxaWIEn0KTWEqZpPGuqPSRqofFC/
         h4X3oGHlOiC7+DSLMEb/ciuX2vG68scLvEbl7ifY4qGt5Jzn5zi8Eo4qsDDAQf7zKWQi
         B/+fHF+8xN8Y0S/r1xxiSLtW4AfEyvYpjIMVUS2rw7EyCIH2l9AZnrsgFt5mkeQxXhd+
         FQo5CsmA4XTZGOtoAfO6+52yKM1odb4myYlH9fZ+K4w/Q2Jycw0Vz/12WqYqUDawoZgO
         Oj/g==
X-Gm-Message-State: APjAAAUYN2A0X1c5hFi7+eYf+y8A2Gn2Mby1++5RxcSgdKxop3HrLwue
        d+ZUbAWBvVS2aN/oFOA9vJJlVUG1WHqa
X-Google-Smtp-Source: APXvYqwiZwvBOltMs9I4OhU7gcFMnGzl9uDBH1IxTQX4GOsMahpF57ZywVce/nkTSX8Iwjlwplg1kADKR5vt
X-Received: by 2002:a62:d241:: with SMTP id c62mr560123pfg.110.1553872228903;
 Fri, 29 Mar 2019 08:10:28 -0700 (PDT)
Date:   Fri, 29 Mar 2019 08:10:25 -0700
Message-Id: <20190329151025.204094-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.

Signed-off-by: Patrick Venture <venture@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v8:
- None
Changes for v7:
- Moved node under the syscon node it requires
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- None
Changes for v3:
- None
Changes for v2:
- Added comment about syscon required parameter.
---
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 0000000000000..088cc4e3dc54b
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,48 @@
+======================================================================
+Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
+======================================================================
+
+The bridge is available on platforms with the VGA enabled on the Aspeed device.
+In this case, the host has access to a 64KiB window into all of the BMC's
+memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
+has read access to all the regions of memory, however the host only has read
+and write access depending on a register controlled by the BMC.
+
+Required properties:
+===================
+
+ - compatible: must be one of:
+	- "aspeed,ast2400-p2a-ctrl"
+	- "aspeed,ast2500-p2a-ctrl"
+
+ - syscon: handle to syscon device node controlling PCI.
+
+Optional properties:
+===================
+
+- memory-region: A phandle to a reserved_memory region to be used for the PCI
+		to AHB mapping
+
+The p2a-control node should be the child of a syscon node with the required
+property:
+
+- compatible : Should be one of the following:
+		"aspeed,ast2400-scu", "syscon", "simple-mfd"
+		"aspeed,g4-scu", "syscon", "simple-mfd"
+		"aspeed,ast2500-scu", "syscon", "simple-mfd"
+		"aspeed,g5-scu", "syscon", "simple-mfd"
+
+Example:
+
+g4 Example
+----------
+
+syscon: scu@1e6e2000 {
+	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
+	reg = <0x1e6e2000 0x1a8>;
+
+	p2a: p2a-control {
+		compatible = "aspeed,ast2400-p2a-ctrl";
+		memory-region = <&reserved_memory>;
+	};
+};
-- 
2.21.0.392.gf8f6787159e-goog

