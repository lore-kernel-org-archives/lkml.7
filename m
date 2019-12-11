Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1336FC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE42E206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 05:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="abIzf/VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLKFrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 00:47:33 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:23023 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 00:47:33 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xBB5jdVa019523;
        Wed, 11 Dec 2019 14:45:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xBB5jdVa019523
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576043141;
        bh=UxDx8RnuQhkTN8+zyVJvCjCQ3hY035WRmN5rhX+qiCg=;
        h=From:To:Cc:Subject:Date:From;
        b=abIzf/VHWf80xkCNM9Nq9l7bCTZhTmzvAGgpyGNxWkKxeNhSUY0HzAoJS1K5AHGZx
         qcghRfQPNCejAohtVrKvGe/1q2hkoB7P1vRWONc2sa3mkdinujSyiHWkpZaoDcHVT2
         zLPKf8piCsaFj9Z/2bobrErHtgQrZf7eTZhphVaG76AjykCd1sXuqDV4q+Y4tejqhZ
         wZfufdLfCb6ZEkfRpHSeyvPdwg4bWncJdnoa0uyZE0hiubTf/osHL2jjna/WnDaNk1
         nEwqKSCGynuEPXml7xxwpm/HF52oewbK7/qwron40H4rYnyHkUjYBlZuDcRXj5UonQ
         V6RaKNL1cLNvQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-binding: mtd: denali_dt: document reset property
Date:   Wed, 11 Dec 2019 14:45:37 +0900
Message-Id: <20191211054538.8283-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Denali NAND Flash Memory Controller User's Guide,
this IP has two reset signals.

  rst_n:     reset most of FFs in the controller core
  reg_rst_n: reset all FFs in the register interface, and in the
             initialization sequencer

This commit specifies those reset signals.

It is possible to control them separately from the IP point of view
although they might be often tied up together in actual SoC integration.

At least for the upstream platforms, Altera/Intel SOCFPGA and Socionext
UniPhier, the reset controller seems to provide only 1-bit control for
the NAND controller. If it is the case, the resets property should
reference to the same phandles for "nand" and "reg" resets, like this:

    resets = <&nand_rst>, <&nand_rst>;
    reset-names = "nand", "reg";

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Split into two patches

 Documentation/devicetree/bindings/mtd/denali-nand.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt b/Documentation/devicetree/bindings/mtd/denali-nand.txt
index b32aed1db46d..98916a84bbf6 100644
--- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
@@ -14,6 +14,11 @@ Required properties:
     interface clock, and the ECC circuit clock.
   - clock-names: should contain "nand", "nand_x", "ecc"
 
+Optional properties:
+  - resets: may contain phandles to the controller core reset, the register
+    reset
+  - reset-names: may contain "nand", "reg"
+
 Sub-nodes:
   Sub-nodes represent available NAND chips.
 
@@ -46,6 +51,8 @@ nand: nand@ff900000 {
 	reg-names = "nand_data", "denali_reg";
 	clocks = <&nand_clk>, <&nand_x_clk>, <&nand_ecc_clk>;
 	clock-names = "nand", "nand_x", "ecc";
+	resets = <&nand_rst>, <&nand_reg_rst>;
+	reset-names = "nand", "reg";
 	interrupts = <0 144 4>;
 
 	nand@0 {
-- 
2.17.1

