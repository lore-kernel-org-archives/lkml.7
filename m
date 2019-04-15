Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD9EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20DE20645
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ey/A3VHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfDOLlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:41:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43882 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfDOLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:41:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so8440813pgu.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4x3PZ0m4B0BDc7pgveF+ss1l/Njj30x4kKCYTwJnwrE=;
        b=ey/A3VHOwfSDofaeIV2lHRKJb5sEANApgl6wL6VPhkVZbyQcd8pcu/1GYYKC0iGTTy
         /CwZt9tlv4hIIz7j4z+Lp1m/dyo2OrsBJ/h2sGyw0zvlQZBcBjNJbbVaKWnyLhso4kKU
         1WZljXYBVzQFJPsLMXwdnOEf3RGZd3U7gdovghAsEoAynTccPBcGN1kIUDJSoOo3pqob
         mEMEEwE+iekK603dYyBNYLdHShMM+Wiq5/Vi34OPxYkzUqlHdkm7Dt3BwiVcZoc5lEar
         4fY2A4e68dXKW4rNUiPgwx8VQRQw669JmsYYnp9WtEtX+aEIRvKNVaGSwmNDwKxQFLrO
         6fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4x3PZ0m4B0BDc7pgveF+ss1l/Njj30x4kKCYTwJnwrE=;
        b=KJN+yekK8emHmYDtEgXCsmJerbT7sWHaa/Xo31sWs5sI7ywHNCfK48CLTb7IVopeb0
         ZDIBejMRyqt26FTLOTiGReo7vS9uBJDAzyllFP5aW4aFTMjy1sfOr6UIETU7OB+U4ydU
         4x+7g4ngJDniIk4xqm6DqKN9BtEix98rKhvoQTREnxzGkcTe0EglW6P1FM2vvlk+oyuL
         LDtWjkI0NSLSIfDg/qmH8BmggeRgnEVl98u4AVk+qOrcI5P3opvtYHgpIDMu6THe+3Xj
         fTZaRQhvZ6HyF8XHuJAoUEU/tIVndWGCvfFr15pDWS2aY0K9svn7M6lH36fwBFlL2ybm
         vgKw==
X-Gm-Message-State: APjAAAWUmFJZU0ks8phnaYYOtV55+ne02CyxcUjpvCyPP8gelxpL7HGy
        45qIhibpD5F95woKrBMgZlRSGA==
X-Google-Smtp-Source: APXvYqyyXuSMV7qYfPCLMYOL8Y/aU7ButgBj5OSBrMwc9kzENvL5nZP2gcOIvgW4uhxOpiyIzvfgNg==
X-Received: by 2002:a63:c046:: with SMTP id z6mr65559715pgi.81.1555328495776;
        Mon, 15 Apr 2019 04:41:35 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l4sm32317273pgh.17.2019.04.15.04.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 04:41:35 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/3] RISC-V: Add DT documentation for SiFive L2 Cache Controller
Date:   Mon, 15 Apr 2019 17:10:41 +0530
Message-Id: <1555328443-30874-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555328443-30874-1-git-send-email-yash.shah@sifive.com>
References: <1555328443-30874-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree bindings for SiFive FU540 L2 cache controller
driver

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
new file mode 100644
index 0000000..15132e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
@@ -0,0 +1,53 @@
+SiFive L2 Cache Controller
+--------------------------
+The SiFive Level 2 Cache Controller is used to provide access to fast copies
+of memory for masters in a Core Complex. The Level 2 Cache Controller also
+acts as directory-based coherency manager.
+
+Required Properties:
+--------------------
+- compatible: Should be "sifive,fu540-c000-ccache"
+
+- cache-block-size: Specifies the block size in bytes of the cache
+
+- cache-level: Should be set to 2 for a level 2 cache
+
+- cache-sets: Specifies the number of associativity sets of the cache
+
+- cache-size: Specifies the size in bytes of the cache
+
+- cache-unified: Specifies the cache is a unified cache
+
+- interrupt-parent: Must be core interrupt controller
+
+- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
+
+- reg: Physical base address and size of L2 cache controller registers map
+
+- reg-names: Should be "control"
+
+Optional Properties:
+--------------------
+- next-level-cache: phandle to the next level cache if present.
+
+- memory-region: reference to the reserved-memory for the L2 Loosely Integrated
+  Memory region. The reserved memory node should be defined as per the bindings
+  in reserved-memory.txt
+
+
+Example:
+
+	cache-controller@2010000 {
+		compatible = "sifive,fu540-c000-ccache";
+		cache-block-size = <0x40>;
+		cache-level = <0x2>;
+		cache-sets = <0x400>;
+		cache-size = <0x100000>;
+		cache-unified;
+		interrupt-parent = <&plic0>;
+		interrupts = <1 2 3>;
+		reg = <0x0 0x2010000 0x0 0x1000>;
+		reg-names = "control";
+		next-level-cache = <&L25 &L40 &L36>;
+		memory-region = <&l2_lim>;
+	};
-- 
1.9.1

