Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A075920850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 23:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YVNM7/Wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDJXFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:05:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61696 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJXFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 19:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554937501; x=1586473501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/x+jL+kPuh7mg6eMR2Nwf6ik4gO5nqwDyzrx7ofC4os=;
  b=YVNM7/WozhorDuY1hXz2MSDRs5tsvjWYEx5nmCcW79kcVMxEFqKlGzbn
   aqES9Y6nCLn48u6M74yJbkVIHoLru1RCdSSPiIo7qL5ao3ZGi1xU2gpaS
   laoQoJgGC4o1m1qcn7nMgziTAyyEHtHrrk8oQVgVXZQHfq5xP+8ESkS2S
   nqYqQpD6QLMAMLswFWG7Vi5aONONIttqEpCOrk3xrU7qbtGwDrpLetkFe
   UxvuS1LFqab/FhW2aeE9nLfJj61BxcHm1na5hzVRrToi0rirduz+14kkP
   eNmfvFEcJXNyP6aW0+kYgruTrAcBscv2KWiIRWCVSAFoP6/hLRusXOV37
   w==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; 
   d="scan'208";a="110531206"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:05:00 +0800
IronPort-SDR: TGn41lHAy93Pk/h1qH/PI/EaVhW6Jw/UbmsYeyJ+zdK2xlaBQd+hLxQxJ0ygjla/z9K/tKoAod
 +TERW/K0jxGEhqFVSIClQs1Nr0LDWrO6OigvexZMcv9dwqsEryZ0DqM7skgHmnP+vA5rq+yI1l
 Ftc7TmUlVX4+WUoLiSzV4iBGPQXWFr/wgs+nLlHL3MP09l1Jcbwq9/giDk6wjLNWKJfcebeONI
 ov8+OR2Xdo+CUzWZvRh/nO54UWnq8dhf/jWgEuD72uG24qTNri0JiNM8LOwKJGvNuBAs4eRGa+
 WlYhAYsU/d9eGp1rR0jub/p2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 10 Apr 2019 15:41:52 -0700
IronPort-SDR: ZsHMd7rSmer4yMsGq+pWheMFS8QBalwNLIJKk+UiMBz0JIeI6qp4vryMi/b0aLq4o9VhbQH/NF
 Wv/a8KEdXuXeOc33WEpE7NhCCsufSFng2oK7YuCSzBJHUIigAwfSwFqLAG+g9yRiMEOmCKzU3H
 Y8puD+pbOuSRbipKi0yZONgdepAZX5HDgeIbIQoTDEGQ0modJhBreYVdlW3rxYW9AvEw7XFkHZ
 d5bqhkXwclCMvRczdB3lhF5Gao0dWphTqgSbqaAjFqbDPpElq9QtpbhHOPQwDVQATPnjAMySjI
 lAA=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Apr 2019 16:04:58 -0700
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
Subject: [PATCH v2 1/4] RISC-V: Add RISC-V specific arch_match_cpu_phys_id
Date:   Wed, 10 Apr 2019 16:04:40 -0700
Message-Id: <20190410230443.15729-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410230443.15729-1-atish.patra@wdc.com>
References: <20190410230443.15729-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OF/DT core has a hook for architecture specific logical cpuid to hartid
mapping. By implementing this, we can pass the logical cpu id to cpu
node parsing functions.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 0c41d07ec281..94db72662f60 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -70,6 +70,11 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
 	for_each_cpu(cpu, in)
 		cpumask_set_cpu(cpuid_to_hartid_map(cpu), out);
 }
+
+bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
+{
+	return phys_id == cpuid_to_hartid_map(cpu);
+}
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
-- 
2.21.0

