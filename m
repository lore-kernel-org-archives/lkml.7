Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D2C606B2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7666D2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfGHMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:38:53 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfGHMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:38:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFsAJ-1hiUBN3Zux-00HNox; Mon, 08 Jul 2019 14:38:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Osipenko <digetx@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: tegra: fix debugfs compile error
Date:   Mon,  8 Jul 2019 14:38:17 +0200
Message-Id: <20190708123843.3302581-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MSFUKXJPI4w10gi5nIw9N7d6gTewK6MnUXHlro7LaCUr6eFZ32c
 CVfIwEp/Yeh2OhpLrwyRjgIVMO5VvpaD6HE4pdXXoesHctLKVesrcGNX3JbJ6V3xjVERn4J
 HOMNBm2NYE9hdU2W600TMEH9qHk6BmEGTny9CIIUUpNcQIOXNYjfwNPvwMo8T72gXkgDl7p
 /yuw1mdSJjFQ3zuMGWqxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mtajkxsIi98=:gEYCd7m+A0QSVqeIysMG6+
 I8KyaNRiW26n1eB4lByLWF3jJDDBdojMUsI8iWNqG5k14EE4JQjWZQ9EmVlVcvnxnQsxdZ2wu
 FNorKrqPUQugWbe/QePFvtdkYuJzJnmiermFLrmcVmerxfgluQ6TvLBO7XeOL5DU6O2bweKMt
 QjnyHD/caoKBS0idl3Fe7rNHZJYKjtR2HcRHwgcxK5sfDOVu/Uvy5gXv2OC2nDbXGTVDVfMjl
 kteR5fl9+Pg26kS94OxE1Yte7HjN8fE1kOJyci1ZeLyLqWBFnVnIbcFtSRvxGPvdomm8bsNqT
 wKFkMIb8fsu33boEPOKVabhv8CtTpCjeTZNzFYlKs9uov/q36g1sh1jBrmIA9a/Zv7fjPZBvZ
 HZFjfgvLkKXmM46gLB5MnHr5k580PHUxeXC/JU2fEQ9EeeA4qO9KOUjAgaFRdUzsM1Kpq/il+
 iYJ/k+CTAWbS+rJ4tnFbvJjjpZk4JdGgJArWxWyTmDObvIKiQQ7jgUxD66jei+D7mNDP/fIcU
 Z+l8SVz/wzV26Swqw4hjwH1DNYpWoIf4DSXwnyfq3lg7Bn1XmOJt8taMG/LWZkbmq7Mmk5Bkh
 WeThMPl4iiExHOuV9hjB40mqH9kmJD074vp6D7VltBZ8CEm41qR1G2Tn+xKT6c1uaCC4f11dN
 A87qC0mjojL7s73TRNLtqdfDs9KS3d4DAYrnGRrynd+FV0Fp7lVjyNe0lMx1jMBl4hVtl6B+N
 e9g0ypuomU8RZxnrqaMknmUTJbgRJaGrglSwwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this header, some configurations now run into a build failure:

drivers/gpio/gpio-tegra.c:665:2: error: implicit declaration of function 'debugfs_create_file'
      [-Werror,-Wimplicit-function-declaration]
        debugfs_create_file("tegra_gpio", 0444, NULL, tgi,
        ^
drivers/gpio/gpio-tegra.c:665:2: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
drivers/gpio/gpio-tegra.c:666:9: error: use of undeclared identifier 'tegra_dbg_gpio_fops'

Remove the #ifdef here and let the compiler drop the unused
functions itself when debugfs_create_file() is an empty inline
function.

Fixes: a4de43049a1d ("gpio: tegra: Clean-up debugfs initialisation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-tegra.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 59b99d8c3647..dbcecbe5f52f 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -9,6 +9,7 @@
  *	Erik Gilling <konkers@google.com>
  */
 
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/irq.h>
@@ -22,6 +23,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
+#include <linux/seq_file.h>
 
 #define GPIO_BANK(x)		((x) >> 5)
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
@@ -508,10 +510,6 @@ static int tegra_gpio_irq_set_wake(struct irq_data *d, unsigned int enable)
 }
 #endif
 
-#ifdef CONFIG_DEBUG_FS
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
 
 static int tegra_dbg_gpio_show(struct seq_file *s, void *unused)
 {
@@ -538,7 +536,6 @@ static int tegra_dbg_gpio_show(struct seq_file *s, void *unused)
 }
 
 DEFINE_SHOW_ATTRIBUTE(tegra_dbg_gpio);
-#endif
 
 static const struct dev_pm_ops tegra_gpio_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(tegra_gpio_suspend, tegra_gpio_resume)
-- 
2.20.0

