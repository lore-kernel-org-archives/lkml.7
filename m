Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587B9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FB822BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hd0hT81s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfGZTqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:46:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17125 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGZTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564170408; x=1595706408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w14oJ81u6w2W34wdULaaio4UuiCV/eOoDOsEOvwCQng=;
  b=Hd0hT81sq5ubqvd8vz4lUNBGO9PdXbZC8Z+uAcmrzID0vSTuEY9RUdfO
   v1Tg6N2Btkk+YPqUBxUg0YL7L/bLCUK8eSDaZOarbkiVoiL5HLWQhLCkD
   VyuQuWcOOWIKqvnW/NjU/Ob7quvORN/HRWcryHaktPtvJFUzXWFtiZfcY
   hB+rz29GMzqs2Uz+DAi70wu/f7q+y0smVtG6GplkTHj8k3AZxh4Klh9GA
   BaVyaJ2xMzJTebEj7DjJE0Bw6UntNFLey577ryl7vu4F3FG40chD8l6YY
   NttcXZxK91XctbXNP5sD/iJDVhSqnam1uDHhVUh60i1RVpml5CccdPyOD
   w==;
IronPort-SDR: lmDKtt2MwWZh94R2HA615euf17hofFE4ZAWqC4afs0CvOIJotu4WPXWfPt+eL0iDWKKeVJOWcZ
 iR/Im7arInbwxW4qE0cWgi9HCIRUedBp/54ncxJwc6fRL9aEvQLO8AjUimj/OYUpZgXbvxN5Lg
 jQKGN22xwJ4TJ6EFsetTx0xxQx80rMqIbW4LarFuZug46IubgKHgkS3R197qQBUlJNbwRb9DcK
 H5td+Aq+6km0qx09Il7RFrKlOOxuWQE7WwS8ULZlwi4O/qz59WgAu7dQ/5DocEYbJu1GqeAu97
 Prs=
X-IronPort-AV: E=Sophos;i="5.64,312,1559491200"; 
   d="scan'208";a="114239804"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 03:46:47 +0800
IronPort-SDR: ZVTNzIeWh/cyf+Mmy5wN1M9PinS/6uzZxIORdZojTdVbhrrfARiMOYDw2WNh4yBAHNI7wLJ9wg
 72OypoLLIy8PSu2bQDABkkbbuuuo2LWH9rXiSwhyqG31fM7bCOalESrUJ5EFFb1/ufAbxbrCE2
 lYxjtUgB/VSwbuQwhZEVLsp5GFbCs4Jo1o7lWW0o2YK0BzvWcHjDmwVb3kLP4WlZAyxAPGxNli
 URQ+UUW+vaqMTl5/uovVGBKaKkKqxuuItPldsYUyXhtkAWOw+9vHQMAnhM82ZHOe1So/NsN/DY
 Dwzbc8nzKV1j8l/PvoWhOz+h
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jul 2019 12:44:56 -0700
IronPort-SDR: HAtODe7BtpcPlbhxcQtN84PgABdtn9KVeCxDnDLg0eCJzExb2XsvQ+7vVs7bSESg9dXpMWBa7v
 8XA2Ccy4KEmkY7BHg5bYkxTdAX0FkephrCa6PP1UoVXT4/fKtHSJTmeFpQn1+qrodgxo9wmLRk
 m8h5HvbIhxFC/mq717nZ4gy7VA6Uek6OF5BZCQAoLgpZWwjfjK4ncq45/t4bNtMengEBHY6iLH
 iXN07HIQkdQndP8Vpuup8bVgg5HSai1M/AntD3QQWM/462VId0g4hSqGApN8ZT0mnUvkRote2j
 uvc=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jul 2019 12:46:47 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] RISC-V: Remove per cpu clocksource
Date:   Fri, 26 Jul 2019 12:46:35 -0700
Message-Id: <20190726194638.8068-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
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

