Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C0921873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfCNWin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:38:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfCNWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:02 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7RDn-1gz9Y43qLl-017lIP; Thu, 14 Mar 2019 23:34:42 +0100
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
Subject: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:40 +0100
Message-Id: <1552602855-26086-11-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:e+xsu2rGR431BJ53y517tmlE8W5jQaZDjF0ZISqDlpAzK97CtT0
 xeQZCrkd5R5Ivwkzp7lEouW7Y7YOlQJoliVOYw8iloOq/yWBz6n7a+V2hMrabK07Eb0QXxQ
 1MPrP5enzRic6Mkdczn4Cc2XzpHPGquEUKOxM6kM80+WrurZJ8Q2BdX46Kfc0f79mk6+KFl
 EEfIMjpNhLo9d2lgkHFxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e6eQEqMXi+Y=:BD2rZtjclkb8YnsgV6olHo
 vTXKLtIRwU6gePZ/fRrTXd1sL8nXzr/GcgAkb7VjRu5OvrQpNPaHeGjveWsz9E2vMe/QpYsBg
 B+UARM0HRe0F0DAJr26kYMSeLGnt4kK1XClgfFfSeTt2C7dUpTzmZX0cB5YgTHRJXJZSntRSA
 rpYmyNsD26UM+uUTyOjLtw5nlD7q+zxt/M/45ZdYKqqyViQjqjdT2SYSZnglwRM7AGOyu5DGy
 GcL6ilSN2wWijlnhoye44xdNPrdqRrtyMhJCoMrz6O0Dq5ZxWOdRJCNDlx1ZCDGG/2L755hMg
 JDC/o78hN8P9AxV20Kcp1JKORwM5ZZ6hG4xWtwLKm+W3namK23kCv/2HgH0umWrhqniM6ZKQ4
 f9ZCGGNYL9TRkIkuIjTEztKVgrGNri6bCVlmsF1SeSAbpF0PASOhN8Pc1Px4zzbbNcPUgdleh
 i/bWxROK/FVYOZccZtvvL7IhNI4I080wIyQt5lbD8OHkMF4cj8aP+RgXcHeT0Kw3RShah+Zlx
 W/ulsxqClhZqYK1rmMkkzwf9muBp4ptBYAE8RIDNdQdD2gcSIVB4hl91fn4Av0j8TGSJUHYt1
 XVU6sHJOXf4Nzh+YWjCgQ6Uc9xsZOodcGvuZ680+nOZ4VNRKGWWmGiQGk93w42XHD3T+FbgwY
 m0PBDPifsFSMRHjXWcfFD1xAKMXqd7jQVYz7nNkdiiNMFPswEefzP71lFqJFF41PQoDz+QVax
 5PdQwC5SD2pRDJf4/2lwPMvxtJgpUwrkZmQG3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/zs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e4..0b1ec2f 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -984,16 +984,17 @@ static const char *zs_type(struct uart_port *uport)
 
 static void zs_release_port(struct uart_port *uport)
 {
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = 0;
-	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+	devm_release_mem_region(uport->dev, uport->mapbase, ZS_CHAN_IO_SIZE);
 }
 
 static int zs_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 ZS_CHAN_IO_SIZE);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      ZS_CHAN_IO_SIZE);
 	if (!uport->membase) {
 		printk(KERN_ERR "zs: Cannot map MMIO\n");
 		return -ENOMEM;
@@ -1005,13 +1006,16 @@ static int zs_request_port(struct uart_port *uport)
 {
 	int ret;
 
-	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
+	if (!devm_request_mem_region(uport->mapbase,
+				     ZS_CHAN_IO_SIZE, "scc")) {
 		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
 	if (ret) {
-		release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+		devm_release_mem_region(uport-dev,
+					uport->mapbase,
+					ZS_CHAN_IO_SIZE);
 		return ret;
 	}
 	return 0;
-- 
1.9.1

