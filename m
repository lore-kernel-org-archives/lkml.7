Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EBC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B352087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfD0MxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:12 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38839 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfD0MxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:07 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8XHV-1gh8Cp1oHJ-014PTe; Sat, 27 Apr 2019 14:52:34 +0200
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
Subject: [PATCH 01/41] drivers: tty: serial: dz: use dev_err() instead of printk()
Date:   Sat, 27 Apr 2019 14:51:42 +0200
Message-Id: <1556369542-13247-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ZsvBvAt/rLDu1xNT1sLalxIcX9jz7QA0qevymQS/WxRCH2zr6Wl
 xgtlPQz+G8tT6HFrUdOePnL/g6Nz/IIjRENpXyf+TYdtSi3HrsJGdjKV+IdrLIpqWKUpGIr
 dGZH3/KAvVSKXLhp+eDtJ5SZp4iM/k7bWZWc3G+D3RpE/VH31kx+tVU+u8Iwg2ZCwcrt7Md
 VmQRsAPpOo0raWOEg8/zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j2N/FCIfxd4=:bTewDVrnVLOaptDPWAeuYB
 qRyMUvP7ZPhCmHnVLyv7ju+39CHpoR56I6eeSo+QPHPGCZx3Dqb1I60yuGCld7+3VbN8mYQwM
 2ZbCjusuSxTA2+bf+ln2gKOriFRvIYv03fZTu+YI/5yLbx6CSI9l+bTwHEvU0H3ta1wkb3w1G
 M+LRWzsJhzU1D+iabrBiJqQulwdI3SOWT2P39DSrBTgj2TeG0p6nM0OK9s4d0AagkEnaTtFDS
 GvIWfSoCbR2/5PkucHigRUl586888kNEamyG3pD+K1ZnRZUvnQt/2bPJMzgLfbBVnFR2n0rOH
 DsIz1uuQuxZ7xJAdCE1i2GlN5DwfyIfqrtAA5c9XnIO0mqFGZSvMUtg1KOyuRQsHPdH2C4Nkh
 8yh/9sHWREWoAj6h1c/8kcQJwWpF/j89Q7lN01agcyFr3XDqClCzOiVbL/cuH2l5+wBbKl4nd
 gSsSwspQkSoDZm31+uFKkJY6eYFb8qq5u5vRxi5/XyLnlD6Y22WLY90exJLjhzbZ1RBv3msRT
 j5X6PznC/2y4lrGdO5AgaDwAv8zPI5drxxuPiWfijNEnfgb8HX+g/xkSO/S8J4vLbq4psstD7
 q9QxcVenJmTkCoZUZ8DCf0pUWm4fjCG/QmMLXdJHruAEAQLXD/UUAuMqcTlPi/svDYKKsH8aC
 NgqmkYONc/sKFoFcNypfgkXrsyaRmZhIleuG7ABCNJPmKzGwbidMFStX+km4vIUZ/Cnup6GQS
 oGpzEdn60+VNwCX/u7Jnm8SJFhRmTuBbIh4ULA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 7b57e84..96e35af 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -416,7 +416,7 @@ static int dz_startup(struct uart_port *uport)
 			  IRQF_SHARED, "dz", mux);
 	if (ret) {
 		atomic_add(-1, &mux->irq_guard);
-		printk(KERN_ERR "dz: Cannot get IRQ %d!\n", dport->port.irq);
+		dev_err(uport->dev, "Cannot get IRQ %d!\n", dport->port.irq);
 		return ret;
 	}
 
@@ -680,7 +680,7 @@ static int dz_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 dec_kn_slot_size);
 	if (!uport->membase) {
-		printk(KERN_ERR "dz: Cannot map MMIO\n");
+		dev_err(uport->dev, "Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -697,8 +697,8 @@ static int dz_request_port(struct uart_port *uport)
 		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
 					"dz")) {
 			atomic_add(-1, &mux->map_guard);
-			printk(KERN_ERR
-			       "dz: Unable to reserve MMIO resource\n");
+			dev_err(uport->dev,
+				"Unable to reserve MMIO resource\n");
 			return -EBUSY;
 		}
 	}
-- 
1.9.1

