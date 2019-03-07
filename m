Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7227FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B55720835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCGJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:31:46 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCGJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:31:46 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0G9p-1gqMWs36Fr-00xKPP; Thu, 07 Mar 2019 10:31:37 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] davinci_emac: always build in CONFIG_OF code
Date:   Thu,  7 Mar 2019 10:31:20 +0100
Message-Id: <20190307093135.3354493-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:etRUGx8QeL6QeLXRQ60BTAuLTz0VVTEPwYa3rS1B1VWaaHj2I9L
 q0dgHKJAkEy6zQqDz2C9SUobsICWNfq04buS7Jfo40LaSsd+x+aQls6GkAmkt0C5YBrezMz
 9oN1InRt7oIa9BrTloJVRnfqac8Py00hKjoflvL2ddagHnZjvBBRMw6Lna+/KDufTH17Z+c
 6Cck4/xQ3ZkjsXCKhmDdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8OJzxD7Lm/8=:e001oIdIAnmkHtROl44u37
 o6t/ebU8MAjDeD7lMuDJVMTmkJafR4Qmi8ISXrrQMlnzmTdJ9lLeNA04XX4A988WxVvNW0+f6
 dOLC4oaGDHt94XFbJmD9zkq+KYWqTIrg31bVayp5cNJrNJOUNL8dwlfW0UQvcNvXW3H7MDP7T
 zl2z+U2m6kQjNcapkMgcC67VMGQU4NA80L+7OrivRukvRqoknF6gr7YF7SqC/ROBRVRGXI4m4
 dKMLZUtoeDrTs3XIrcT0NKyxI3phAPyB2AlXFMu7uSwgUJkSjkSPXU8R1wgXm8arozaUVtXwp
 TQc9s5QExvyb6BWlk1FqeYmPGUeqTpWQvsBZEV0xMt3HByFaqY7Gb8Kf7gKFPCdld4W5SIgqh
 jziqCRrkyZAD5qAkh/1VxddY97S1kahJtRV+pd1ZTD1rHF979sMfpxWOtuipf8cUp+xq7Lup4
 SzzvBrvRQMMV3sORpL8aRuZ68lVWIwFtueM/Z0lanvEo3pwu25eoPYiIJTWmEtKl+Jqw/K1Hw
 qk+3VuhxLIH9dhQGPnEByt3DS2Uv0CUn7+AG6gSPb7udO4tVki4/jUQeDIu/fHt3XCwQoKbXU
 1pw3ckLMI2c2xdOT8yvlAIqKahzilG/opUknnlOgxPOqFw8uKFPN4fbal2bKuXUr/mRjxmrei
 9H3YPEzeBuHOnNKLCh24A9zdrwbhY5D4RAH6RipNCeOYvtyqTyE05ihFlLrLnQ6MJSP/vz8Wz
 g5ReyOwxTKovqmHMSaTRENblIcjLyZyqLVkKAQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns about what seems to be an unintended use of an obscure C
language feature where a forward declaration of an array remains usable
when the final definition is never seen:

drivers/net/ethernet/ti/davinci_emac.c:1694:34: error: tentative array definition assumed to have one element [-Werror]
static const struct of_device_id davinci_emac_of_match[];

There is no harm in always enabling the device tree matching code here,
and it makes the code behave in a more conventional way aside from
avoiding the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/davinci_emac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 840820402cd0..57450b174fc4 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -2029,7 +2029,6 @@ static const struct dev_pm_ops davinci_emac_pm_ops = {
 	.resume		= davinci_emac_resume,
 };
 
-#if IS_ENABLED(CONFIG_OF)
 static const struct emac_platform_data am3517_emac_data = {
 	.version		= EMAC_VERSION_2,
 	.hw_ram_addr		= 0x01e20000,
@@ -2046,14 +2045,13 @@ static const struct of_device_id davinci_emac_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, davinci_emac_of_match);
-#endif
 
 /* davinci_emac_driver: EMAC platform driver structure */
 static struct platform_driver davinci_emac_driver = {
 	.driver = {
 		.name	 = "davinci_emac",
 		.pm	 = &davinci_emac_pm_ops,
-		.of_match_table = of_match_ptr(davinci_emac_of_match),
+		.of_match_table = davinci_emac_of_match,
 	},
 	.probe = davinci_emac_probe,
 	.remove = davinci_emac_remove,
-- 
2.20.0

