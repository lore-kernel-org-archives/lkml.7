Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4421873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfCNWfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfCNWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:07 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M2fM1-1h3Bl93DKR-004C7v; Thu, 14 Mar 2019 23:34:40 +0100
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
Subject: [PATCH v2 09/45] drivers: tty: serial: 8250_mtk: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:39 +0100
Message-Id: <1552602855-26086-10-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:tq46V5HkrKkArgmZSws3car69JUj8undTbtBhIc70QwufTd1mZL
 sWiBwGH86COST0US8abTbeTb+YuOxrd+ByPEkwf/3SUkGlon3TFUmogQpGmbYbN/Dfqd/m7
 scOAUvc5wsVofgiem9lmqwyaaNquTW8jzLZVbee2wrjJYMuaEh5tI2/4lwJL8McPMlhNDpW
 Wl1Zwfy3og3RCloZTQzWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50IfZNt8boc=:CfXBiApkrcTvBgZbLg35Dg
 upFwS8Jm4wS6YmMKSzaino3Z3YUe21ImLvvnheGbFiomoRy/8sOeNvni5VPgcP3niv8WSba/Y
 5oGgUxCzwtsNo3Io79U4eaBB8CL8y/9VMgnfWwDf7jglVbT99W/fPLp46qRiEMe71drhaqT+u
 BAejh6vGvOjLPxkJG41nxO67GxaQMaZGp86zGhMLFsnbASFg4BZK3ROkKHMHTAqVW9I3jwSnF
 wJLQJoz2caFIgOMmFmUHlVE/V1rlXGrpBqUitTw0Ozjr3gTkixXjStuSJImTG6hCr/OcrUH+P
 DpwjMIuLjE28vAYDl0b6XmcYdWY3JppJTY4zHFG3Z+zBQbZLb16qRTaPbJKnDAJmxqt5MOUFP
 OQZmOh9w0GiqVFdLURWlC6HUb1wGgQDY6NmMK5/jf08TnmJMXzEKaeQsfcEeLBmAQQHEwJt8d
 bnmKZUVHBoqAKD7bx6jkAqRq4KWSTrRACEYdsxaqyBAbssEIWsre5UcS5BIqBeZk+s4q+ZNFH
 7KXwofGkW5LdCtbELQXHPtcN0F91MGcnMsi8qYHgRZoXLo8icJEgznN/KPtnPSpH7/4TubAza
 L8kmQUg172IS0m+ShXugb66ec7IQwOYDlooUxrqNXrDE4H4O/JNid8LOndJBDFKuBnY4AIW5/
 vtOFqwUx7yXOkrCRKsStLmTVXfVmFcn6zRJiIkfQP0oHEptegSoykuvOhdAAJWuxEqs/IjKdt
 rZyG3kM6Ei1DqWCJc5ovuL41R9OtBEwXcFq0wA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_mtk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c1fdbc0..bf6eb8d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -383,8 +383,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

