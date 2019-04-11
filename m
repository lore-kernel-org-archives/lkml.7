Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF867C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A682082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kgr6CJjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDKInc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:43:32 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:35781 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDKInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:43:31 -0400
Received: by mail-pg1-f173.google.com with SMTP id g8so3199982pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqHO8lKeM93haURO5R5tVecQJ8UbH1Kcw/Zab79L6Eo=;
        b=Kgr6CJjAYBSxyonIFQu5rNUAZvcTHIQwudpmELNC7yENvka64jmGeyFcnpd737baLm
         1h63lHGgT6Qx+ZMeMlVjJeiSGi7AnZD2EVy/ZRKbSovA6GYP6KvnWhPC6ln0Rnq7JBTj
         fjZU6Uhjh19wQRYMSmbnQMzg9frYd5FOEtM2aT0msi8ze1zybqeRP2LAZ30zm0c7Y1pK
         qxOH4DYO48oPUA5lrKNQ3arCiOqboIdV/RN7XQjNLTvivuB4fVaEi7qa98n1p7qrtUbg
         +aysP33pjlGcHfUbDwCZMF02zfYHvJJn5yI4mZwNRz9DQ1WLSkttVaf53x0rTEjHuD71
         ZhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqHO8lKeM93haURO5R5tVecQJ8UbH1Kcw/Zab79L6Eo=;
        b=O5Vm0V+W7wOHtqOobO4gjA3EfLq2Atqbi0Rn3+5nuhK8Eh2hlJlSCOhBj3noR8hdCh
         4kHR12byYGW474UVenvSsfHKB9tH9aIaE5LUoTfTHi0gMUSkAtnp1tH0A+MHqB7QoL1H
         sIk8+AZD2wxPsdyCMYY0l7MIqrOuSjvbpG40D7wZSgT5TBehD8wCftssZoowxoqc0Rr5
         k6Ur9XLc1MEAeJIxSVA50IFjyAdv9I/H1GHzIcPZT36vMaW22YICzDPzFE2G/TCDQL4I
         2AcnUo8Kcvyg4x/FCvwQuLZybULuUCMmCy6W7xiV2w1oQ7A3GkW7jL7NRATkIugBznMs
         mBJg==
X-Gm-Message-State: APjAAAW6s1QG6ZEWz/dUy9art8nPD+4JqsM+kVclfu2lXWZJih6Akfhe
        D3PvETtSxo4Kv/E4ZPGEBXeMhlkZYJY=
X-Google-Smtp-Source: APXvYqyILngJUeKvAkhBQwQyGvruEDKBmzAJ80hxuYFdNukeTQmUPgMamthwTe2deeanGqvmF1O+Kw==
X-Received: by 2002:a62:e10e:: with SMTP id q14mr47618676pfh.161.1554972210998;
        Thu, 11 Apr 2019 01:43:30 -0700 (PDT)
Received: from viisi.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a3sm61699456pfn.182.2019.04.11.01.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:43:30 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 2/6] dt-bindings: riscv: sifive: add YAML documentation for the SiFive FU540
Date:   Thu, 11 Apr 2019 01:43:00 -0700
Message-Id: <20190411084304.5072-3-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190411084304.5072-2-paul.walmsley@sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT binding documentation for the SiFive FU540 SoC.  This
SoC is documented at:

    https://static.dev.sifive.com/FU540-C000-v1.0.pdf

Passes dt-doc-validate, as of yaml-bindings commit 4c79d42e9216.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/riscv/sifive.yaml     | 26 +++++++++++++++++++
 MAINTAINERS                                   |  9 +++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive.yaml b/Documentation/devicetree/bindings/riscv/sifive.yaml
new file mode 100644
index 000000000000..d2808d8d79bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive/sifive.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive SoC-based boards
+
+maintainers:
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+
+description:
+  SiFive SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    items:
+      - enum:
+          - sifive,freedom-unleashed-a00-fu540
+          - sifive,freedom-unleashed-a00
+      - const: sifive,fu540-c000
+      - const: sifive,fu540
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3ec37f17f90e..c02bf352a8c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14138,6 +14138,15 @@ S:	Supported
 K:	sifive
 N:	sifive
 
+SIFIVE FU540 SYSTEM-ON-CHIP
+M:	Paul Walmsley <paul.walmsley@sifive.com>
+M:	Palmer Dabbelt <palmer@sifive.com>
+L:	linux-riscv@lists.infradead.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pjw/sifive.git
+S:	Supported
+K:	fu540
+N:	fu540
+
 SILEAD TOUCHSCREEN DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-input@vger.kernel.org
-- 
2.20.1

