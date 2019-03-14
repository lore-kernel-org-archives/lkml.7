Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B64821873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfCNWfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:24 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfCNWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:12 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hEd-1h9DdJ2voX-004mDV; Thu, 14 Mar 2019 23:34:56 +0100
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
Subject: [PATCH v2 26/45] drivers: tty: serial: dz: use dev_err() instead of printk()
Date:   Thu, 14 Mar 2019 23:33:56 +0100
Message-Id: <1552602855-26086-27-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:t0vfwJPx9NfL4tq35ATbtyhLGWVbWI4RcxTsENYe1aYWbwSsoQZ
 1Z5+0lsUwBrQI7AvTa0DeKSahSaDtX9EbAWLqXqLNZMfq07W52PHspP/T3ruOaZhqKhbg36
 SyPtbHYVTyLU4wK5aeHInuw34Vnn/lEwuANVrVxVGZ8fog4g2BnfXSESTzTIdRpQTGieYG4
 7gKVMzlBXkmqTuf2x4gDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdgeTBivkGw=:RPOxjN0TRjmLZotsls/HGF
 I0NqukCdHXTA1EQMsz4L2ETUg7o3hDb4sKCGrHARx9nV1dIAMr/GP+MJ+kOaosBgoLzBJayuJ
 W3YYvruQ5HAUF2V5tjdgR91rPiCUrgpGSSvAWOyBj9/jzrIQ6nuqqjG5KQHW94Fl+5DRLhCLK
 pZ+QT+HEdwIctgz2lKClTn5QIw64xUTqsMh6XnBticEvP0+5ljq9VQsiYfhWjYwwC5/2P5Gd2
 OP/iVx/U2I5+IEJXvspcl1q5t+M1PuHnFy6Ki5LOvv5Jg33s1Vb+Ayj5h4lEdsLRMzT9OJ7z+
 taNfpZpUMfGkXI2qgx9FVEv0qaD/yKmdZpKhuZYV4PVqzMxXUwVUe6pizq9nLA51LoTVrHp59
 hDyytVaOLzpBm5xzSDQTT+GXnY/hcepe2EA56w9rc2N3+iImcRaUSM8LPRvxUtEueZ9qI44a2
 yjmiNd7VozJb2CD0dMAar91VMigWKJ+gI5hdHrjtDE6opar1C+smiXgcMwUwJtvTAC8RSLI2G
 dfr86qHgeYX1BU9NlEYg+jjnnu0c6+lusxQSSQOWAu5GRCvk4EmatHKon7OpqhiWl1hepTlzN
 y9kDu2zE8ueqlotE0gN9kqIDyz/j0azDxViO8SueLl3l5xH+aazTrwvbZyHLjF0L8lWjhPe+R
 Cq/6Uaiep5hu1OgIONAJtT4hg09NrifaFmrIJcKwxFwN8hJ6tjXCHaBiNQYF4yS0ev/ZaumE7
 DKl5BnBxcJMAWDUvSy16u+aIqwd6+7y7Fja7qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
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

