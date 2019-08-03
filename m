Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCCC32751
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D05C2183F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z1iNQ1GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfHCE13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 00:27:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20709 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfHCE1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 00:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564806446; x=1596342446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x5a25h+13vDU6pS3SVLBNKrcj2J81NhRyjpTNiIo8ng=;
  b=Z1iNQ1GRBHUveyxn3fscSOvy/c9+fj5LTBXut62jdRg/Q9cvXJW6BMmd
   qZ7RGoPXqnGf9SZow+KKZZCdWd5Flw1lGWB/HbimjTSQkK6/UwBmvhaTG
   skTrFsBqTuIrB3YhJZygrAz0dR3RhDX7JcP/au1xhTQ59tA4t4+a9dj8h
   JCes1YD+EBWyEQ7epc1skOp+dM5bvprNCtYXYyKHm5kaNKZNEoj4xAocb
   3bLu0Hb9qFKxIp/QsBcYRxC0joWbtiGmtTIH8milxrY/HothOrQmwdBhd
   Drbjc22NXrsxeMWO1tvExIl96KnkC0KQFQW57LM6Fkm+9mFdCMpflMBp+
   A==;
IronPort-SDR: oJ7hs1j2BzuOLxwr/WK2eK4IdV45KJ1qkCKpXsNtcrEi/3UgnGJLzT22Fj5f1GZ9oDsEXdXh01
 lXryHPvQio7M6KC3llH8UXOwlFz52gi0Mmk8bOhz4ba7zIYY56Cxs7GcLK7hSuFm1H58bkeyLT
 QdlHTlhg1Tzx7827ik3kl5mEtmMlGe+yS2jqBmtdy6ut65CU83Ckx12xVOrj/qs2o0A4qxd+gi
 GBQC/u3htM3r0OJ8xQlfMIET20boxYAeRr338fmwk0/azGA/iEk0yHvWEysz2e5mBs2gdjdkzi
 uE8=
X-IronPort-AV: E=Sophos;i="5.64,340,1559491200"; 
   d="scan'208";a="114857040"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2019 12:27:25 +0800
IronPort-SDR: V7ndhCnBLZHve0QUDUv475FQJyE75JL/PnFEj3vpvMCeaM/Pdb30/WB/Ei+Nr4REOYhMTeT5iN
 DGxOwl8i7Y4c+bHNZj0H/X5akHjMzKuM+Hvgy7zbPe93bhDDw1a7m2VFy+eOZm8qSNWu+bUaHz
 Mo+uPIUeaKsm6gXoL92kTseChAgKL0WTJa2YEuXYGlIh+f+FPRkFdHVowSN71nNKG3nlFVKK1U
 lvqHF1fk9ZucPMDXkNwcMm2v402zbpi+n1FWvDSFjHVHY3salgmWZc2724C0TGbzDc+buSWOWe
 zEKS+q72WwgfJP9csUloSMiv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 21:25:20 -0700
IronPort-SDR: 0v4e9VHYa72MRX66Fef5d0jSyMrlTHPpXWIRs86/yPfZHpcHR22X3GhlOA2OzfKa7o4apHV5GZ
 wh6i7v062Z6qNPcbSF1wz/WFVnSyWd1y/Q44BJ+ADtYivKFhIYgxm3TIsG6y+THA4P/gMiBOYu
 K+Nkh7TiXbvHW72yXTZfEJ98o1xSCZgB3eQfLAinXTS+0JcWtWvOAN3XJNO/jvaJEp6sL6In1d
 w+BHo1w2MxlqO8tJt1tfwagiT6Yq1HJLSgswIx4QTMOPB3qY7ZXiz8tzSmzG1KjjkVUImkeob8
 +3A=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Aug 2019 21:27:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 4/4] dt-bindings: Update the riscv,isa string description
Date:   Fri,  2 Aug 2019 21:27:23 -0700
Message-Id: <20190803042723.7163-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803042723.7163-1-atish.patra@wdc.com>
References: <20190803042723.7163-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the RISC-V specification states that ISA description strings are
case-insensitive, there's no functional difference between mixed-case,
upper-case, and lower-case ISA strings. Thus, to simplify parsing,
specify that the letters present in "riscv,isa" must be all lowercase.

Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index c899111aa5e3..9d3fe6aada2b 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -50,6 +50,10 @@ properties:
       User-Level ISA document, available from
       https://riscv.org/specifications/
 
+      While the isa strings in ISA specification are case
+      insensitive, letters in the riscv,isa string must be all
+      lowercase to simplify parsing.
+
   timebase-frequency:
     type: integer
     minimum: 1
-- 
2.21.0

