Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09511C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF46A22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTMgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfHTMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:35:59 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvHa-1hmlhW0POy-00UvhJ; Tue, 20 Aug 2019 14:35:50 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/9] drivers: ata: ahci_seattle: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:41 +0200
Message-Id: <1566304548-19972-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:8p4Km0MCnpVjDS1WNM0GIZVy6MCCkt6Cv7JtBwcg2MXrS60BV7A
 lvFcRZeDyIm3aMe7keYq/C8erCHDJdlNa5anpt5mUUZqrtgg339e2zkMHQPZzSswJypMLQO
 jJVSsti86pe+gVBYSN5XmCC/jAcsqVknZY4aRjL/76i4LweKHT5I6Efk4gliE4fR/mNG4wA
 fkplgQwKHfH3o6iVRzpog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mBQMjtd9fJg=:xsdD5yxAnXqEEBD3r3gsd0
 xnGtDN6s5tx8fdaz3FsQjGD3qpeDRer8W4ZkBPpjpoXwV/LGE2eGCD0OKwmGJ+vL1KARuXtYX
 NDW1Q17CNUFixKaXjPJ5pmqC1FB//P8MD/c1DgETY2P3qTKkbkQGScHtPwTLn0d+sBNn3IKZ3
 XI6R/1JRqQbf7E9U7E7AVDUiriVSKnR34DWj4kpDe3vlpDjut0XFjzHksTwqp8AitZ+VOJLjD
 Krzuz+jnXXKTXFe9kxdVF2PVg/YPdu/853y89G6zyvktpp/j/RV1NmgeayTrcK39tnCWa7CH/
 QSoWm/7h0ZpJ6K0GCRie1SL3zNHMaPQknT5FeMoI/puWwAi+HBny9l13+i4tTBtKWHjZXuut3
 IR2TsBj2gIoWVIceCJCK4BX5xnndSvkIpmTWj0CFt/MluJA/QlI63FJdL4Z5jAVMB89jltuLk
 jnNVx7sAgXObyxiiWJqAxZQlOiTpU4AQio0wz9RxpNJ9clvubjgjWeCdTzd6y6wK3vz/YNW+r
 rKjMrNZMQ0CGfHAs65Yxy/SpSJmIAouGUIGPbiWiqBQWxJI7rr2RPPKYqQ7C+BycPqdMboXXf
 goaOG37ivhAa0Jd6MJ9KFpPC3W2CiBxQ2ualHd/vfG/+EjxwyN6MiSuiGPqq23ilDcdK2P3O+
 ErsBKjUythOtRyoPUxbMjbSZVSQseguuTMJTu8H3J6X0NDq9MIl2dY5egwtIptHuMlR7ZI208
 AJqWfMbahqFvF+mRzXVqcRcyvZUrGMNr9idYsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/ahci_seattle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index ced12705..2d88d36 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -132,8 +132,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
 	if (!plat_data)
 		return &ahci_port_info;
 
-	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
+	plat_data->sgpio_ctrl = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(plat_data->sgpio_ctrl))
 		return &ahci_port_info;
 
-- 
1.9.1

