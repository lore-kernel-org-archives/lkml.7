Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05684C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B722082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vcfPZFjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfC0VWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:22:05 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47457 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfC0VWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:22:05 -0400
Received: by mail-qt1-f201.google.com with SMTP id z34so18274113qtz.14
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=48scp4XmiicMd1uJB9R9oC5WIEZgJYNMZkP6/YkFhCc=;
        b=vcfPZFjZYFgyT9FnqPuRx0mXPB372rFJGA1lsKfHxFUdltAuMAUoeXHoUoNCbz/dGp
         8in/2ytey66tmgfoYCKIFmQD92zZ9uaJvpMd3QDPS9J2AkHOow3Ukps8UkRDXKmFIJQg
         6XAqSwnnhCWNOCxGZVTOAf2tjLAsqlI8XRNo0h/pq639FNgc/1+BFa0ZWfeiiDdPnR9c
         JvKskW6woW+0e8ffLXqR5K3mN0Te4Fr3k6kC/cAcOIR/nGjE/TXlkoluMuBOyIOlIj1O
         U6dj8mqqdY/XhS/uEnKJqUtyl2PNGqxjblojVvuB3ZNiKwky00P/nx8uE4wHeH4tj2m0
         xaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=48scp4XmiicMd1uJB9R9oC5WIEZgJYNMZkP6/YkFhCc=;
        b=Bsc6yajmjdNOTAZtfayDGkKcIQ/FeOwyc6yTPvnNOcFsSQ9hbSCRhXqFgv1uWhLvkG
         apq+pnOsQ5I18Tn2GoRQlg+WOEJHD0gR7JQJnPqMkpMfepG6mYBfl0hRh0sSBrpbvDXH
         qTrfWQaeF7WMHMLjcjSRxfQm8nbmf9bJF2ZWwoavciItoMKENA5E7jOaiCPtz+IsdLi7
         27cO46IJwJhOE//roLAW0cB6b46QuueN2aayrJMZLT42oClAcWnOUMorxVfwUFvzKDOf
         sTZsFNjcVZlJCX9CrUrIK6QDAdqPRgwrnjUqjGrd1Nq18+1jsr0BtAY6WX/rLkTs2sQe
         SXVQ==
X-Gm-Message-State: APjAAAUaWXGaeBbniwj8hB1fDanb0OOIdcyY7zLZ7AXnBsv7hyJm4xCZ
        8pYZqr6nLtb960LuAL2K8nYkPoDoKHqK
X-Google-Smtp-Source: APXvYqwu0UXYWUO2Au194kl9CxcUr6cu8AT+tKYOIEQUMOHJprFLKJq9sEDQmpHMlwoJ3w1etKSm7myJKCHi
X-Received: by 2002:aed:3e16:: with SMTP id l22mr1962071qtf.50.1553721724234;
 Wed, 27 Mar 2019 14:22:04 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:21:55 -0700
Message-Id: <20190327212155.80730-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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

