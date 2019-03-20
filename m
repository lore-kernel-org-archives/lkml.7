Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F60721850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aqrgRi2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfCTLxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:53:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfCTLxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:53:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so1634357pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImPJCN+vsTzjzXErHaf6oGJCBI+1ar28iCl0HZa9VJQ=;
        b=aqrgRi2XiQUISUC2hN202lYS7gbLH0k54i5sP9YK9JMdormsXoYFybNxHb8Ifb83rW
         iS2V7dlDwSJHCpbAEgTWxyb0+Ib6wEgDsFG3qOgI8Axk3xicYpFdhBpMiIU1CAiuIk2l
         Y4CTb3P+9c7azxNbpLkGt+T/kwmi2LsDUSbPuuhqFm/WqClrxiMhurtj2grqXpnOC9mO
         Dug1pVmIKFGywdy6OhOKwEPXCVauQwK0gbSClY4AlZkT9nf1dVKvWYK618h4MWL3sot8
         Lx2Mly41pDxZ/NDL+BjLn37+wFG8mTYwbRZIXjhNtoLN2aQ907nxOdI57o+iyni0tGeV
         MOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ImPJCN+vsTzjzXErHaf6oGJCBI+1ar28iCl0HZa9VJQ=;
        b=UsGNTTlnwrvm/Oy+9XcoqpG/A03NmR150JGWOR3Rlwr3ITAu8bslfR5Hxo2K1QiiO+
         qR1xrsNnoiZI4FicDaJvq+HbKvzlqW4aZnm6gtr/Zjc7/9ALcMHzr/Iwco63hPD/eVHK
         E2R3hoLD8Ob9/rTle1/PR5xuSPZegDuzMzvnQRwowcHyXyDe9xT+fX9BdgnLOrc3A4Hf
         F4gHjtLjeNIdh7NIOwiJqqwSfSZh0mTmn+5O1oWgguUoQXHy1nr8W0QjLSzn25i25+1N
         rwsZxXWacprnPA6+F5EZt7YhxbNN1ezoK+oKchyjXotoVjLMmnLlBSlTR/uVKO29IME8
         UMDw==
X-Gm-Message-State: APjAAAVCKZQ7Yf75/ajpMvaPBKi0qKkrYfg1WlO0mFOvQTw86o7ERdnI
        Hib1JxPg4pbz6XjXX/8fJWj/ZQ==
X-Google-Smtp-Source: APXvYqylgTysB+3yhU/KJWubLD4VCZXV5AxUqj+FUcQXvuuCDxz3Ibplyw/B3I9277VuVdluFL/mYQ==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr30982481plk.105.1553082822850;
        Wed, 20 Mar 2019 04:53:42 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id u10sm1999435pgr.2.2019.03.20.04.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 04:53:41 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, paul.walmsley@sifive.com
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive EDAC driver and subcomponent
Date:   Wed, 20 Mar 2019 17:22:07 +0530
Message-Id: <1553082728-9232-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT documentation for EDAC driver added.
DT documentation for subcomponent L2 cache controller also added.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/edac/sifive-edac.txt       | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/sifive-edac.txt

diff --git a/Documentation/devicetree/bindings/edac/sifive-edac.txt b/Documentation/devicetree/bindings/edac/sifive-edac.txt
new file mode 100644
index 0000000..c0e3ac7
--- /dev/null
+++ b/Documentation/devicetree/bindings/edac/sifive-edac.txt
@@ -0,0 +1,40 @@
+SiFive ECC Manager
+This driver uses the EDAC framework to implement the SiFive ECC Manager.
+
+Required Properties:
+- compatible : Should be "sifive,ecc-manager"
+- #address-cells: must be 2
+- #size-cells: must be 2
+- ranges : standard definition, should translate from local addresses
+
+Subcomponents:
+
+L2 Cache ECC
+Required Properties:
+- compatible: Should be "sifive,<chip>-ccache" and "sifive,ccache<version>".
+  Supported compatible strings are:
+  "sifive,fu540-c000-ccache" for the SiFive cache controller v0 as integrated
+  onto the SiFive FU540 chip, and "sifive,ccache0" for the SiFive
+  cache controller v0 IP block with no chip integration tweaks.
+  Please refer to sifive-blocks-ip-versioning.txt for details
+- interrupt-parent: Must be core interrupt controller
+- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals
+- reg: Physical base address and size of L2 cache controller registers map
+  A second range can indicate L2 Loosely Integrated Memory
+
+Example:
+
+eccmgr: eccmgr {
+	compatible = "sifive,ecc-manager";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	l2-ecc@2010000 {
+		compatible = "sifive,fu540-c000-ccache", "sifive,ccache0";
+		interrupt-parent = <&plic0>;
+		interrupts = <1 2 3>;
+		reg = <0x0 0x2010000 0x0 0x1000 0x0 0x8000000 0x0 0x2000000>;
+	};
+};
+
-- 
1.9.1

