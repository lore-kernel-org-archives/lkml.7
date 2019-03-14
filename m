Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD3EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310862184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfCNWi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:38:59 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfCNWfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:01 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9Evp-1h9lKv3Uud-006Q6t; Thu, 14 Mar 2019 23:34:43 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/45] drivers: tty: serial: zs: use dev_err() instead of printk()
Date:   Thu, 14 Mar 2019 23:33:41 +0100
Message-Id: <1552602855-26086-12-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:t3jMVA/czvP0HqlL70xGOt9Crf6Cr1wu2VJnPUa/CNRwWkENiMe
 NAdqimtATnaJ7UYdV4CPycW/xq0AfdDdp+tJQUFIoVnClKiKkap/7gkwtj4A4l77/mo7614
 q4VA9pCQoARA6IBspFcQfEgNNfwAkkuz2i9wTu/BlD/coo08FiAmqbScFdKyg5OszRZNLU7
 q6mKJfwz2h2JqiR2U2P8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jlibMTe23eU=:DGPTgN9T4kTF6+3q339tQt
 tRDISBOMSHLaDAolfYFHJjOWNsLjgLbrzGO90EsTJ8wuyCnqxmUicsriqrfW7mZBiSnXEZsdd
 i1GdNWSkB9/IC5MYrhj+dtRocHulkbJU7o9HM5iiKabyMh2rqyTtjM7C5rg+kkwuz455tG08a
 GETfEVbBnGQNQ1betfmKQiB/hG3FyyzKYSMzxTGKNKDIfZgNZOdkFWkCL63rvAp2Z9YIQT3ZV
 AXsvQS/3abdpjgoWjnZB0R6mPqPAIKCzWXUxnY6/gsryYChrl5fIMeJ/zukPlQHS2Hmvsf7U7
 C/p/fJSF85P08q1QermYsTZ9juG3X6qBiDKEHIWnnkcSFhooxtcWa7xdfS3xmjZ3jP2GAibLQ
 7X/CvVa46uysK8cO+0zEHxtH5CnU46y4ubqFfF0dC3DHup3BP8NTS0AE5FXEFDVdYU7Aq7lq4
 Nn9KX8gcj6kBuo3m49+ewtV5CSA65AHtNfDg/6/JmXKXJ2odK090d+1XJz5S+BpD6Rt4mYIF2
 xY789SJCL0CHP+cls5S9p3F3qVeh/yzfAPQY/gTUhv5y3DXY+4cdmHlm0ZP3DZG6s/65IhaLm
 qEfd9NW+8xz3qq9e2ltbsSzoTVl+3Glhfi6s6A8tLG3N8h8jeUjySYUyS6UhJuh4x20zZHCic
 flzhJlO82MQyzcVPI7ADzpznKHnddRnRDC3IS0OwXRCmPBN55Lg9l68In5+TTfieueZfpXABp
 62njyis88A/s5JxRQYoDkrnDFdUR8Jzbq8Xb+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/zs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 0b1ec2f..c3e23d4 100644
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
@@ -996,7 +996,7 @@ static int zs_map_port(struct uart_port *uport)
 						      uport->mapbase,
 						      ZS_CHAN_IO_SIZE);
 	if (!uport->membase) {
-		printk(KERN_ERR "zs: Cannot map MMIO\n");
+		dev_err(port->dev, "zs: Cannot map MMIO\n");
 		return -ENOMEM;
 	}
 	return 0;
@@ -1008,7 +1008,7 @@ static int zs_request_port(struct uart_port *uport)
 
 	if (!devm_request_mem_region(uport->mapbase,
 				     ZS_CHAN_IO_SIZE, "scc")) {
-		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
+		dev_err(uport->dev, "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
-- 
1.9.1

