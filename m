Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05017C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFC720833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LAwvOwB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfFIOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 10:55:57 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:37440 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfFIOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 10:55:57 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x59EtdRI010736;
        Sun, 9 Jun 2019 23:55:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x59EtdRI010736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560092140;
        bh=jtnoBODgvgkIn+oPvGbtw8+xb1I0SA+CgwTYY6nRBaI=;
        h=From:To:Cc:Subject:Date:From;
        b=LAwvOwB9hQSm+WPfhtyUDAMhWJPyJL+CTqLeX5Vs3p7o9E5MHva6iLrHb/E3ZrLh0
         ikQaaueHxQMqjfVY8J0bUOSgG2U3Y9DVbHf/37TogbHCAAWBL7dnuY0kxpwpkq6DgB
         dyhjHDiI20t4keuvQr9mYfirRKNNzWuFdIKbaRpluqPXPzRKNzDX3Pzptxme8QfRY0
         gazeIlAqU4xXGM32SPx1sCPTbQLXSHzQyHxI9uG/52NZ8NOUAlkdtcULt2F5r0nbzA
         Z/hSR84o4YTD9PKoXn4aUhMrNdBHiIuJB003dIBUojge326iIyUyspOyVl7Sj5PsKW
         p97Pvh5hek8VA==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: remove unneeded initializer for list_for_each_entry() iterator
Date:   Sun,  9 Jun 2019 23:55:37 +0900
Message-Id: <20190609145537.7953-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iterator is initialized in list_for_each_entry().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index aeba6366fb13..15b680507867 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -98,7 +98,7 @@ EXPORT_SYMBOL_GPL(pinctrl_dev_get_drvdata);
  */
 struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *devname)
 {
-	struct pinctrl_dev *pctldev = NULL;
+	struct pinctrl_dev *pctldev;
 
 	if (!devname)
 		return NULL;
@@ -288,7 +288,7 @@ static inline int gpio_to_pin(struct pinctrl_gpio_range *range,
 static struct pinctrl_gpio_range *
 pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
 {
-	struct pinctrl_gpio_range *range = NULL;
+	struct pinctrl_gpio_range *range;
 
 	mutex_lock(&pctldev->mutex);
 	/* Loop over the ranges */
@@ -368,7 +368,7 @@ static int pinctrl_get_device_gpio_range(unsigned gpio,
 					 struct pinctrl_dev **outdev,
 					 struct pinctrl_gpio_range **outrange)
 {
-	struct pinctrl_dev *pctldev = NULL;
+	struct pinctrl_dev *pctldev;
 
 	mutex_lock(&pinctrldev_list_mutex);
 
@@ -1642,7 +1642,7 @@ DEFINE_SHOW_ATTRIBUTE(pinctrl_groups);
 static int pinctrl_gpioranges_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
-	struct pinctrl_gpio_range *range = NULL;
+	struct pinctrl_gpio_range *range;
 
 	seq_puts(s, "GPIO ranges handled:\n");
 
-- 
2.17.1

