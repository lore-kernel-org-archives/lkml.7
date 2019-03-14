Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4555C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5612184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfCNWgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:36:49 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfCNWfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:23 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMFdY-1hMdWN1TK2-00JG0A; Thu, 14 Mar 2019 23:35:01 +0100
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
Subject: [PATCH v2 31/45] drivers: tty: serial: amba-pl011: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:01 +0100
Message-Id: <1552602855-26086-32-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RrhaH1V2yhApRvvvaZtoxAX7c0npCjW9x7ofTbyAp4JJexoeDXu
 VgCgkfPxOnd4RyjxsmSHh88smR49ypo/XC23MVHNWOgQ6N1w2CcXMoNpydlWWCrvQMRLPQi
 2IZTIUfDuFnD0iaBupDlWJtMF54wZ5A5zDWEuAgj5MrP659Kcr013u/1RtS0CwnlTYOWZr0
 WKH6/xjoUg4ACtBgMxuBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/QDu1IScZbU=:IXK2PaQZ/9vnkXPG8Wwayb
 1kua3tdbPc7mbBEC9l0UlVqmqRCb2f02y+LNMcmeLKLitk5Aqn/yKdQq6HvmNSAsKxJYNQd2S
 Ejs7Bn3RvxLsT8aPAJleHDXCSD/028cKdSSM9k2wWNFn5A0IQJS7tJI2piBddf3KAsJQlnXFZ
 nxopxuFgrU5qvl0oz9bl+GGpxoAtg+77H7BaBKiJqKe5elLq2DQwYPhyWCMa6R5+4YNL6+lPf
 hTpSAtWlzu5IEB+lAaSFUyH4EVzBxfoPrsBUCDlQIaPKPae7EwHdF2kjdpeCbphn3PnVhe00G
 XqVRzKOXl86epnrsdZoHL4GjRlyVr/CgO6d31rWlL/oZVvzupBzaCJSpzrP5jyMJyBOrq9oI0
 ZvGvxua1AeVE4nBuqlQldFMfqumQt+EQ/78YZgNaF0hloWQKXoMzQz6LpgM0PvWqIXN4suapn
 VpPwKjWTLqnNCQKP0Iubr04WRvAB7D3usSr2rrPV7QKvMICppXLKMcMcnMoQL/rCWhJd2N+T3
 RbpdCUk+m1w1G2S7fkX4MK6arVQz3Wd2mQ2OAp4QBuRB/4pJMNg7Vc0FL9QvHpKkk0bLq7Oqw
 SKr8BQR6P7qR6KjZWYB6iwZaYzgsuKKrDuJ4LO/Lx++PsXE8DBstxlPRQMiUKD4Mds/ZQDky1
 vPFVseyvoy+bPAkC+xxFQQOENvNgcFyBU0FZ5B+c5cDKEcSbBooBGc8JQwCNZSDDRju5P9wx7
 afZT0OR7egVWlpIb4+JJQciZX0vXUgor9gFWdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/amba-pl011.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade21..2a968b2 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2098,7 +2098,7 @@ static const char *pl011_type(struct uart_port *port)
  */
 static void pl011_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, SZ_4K);
+	devm_release_mem_region(port->dev, port->mapbase, SZ_4K);
 }
 
 /*
@@ -2106,7 +2106,10 @@ static void pl011_release_port(struct uart_port *port)
  */
 static int pl011_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, SZ_4K, "uart-pl011")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       SZ_4K,
+				       "uart-pl011")
 			!= NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

