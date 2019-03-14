Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AC621874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfCNWfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfCNWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:26 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybX9-1gqJq61u05-00yvbl; Thu, 14 Mar 2019 23:35:03 +0100
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
Subject: [PATCH v2 33/45] drivers: tty: serial: sb1250-duart: use dev_err() instead of printk()
Date:   Thu, 14 Mar 2019 23:34:03 +0100
Message-Id: <1552602855-26086-34-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:mXqIaXu/DsCMYAftQQOsTksW196HtfI2cGBEAdlsI7IaVaRzetQ
 hQ9E6yXhs8QO0celBJI9MkXkb9xa9UZ5NVEfVYG0q6Ylu4o5S+dTfLuWhdWJYvG45z/YN+H
 BLHC6mysacRdZZo/HKhZBzq3N18KWoD4v7i8KJ9ddSJO+0V1mnx9vGoMmA/fio59soYXwlj
 2iPg9YGI7E8HJelxcgQfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vH37rNIdhrg=:9t0UMKNOshW3jKdl00zRP1
 K01TXJoRjyLHcC6zzSlIohpRDmwb6YDpRc1olNvhl8AJcgxmQiNV47g8mvaA9drp98mJZJLTB
 dg+E4LXdTJ+ytkEIznH5f/SF0VdvhejTDv94i0715GcNwOTapywNxF8U7LTi3nW2Pu6keg4iM
 rjO8tGsp576ZwhFUaJI3NfSeFTzBKMDyFVXzlNsJ8htOTS9SNIyzgNeIqPXmxc/FB2isr1Kfb
 LR82JGnsmEqanmMaguxzT0hap+jIOyvKoGTMk0MvsQVuyYAZoy7Vfcst7Ca1WVmLa/44OTIXa
 tIbi+NuBQomBxJ0/kldrdybOIMnQcIshH+Rd0jiuJB3ureSugPA5Co2jbmZgvoyeaqKcwPujX
 Slh1ROMJx1bzExGlLx7S+aqLAcd9uPGBeMtQjxTV4E6UxMH45w/MbEvUqzVu4oX1P5rCY8dmY
 oSkKijHl77DkwF//IsujcFRnbzh2usBh9fFs7fMddNsJ+Sq9ByAaHqsvzJrQB1KsQhoLvvmw7
 tVgt5NxBdKEgFmmR2eO4R8Ly5/pn+Hv0zcrH05Dk1VNufXfeBfCRiyW4uU8xWNdNbXGBTT4Vg
 DIL5xSEPdU+1BBZaGMHasRFDM877DnvttgO6yHXIcYTu4RlDJQZI4SJ3rcVqALNrZl0e4nMTV
 wFMT4odT3YgVgLidU+zlysssHst81QN0qABsTJDgt5g7EaSvrpyOhGNeghYLao2O77oDqYDKN
 Br09yrGLW5Ns9ljIsJzZjwIMGk/o1qdTcTi63Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced..655961c 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -663,7 +663,6 @@ static void sbd_release_port(struct uart_port *uport)
 
 static int sbd_map_port(struct uart_port *uport)
 {
-	const char *err = KERN_ERR "sbd: Cannot map MMIO\n";
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
@@ -671,7 +670,7 @@ static int sbd_map_port(struct uart_port *uport)
 		uport->membase = ioremap_nocache(uport->mapbase,
 						 DUART_CHANREG_SPACING);
 	if (!uport->membase) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
@@ -679,7 +678,7 @@ static int sbd_map_port(struct uart_port *uport)
 		sport->memctrl = ioremap_nocache(duart->mapctrl,
 						 DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
-		printk(err);
+		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
 		iounmap(uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
-- 
1.9.1

