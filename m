Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA446CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903EA21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TocT4wWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503565AbfJXQit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41382 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503532AbfJXQip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id p4so26845255wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8DxW1d6v2NWJpBGtpmglXzzbNqCWfH+E3Y1OAoSPDQ=;
        b=TocT4wWJl8/oyox28PzGdGFVTCR25Etd7BhP7Qc2cT5lzmEIZQi4tVOoNnf+I+jzVG
         jH7I9TaqB1wIT4XzmJhJOBEWcNaJ5ICg+n0N50/AVxig+aa7g/rFuKqHScLtkHqD1DAp
         eh/o1FgmMvGXskWwY+tBnjWvoGtX5TFg3g4wy3Nm/0yL0A2lDLBM7gWPHzm7PYmnZEeB
         e/QOnIvS51dRheVYG+4wU+2vpucvGzRotxn7/Ub5aur/FiB+/VYXGyqTEAV2Gql4ncro
         faX5qcVVEkPX+IqaJDgtdfJVRys2rkt+pKna51QOy+7bQEu5rfElCk68o3c1diDOkQen
         hv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8DxW1d6v2NWJpBGtpmglXzzbNqCWfH+E3Y1OAoSPDQ=;
        b=d4hbNYkApd7XQMRxEhFl5ES4gf23cMaKQSyQBdXyyUE9dbMgfBL4m2fRiXf5HgAJCC
         DfQkWW2umsSc4hN89RaCav9+SueFWb+g0fAeI+21s5R7efGooN38lSkvljSbDNoNwLPX
         u6Re5cZ07Nd8LnmwCKf2svHULoVYrdx/AQfcuSfZckic4o0HbLSotvhjUDHNS+dzaZBj
         jsuJrcrbX1NvSMEWebOKaeqI4kxFFz8UciQt8FhjR6ay6T0mYhAcC6TMXQUHXWAV0yup
         zOifkUNXz4uoxkbVaN98L7WG8v6RdqJazkTXSggu565jj2V65AIgbfWMWSPrg4nIAWD4
         aDMg==
X-Gm-Message-State: APjAAAU8vEl/kwrS6qlL/jPQ1ihQqG6WYGu9l+Va49le8a+Rsi80SaAa
        YHdCl+qON5MO2OBy5CNZDxgqxA==
X-Google-Smtp-Source: APXvYqzqEEkHDBCb4DZUQVidIpkiui9GSpU76/wGElNi8aPtzMHnP5x265jbONW6aIDcRe7IUqFl4A==
X-Received: by 2002:adf:8103:: with SMTP id 3mr5023528wrm.194.1571935122686;
        Thu, 24 Oct 2019 09:38:42 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 06/10] x86: olpc-xo1-pm: Remove invocation of MFD's .enable()/.disable() call-backs
Date:   Thu, 24 Oct 2019 17:38:28 +0100
Message-Id: <20191024163832.31326-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO regions are now requested and released by this device's parent.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
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

