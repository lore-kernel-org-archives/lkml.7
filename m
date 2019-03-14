Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5782184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfCNWfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:21 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43087 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfCNWfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:12 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7AEs-1gysYv2WhY-017UBE; Thu, 14 Mar 2019 23:34:57 +0100
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
Subject: [PATCH v2 27/45] drivers: tty: serial: dz: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:57 +0100
Message-Id: <1552602855-26086-28-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ttxJh5/xAJalSpvfPzcSPkK1u0tHzU5oEa0OJSDkUB5+9mbyZ93
 GfixrGgZLuEqOktG1VWublpF48aVXf47MLO4J1+kmnjK0SbYIgmiGKY3LLYP6rgFBaKHlqd
 P7mjlfvaVnAntwbTAk1Xih6HJ1iqeZvlH+VjdFH6i1YQ8qq1Xvmq0Lfc1Wi5itpO5dELCuf
 KAZi81lWjiID8vIbWtbsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wU9DjEuZZJA=:nJCE/InL+GAwgkIiYIePtH
 45RseBQ6QTRU77N811dq488PMiaFvZqrLvEb9FLsjjDIdcSvGkqpqS7VZPIUGUjl/chjWRMMY
 ISUUKdHuhSD1usg40seVQIlcujqdPIwsst+J/kL1ZN4ERV9Q8CgCNvUp7SqzkKaM83AXOLSt8
 r4G93Gx+hFJTcHc/2BIjOa1CgWNikqcNATXDdOJ6W/43/f1V9vIzwqyr640QH+hbT7VbC4jUh
 SgH/IhZzKfyPtqikAI8BJcEsUTNESd1f/lEmq9goAVZL41zBw7PpiLu5SeGvGVeEr/E8T4Xcp
 NIPhvaiOdcf6ORfkXwPKMTnW/KmbFxhNGwvMZOSsMYQj4zfW/4wupB3K7EbWsIBi3eeWbEiUj
 njLP8MT3L4G9FYwuEF1Xudy9G8T5myhNgFGfVSN8Clm39f+zhgk0Cu7dcNd7rMuhoZY04Couj
 24hrQOyylbslUDxhrtxAEpfqazsezMUIVCj50tSyxCVFNQy42DMEikcVJfp7QCh4udI822qUL
 ec91f/9lHOrVH4CIbtQdI6S1IVJppFXjGzyUnQScvGBQJIG92h7ZxvboSQmd7hTwHjuhtJwED
 tbbqjaf8C+YZ3HixCRyEaac3L8vSpWr7mISTmCkHIQNmu2vrBX+eqNMMYdL6yCEGIvxL6PtMe
 tJX/63k5jXzCAWFIGVPtPNXsafm9mZF/8BBpjpvYbGVzoqEQFe8bfxwz4uGSgpAiKcm8x4FuE
 SWMf7Ac6FXgHQnr1dPYBggJ07Y6LT8OQkEFZAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/dz.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 96e35af..10a75e3 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -666,19 +666,22 @@ static void dz_release_port(struct uart_port *uport)
 	struct dz_mux *mux = to_dport(uport)->mux;
 	int map_guard;
 
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = NULL;
 
 	map_guard = atomic_add_return(-1, &mux->map_guard);
 	if (!map_guard)
-		release_mem_region(uport->mapbase, dec_kn_slot_size);
+		devm_release_mem_region(uport->dev,
+					uport->mapbase,
+					dec_kn_slot_size);
 }
 
 static int dz_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 dec_kn_slot_size);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      dec_kn_slot_size);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO\n");
 		return -ENOMEM;
@@ -694,8 +697,10 @@ static int dz_request_port(struct uart_port *uport)
 
 	map_guard = atomic_add_return(1, &mux->map_guard);
 	if (map_guard == 1) {
-		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
-					"dz")) {
+		if (!devm_request_mem_region(uport->dev,
+					     uport->mapbase,
+					     dec_kn_slot_size,
+					     "dz")) {
 			atomic_add(-1, &mux->map_guard);
 			dev_err(uport->dev,
 				"Unable to reserve MMIO resource\n");
@@ -706,7 +711,9 @@ static int dz_request_port(struct uart_port *uport)
 	if (ret) {
 		map_guard = atomic_add_return(-1, &mux->map_guard);
 		if (!map_guard)
-			release_mem_region(uport->mapbase, dec_kn_slot_size);
+			devm_release_mem_region(uport->dev,
+						uport->mapbase,
+						dec_kn_slot_size);
 		return ret;
 	}
 	return 0;
-- 
1.9.1

