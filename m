Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E8CC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E811322D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566398320;
	bh=bpvKrS4xjqV8MEvCfqz1VDqPz4Adz4s3wbNsncnxpkY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2emmZFUKXfEdfUuuoI0rYRSOQfEosWL18qpmOWS+lnEv6uZoVyah3DNkREE3eSylP
	 dnp+M3Cxz0xKSWuc+HUgmfnfVx6R27FY4q6FDDmZPpFOHleTPfwDO4aOm7a1IcespG
	 xktvYifBPgT/KtuAhh3ZXAN3TuQGmE3YsispD+jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfHUOij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfHUOii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:38:38 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E833206BA;
        Wed, 21 Aug 2019 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566398317;
        bh=bpvKrS4xjqV8MEvCfqz1VDqPz4Adz4s3wbNsncnxpkY=;
        h=From:To:Cc:Subject:Date:From;
        b=wj3piKtzc7YjEGap2/eQeyeo2oaQNmjEcEc+Rvvy5t+402fgWQLymblGmGp/Hc8Wf
         Le9aKUL5EYLmOOYojmaWn4mUa9XdHH0VQHiOXyo8FgcOu0vSRn/RpplR3x7sSy8Oka
         /hK9V/wqVzoIB7eXn4cb+dB7XNiwxZpM13yiIcXY=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH RESEND v2 1/6] dt-bindings: watchdog: Add YAML schemas for the generic watchdog bindings
Date:   Wed, 21 Aug 2019 16:38:30 +0200
Message-Id: <20190821143835.7294-1-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The watchdogs have a bunch of generic properties that are needed in a
device tree. Add a YAML schemas for those.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - New patch
---
 .../bindings/watchdog/watchdog.yaml           | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
new file mode 100644
index 000000000000..187bf6cb62bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/watchdog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Watchdog Generic Bindings
+
+maintainers:
+  - Guenter Roeck <linux@roeck-us.net>
+  - Wim Van Sebroeck <wim@linux-watchdog.org>
+
+description: |
+  This document describes generic bindings which can be used to
+  describe watchdog devices in a device tree.
+
+properties:
+  $nodename:
+    pattern: "^watchdog(@.*|-[0-9a-f])?$"
+
+  timeout-sec:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Contains the watchdog timeout in seconds.
+
+...
-- 
2.21.0

