Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16810C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A55206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ShcohsB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfGaBYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:24:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64333 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfGaBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564536277; x=1596072277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w14oJ81u6w2W34wdULaaio4UuiCV/eOoDOsEOvwCQng=;
  b=ShcohsB2O/v0hXn9yNGDSiYHxpoCxlK0iCraMSDfWNwqCj+sJC67Bg1n
   zHv7Qhrr/yL+/yeNDcRzNQ7VM4KrnXOUt9YeO/9il8PqeFVSO+P/I2IQo
   zSJLqg1lC4CIeJX/LOEDI4T8+mCZTHVQr3DcN2NadmRt9O6zJEfPqQkic
   g/PQG9vj4B2zT6lbAttGqBfS+r68m1kFKtVT7tUfqu8bKqgFuSoGK+6wB
   nqMJ/ICSisCD5y8zbcXeG0+rggRZ2Uh3tHy/9k0zkt3V7zJEf6DdQ/JGU
   JjWY3k4TqHnP8YSbYXWtW2wGtwSDAVm5+WdqJBwkLcGtZHfEeJpNcwM96
   A==;
IronPort-SDR: iiNk5ZWkF2X36Cc0WXg39kw4jqskeSKNALsqIt8MTtmHB000IDfYdraj51UrQlMT34yKShZu2f
 h2jyrsaI+A4HDiUOKKsRefkAe3y0omRz2/SdIMhJctOafsKFgnneusfYipb4eCb2XSQ+Oh8R7c
 1xjTdudYTJQzj5X3tS3G5FoKmjulB5qtqgw4cV6R97ro7pbLCIaHKbbdEl/lVrPo+5tVgYyqLE
 acA0SdYvF8b5+WfFCsN7V219izx4sQII704oASXShO2rKkgZV8yFEd0mzeooUCWDUlpjW2/VMk
 0U8=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="115555800"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 09:24:37 +0800
IronPort-SDR: G2X0N0sA35LKBVbTJZtDHtFS3ERRsCShVu7qsSW+uS16Gn1JIV2jb9aFpvvMzXVMibDrz1QFvl
 dOR2U8nqXRtfKxDxhw3E65SAMgmvbdcx+uArbAEVdrDy7zqaKlulS3CwynBi0xZJJDMLryDndU
 B5BKu+yJzoFRgd233kBXoswtahp3GG40d4AmdQTHbS7AZqRjFErIpQvymE9NBR/WOb1AViAP+j
 bCvgahsJkAJvfsI91w0ZCUsvpVBrdRf/WQqR3YBd8Ih22/dDTrI9/uFgkN5ea8GDHi9eAnmemw
 9Ban0INj6rf64VYe/2hd+u5H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Jul 2019 18:22:38 -0700
IronPort-SDR: 3sIcbQgxnvm/OmZX79OUSeBBjL/aRRiiJnuYpbIO4ukQp1vBudqAkfTquNuNNV1yxRpXr5VXYc
 BDPkC4kHvf9e6rAQFeGOlPL1/Juf8fqKjuEt69N/+Vc6qIsdKhLHD/jlPRvxT1byy7KeQNMHX+
 XiWV1JpOikc6JZwyARbD6vaXdBZSu/LjSzYW5wtXtjdG73uT2ql5rpdbuTqFScrr+LPWIdZY48
 AGJPh+uMNAqF0M2AzlsQO7XMNrLdhOQ8eFaOlI/+VxcraJ4IRcn5TB5M338/QYEzkYopcwugPf
 lPs=
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2019 18:24:36 -0700
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
Subject: [PATCH v2 1/5] RISC-V: Remove per cpu clocksource
Date:   Tue, 30 Jul 2019 18:24:14 -0700
Message-Id: <20190731012418.24565-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731012418.24565-1-atish.patra@wdc.com>
References: <20190731012418.24565-1-atish.patra@wdc.com>
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

