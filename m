Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC87FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79602175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oOTPxjsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfCSWUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6004 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfCSWUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553034043; x=1584570043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JHyZqNF9UsH7+ClJFH5uWEO14tdxMwlKOp4HiqDbalc=;
  b=oOTPxjsuWeZ0SrPT2DwVs+biy0zrUVAf8208LMIqM/2l54p+UtgoA/C3
   lu1CV0RgSporZ0hCVDiK/v2jIspmJej2t5tYeSgD6YvQjb9YevYwNiKER
   kxW9gzRiYZF8WREjdbjSbtxKnx0DLirIHPG0BUHzbBcOzcRNJCWdiuEbb
   h7Wa0/QfM4UPM0/MKqNHiauPuGUg0DuIIAqLcmx7WJ4hXZHFGA9ak+849
   w6NIKeeT/qK5wPCpj5XvM7wgz+RMR2ybVS7OartKqfHDUAv+6jGbmJmol
   UdQDRZ3LZhECZYO1MQpesKfat0yxyGpdM4spXw0J/OMJGlb0Aqotf3K7n
   A==;
X-IronPort-AV: E=Sophos;i="5.60,246,1549900800"; 
   d="scan'208";a="105523537"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2019 06:20:43 +0800
IronPort-SDR: psqnDJD2qlvku8FdKa/30sWoObUwOHnqxjySRMDvdimSGHpypHRVfOKD551gkXukVUqxriVGx7
 3VZZRu8wsL8IqcHOEOOKanbEgLh8hg5AEfoXWB4fHJwq1h8cMhp5K3mv+ryZYuEKWk4dJRpfz0
 9k9deCuoQTkiAUsjo/9xBFAhIrP4wFGWBAyTqq0kBF9iteqqY/zYvSp5ihji60tLnfA7CTTKDj
 X01/6EBsVpaLZsN4/vEi1lIUXdnkQr4AzxnziL2zikhxI/dVx6dZxGJfZ1MdtliOMjPPFKUREi
 nOnA+EHPzuPFxFcTR6bEX8oM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 19 Mar 2019 14:58:20 -0700
IronPort-SDR: S/UjAAnMnYpTs6jw+2waR06og3vocMTSGYhml767rgnlKG6Me1JB88TbVoMAk17uXmElwqXLaA
 gI4TXxJd1JDa65Y2Bq/3HjT2BiVEMRBwAWuhKY0hh9C0dQM75Fy4eAPBB42p1sm14vdcOJSIp6
 cH8FQfT41ZIQw3GTWW+6CRUmPTyjza1E2p85LNIeZy/EqtO82bpQv5Wk1FJKFJ13KgivPq1SDq
 QdsxQB5aMRkfQ43vPujqsRVFIPbwqmIGRza9NhQTmbO2aFNY3wosWgiWP1AwcUAmYMUxrQf5zP
 sSo=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Mar 2019 15:20:43 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [v1 PATCH 2/4] RISC-V: Fix of_get_cpu_node usage
Date:   Tue, 19 Mar 2019 15:20:26 -0700
Message-Id: <20190319222028.4293-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319222028.4293-1-atish.patra@wdc.com>
References: <20190319222028.4293-1-atish.patra@wdc.com>
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
index cf2fca12..c8d2a322 100644
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

