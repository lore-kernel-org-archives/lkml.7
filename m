Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C2C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90919217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AXO8YCmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDJXFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:05:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61696 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJXFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554937501; x=1586473501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lvVtI67GMwWJ9cv03bHsz1eiddUW1dTASmv1umxV15U=;
  b=AXO8YCmwc7n0WlfaUZxj77/4e1cD+Quf1vokqvOovg5OylXmVxjMFWLo
   c0WE0tI2I8Y/GY7flmHfk700Oit7HNWhl3nZU1J/dHgi7K+mKXHcAkd3y
   2yg1mb+aB8MnMpBjSJRn19+UACkl1XmdGFkmGWjpS2PW988MorfebmYZB
   Wka8E43T1SKuNXqefELA8nprV4ojCTPaQWdpie5pS9u1u3lqxLGpzEr4h
   KNDjEtKs214ORdEknW7lQh56VhGZJwdfBVWbTRPFEBHvNhpWiQRTn6xc/
   +x+Av9TcvB1Eg/+cpfscT0tl4saXYTZcOU4yCSUjSjoy3LSIs9EwR5QqD
   w==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="110531209"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:05:00 +0800
IronPort-SDR: PB/oPCDfWu7Svyvvzm22TyAkcAzJ5sml3wV4P5R3ueSEExiBj/K7+YiY71mtO5eJVB/eXwPpJf
 U87g2I9uDDHyQNsHgtgvItulV6D0KCAJPj7CuIQkEsyltkruQU3F0ZPIxLgkOIJTydnmsCltQp
 N6eFkqfbrzDBeY32eLfiS5W0brgaYCQ2mHkwz6jOYtmMNHjOwdAPIMqGnazebsSNQ+Eaa714YU
 wH/DS1L9tzcUyQmJWF//Q2++gV7kB5COgwpvoAPmzWjX387IPWStsjd761TWKgPnKx96GyH+AR
 XMLLH3vp91vs1137puT70A/E
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:41:53 -0700
IronPort-SDR: R4DRtdzTOmyurz1EQPBXhM/9XFWc6CUxuf9v2Kp3b0td5Fqi+tavjBieLnUnPi83A7TUW9nk13
 EPtUWgMqdDypcMSLBXazloG+RUgzgHu6pTEfGFtQum21oOx0s4MGpFkL368hDcuq7k3c6037Xt
 ixdOeDXxtTYkxtywJEthG4scVYWjjC6xcpDo2biOqG9CK1q37kmmVQfkgAB7XX+kHNXpLZYafa
 Nwsr5DjYuYPISre5O5vChK7pL93OKJl3eyqE6aD92ebSCwcvEg9rj/0Iq9b/8oZqLp7ypwch4F
 ffk=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Apr 2019 16:04:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 2/4] RISC-V: Fix of_get_cpu_node usage
Date:   Wed, 10 Apr 2019 16:04:41 -0700
Message-Id: <20190410230443.15729-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410230443.15729-1-atish.patra@wdc.com>
References: <20190410230443.15729-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_cpu_node expects a logical cpu id not a hartid.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index cf2fca12414a..c8d2a3223099 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -136,8 +136,7 @@ static void c_stop(struct seq_file *m, void *v)
 static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(cpuid_to_hartid_map(cpu_id),
-						   NULL);
+	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
 	const char *compat, *isa, *mmu;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
-- 
2.21.0

