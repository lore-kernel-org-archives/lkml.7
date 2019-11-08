Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA26FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC7215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbfKHVi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:38:29 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:43755 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388444AbfKHVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:38:29 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N0WwO-1hfVjv2o8i-00wTtI; Fri, 08 Nov 2019 22:37:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH 16/16] firewire: ohci: stop using get_seconds() for BUS_TIME
Date:   Fri,  8 Nov 2019 22:32:54 +0100
Message-Id: <20191108213257.3097633-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108213257.3097633-1-arnd@arndb.de>
References: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ShTMGp4lVNVsHj+KLbB1IsdO5sH5jn0FUtExiYeIktC9NBhPH68
 Eo6Di/s4x1/c0s0lLRtXEL3+pUqH2jXe+lTpS1u0fj9Wj5g2hSZfutPCDmz9vVx1gkCHN+t
 lGkblZXmLSCwyqit9GXFDVWTAAGNnFLncfw6TYZEMKhOitqIsxr/7PMTbimFz3Ksb8vTWOR
 lcjupetSVcK3O/vCeAMtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:leyoQLNXbQg=:XqNTH//TUd2wRfId2+/xfy
 eQ+WZQp1hTDWEnjaAb3rr/ypuDM/uWEbbd+ht2cL4NNSBam+Merhk3GCl8f9Na4vCuujDmXp8
 dTjKewx5lcZM1j2vniPAnG5tRQtmf4DXuVdbRTg/AJW7r2nGu5oaik/cj+FLrQALbLu5W3S2g
 gn9HXG8FzCIFPb/yCthoolqyFw1m2CxJZI9yWZgM2EqbmeJkf1nAHcVCMqKOF6TCy1SC0r0pV
 YnTSdvXiIpNhzoHR2kfebW4bI7Jj+aN39JoSq370yilI8ABf3QPD/FULOrAElxyBBCVnigEUv
 qCDQH5Lo1X/AMa0go2UF08ZtuZ3WfXhE9/ULxTNV6KqnBU6W+jSU1tyAJtszmDnwmNIi6v8si
 jSBExJE9oZ5quHrJTc9DZ577cTb/GNuAJUDmoAub3HEkdJ2KxO5YZI0PUcsG22ysKX/+U0i6C
 0meZYkHhON7G/I6cH0I6NivXIWpO7MNRerECpI5I5D4h5NGqscYeORHflrzpCI25c9GxtLPQJ
 JgpoygF3V4/4nBEOZTUOYfpCRWcaWMe+ZyAt/gYF5GRy5WAU3VETV85RWCDjhPLFKp2LvhP8I
 BZDS6CJDy7h1TOWLwOBMIGvM5bLAayvlR1dex0YsaPLpEh1b22ozGKQF8+DrZy42ok1EDxLpJ
 SJhNU7KVWt3RglSABWD8Pc98EBImv87rsCwacFTUKL806Y2GIsiTq/6DqDKWKsih4BhsCtQax
 TV2lC6jZ38zsEPk/ETTxzKlYrkyogQt7gehGY9ObecJ2WRR+9e6JIM0XpYWBTEeXkZLIY2mLc
 Kn/cN2Ga7qkgoMkPqDxRkgz/aavM11Cuw+uzN2F84JYcYiOLXxXTBZLQ5pqciOre7GWcnWYXf
 8sV8mV4nOIfQV8FMpaVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ohci driver uses the get_seconds() function to implement the 32-bit
CSR_BUS_TIME register. This was added in 2010 commit a48777e03ad5
("firewire: add CSR BUS_TIME support").

As get_seconds() returns a 32-bit value (on 32-bit architectures), it
seems like a good fit for that register, but it is also deprecated because
of the y2038/y2106 overflow problem, and should be replaced throughout
the kernel with either ktime_get_real_seconds() or ktime_get_seconds().

I'm using the latter here, which uses monotonic time. This has the
advantage of behaving better during concurrent settimeofday() updates
or leap second adjustments and won't overflow a 32-bit integer, but
the downside of using CLOCK_MONOTONIC instead of CLOCK_REALTIME is
that the observed values are not related to external clocks.

If we instead need UTC but can live with clock jumps or overflows,
then we should use ktime_get_real_seconds() instead, retaining the
existing behavior.

Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Link: https://lore.kernel.org/lkml/20180711124923.1205200-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 522f3addb5bd..33269316f111 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1752,7 +1752,7 @@ static u32 update_bus_time(struct fw_ohci *ohci)
 
 	if (unlikely(!ohci->bus_time_running)) {
 		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_cycle64Seconds);
-		ohci->bus_time = (lower_32_bits(get_seconds()) & ~0x7f) |
+		ohci->bus_time = (lower_32_bits(ktime_get_seconds()) & ~0x7f) |
 		                 (cycle_time_seconds & 0x40);
 		ohci->bus_time_running = true;
 	}
-- 
2.20.0

