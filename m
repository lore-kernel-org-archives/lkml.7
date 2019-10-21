Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79131CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3C02084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVJ355dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfJUK6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfJUK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id p4so13409450wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N1QWSWmQ9Z196IzSFBZAn5l+uyQZbYxA5PcE8j0aOpM=;
        b=iVJ355dx/uAdqxNtz28IemMGbVKdAZvYRt4leY2T4v9S/sVKuTNbBWEXGYb7MZQCCX
         bEMWit0rElAZ3UzowGiYzAR4vfkkAmBx3y8kVbey82j9a06PIQ6GTbSiUzbDTjIsE+Bv
         2ZMWAnxzQUrV7IilCxBkdlNYVRT+P5Ws2aMb8Zu935IT1F4HYuuIDnRI4O7xVZ+L2d57
         ff6UR1t6nLVlBSenVOD5qWq2MDiCJuJvhJEZSVaCHLRxc7WD/mjIKPB2RloQse8mdFef
         WDnRAh1VS5BhGhAG1h3QykJIzwhm38VrNRNRsL76fsaSmdR/HU5o619gIDhf5FzS5WaF
         kkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N1QWSWmQ9Z196IzSFBZAn5l+uyQZbYxA5PcE8j0aOpM=;
        b=HRngjDSW7y80ut7Arq9/XExDp52GELQgNuKLoli5ugXfpnAO01GSRZFz+xvZItXGuX
         D9eSbQnf2QBVPNJ9XyPVuxtFuTv5VKdU0E7M2TDAAw9AHO1Fm+MI91uZr47k5aQ22EIX
         +4Jt5/VnTqYDclDgN/mrGEjQ/kHsULzmBCKVPrwptNGe6YU/Onc5aS+3F60tB4H7zQez
         UPoNXWBrNnryorS3GY0T0cN/w5JCx/g+0LQBS4j4YRIbUig83cZwA3+dQh0/w75KXb5f
         dopOzY6BjCjm4rbL0O7S1mqC1o12KyGjtFNrUbJl3AYS0DphtQd11DwPSRGOsI7fW8Xp
         M99w==
X-Gm-Message-State: APjAAAU2THP7Jbr3/2lH1iswY8fJoRstjBdMS6KrJmoO6sMt7WZo3ji5
        bEcm5LxJiJjrca5pqfnFLuKflCJBj54=
X-Google-Smtp-Source: APXvYqy2hUAWHMhpqsswzADUSS5WFevWYnrpG1oaM5tqejj4eu069CKd6dTBOzUh36UABsHZOBvqWg==
X-Received: by 2002:adf:f343:: with SMTP id e3mr19104359wrp.315.1571655511574;
        Mon, 21 Oct 2019 03:58:31 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 6/9] x86: olpc: Remove invocation of MFD's .enable()/.disable() call-backs
Date:   Mon, 21 Oct 2019 11:58:19 +0100
Message-Id: <20191021105822.20271-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IO regions are now requested and released by this device's parent.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/x86/platform/olpc/olpc-xo1-pm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index e1a32062a375..0fc57b59743c 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -126,10 +126,6 @@ static int xo1_pm_probe(struct platform_device *pdev)
 	if (!machine_is_olpc())
 		return -ENODEV;
 
-	err = mfd_cell_enable(pdev);
-	if (err)
-		return err;
-
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "can't fetch device resource info\n");
@@ -152,8 +148,6 @@ static int xo1_pm_probe(struct platform_device *pdev)
 
 static int xo1_pm_remove(struct platform_device *pdev)
 {
-	mfd_cell_disable(pdev);
-
 	if (strcmp(pdev->name, "cs5535-pms") == 0)
 		pms_base = 0;
 	else if (strcmp(pdev->name, "olpc-xo1-pm-acpi") == 0)
-- 
2.17.1

