Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F09EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C222087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfD0Mx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:26 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfD0MxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:23 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5G1V-1gbeYR2mc1-0118EA; Sat, 27 Apr 2019 14:52:58 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 29/41] drivers: tty: serial: sunzilog: cleanup logging
Date:   Sat, 27 Apr 2019 14:52:10 +0200
Message-Id: <1556369542-13247-30-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:uxxvCa66CYSGi3Em4nuMPvtSzL45VE6ce5qM7EP5uZ2jwnJH/Rf
 VzWdbFvPirBwCJNu9f+Jwyc9lVwLpUGhejFkC7ldZJdxwR7DA2BRn+Vl0BQckBceQIF7qXC
 WyxgtztRffigF7v1SzndzvbVeMKNS2DbGfpYfH4EV+kNq293CGWXupsg6VWK6tqIR7aTFMf
 +tRlOKQpyia0QglzkJKNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y11A1qYqUqI=:8rPS9vSRvAXoCM5mb5BhuI
 WjE5yIVWUmfvDmA/AQ4ypZ+srkteIQs198t/oJOqUwZx5Rp3SPAGlO++llU7eG0RNjUsALBZq
 ZUvb6zw3f9sYxfEGhrGcIODhWtEO5jSQT4jIVhGurbVttXmC6195bA40SA690OEhhnFI/qCEi
 WSwQCTE70G9mH5ZlezP2NFueEhbG7kWFhxlgd96LRp1M9Nb1RFDllOpLiSlWwuEgrwYc/txEZ
 Jz5ZQj7Ur9cWxizBCpYX6lQ8MA/6iwg/+OwOBQFBaO9/oRTiS2RJak0h4ldhbLbwq2zihGidG
 1rGx2U2IrRbLZ4JMDQtJAaneQYfRx5ecqZDD3UkLCP4Ei05fNui5iI8OpZLsbkAWQMiKsryvO
 2kCFC0VRHePJTFZPqt9Ik9I0+gIoWPxwpdB8LfjEbEvj6k6/XPYQgonaBdL12TN97JkTvX7X2
 zPhIz62y5IwAPzLzViaQBeYU5gJWmkOIO+mcjozxcMghEPjcS0OHpgnDA8TYNsChOcClWQN5U
 ZTY0rQijbKo7+Fr6crZw1sEjpHfTqC53E74pOXaRvnpUsI/uBenbneEDtTlLAdpaHpm6wTBvF
 WLYWF5qQwW7fPx/YeqvLiajUl4U2/pvABrvxsQRwW6Zi/tOfEaKerfDWvrHkfNX97OpQ9rjqO
 aqTj8y5/k3NSG39yLJhNMUwbIOnBHg3Ua0eJn7jjxkxpYM82/aUzhOuEWTDJOxHkTsenB2gj8
 mCkokTH7YsmuOy7tzDvemUKChz641N4UkAKV+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning:

    WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
    #1238: FILE: drivers/tty/serial/sunzilog.c:1238:
    +	printk(KERN_INFO "Console: ttyS%d (SunZilog zs%d)\n",

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sunzilog.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 85edb0d..dba723c 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1235,7 +1235,7 @@ static int __init sunzilog_console_setup(struct console *con, char *options)
 	if (up->port.type != PORT_SUNZILOG)
 		return -1;
 
-	printk(KERN_INFO "Console: ttyS%d (SunZilog zs%d)\n",
+	pr_info("Console: ttyS%d (SunZilog zs%d)\n",
 	       (sunzilog_reg.minor - 64) + con->index, con->index);
 
 	/* Get firmware console settings.  */
@@ -1615,9 +1615,8 @@ static int __init sunzilog_init(void)
 		while (up) {
 			struct zilog_channel __iomem *channel;
 
-			/* printk(KERN_INFO
-			 *        "Enable IRQ for ZILOG Hardware %p\n",
-			 *        up);
+			/* pr_info("Enable IRQ for ZILOG Hardware %p\n",
+			 *         up);
 			 */
 			channel          = ZILOG_CHANNEL_FROM_PORT(&up->port);
 			up->flags       |= SUNZILOG_FLAG_ISR_HANDLER;
@@ -1655,9 +1654,8 @@ static void __exit sunzilog_exit(void)
 		while (up) {
 			struct zilog_channel __iomem *channel;
 
-			/* printk(KERN_INFO
-			 *        "Disable IRQ for ZILOG Hardware %p\n",
-			 *        up);
+			/* pr_info("Disable IRQ for ZILOG Hardware %p\n",
+			 *         up);
 			 */
 			channel          = ZILOG_CHANNEL_FROM_PORT(&up->port);
 			up->flags       &= ~SUNZILOG_FLAG_ISR_HANDLER;
-- 
1.9.1

