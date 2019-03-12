Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58443C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2735B2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJWnPgki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCLQa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:30:56 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56606 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:30:56 -0400
Received: by mail-pg1-f201.google.com with SMTP id d10so3170256pgv.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kqjBTmv26VIX9JTEJkSps2f67FmEYh7rx1GjvZ/U8pI=;
        b=LJWnPgkix8BIabxV1von5P4DriBG0kQECT+Xi4MDn0V3SB6+vCsJgnZSLKvLiCKOAg
         twG781De+59NaSoRkhBVWmG8Uhkg/u8+AfFf6XZd6JRjaXQACxi2+YJyyJ9/A7ialpO+
         c7EvVBG6ERwgg2Z0Cjg6+XpT1QpZLexi0GFMbKacHA/QYmGNzWIKs2iwpDG6DrZvZxyY
         t8BI1IleBOqkGpWQ+QtoDNkrR3yodnZdWjK7jz4DXEYNQ2ulFjtwfxiASB5oxKZh0E7H
         9HcwirRPavXd6Rcgh9gcXhMDEss25esPeUqWcwziqDFYyG+9ZPlPFYWp3f4D53WqhxJs
         cmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kqjBTmv26VIX9JTEJkSps2f67FmEYh7rx1GjvZ/U8pI=;
        b=grpLqf2ZS3ugHtwRUsvQqXhNwuOlBqK2Uft17OlzVgsRw+zsYcbDhBm8wcekCw0TEW
         qUalOE2K09yxhkkU0LR/K+/izBvCwntg0oXL12lkB+0gE0Kj+FCl6yyMlvKF3kZhzuNh
         o7E8badC+x58AViQTNShKhMdRjexUluogLt9BpdUZiwfTwhAXGrq4r4dDI5OOaYdHKtX
         QAQveUzEFO6PbWInU1X9EvTXNXE66wtGtz01lJaDHdJXVMMhXnwNFuSLQmAa1pwg52nC
         didLQmt+3wRzQRenay4l2q79lFT9gdC2Wi4cX+foQJSEs2GFxnk0LLvyOm8x6Tol6+YB
         IgWw==
X-Gm-Message-State: APjAAAXVaHrKKGc3yiHBl5nDSk3seuz47Zr2dWo/ImKkg0Cyz+QYliKx
        Bw6ib6xOGScJGgUm5nYda2jgbAMRGNeX
X-Google-Smtp-Source: APXvYqw3K1vvGTj3mos4O70xYaHCSOgRfg+3LTgTxrs/2YCDxjRpK3cbTwZOyq9YHDycN9NN60UHpfmgEexi
X-Received: by 2002:a63:4e15:: with SMTP id c21mr15008108pgb.85.1552408255456;
 Tue, 12 Mar 2019 09:30:55 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:30:51 -0700
Message-Id: <20190312163051.155405-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH v7 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.

Signed-off-by: Patrick Venture <venture@google.com>
---
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
index 000000000000..088cc4e3dc54
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
2.21.0.360.g471c308f928-goog

