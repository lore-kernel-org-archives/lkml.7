Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB70C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2CD20879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUh7F2Ww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDHOm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:42:26 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33809 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:42:25 -0400
Received: by mail-qt1-f201.google.com with SMTP id x58so12903073qtc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=b5YLUBhVLY7mkfopkFQjIkzP3Gwv/ZY13l4EfD4a/cA=;
        b=YUh7F2WwUojHZWZhi2LqD0Ket0y9zsQII1TAC8SrJXeJ80x5k54IoXJIKfmWCcrC2j
         isKlloJdyyFi/HQUlZ1hAd61zifYgV2moItCWqQ25ckbjXDI69lMyVDrZYk5gvn+VH+W
         +67Vxa5J7AwqtNZ1Dapfl7qQiRmBY3kU+78w6F9t9s0S9iLOUKf37N5kHTOb3V1w+WEf
         Of1kzmvpSFg7EF22k22BcV0VuCRqN2IUzN4RrAKIcAAkvBIZzz6EGa4lY5ZFxcxOx3un
         2uz+Q5nrz6cSGfEfsEaojXCynAesG4Wvrt1l4HC6PBhhpfTkPDI10dYyppTWGBnEK5mj
         E4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=b5YLUBhVLY7mkfopkFQjIkzP3Gwv/ZY13l4EfD4a/cA=;
        b=kcZMww+Md35rcv7o+qhcDvJg9ykDs6Yq9LOFp3kGn+PbRz10+6ScGwMaf0KEsTWbGm
         xAflqYbTYbPJVk0GL1tP3VYwg5CJz98qSbv5ZaYwzfIzfk/BtCf2YhUUSF5OLZ2TNkYj
         PMf8x+2f264oPKLV6GvXuVaa0AiAk5imppwmj04KioELdv8IwguMGa07cwNYlefbmCKE
         fOcp295V79ibIytAa+yqXhxPENJJZylIIFg3ZykzQByzZNUUqzLov9e9hpnqFE7lM5L+
         KwX5lu9xstC3DJcO9pzg9sHVhV6OQe9oAJTv30dzs4ynfQ+EHBrsZQukLsb0lF+uxLEK
         g04Q==
X-Gm-Message-State: APjAAAWYfN2vs9GNwXFwoNCzJMnBNKOa76kAbDYoDt9/rEMYXwMKVxxj
        bXlZMKVkb9GNTo6DFDnMflR6LqHQH0tA
X-Google-Smtp-Source: APXvYqx8DIwao7Qeicx77irHcsITaRHETyMc24ZgVrUbqrPzxKZF5aW+yMwNH21N6DXctR0ATjDV0ngcwmzI
X-Received: by 2002:ac8:93d:: with SMTP id t58mr3643003qth.41.1554734544323;
 Mon, 08 Apr 2019 07:42:24 -0700 (PDT)
Date:   Mon,  8 Apr 2019 07:42:16 -0700
Message-Id: <20190408144216.160082-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v10 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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
Changes for v10:
 - Chopped out nearly identical information.
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
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 0000000000000..854bd67ffec68
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,47 @@
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

