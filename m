Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE0C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97197206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577055;
	bh=9QHmlV3UC/Ih0nbNZ6S7QqAFc2A/UoarGKig2YK8eAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRSUrIhgcewIs+VgKAZrjiUa+okIS9N+HARScX9ITLtGPNTKlHNRKYmsoEweTl93n
	 vE3LVGJ3o6MSUoK2EICYY4YRqEIF+o+xIp/T6kwEPc3V0uiN1SUfkSAsWFgJrAuOTO
	 CxlAE82lt3tI7nDFP4Rc1B4ED3Zd17kysOAFds4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfGaMoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbfGaMoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C0D92089E;
        Wed, 31 Jul 2019 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577050;
        bh=9QHmlV3UC/Ih0nbNZ6S7QqAFc2A/UoarGKig2YK8eAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLmDhPMnwFa4bHwcL2y6xpUezufEHiDE7DhS2/7BfgfJWrIEYEYxH31VTQZEIsdIt
         YT+n/CCuy3wNxsvj2858TbE4QSuC4Sv1tSJpwLGWfyh3dJGiqycRYEnlAVsUUETR2P
         TcU5hYJ8Zp+lZ71ompEcetmnfk4b3G+DjeC9Iog8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 03/10] input: keyboard: gpio_keys: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:42 +0200
Message-Id: <20190731124349.4474-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a bunch of sysfs files.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/gpio_keys.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 03f4d152f6b7..1373dc5b0765 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -351,10 +351,7 @@ static struct attribute *gpio_keys_attrs[] = {
 	&dev_attr_disabled_switches.attr,
 	NULL,
 };
-
-static const struct attribute_group gpio_keys_attr_group = {
-	.attrs = gpio_keys_attrs,
-};
+ATTRIBUTE_GROUPS(gpio_keys);
 
 static void gpio_keys_gpio_report_event(struct gpio_button_data *bdata)
 {
@@ -851,13 +848,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
 	fwnode_handle_put(child);
 
-	error = devm_device_add_group(dev, &gpio_keys_attr_group);
-	if (error) {
-		dev_err(dev, "Unable to export keys/switches, error: %d\n",
-			error);
-		return error;
-	}
-
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
@@ -1026,6 +1016,7 @@ static struct platform_driver gpio_keys_device_driver = {
 		.name	= "gpio-keys",
 		.pm	= &gpio_keys_pm_ops,
 		.of_match_table = gpio_keys_of_match,
+		.dev_groups	= gpio_keys_groups,
 	}
 };
 
-- 
2.22.0

