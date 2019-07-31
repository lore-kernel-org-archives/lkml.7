Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F6C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753BC206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aNxlkGWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfGaBYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:24:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64333 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfGaBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564536279; x=1596072279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmXuHR7SC+aN09FeHOdioG1YLL/XU2JJ+5WuI+zCHk8=;
  b=aNxlkGWgPB8950NptULFs+WnfJCe5H/bmrSwPHb188VlKR3uDYZeGMiK
   MZHWh9YcO6GheyGgneBbhVniPxXSChxHlXL5E+jn+/2PduaiuY6gWLHEM
   u+Qk30siRbxBTIx4JFX5VRPQZ4ER7I9H+u1uRBlLgMJAtTwCIzhOxq0G8
   0RCL42a3nxeywnfps6mcKzYDoc5mzgtnHFbhw2cSOZUuKdVdZlp9QNVjQ
   fPhXKUz9zhpHhtMaySTxFRVUVYGLptFCp4iK9b+DypB8b92IwwAwGP5mq
   mxkmgXNGsLXwP9dYd5rGhW4xPRQ1Fijy1N2mmj4xP/n3317hL0721UxWd
   A==;
IronPort-SDR: KQ4Us2XGzECFelMTW8awu4siqN+LcNy41GzNWEnOXqpChGNJNaqM9wSgWWvszVSC3vOtH0u3Tc
 /zPhoB7r1Lhw6XB8WGTZekd+lyI2pdH9SQcOLcKCeefEupagcVGnr5JetGXQtEqLDlLMFMyxzs
 1+cz2iHD+QzvgCPDsHRhZZfr+Qnc7JTApEyjiqbrteI7+xUxUUXcTYgWTrT5J8GF5wk6rigEKR
 s3C29BgG4VlzZP5N7/Iw5JmVf3G/1uNopFB+q7FKGQmacO1lsumjmqjAapnDavZ0ZgD0Tzy54J
 4Xs=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="115555813"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 09:24:38 +0800
IronPort-SDR: 3e2u3DSqQSOJ64Asq4RaOOC4SklS2c005bEeibpmTQoSvMLNmVx8cON4uu2U1Ob42NYb1a+d/T
 wwlDQpnYzAflJvWvX4A+sUjTmu4yd0U2kA45P4+wKCWDXOIAop49GS/GVDR3UCUz/8J7NZDIQW
 vz8ybAobFZEHtVqqQkaRflzjbCt97gS2EZNW7w9Wc9b7BltBY8ekPvSAKPRv5Oag8DVskT32CG
 u1Aw8g3hWc2P6g4YvI2OFGKsnj5H9dnyxWWXYBsdekGgvAjNd2rqf88uWz543zjwwjddNY2pqA
 4iPQ+GI8UXeS8AT2TtKiUETn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 18:22:39 -0700
IronPort-SDR: 54+vnEozrIPP/nGlxcV+NuLLZU4AoXI0bIuVPynL3QuKqnp94GO5rpklzJg4DTr8I6zGhqFLWA
 s1C7Da89ocDa2IAbOOQ3jgYUnykvwd3LzNd0V+BkgTZzUWpTEMqbUHLKpBUCxiib818L/vev0j
 wbVbx4ymaAW+A5LC0e/aj0ba/NOFHW84E9vjETkBd5411ZeP8Yiiw3CeeF8i29a9ZQVFwodlz/
 +K0/YuGGe4kngYCmTUa2VRURvS1FWjQoJ3ZcmhQl0Gq6bhwAh2v0ypiE6FOwm7P+ZdODR6Zyx3
 uAE=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 18:24:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 5/5] dt-bindings: Update the isa string description
Date:   Tue, 30 Jul 2019 18:24:18 -0700
Message-Id: <20190731012418.24565-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731012418.24565-1-atish.patra@wdc.com>
References: <20190731012418.24565-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The yaml documentation description of isa strings section doesn't
specify anything about the case sensitiveness of the isa strings.
The RISC-V specification clearly specifies it to be case insensitive.
However, Linux kernel supports only lower case isa strings.

Update the yaml documentation accordingly to avoid any confusion.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c899111aa5e3..e22a2b7ebafa 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -46,10 +46,14 @@ properties:
           - rv64imafdc
     description:
       Identifies the specific RISC-V instruction set architecture
-      supported by the hart.  These are documented in the RISC-V
+      supported by the hart. These are documented in the RISC-V
       User-Level ISA document, available from
       https://riscv.org/specifications/
 
+      Linux kernel only supports lower case isa strings. Thus,
+      isa strings must be specified in lower case in device tree
+      as well.
+
   timebase-frequency:
     type: integer
     minimum: 1
-- 
2.21.0

