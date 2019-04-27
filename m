Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F76C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E167B208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfD0MxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfD0MxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:19 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MG9c4-1hYhE40ZmG-00GaDP; Sat, 27 Apr 2019 14:52:56 +0200
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
Subject: [PATCH 26/41] drivers: tty: serial: sunzilog: use dev_info() instead of printk()
Date:   Sat, 27 Apr 2019 14:52:07 +0200
Message-Id: <1556369542-13247-27-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mAhDCbido9+iZFtRE4TdsCbv1vAr9Joy1VbiPU+XYBGA3j+D1i7
 8tBC3ZCd802YRf6g/j2wz/Rpr+rNfM3/C9qVun5TY7ecwFsuAGNQ9PkxsomQbrK7CQSqD9t
 lNVdEtEZXMG24nxtzJ9rZ1N16lMRzqr8eSk0ACn+9ciZWtRdbmtCGj6cenKYS6p9eJZMPGK
 +Gf+FP3wxSs4kFyyMktug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0SWS/YPHXl4=:xXTpK4xlmi8jyBmh5+ECF2
 2f9XUV5idTnhYPicmiA4uN9epzHkr0tM2wgGgfiaPSshMy4/xofCE6fehmo0kVhDKiF8UVbMG
 XR8itAO4whaeeAqp9zT5DYaaSKJ2vtlF2N3zWHCsj7pHbAGbhkSM9yxnLE5xXWK/rrI3rNFKs
 YIL05g1WGyY8xdJe4HFEc4NcJhKh0f6h9LUIcxhmKvH9XKe8ycd0Xe3RywlvzHmnWjcU1z9Vj
 T6vHj0osI3kq595a3frTeGB0+jpxTiEP9p6T6XiuZvNJcMFcVfR19rf4Gj2yDgphVYvMsQryv
 Ksrc5FpwDCtuUawC5zqz/Epzic7ZckEfLjO0q7+UoqsY0qU2w5PVM0DrEJwWrMmVrMhIrOFFw
 81XKksVUTD4AuR+sXqurAVCxRwn6CXlYCaUeQij0f2JVzNuq7fbmsbAgJpeEfV5/tIPLtdEaR
 vBt9XarGGDlzVuyi92jSjgdBgtKrY7LZr+9m6ioeJxy2ufRg0N32AcwiJeOcaGThmWCpht23Y
 m1ocX1+Dlr8+TlglVKRnWgCqKWI2lhH9KcTZN8l27ajs49owlLXy8zkyJUHaswH8NaJ7Vo4HJ
 /Q2JJ0/z9DlIk0AXgG0IJq1NdJttYEUAtvhk5Ms9Ad6jVBqAzeWwQ3FXaB1XSVn+7YmVjffw6
 nb8ej0Ia5DlAdpZ4D1aTwGxiigyP+2TidNSBWB6whE/gbiB9kfqBscb0vJZXs8WN/bVMk7qiH
 gIjVcmF0qrPRPdGta3xTuJy8beZywXyoAWaOnw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_info() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sunzilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b..6285bba 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1489,14 +1489,12 @@ static int zs_probe(struct platform_device *op)
 		}
 		uart_inst++;
 	} else {
-		printk(KERN_INFO "%s: Keyboard at MMIO 0x%llx (irq = %d) "
+		dev_info(&op->dev, "Keyboard at MMIO 0x%llx (irq = %d) "
 		       "is a %s\n",
-		       dev_name(&op->dev),
 		       (unsigned long long) up[0].port.mapbase,
 		       op->archdata.irqs[0], sunzilog_type(&up[0].port));
-		printk(KERN_INFO "%s: Mouse at MMIO 0x%llx (irq = %d) "
+		dev_info(&op->dev, "Mouse at MMIO 0x%llx (irq = %d) "
 		       "is a %s\n",
-		       dev_name(&op->dev),
 		       (unsigned long long) up[1].port.mapbase,
 		       op->archdata.irqs[0], sunzilog_type(&up[1].port));
 		kbm_inst++;
-- 
1.9.1

