Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4702084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfFQSks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:40:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55045 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFQSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:40:46 -0400
Received: from orion.localdomain ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M72bv-1hhaSb2MWN-008X1c; Mon, 17 Jun 2019 20:40:42 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 3/3] drivers: gpio: mc33880: use subsys_spi_driver()
Date:   Mon, 17 Jun 2019 20:40:40 +0200
Message-Id: <1560796840-18207-3-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560796840-18207-1-git-send-email-info@metux.net>
References: <1560796840-18207-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:IaUNo2LISoksoHpM067Yxxizrv4ia1vDNAPnlkCC16FLenVR/LQ
 2nKdbvumgxiAy5amfyeRkCLUDjJ5YUkeI/Y6zQo9bMbqu2P1iWjxKAiDvP9nzMY76xNoAWu
 jE5IHsRJ4DJS2EYxJRa3taqOjZ3lFTgocePA5Bm+kqo2Jx0kjAOWlcheqMJmXE1Nk35bv9e
 n0S/ffXhfURKOhxJJLf2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ymbqzy7Jl74=:71GHVSPQfr8zkDMir2bKNz
 kKntcIsG1RtG+fLZVgTO35auZOdan2142hoIlBPNEYLOPs+5xt1ur/MPNHtTYMxwAPOP+JjNG
 ACkGAmhCLWgVIFfMa1YRZg78D0X2WVzLhHJngHyPJYai3nyK4nJmJAd6Up71twKJSvCZhnBkJ
 Zo93b68bYpm9U3fSBsSAGh/wBFFS0FXpHBrlipDcgD0oCt2EJMudmJ6kde2GRpm3YR4ST7wfB
 qq3ZB9e2C2onAP1V+OEgt5JDqoupaY6fuV+y9hW0ozfAg9mva1XJBUrvT+l4E1+UgkZ38K4a7
 FUjEq+yZxJrTQMNcM/m3kSK/R2iv7eJBD09NrJYJHVePjzS9cw/az678GNBTzSTPBEdFqau7h
 IYnRBvnZR8+XJeoibstEvhUrzbQwsXYCUak/Rk9SRoFVd4pHo6qUcdeEWBceR/PAq/FgGKZHD
 wJH9CkTDArqr9FMHtUb5rJvysa1AdsQbe4WsZeHeB8rd3Nvw8GxbGntyavgHMIyQxcZ98CrIS
 peIO3XX0OJOwFqj73/aDlScRKZOYwgZlrvIyiC6MhXkZASzYLuLq4T6xVGGz4JjRG4Lu0aUaU
 GDE6s0ZhoqDfS8ZYNmdP4sNKQQg/hhW4OFdcr1+sQCY1r4Y+28Wzk2HEmImVVBjeThVVMYdkH
 PV6mYT8KOGT5uI7KD/2KuImp3zQnGuvxKoJQnMd2bPpYwBu4z4ewFM/2faiKgtQWkzxERKyFb
 jqJfEIV8cnUwzn1BsE1tTBU0dcIMICaUwd/1LTkKDVDCNJ+sJgju/v6BFfpEY7NKKpaZmugzX
 2jf11ompMFwFkDywNmUlxAoh2QYxh6dXsPJeLeA5t179wzQcox36lOaaVeGW01OdFIggqPoWS
 1G2xhwxEI9gUFaSsTHwj+lEcv9VCAxvo2gwzAMYRBusWm9jXAaialyBkjGwYCYrXquyce5LYa
 J+MdfmFvhEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Reduce driver init boilerplate by using the new
subsys_spi_driver() macro.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/gpio/gpio-mc33880.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
index f8194f7..1b9434c 100644
--- a/drivers/gpio/gpio-mc33880.c
+++ b/drivers/gpio/gpio-mc33880.c
@@ -156,21 +156,10 @@ static int mc33880_remove(struct spi_device *spi)
 	.remove		= mc33880_remove,
 };
 
-static int __init mc33880_init(void)
-{
-	return spi_register_driver(&mc33880_driver);
-}
 /* register after spi postcore initcall and before
  * subsys initcalls that may rely on these GPIOs
  */
-subsys_initcall(mc33880_init);
-
-static void __exit mc33880_exit(void)
-{
-	spi_unregister_driver(&mc33880_driver);
-}
-module_exit(mc33880_exit);
+subsys_spi_driver(mc33880_driver);
 
 MODULE_AUTHOR("Mocean Laboratories <info@mocean-labs.com>");
 MODULE_LICENSE("GPL v2");
-
-- 
1.9.1

