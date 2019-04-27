Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E28BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA28214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfD0Mxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfD0Mx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:28 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2wCi-1hLTog0PAy-003R4p; Sat, 27 Apr 2019 14:53:02 +0200
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
Subject: [PATCH 33/41] drivers: tty: serial: zs: use dev_err() instead of printk()
Date:   Sat, 27 Apr 2019 14:52:14 +0200
Message-Id: <1556369542-13247-34-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:QF40RLIzjg39yF+kkJLwWE6eyJO2lDQl6Yzy88yH5771K+U+/wt
 1Wjl3D+kIur6TBPIOh4jOyMYXzSox/0XX1Hcf4zFuPQmKc9TKSN1fBoJRYlf+0M/kOR3PC/
 l9Y251gM1AKpBxtXImahYkduMkU7yDZeVYsF1N1b7uZfo2UV2TlEEwBb0bCY34hAZbZneXk
 NbA8aA4/MktrW0coiKTyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Eh3DZPiCkGY=:tjxD2QwfgapatdwHmJnkdr
 PSdGT9lcKoxn0vZ7Rp//x/uyFYBtQLUi29IcunkocMEKUs5YJFdHogbVsFAVMVJLZO8ZzntWV
 O7kttBq5DAGhsobsWXs4e23+7HwMITcEiszncVa9/3sUVc1cH0grthAJlNpQumTFiLTwCEiiy
 +AFXv1re1PUwC5xEmLzo9ui0isgMgVA1xQUwsRbOaPLMm9NhDZ+d0FJwbTo3KHNsiTsZFuWxL
 9JQM7Z22RLBAG9wa3ASrrfM5zKmHkSEOPc2X/N82bli24aD3TTUO9a+J+ojmDWRplKpAIUyZT
 fXId/zFNr7AEGUcX7VezsKhscHBTO758/ZyMrcgNAMWDnhT/70u6TQvUuOifW8D/Y1Hghh6cB
 4QO6ZhurmdxyZ0oOhuThszQgC1ht87ExyjwAYJVydH9z6gq+SRyceTbbE4E3B8S9L8NXdBQ/X
 zKuAsUqVCpO6cv0AGCVD4beEqaRkWxfry7+cFMzTYdlW9kxaiakkPg3peM6cGo/Y3aOswdDEM
 yOFjkyXAkmIJS/Cpq3mFMRySCepHNYPls7KvZMbIrJ54ISXVvnt2+YnC5ifFf5IWfXTwyd4en
 JgZaWxnJ+lu2qoKH06DlO+YuUroKlBo/Cj+M98Q3I29qfcokFkZmGZ4OCqvk9mLjVWnIDVpkp
 NK+vpcb7NDaHyHNl5rybbr37KyjM3iS4zuldMiVnuspOHZWY+urLdryZZCNfYizdguQmQcDYI
 VGv8B4cGjKb5Hp8pFpGXlDXptI7yMcxq50+aGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/zs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e4..adbfe79 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -767,7 +767,7 @@ static int zs_startup(struct uart_port *uport)
 				  IRQF_SHARED, "scc", scc);
 		if (ret) {
 			atomic_add(-1, &scc->irq_guard);
-			printk(KERN_ERR "zs: can't get irq %d\n",
+			dev_err(uport->dev, "zs: can't get irq %d\n",
 			       zport->port.irq);
 			return ret;
 		}
@@ -995,7 +995,7 @@ static int zs_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 ZS_CHAN_IO_SIZE);
 	if (!uport->membase) {
-		printk(KERN_ERR "zs: Cannot map MMIO\n");
+		dev_err(port->dev, "zs: Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -1006,7 +1006,7 @@ static int zs_request_port(struct uart_port *uport)
 	int ret;
 
 	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
-		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
+		dev_err(uport->dev, "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
-- 
1.9.1

