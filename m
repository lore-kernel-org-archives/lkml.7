Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D948DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2F218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfCNWiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:38:10 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfCNWfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:05 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MnZwp-1gfQqZ046X-00jcjx; Thu, 14 Mar 2019 23:34:38 +0100
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
Subject: [PATCH v2 06/45] drivers: tty: serial: samsung: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:36 +0100
Message-Id: <1552602855-26086-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:biPYKTkboYb/1OcCYoABqLwj1O505ksU/PyTR3LJ7Da35VWUqJk
 KaLZ2YHPrK+MwI0vSMJbRK2E3/v/XiYFWvv74iQVL1ADferdn+dvJmjrKVVTOtQGW9LHINY
 pYkp6FZIW2ft1INaMVS460EQaeKy7jQqTy12j0ZJ0Qb+sLxC5h+erEeWrmtopbd4om5ulZ5
 /5eWv8ekIAvi+Ut3e1bvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QkSB6AzkaFA=:/04NccFh0LgsEP9J2BJ72q
 B1eFmVEwPpMjYm749dnhjlR1rmq+dnbhS6j1MXeV82rBiAi26ThL9pAAc7klQcrBlTg+hkxu8
 h1rJLzQ/4yonbiJVN6eV4GUs3aA1WldGeFNX3MyrNaGjcDvKrgDaf92xZ3GjkVlxMznHPwgBu
 gorsROrsJc3QPP05pvlrxMcoB8Odwxr/OOInZYZ1C8+7iJGYltXL+homHLriVX2jA4ZRjrwbO
 iz5G+tXjg0v4D3B/kBij3/OsX4pNtdNL2e0s9P+at5Tm1wAQFNb+/c0POxcgyoplqD2JoeoMs
 pUu27HM70pR+0N6EtOCi0mQOFd2p3OkgwemsL69XOYPm/La/tKOs1xZKj1G4dpxC0IQHXuFR9
 bEV6dEwTq5AgGjNTs4l+xEl3Wsp4guxJObrvwleGgxuo9fBmOykncZQxvcZwazG7u9EVYIZAN
 ZmSt4oaQYJaHNFvKNAjUfcz0OwDd9BSt7BAEmhy006a9MCW7ol88W+fQ9eqj0Bspk8Ap/2zHt
 oWG0svr6rviYWfub8FWEsOoQfavzOW8eEzn8Kg71fNi8NLLmJDHbocxubhmKWsODbTO3Ns9PU
 twaMKF7mHGFdqfjwXzeDqMUPwvvjX/tAWETSvK9Uyly9LwBTcWZDnARxTOHT6WdMHl55Dr8lK
 2X3WCBPEkivrB4HiM9zjH19trWcXVULV7kI3OG/2ZThodsdZk/jgKz8GwO1He91bKQOtyQJwo
 D01Eu3eXeIA/cG/JFR2C/6WCsl7Bv0pmQa7DCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 83fd516..a49cf15 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1775,7 +1775,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dbg("resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(port->dev, res);
 	if (!port->membase) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
-- 
1.9.1

