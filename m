Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B5C433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766A3206C1
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 04:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bqfu6Aak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfHCE1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 00:27:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20709 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfHCE1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 00:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564806445; x=1596342445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w14oJ81u6w2W34wdULaaio4UuiCV/eOoDOsEOvwCQng=;
  b=bqfu6Aakj1HaXXLwELvcqGgCFvCpdcZly8H9kONURXRhEu9G1gsxJL+h
   Z7H/3q9RnPR2/23JmD8vTbrohQcyfTl0ALPPM9gYE4CDEFD8jXiRyWEUf
   PWhLo2ixxLQ6vrht3R2kPqrlNCZG2eqG0D3sYiV/dC0uVwKPJ2LLN2XTI
   /fo4ZCWFhbSf73z5jWMLai/m1RUaMGsMrThcC0Xdj10TLrxfg3IkuiLfg
   VFD+7E3CIOXqDdQlMaS5thg/fnQ8a5zsS3rx2799iaUGGypaS+J57rQ0y
   JKDnJnbJm5SqT5I8iq6cYz1SBfxNtMHnEa46GiuPNzeMBIGOchKO4qBFU
   g==;
IronPort-SDR: hz+0ko6rLnCqJoQeldSLAlfP8Tx6fD4Y/vNx1lBxsYaKpfvMhyA0MJklsKqrTW94bvojUY3Uql
 W37hVH7u4hEwSMZfwdaIpl2Tjt4czaGu2jHXyJyjv3GG/Y2rBSy89qt04/eFAqwO29fueA1Xw5
 3LOf29KQG8x1XuXFX+4j/VPkdqwb1u+Vp511ATYQqvbEXBcrSK654uUkWuXSnhJA9sk9/XRuY6
 gkhgolV5i6xczVVTwVBMvTR6slfUka8y+hijf0VRLgg3SGUEF9RzYWjW51lJMkrJJzq3HGocEy
 jEs=
X-IronPort-AV: E=Sophos;i="5.64,340,1559491200"; 
   d="scan'208";a="114857030"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2019 12:27:24 +0800
IronPort-SDR: iGs7c2k5z9Xlm0S2HI6if3JWKqGdrQt7LBHXSlxtjXxGkrQfSDryXeHlVBf8tLRplkd8hwr5pd
 lAjWS+E+0DhqZrSFZtJmqUB2YmwIcFNMIQOTvAhFzBj9Loiu95jwnVPIwQaUXyVAJWj3cBjhIs
 tHck9VpOtxEwCYrFpmNYqIpXjiL3JVH6PWZoWPn1pH7xu6az3VlSa7EOm3yWGOjbrz+TOOUfbt
 0R6vRXoCY6gAkud3F1//WQI5udWCQG4cuZzHwuCzUW/P1PH+BPav+jDcDcoSFzXzh8QsngmmVi
 l/O7D3McF+K9J6ZuM1w+ukzi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2019 21:25:19 -0700
IronPort-SDR: EV3f/F8qxlIo9igWSYgtFHn6XxX3ySMuuexxzaM4Yu0/BwkXYIf0EXQa8FJRTxMZ69F3KbJ2G5
 CMXdctZnNrCIGAk1KMNOfxGra4Hg7xLqElkQLojhEil4USPW8gvAKAqypu3gvmQz3Owq4v4YB/
 9JFJqui0O20wOwyVGJEY2SX1LA2DqI7wB/rNrs49TlslpT6qzjwAoek7bgLHYSq+2sI1qTkAvM
 l/9gSfipVdVCVkLcNjLVVHF9TGlbKqwJJO6RPYxguiovwlAnqfJt837WDOOVu3ncs62uVG0qpa
 JbI=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Aug 2019 21:27:25 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 1/4] RISC-V: Remove per cpu clocksource
Date:   Fri,  2 Aug 2019 21:27:20 -0700
Message-Id: <20190803042723.7163-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190803042723.7163-1-atish.patra@wdc.com>
References: <20190803042723.7163-1-atish.patra@wdc.com>
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

