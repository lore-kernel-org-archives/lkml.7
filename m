Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A4E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfCNWjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:39:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbfCNWe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:34:58 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MD9CZ-1hDfjf0Jv7-009C3p; Thu, 14 Mar 2019 23:34:34 +0100
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
Subject: [PATCH v2 02/45] drivers: tty: serial: 8250_dw: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:32 +0100
Message-Id: <1552602855-26086-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Mb1aUiA004kr2uSah9d4wlExLRcQhipnWCVS4BAcbnoPRYa/bss
 oD79K7HFQLndrlsEJ9Of/JgeFlbQKlOZCP8e7yjRHKTfSWITjQmzqYj409eAlymUCAYoH4o
 AdlkKdRz/SQvcjgvoCKtzVLvitt8JRmKd8ZYJeJOTpsGVYP+m+lx+195F8YLDvZ9CH1a+Gx
 E1SsaYN4GON7eQmGjxLOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bz/JnTN5/Cg=:pzgRLkhM8Dp7W4fhrMgzkV
 9y9qX9W2gK8YS0DbuZNBaFXI3+xB/cfm5J1jCxFpDpdEHrc8YmVY0dCSp97Rqh99TJlHsGRYY
 SyncdxE+2AMlWM6CJ7UOIS3YhuNXwxQ9s2ryMnTo1uTDeHEkaqmNuBgFNyNf46cDcxyvGPHO0
 6ZDv2vZHtJakrEGw0jdB6yqO4l7DGKJbRU5strhw9ou8U37CGbTbDoPYCqRRDgr3uo2dZ9o9r
 dRPkd5eU9Kg0PiiG6QIK9L41SLEvJIFQR6Zhr/mOHcz34UJvkr7/qLS/20PgocfBB1nnkU77a
 k912N7WV147R6JPfTPoQmbQEtOnowIg1ZrAKKRcTVzpuRiLglLu28iGkIfbyu8wQAX21OV656
 3azpbykOf0omdEi9pEH7Nv1AHUUDvFcyTqaTitlZ2N9I40RJ0SOTy1HgcesFZ6zoeJSB+WAoE
 +ckp9PF5hitnxGLhMzVEmyCSF4Iw7SuBIab4rmgFhDKaUWgxxO0CmtglDPc8hTsWGU89Wuun5
 dswUy8L0a6sRkeQs278qRnZo3C30ZZcOotsulUmCPVb9V46HMbTQT3kaovmyZAu5bHflTFJge
 etFCpGHjEYHLixWt2IfKLYb2i2DgjZoXT+asuiQLcj3nIlyimPNf5dNWEOQRJtjGNjNhAguEx
 jlWBC/cQbi6D9BYs4lxl0Zl+hSnGeck62Togmf7Sx9LOt+T6pNIDHjkrUYOBddX4x7ay9/szs
 WgjMsq5NQgdJhjjH9lILaBokEfTnqr63bGHlJQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index d31b975..f0a294d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
 
-	p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
+	p->membase = devm_ioremap_resource(dev, regs);
 	if (!p->membase)
 		return -ENOMEM;
 
-- 
1.9.1

