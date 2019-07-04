Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97291C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2DB218BC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562230021;
	bh=+ThnAsF1ex2q6upxPj81qdHFANvTESX3zSvvx0uAZlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h0dgRMQzgzU4jwT2SyDL22QoNpmX+jwNZnl2x5yMFPgUPsxJ8L19aEFZeOosf+o8p
	 qMl6gbI5gWRHxykf62ajQ7x1CTWbBi6wDFFmcMfJvQICCAbeapNkwZR8nP4vsDNFn7
	 i2NH/ywGPej6kDwWO6pVXqWQdXdD10Gr5bDS9DPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfGDIrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfGDIq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:46:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2FF218A0;
        Thu,  4 Jul 2019 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562230016;
        bh=+ThnAsF1ex2q6upxPj81qdHFANvTESX3zSvvx0uAZlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwlHS41Wnso0LpBSRqAayCTAAQSxRzIJ9aMS+u3QBBCyugWEGNiwA2WGounbLF8yP
         1sY1LVa18SZC9AibsijFgDl54NygJ3Wb2Cp7V+5v5Uiq+Ot0HI4RypTj704katZ97O
         dFBBU9LI8cCbvbGydtqMUHPRC1Hm7jFbcIemDefU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 05/11] olpc: x01: convert platform driver to use dev_groups
Date:   Thu,  4 Jul 2019 10:46:11 +0200
Message-Id: <20190704084617.3602-6-gregkh@linuxfoundation.org>
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
and do not register "by hand" a lid sysfs file.

Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/olpc/olpc-xo1-sci.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 25ce1b3b0732..ce1948918dd2 100644
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
 
@@ -629,6 +625,7 @@ static struct platform_driver xo1_sci_driver = {
 	.remove = xo1_sci_remove,
 	.suspend = xo1_sci_suspend,
 	.resume = xo1_sci_resume,
+	.dev_groups = lid_groups,
 };
 
 static int __init xo1_sci_init(void)
-- 
2.22.0

