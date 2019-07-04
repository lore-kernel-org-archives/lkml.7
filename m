Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1610C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7086218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562230005;
	bh=/nscaZ8tOKoA1xhpKbG/KBNAKedrtqbPGjp5wJ1TSpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uvHHQXlrXCgKJe5J2BH9u4fAmCl8q8hpDLfC9J995KGi0v0eLOakkumM8ZW/ly9tL
	 M7jHEaa13AUazhNLf6Q5jn0ZHDbpkYi+fq7OSb/h7SNFeUCvPV+Ywr7zztinWsHzOz
	 P6ydEvLMEolWmcw/mCeTAvfSvpyEfSmbqAKyiJJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGDIqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfGDIqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 626A0218A6;
        Thu,  4 Jul 2019 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230001;
        bh=/nscaZ8tOKoA1xhpKbG/KBNAKedrtqbPGjp5wJ1TSpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+DCsUahJo9iDLvMN0Xcu4HnNamjXiAT94J/+uj5N3iNe97RaB4mbBXXducoiirEQ
         9SeyP2XeHF8q+au1V8zq5T3zJ5GQXBFD9ndhdnYrrDIQRlPEFKdmUcbbvpsZ3DwoIv
         P5TLC/YESUEnwbFOB7AJWeQG22osfis4URZS4F78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 10/11] input: keyboard: gpio_keys: convert platform driver to use dev_groups
Date:   Thu,  4 Jul 2019 10:46:16 +0200
Message-Id: <20190704084617.3602-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
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
index 6cd199e8a370..1f6547440edb 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -354,10 +354,7 @@ static struct attribute *gpio_keys_attrs[] = {
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
@@ -856,13 +853,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 
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
@@ -1025,6 +1015,7 @@ static void gpio_keys_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver gpio_keys_device_driver = {
+	.dev_groups	= gpio_keys_groups,
 	.probe		= gpio_keys_probe,
 	.shutdown	= gpio_keys_shutdown,
 	.driver		= {
-- 
2.22.0

