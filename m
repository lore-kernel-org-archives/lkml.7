Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C23C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0976F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CigVOVk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfFXWjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:39:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55769 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfFXWjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561415945; x=1592951945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=amaL0k2oUBluhz5amtgozZ38Lqs3Jm8acq5qCLADl/0=;
  b=CigVOVk5rNeTLtOrVr37e4eIpG2j8X2rjPTsuQfS6E6dswCG7E8zNHT+
   oHVGB5xAFcH2sgg+od0AI/BFmCCOtJWJ4srw1BJOuSMePrc0YqN3wdncd
   ijenbyMMIov7wfwDWGuN8t9+QPdZN5nl2fLKaDoT+iUKIaDjl21tOZwcX
   LNcMbQ3ug8DohKPK7K4bcfcS1RwAUYTmN2nWGTin2TRmdmE3/jp6IvQOE
   Kemv+FByEk/ceKDqf0Wv4LlYd1XNF0aLGWE35sKpoiIa1c+DsjcGYfIwT
   IdBZ7MhJ+xPLhuN6nyKdpxqXzA3z54ehv2pk52Gvg1+JjwIUQL7ID3uJ0
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; 
   d="scan'208";a="112639901"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 06:38:52 +0800
IronPort-SDR: hOZJrM82do9XHd01VWm9Rd3nqlX57UDL02fa0kh1lfjiUmoZFXXn8PNuHX6VcIXjtPDy3bjRWV
 DKemYyP4m/+3OyNzu1hY7t2nlgJ+Hv0fKu+XZ2MQ8U0JZGfRPz72wQmAW/ZW16L16vPkBIf1aC
 UiK8Ydfp29+5Ay1qblnjGpVzmR64o54hkXO9mZwlM7srsVWSZktrNK1gZgfSYyYWsy6B1f51Sg
 QxVmvvFYylZfOxZe/dmVgyntexUgVDOudCHjtalNtyjwV56ff7y8Y084Ki8n2aE8oysiAJcVru
 5QZ8XAryEr/Avm5ck4ZE+ly3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 15:38:10 -0700
IronPort-SDR: jYLXl3hSQmhk2KvSiMaIW/VEw3gCbmz1B8E1cNVXFGHRCN1oqPhMfM4xfeynB4tzA9GtbHJI5e
 hg3N+OzdzF3tW2Yh3CsZMkaGDrSj46aRvbxxkdVXy0j2Jz3JPYgaWpldwq5vg1qi/DvOAcOkn+
 sGXiaWy0cdep5J1lVBRrLDaJKF3vWuklHa1SG/KdeGgSxExWduUNMk8sGlTJpMBKY6n73vj8jx
 LAiSMnIrzgiB67YyIjXq+4OyTDgfKSsGQqTtr0e/VBt/69hSjueSOlDJsw9pwNZ0jpb7zgFKfg
 /Eo=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 15:38:49 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] riscv: Add cpu topology DT entry.
Date:   Mon, 24 Jun 2019 15:38:19 -0700
Message-Id: <20190624223819.14320-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no CPU topology defined for RISC-V.
The following series adds topology support in RISC-V.

http://lists.infradead.org/pipermail/linux-riscv/2019-June/005072.html

Add a DT node for unleashed that describes the CPU topology
present in HiFive Unleashed.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 83f40b00ab63..907564f4f07a 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -22,6 +22,24 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		timebase-frequency = <1000000>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu1>;
+				};
+				core1 {
+					cpu = <&cpu2>;
+				};
+				core2 {
+					cpu = <&cpu3>;
+				};
+				core3 {
+					cpu = <&cpu4>;
+				};
+			};
+		};
+
 		cpu0: cpu@0 {
 			compatible = "sifive,e51", "sifive,rocket0", "riscv";
 			device_type = "cpu";
-- 
2.21.0

