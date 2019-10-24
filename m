Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41507CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A29205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQl9V900"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503585AbfJXQiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38680 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503545AbfJXQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so3254029wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Uje5yZA2ldJsbsoiBPp+JyZjTmn5fr8PAwcjGY2GnI=;
        b=DQl9V900fqGUpTL6GCaKfkeZ3gpfIHFqAKSX3ufvAjrIcUCC99G8QrABRgrFAHr84f
         zXLGkBQbvxYo558DCuJqQRDDXaj2qphtEatUBS+Lk2L/kgUEZOlNLKkQr/2VGOUirh4E
         6jKdZxmOXPYIkjq+XUBdV+4Kw/ot1PyjPtVGHPHjzWvr5e5pNz9JmDdPSIPFVB09IPWO
         J99BmaTltlCpMUovCATgjqDRfUheM9tsvnCGce4Ysz+isq5zOjxTekh7k4kElKxW1h0I
         wSMBV1bRCLq9eaApiDlolzZZeA1p6It53pyezLs2vAm0LSkxnBL7yVJGV/ov+1Xf6Njw
         Chtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Uje5yZA2ldJsbsoiBPp+JyZjTmn5fr8PAwcjGY2GnI=;
        b=gjkuulNg03UzZMx//iRvHYESdwVaMwsNbQZOPbY2gEnU0WbO8dsF4g8zxv68kCkTsk
         8gSLOlpdXzRolJ0Ppt5YPyq4LTveev3IWBbQuwmmbIZmmf9XdB8BAkYWo1WZaqsVycn1
         RZU9/vKUOVkNkjdhPcL9R2m4NTz3XJg7xQzC/zdNtgAOV2rHvSVMTaIgGKWNrZePtPYY
         LQ/hp055GVNLfM1XbkVpCeJWCR47RbA0F2sd4zcoaK4bCjPCYR5exIxpHJf6i5sSzJbJ
         II5pGn4xr4MkagZ3faum7aL+5CNwYmaIOcvrJBlbeQSZu6tdgUgxD+B0R7WtyCdeQkFu
         EeEg==
X-Gm-Message-State: APjAAAXyJnJ7YNLBQ67SFlqydtQK3TeqKrFP6j3iqSyEhC96f60diIdb
        ufeD+u4XvL4l6IMLFZ3BiHTXUB3h8b8=
X-Google-Smtp-Source: APXvYqxlMNsjCTwkEt0d7L6AsHU/jq7MCFgUCZONkNBta21bcHrPhdZtg5MDI/XxzWmIHo3m+xvqdw==
X-Received: by 2002:a05:600c:143:: with SMTP id w3mr786098wmm.132.1571935124805;
        Thu, 24 Oct 2019 09:38:44 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 08/10] mfd: mfd-core: Protect against NULL call-back function pointer
Date:   Thu, 24 Oct 2019 17:38:30 +0100
Message-Id: <20191024163832.31326-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a child device calls mfd_cell_{en,dis}able() without an appropriate
call-back being set, we are likely to encounter a panic.  Avoid this
by adding suitable checking.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/mfd/mfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 8126665bb2d8..e38e411ca775 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -28,6 +28,11 @@ int mfd_cell_enable(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int err = 0;
 
+	if (!cell->enable) {
+		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
+		return 0;
+	}
+
 	/* only call enable hook if the cell wasn't previously enabled */
 	if (atomic_inc_return(cell->usage_count) == 1)
 		err = cell->enable(pdev);
@@ -45,6 +50,11 @@ int mfd_cell_disable(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int err = 0;
 
+	if (!cell->disable) {
+		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
+		return 0;
+	}
+
 	/* only disable if no other clients are using it */
 	if (atomic_dec_return(cell->usage_count) == 0)
 		err = cell->disable(pdev);
-- 
2.17.1

