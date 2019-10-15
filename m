Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD52064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wOJ7FvhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfJOImS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:42:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64416 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbfJOImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:42:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9F8fLfY022078;
        Tue, 15 Oct 2019 10:41:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=VcswSaQgjwVPJKQoYkqU+reFn99J6VbQH4Gn2WoEbg4=;
 b=wOJ7FvhBt0tKm13YE/KziypjLfgScNJumVeh9zev23ZAbAQjnszYIi6qKLuZypqCx+14
 Y+8eY8/UY1WbhXEpfgOGbmDdMu0LvhkGlp/LGYCKg0wrgYsihDxx1+vxMhyrWOGGRAvI
 KcLEs6XaogPQCe4XZDFeYo7Vrr0yCOdKGAPhp1c8zi2xz5lu6EyuHEWuKcfNYFqQIJoQ
 xHPrKi1v5FrWdEE03xZpxiiaUmshtMvbHS2XOL2OYNxXGTTe2vxUXde7JFwIu4HeyaZ9
 3F8Hjo6ZenpA2iSOAnja6zpvbq5Iemdu0OtsNEPUd+9PWkRT0Kjbj93i8DDz9wwkiPHx NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4a1728e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 10:41:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6D4D100039;
        Tue, 15 Oct 2019 10:41:42 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9118D2B758D;
        Tue, 15 Oct 2019 10:41:42 +0200 (CEST)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 10:41:42 +0200
Received: from localhost (10.201.20.122) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct 2019 10:41:41
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <linux@armlinux.org.uk>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] arm: kernel: initialize broadcast hrtimer based clock event device
Date:   Tue, 15 Oct 2019 10:41:39 +0200
Message-ID: <20191015084139.8510-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_04:2019-10-15,2019-10-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms implementing CPU power management, the CPUidle subsystem
can allow CPUs to enter idle states where local timers logic is lost on power
down. To keep the software timers functional the kernel relies on an
always-on broadcast timer to be present in the platform to relay the
interrupt signalling the timer expiries.

For platforms implementing CPU core gating that do not implement an always-on
HW timer or implement it in a broken way, this patch adds code to initialize
the kernel hrtimer based clock event device upon boot (which can be chosen as
tick broadcast device by the kernel).
It relies on a dynamically chosen CPU to be always powered-up. This CPU then
relays the timer interrupt to CPUs in deep-idle states through its HW local
timer device.

Having a CPU always-on has implications on power management platform
capabilities and makes CPUidle suboptimal, since at least a CPU is kept
always in a shallow idle state by the kernel to relay timer interrupts,
but at least leaves the kernel with a functional system with some working
power management capabilities.

The hrtimer based clock event device is unconditionally registered, but
has the lowest possible rating such that any broadcast-capable HW clock
event device present will be chosen in preference as the tick broadcast
device.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
Note:
- The same reasons lead to same patch than for arm64 so I have copy the
  commit message from: 9358d755bd5c ("arm64: kernel: initialize broadcast
  hrtimer based clock event device")
 arch/arm/kernel/time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index b996b2cf0703..dddc7ebf4db4 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -9,6 +9,7 @@
  *  reading the RTC at bootup, etc...
  */
 #include <linux/clk-provider.h>
+#include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -107,5 +108,6 @@ void __init time_init(void)
 		of_clk_init(NULL);
 #endif
 		timer_probe();
+		tick_setup_hrtimer_broadcast();
 	}
 }
-- 
2.15.0

