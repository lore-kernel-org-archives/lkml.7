Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FFC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D0520828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfF1PBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:01:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfF1PBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:01:01 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N3bnP-1igMhk2e9b-010foi; Fri, 28 Jun 2019 17:00:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] devres: allow const resource arguments
Date:   Fri, 28 Jun 2019 16:59:45 +0200
Message-Id: <20190628150049.1108048-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7HaU4MfOZRB/0B7B7E6dS8eFJ8e83K8wvXwa/iBWn+c1jz6wkUy
 +jqLflgmpmaLeF1KKn/jNXCkE2kAkPuUGr5z9EjLDeGW6D43zXnzQYKN8d5tKD12eqMoyPY
 qtEFjtjCw5tQbgCvSxsjsjuyV9Ur9KuBUwhBnOhdbWb8BqxsH34iAwmu70CazaFCOvy4mFF
 lmUSsV+lsrJWO8t+tVwYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZJ8xNSFPStc=:v47eXc+cdMNbNOTNCCv5eQ
 8/hQAZ4N/zhYXl6BVMTQWGeuNrcvTEMC7sKludbH8axdtg2FdYLUFPPam1ghaHMqe5rg03BJh
 R0GUty3pPYQBqzrTvFWSArqRx62Fx55CSeT20JedseCjrV3Z4BBXVY/IA+3xCjUt1gBBiFj2u
 fNwoVpYCTZOBvAdGXF/St5/YS1oOmdVoVupcjd+u8T/ADwSN1XaXK1wnFIRF5qmgho0UWFx96
 K/Bazl9RdK6686/b7gP+Y+HNIMH8TKz+bl8JuvPwoJntsN8G/xhfrLRwQw88fjolrqNX6D89Z
 hDD/j9IWXtObFy/Pd/p5jx/u2Xxp455oNxj5eXOjO1irQ+3z3xENXO8tQ3S3lAVYeOcstDfLR
 KRJwrp65sL6iXv16UwZHWLBQFrFC6D7avHMR18f62js0EmE04+kXuH2FqMKUVvXBSfVdsFmoP
 ECUznCJq0QGoSgtjtxwPqqgfqPNEHyboGZG4CiaWld6R4lCdNU/cDbh4nOnKvTKfTQqnRgZF0
 Yh2R6PndlKarFukiShw0w29VKdmAo3FqDjQT3IUrd6cZW70ZE6p07r83R9CfRfoNDXgfkd6++
 65+OThQM1H1whiSHy3vOqXeQ8TvP8pDY7sU60bhif7j5PEdRqI6ieRL/p8tGOjYn+oIUif0ql
 9OIkWZ8Ul+f2bfB6A196EXwsl4qrvXwAARQV13EhMoUjCJ7XICWqMsd3OGzS9OVkX0Cah9MgV
 ZRMV/NA8alftJIsrprOd5kIOPIXQworFHQzpRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() does not currently take 'const' arguments,
which results in a warning from the first driver trying to do it
anyway:

drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
drivers/gpio/gpio-amd-fch.c:171:49: error: passing argument 2 of 'devm_ioremap_resource' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  priv->base = devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
                                                 ^~~~~~~~~~~~~~~~~~~

Change the prototype to allow it, as there is no real reason not to.

Fixes: 9bb2e0452508 ("gpio: amd: Make resource struct const")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The warning is currently in Linus Walleij's gpio tree, so I would
suggest he can queue up this fix as well, if Greg (or whoever
feels responsible for devres) agrees.
---
 include/linux/device.h | 3 ++-
 lib/devres.c           | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 4f65c424e5fd..f4ff92a6a56e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -705,7 +705,8 @@ extern unsigned long devm_get_free_pages(struct device *dev,
 					 gfp_t gfp_mask, unsigned int order);
 extern void devm_free_pages(struct device *dev, unsigned long addr);
 
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res);
 
 void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
diff --git a/lib/devres.c b/lib/devres.c
index 69bed2f38306..6a0e9bd6524a 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -131,7 +131,8 @@ EXPORT_SYMBOL(devm_iounmap);
  *	if (IS_ERR(base))
  *		return PTR_ERR(base);
  */
-void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
+void __iomem *devm_ioremap_resource(struct device *dev,
+				    const struct resource *res)
 {
 	resource_size_t size;
 	void __iomem *dest_ptr;
-- 
2.20.0

