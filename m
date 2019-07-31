Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C08C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9807D217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577064;
	bh=nNiZ8ynXsKlPw8+PYgzgNs1LsM+1eB+GftUFsgDMy6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HFjRUJmm7Hd1t87czcqP6Yh3CZM8GqvYgsYJ5dNK33e5nspyMFpVrOiyfOb6uqRcL
	 x53tXpZwiT3fyLePcNVRlz/+JqYhuZIa0GXsTCUix+92ycESubYOlDkGJFyMVB9MYU
	 5Abbd4p34/huywdPTgkJBeqM6Fkamh5bezmOTT5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfGaMoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbfGaMoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB91208E4;
        Wed, 31 Jul 2019 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577058;
        bh=nNiZ8ynXsKlPw8+PYgzgNs1LsM+1eB+GftUFsgDMy6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/WtVdWGA34wtP6sZsoQK1zpZAAmOBxt2seI7YTbgXcQG1M2VAMPJs5wN4VT5lbHr
         J4tVeM3kFsvX3fSyJZFaLGlDpJiuW5o6f3O3BVtE+XzfCYsgJZYz9H5/zcsdCZmV23
         7ijyYCBHHAoeV3LbNcf7OKAutS/u9+LcGnta5er0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 06/10] olpc: x01: convert platform driver to use dev_groups
Date:   Wed, 31 Jul 2019 14:43:45 +0200
Message-Id: <20190731124349.4474-7-gregkh@linuxfoundation.org>
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
and do not register "by hand" a lid sysfs file.

Cc: Darren Hart <dvhart@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: platform-driver-x86@vger.kernel.org
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 25ce1b3b0732..99a28ce2244c 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -157,6 +157,12 @@ static ssize_t lid_wake_mode_set(struct device *dev,
 static DEVICE_ATTR(lid_wake_mode, S_IWUSR | S_IRUGO, lid_wake_mode_show,
 		   lid_wake_mode_set);
 
+static struct attribute *lid_attrs[] = {
+	&dev_attr_lid_wake_mode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(lid);
+
 /*
  * Process all items in the EC's SCI queue.
  *
@@ -510,17 +516,8 @@ static int setup_lid_switch(struct platform_device *pdev)
 		goto err_register;
 	}
 
-	r = device_create_file(&lid_switch_idev->dev, &dev_attr_lid_wake_mode);
-	if (r) {
-		dev_err(&pdev->dev, "failed to create wake mode attr: %d\n", r);
-		goto err_create_attr;
-	}
-
 	return 0;
 
-err_create_attr:
-	input_unregister_device(lid_switch_idev);
-	lid_switch_idev = NULL;
 err_register:
 	input_free_device(lid_switch_idev);
 	return r;
@@ -528,7 +525,6 @@ static int setup_lid_switch(struct platform_device *pdev)
 
 static void free_lid_switch(void)
 {
-	device_remove_file(&lid_switch_idev->dev, &dev_attr_lid_wake_mode);
 	input_unregister_device(lid_switch_idev);
 }
 
@@ -624,6 +620,7 @@ static int xo1_sci_remove(struct platform_device *pdev)
 static struct platform_driver xo1_sci_driver = {
 	.driver = {
 		.name = "olpc-xo1-sci-acpi",
+		.dev_groups = lid_groups,
 	},
 	.probe = xo1_sci_probe,
 	.remove = xo1_sci_remove,
-- 
2.22.0

