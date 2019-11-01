Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28230CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1463208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SWoRZn1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfKAHph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38732 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbfKAHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so8814090wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I+jRYJ+sv8PSuO5nB4vni872MPFD94JrjqUMD7lrsKg=;
        b=SWoRZn1TJzuIfLyY1vbC2tQKk7pxk2GocVuGBSqprOkpeT/3QhldJootnOYUFiUoCW
         gffwSB1PUQOvQUhc2IycslRcwMVtl0OGCyKY0JVj/7TY2tCwLsJ7NLKuo6qX/6e99LH+
         EpUyQKZrmnfU0fxcYD5J8438Ap+OkYn1pfEIt4AwNc+nu+Q+JDNuETpOqdH/IO3Frftf
         AX0sEGoxCggCDq9ru0P8HsrzgbWjCYKktoN/oIUKG9DUzGDxeiSFH565yAseyidSK+s4
         MdmyH8jZckm8ulA1RFijtPeSaxbpDU+Kk56RJq5tAF/riUxZchUB1MBrz1uJdPhjr6wh
         e+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I+jRYJ+sv8PSuO5nB4vni872MPFD94JrjqUMD7lrsKg=;
        b=Rm2eU2wifrgp5mQd6MnY9c7P9I6V/Sr3jw4HbKwIMTJct9jDRlDwCcusb5EpamsgBN
         6g8SiNJIL+HOMD3ixKlWqCXhZnnIaG1gBARtWRh5NHJiiSNL4NwAF2Nbfn2zGpyshJS6
         sAzIxt9LUY3lpgwcl0LJOiIwLyEGesTpoGMRy/8QBq8JN207XV5/gqN1ZOdywprK28B9
         OdJvcKna7St45a8jgIFlfrfw6Y2dzj/V+uZ7I68WN1PkytxidF4ugf/Jattpl34N+3mX
         52OxH9jiNwLihfIi9TB8PvFkh7bt1AKhh4L+zd5o6mNgojMD1asceQM2GvwkC7bxIbPg
         PZ+g==
X-Gm-Message-State: APjAAAVccwQghCDWcSHeZoPNOeLSw31+SFTIOLlYfWVlJXHj0/fGQJqi
        bB7dtM+ALXQx7fNWmsKRBoAV3Q==
X-Google-Smtp-Source: APXvYqxrCw7zoPnntyf1vR3z7pJtOfHwiCDB2D5feX67g3arLBjDWeXDbRLO8m4RaC53pOLD3sb7Bw==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr9394442wre.183.1572594329634;
        Fri, 01 Nov 2019 00:45:29 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 07/10] x86: olpc-xo1-pm: Remove invocation of MFD's .enable()/.disable() call-backs
Date:   Fri,  1 Nov 2019 07:45:15 +0000
Message-Id: <20191101074518.26228-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO regions are now requested and released by this device's parent.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/x86/platform/olpc/olpc-xo1-pm.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index e1a32062a375..f067ac780ba7 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include <linux/export.h>
 #include <linux/pm.h>
-#include <linux/mfd/core.h>
 #include <linux/suspend.h>
 #include <linux/olpc-ec.h>
 
@@ -120,16 +119,11 @@ static const struct platform_suspend_ops xo1_suspend_ops = {
 static int xo1_pm_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int err;
 
 	/* don't run on non-XOs */
 	if (!machine_is_olpc())
 		return -ENODEV;
 
-	err = mfd_cell_enable(pdev);
-	if (err)
-		return err;
-
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't fetch device resource info\n");
@@ -152,8 +146,6 @@ static int xo1_pm_probe(struct platform_device *pdev)
 
 static int xo1_pm_remove(struct platform_device *pdev)
 {
-	mfd_cell_disable(pdev);
-
 	if (strcmp(pdev->name, "cs5535-pms") == 0)
 		pms_base = 0;
 	else if (strcmp(pdev->name, "olpc-xo1-pm-acpi") == 0)
-- 
2.17.1

