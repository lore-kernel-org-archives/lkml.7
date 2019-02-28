Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AEF20863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8GO7W7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfB1BwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:52:17 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52110 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbfB1BwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:52:16 -0500
Received: by mail-pg1-f202.google.com with SMTP id t26so13658598pgu.18
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 17:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JBlDBrSfLY1P6rn5pc11N2X4uPwgficU/JHjLghtRss=;
        b=R8GO7W7r23Ijqx+sj/SCcCtchfLFBXNxXizYnC4yU1vePy6+sgXiZyUCtb6gz2eZQH
         2ILzls2PR+o2v4jA0ev4g+vzFW2+V0yopnatZnVXNdD50uRQVAXKjUFbs5/Pk0DX5gj3
         WNMkSuOAXHISxtHpprjLpOuIFAYHPX3LZQPnGBtwDu3ggS1RcfTNqRTpwQ7UFOkbaUCd
         F+AM8f6o32j2JxxHBiNmefNOIeEUZ/cGfkuXFR9bvw3EdVwU7wk3OB7+SBtu0slEnDI9
         GE4xrnwDYxRQDvesYJf/n5ijpTt5d+mv1Qq9+Dw2vQBaXpTSvRnjZW3SAo5LlkC3qR4L
         qPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JBlDBrSfLY1P6rn5pc11N2X4uPwgficU/JHjLghtRss=;
        b=jrmWUwS7yzibI0meWXQKJ/+8P20SVWTsGz+nmmiueqQfU+G87fqEGT+gxpVoU5Y+oi
         bbyRGNcBjXqGV2xPU5aPIc+bPUtRT7r0/5boktenSz0eU6QGzQGKqwahmO0G2z7kdvzv
         7t+r/v0pqtDL+pmG72IQ2f8SFiatCS6yqsf3X9shXaVnuZgI2fVrzHBiyYje7CKmNYWw
         GDzST0GcH9XUg/9+zQ0IXRJ6fQbBGy5atLq+NNnHjWUvQas1bFJWJ1FX/p+faUU3uSsW
         gFgzhrNsYLa5pgff9KJV8eDGFmUYaCsm86lp2/8sdXLJ/9abEMQIm/7Kb0kLU5N7maaB
         6rxA==
X-Gm-Message-State: AHQUAuaa1RcdqDPQyFzp4FlP2KLN2r6t/dFc6lXDT5HOiPvJCVIpqlbs
        Csk+4SvrQnK+sBvm/nc81782XBd8E3MS
X-Google-Smtp-Source: AHgI3IZbrqbcz+8aRG2gnfW8Z9zI6GUj9zLgUttkLkxUqm5rP7ZelwWsiRtkWqkWiakubLn6FeT32yhW6YV0
X-Received: by 2002:a63:4a17:: with SMTP id x23mr2251765pga.55.1551318735620;
 Wed, 27 Feb 2019 17:52:15 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:52:10 -0800
Message-Id: <20190228015210.28880-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v5 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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
2.21.0.rc2.261.ga7da99ff1b-goog

