Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB22206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4ooVBiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfCDSzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:55:42 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:46653 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfCDSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:55:41 -0500
Received: by mail-io1-f74.google.com with SMTP id r21so5033619ioa.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=d9nLB53oEnMGgXC1Hi2LQ95UjAQxG8k1zRQvUzAlKcI=;
        b=h4ooVBiy33Q/QktvjkhXIv/KNGQ7M1bkgVZbitrl2LCPYy4l4op+v3YVnE77z4mFf4
         xyNgd0jo+3nACpcPXqTk36edEFxqBKelNRYr6ED8uW0y/zKVXfX+8Cv6SfZt0nqEiu82
         5JF8rgWmKI0mMZmSBVNw7mquiUL556lg+nsMstsK+XGNABwb71y8MIp79XdPFx/9jto2
         W3G5hY7gm0qKoL/Qi7cyLm1g0AgX+SFtXya7VpiyltWg3EPUtuwwc/D0H+qz9c8d9IE+
         LBLH2km5v6/O0ezwdidr9uJyTV6lD0uYTnhthwP/Aujs6US4pJmFpGwRD2WLCyoHOVZk
         VBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=d9nLB53oEnMGgXC1Hi2LQ95UjAQxG8k1zRQvUzAlKcI=;
        b=Lb8adfc29YN8LKrwNYTdKGuiXULEmdwoukd7Y/njDiDUQU7+JqsM1r6GEH281ZuZ+v
         HKHKHHk1fdHR4eWSOc1TVPDD7EUo/DnUhsmaEpyIykJl4v2hCN/lZTN1AJDdfFCXFb6Y
         oaWfCEC7zZjOGZX++qRhdQOn6F4pKR/MNrAkXWvcF0KmcjEMSa2hUt7qiu8CiLzxIPhr
         NbJnpFlTNwYDbNvLy7aZAr+xZQ1uxbq5HBm0aP3d9HBCaMZRgyljccy4LotZBzMqqKPP
         iWP47fnjVFDoqCs8n7c0JOeFsKX7s1XIPhNtPsgPQjmuykVJKWMaRsmHHm5DjCwObIPu
         iz4g==
X-Gm-Message-State: APjAAAWpuJVOy7Zv2trwyulHkGidhOamuwrN5MYViz4VMxAQ0yd/vZ4m
        SAqEWDV9t0wBWBo7rVTpNUSM0txie5sF
X-Google-Smtp-Source: APXvYqwpygwmAHneUpkicCxmRcGUQ9EkQ1iZcKmesx3ZUVxH4jALehHTuJO0mM+wdnNYcZeozMoiXgf7SYWw
X-Received: by 2002:a24:5dc9:: with SMTP id w192mr341958ita.33.1551725740649;
 Mon, 04 Mar 2019 10:55:40 -0800 (PST)
Date:   Mon,  4 Mar 2019 10:55:36 -0800
Message-Id: <20190304185536.211084-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH v6 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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
 .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt

diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
new file mode 100644
index 000000000000..1092d62d1c92
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
@@ -0,0 +1,32 @@
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
+Example:
+
+p2a: p2a-control@1e6e2000 {
+	compatible = "aspeed,ast2400-p2a-ctrl";
+	memory-region = <&reserved_memory>;
+	syscon = <&syscon>;
+};
-- 
2.21.0.352.gf09ad66450-goog

