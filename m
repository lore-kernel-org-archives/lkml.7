Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEBAC32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141D72171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X70jGw0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfHAA6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:58:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61763 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHAA6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564621120; x=1596157120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w14oJ81u6w2W34wdULaaio4UuiCV/eOoDOsEOvwCQng=;
  b=X70jGw0e7BUwXTgQeLclIu2bUYDHzsGBtdEQsZhqxNOZVPGD7L5t8IV4
   duXVsPd6Rvey0JXOpuUpvHIqagf7qN7b+jr+JmyoAqKrWQcARxllX5Sx0
   og6Knkmh52We9TeZxnugMI0dtUBDPslNBJ+N+7jsIn8neyFfjcvExwm+N
   MLdBqkuMr/LrqMkAoFkcv1zftHOWr5rOAOnb88C2CQUYzTJ9ZZeXP+0+D
   Hk/U135tyTzYWBVpfI4U55WP7EmnYNdIb21wpxQlI/oL1UuVq6gDJ80Ig
   K3PE6TKVi7P/R9iUIWc1+NX4KgDTtb6CTxYDtDQO1m+1o43xiU8l4wvmw
   Q==;
IronPort-SDR: PAOHi5BSQjioLFhZoJ4A3dUNFhaIGdbQlxMAtL653cGMDltmeVV3ktMOUREaAVsCACjELllvlG
 gZ560DnyBbXNSKMN/68rfHNcvy63S4iNtwnGWLkGO9kmgU5xoW+rKNUgvAaEFFWqqyXWk0b9f7
 /KRs3vBceyXxFGws2GHMS1NQpJKfPuvRXPXZvG0lFSFmXr35MNpkh94ifPo2pSitVLcYj2xgpb
 Za0vQ+Zij8KjdDHS3xGNUs4ZjUnJCQWjA7002Y9E/UEfcnYSste+RXdxtq4PqmDHHpIvjEsd3r
 rBc=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116247208"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 08:58:39 +0800
IronPort-SDR: ljy5Ka0KsH7PW3zJnI1BN6OlawD+qWF5rTkIumRoIE/pxaf7L6Cs4bhygDtcktot4CJxn3MwAs
 QSKIZ2Kn7bgtbec7dRWta/U9ZyWd4VM0v8ARMal4qK2nifVgAi7yOGdtxIPvyyIFiD5PXJT5od
 /VxNIzk6imLQkjtfJAwSLLonbG+96bFG5iJbjhSVFH3zNXR/8m//fQsk8msVVDhEdtnDj+Mov1
 WkGQpqLGmwq4k/CH9QDN8PzuSNL+Q08+C0+l3xJeF6BpsrdeOq9B8UGlzWSqQSFn72cTCow8je
 edwMhQgCPH6tlEyq81K02iHh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 17:56:38 -0700
IronPort-SDR: D1VyBwHI3DUdkTTZUMWdQnpNnOzsGERZEN5QbIDf+Y89fdGaTxP9sKHHLk1m6KTrqI3jYvCOC3
 bCkxZlsYMtuY6KRf+3Yqfny58of2tXGpv+1nBcYrz2dg+559EPzcAiGE029FLbqjc1NIejCJWs
 TeyPbP/s0dajWY0cJv8Dobe6WiCaS1Pve9JQmZViFJAvaY30yPpSUASBWJFBA8cL7WEst0AuXj
 JSmO9A1YKvlFvfZVhpX1SfSM5R0qDm1UmWFjeLdQmakFKkFePnHvub5SYqi80wMJsNX0EgXmM2
 +VE=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2019 17:58:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, Enrico Weigelt <info@metux.net>,
        Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 1/5] RISC-V: Remove per cpu clocksource
Date:   Wed, 31 Jul 2019 17:58:39 -0700
Message-Id: <20190801005843.10343-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801005843.10343-1-atish.patra@wdc.com>
References: <20190801005843.10343-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one clocksource in RISC-V. The boot cpu initializes
that clocksource. No need to keep a percpu data structure.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/clocksource/timer-riscv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 5e6038fbf115..09e031176bc6 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -55,7 +55,7 @@ static u64 riscv_sched_clock(void)
 	return get_cycles64();
 }
 
-static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
+static struct clocksource riscv_clocksource = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
 	.mask		= CLOCKSOURCE_MASK(64),
@@ -92,7 +92,6 @@ void riscv_timer_interrupt(void)
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
-	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
 	if (hartid < 0) {
@@ -112,8 +111,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
 	       __func__, cpuid, hartid);
-	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	error = clocksource_register_hz(cs, riscv_timebase);
+	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
 		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
 		       error, cpuid);
-- 
2.21.0

