Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E7C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38702171F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577059;
	bh=mYJJh27t+/bVqb2P718LNvvV/gjJuz87nyy7thlZJXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UpaRfjnWrS0isprquieEwGs5ZMY7czwrWfCrHBf9+PlBIWftmGND3Y5a0+XpkMu/I
	 R5ldoX1EDEXWblpK7qvUaxSTepxx+FQYp3p4mAXefHn3/+gDnNTwtwds0GkAWZbxP/
	 Fe4tHwrLzpycjMRn5+/++RK6+7eEaJalFc7Wo0JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfGaMoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388013AbfGaMoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC5C82089E;
        Wed, 31 Jul 2019 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577053;
        bh=mYJJh27t+/bVqb2P718LNvvV/gjJuz87nyy7thlZJXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCt5O2rqUxNFHOYho9ko4FSTDwEKfpYA21/ZZQ36r9aIv0cjPJUCnSxB6UhEsZUk5
         18xUHVSQYnqCFpwDzlKbBMZ98TrhcDbnIqze71sULACdVKdWaQrv1aCSxMuPNl5irt
         rpEL3LxDSu5v3OGKPR+i0EUbHbW3st2mipezsbxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH v2 04/10] input: axp20x-pek: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:43 +0200
Message-Id: <20190731124349.4474-5-gregkh@linuxfoundation.org>
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
and do not register "by hand" a sysfs group of attributes.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/axp20x-pek.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index debeeaeb8812..235925b28772 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -195,15 +195,12 @@ DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup, axp20x_store_attr_startup);
 DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
 	    axp20x_store_attr_shutdown);
 
-static struct attribute *axp20x_attributes[] = {
+static struct attribute *axp20x_attrs[] = {
 	&dev_attr_startup.attr,
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-
-static const struct attribute_group axp20x_attribute_group = {
-	.attrs = axp20x_attributes,
-};
+ATTRIBUTE_GROUPS(axp20x);
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -356,13 +353,6 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 
 	axp20x_pek->info = (struct axp20x_info *)match->driver_data;
 
-	error = devm_device_add_group(&pdev->dev, &axp20x_attribute_group);
-	if (error) {
-		dev_err(&pdev->dev, "Failed to create sysfs attributes: %d\n",
-			error);
-		return error;
-	}
-
 	platform_set_drvdata(pdev, axp20x_pek);
 
 	return 0;
@@ -411,6 +401,7 @@ static struct platform_driver axp20x_pek_driver = {
 	.driver		= {
 		.name		= "axp20x-pek",
 		.pm		= &axp20x_pek_pm_ops,
+		.dev_groups	= axp20x_groups,
 	},
 };
 module_platform_driver(axp20x_pek_driver);
-- 
2.22.0

