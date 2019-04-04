Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1534520855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJ9Gr11b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfDDPZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:25:49 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:50969 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfDDPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:25:49 -0400
Received: by mail-vs1-f74.google.com with SMTP id b142so593548vsd.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YhJ+d5AHWHSW4lcy18GH9PHI/gj3+t8IvEH+dm6SEm4=;
        b=nJ9Gr11bWK/ysPB/ZjK/bSNXKDZuI43qYeAc2i21z+AaGaRnWNKpNDp+MVuf0rPIre
         W7S7epUF8F8ELNZv7MTzbLEaElNsdged6ag8cxKKDcVLxcktLWkiu8rV+4LLqZ4gJSCG
         pMjvw9MgzcfRuZ9ZcPHm772rAjClVhih4j3VYaZNCxdnG/4LEMDBiwzh8kFrfO7ti+0h
         +NnYv/e3v7/ydGDO8KXHIxU5O/n/qdKJLvEceAcSGrz7PfFLhe3/YE7Vttts2Xlu0l7W
         gQRjvafGZ7/i7o6R6TCTqFVkXQbUawmvNZCNnIi+Xvmm0jxi7cv6uSCILLvpyGtM/f31
         qgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YhJ+d5AHWHSW4lcy18GH9PHI/gj3+t8IvEH+dm6SEm4=;
        b=LLLjiDnXBPFzJyWjbrKPlDhZ/+vmR5AQoKj8XOj60I4GfxwylSGHEp+1q4lGhVoslL
         v86gdI+sZ9v3ragtmZUm9ZhaOy+ReH/4I48EOQYCCXfa8DoDYpLC+QGplEuu0zIpnc5Q
         H7m1D7pa+sSZ7X7LwPwzAQKp9hILLdUgMnfclENIdkg6e2QdJkcKFEA1KTYL+IvJaRKv
         saQiMbMHxytsSTHQy9mEYUiCmoAHzEQ0rQLknm3FYyMzvlmDvGjGmJseOTBtCYPeCMLf
         m0+wGIMAqiHviDOT+TJXqLsQazvkkOoPbE+UBAaF9G1YTOmybPv28opIhBEfiZzVYeHx
         kciQ==
X-Gm-Message-State: APjAAAUGRzYuEXb1UEDri6Gi7+F+sjE0PO+v1DsQFiMOjd5auEsMFhMq
        s0LBG1xouQOfRx8qZYbe8tXHw/iBUr6t
X-Google-Smtp-Source: APXvYqzhwZFAaZsz8YOZm5Za/HDnuCAm/4fPknG/MUrV7Ux0nN0yY1KuJA3Jd2pHyBhkWJvXUt/YoLtiH4IN
X-Received: by 2002:ab0:2554:: with SMTP id l20mr787672uan.4.1554391548228;
 Thu, 04 Apr 2019 08:25:48 -0700 (PDT)
Date:   Thu,  4 Apr 2019 08:25:44 -0700
Message-Id: <20190404152544.214988-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v9 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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
Changes for v9:
 - Added missing details about syscon parent
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
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 0000000000000..05ed654848b60
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,56 @@
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
+The aspeed-p2a-ctrl node should be the child of a syscon node with the required
+property:
+
+- compatible : Should be one of the following:
+		"aspeed,ast2400-scu", "syscon", "simple-mfd"
+		"aspeed,g4-scu", "syscon", "simple-mfd"
+		"aspeed,ast2500-scu", "syscon", "simple-mfd"
+		"aspeed,g5-scu", "syscon", "simple-mfd"
+
+Example
+===================
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

