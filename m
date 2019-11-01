Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89789CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4E2208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aPAUMhk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfKAHpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39639 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfKAHpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id t26so4168759wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GReEFG2GWwJjsYxj+qnWr2ZeJ1W345Xh+fZqhg0GuOc=;
        b=aPAUMhk6ayoWZyrvs0fsQnUU17xXjJv6voGdabNYsT7kPSp8UW342XBwFG/EeCKz0M
         9HsX/Ldh/pDdk8lDjcmMli0SNg0TYdag8vMTj25aA78BvXaLqt9Cip7XMGccXX3djbMt
         f5T+xevpesx2ybGhZaHvyv/4lfHjcQ8WKL17xX0pbqQCYyF5U7q2oaX4MLyl5liN0hHz
         CQpfRklQ5z2fEf9l34Dg4zNLAGIIvGG8s0970wnbzNziW5bYYqeUboSChFg21DExUJgn
         MmSriuu9eSFRucviBK0WmT8DoZUToeM4JmB7oRR+ek1UV/IoV6ueW0DXiGuiCb9GxbAb
         /5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GReEFG2GWwJjsYxj+qnWr2ZeJ1W345Xh+fZqhg0GuOc=;
        b=Yh63qrvRItgZ2YnhCxzKxdz3j2YEId6maq+eC4hwGY3JPw+ZhI9wzJEDcroPii1pwh
         FAxki0T9J2Tcq9poeKm/ZT6Q3GjcvwFOsWTD+fwo52sVwysr1clg172d/SxNwZCLe+XH
         AkDkKDxp6icJecGBXgTQVkxwgv+MMH0xwEUmgP2rigEjsInPYSVsc9qej+KKz10Q389P
         s5ZLpfSZQoEMsmVuDkZLUbrco8sP8mul4itBH6eat8nkUQzw/Q8PnXJ12Am2GYLdWHvC
         dLBezwxaAzYhBv4bK+4BqVJlArkG+vQePCx1ALQTof7VsX7ftsngMObpvDoJAshW82z6
         YYmw==
X-Gm-Message-State: APjAAAWmZvAAYo+jGoSYsSuiw3WWFQq1/yj7iynw/iGpFCAJ20R9Htvp
        gb9Q8KoNnXe5kQFW+cbRzCzRPg==
X-Google-Smtp-Source: APXvYqxqiXxfND79tU2euKm70y8ndsR62OXKUOIdUDdm+VT6d6erzdd+NNvtgc9PKa8pxvqTSzxBnQ==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr8624500wmd.175.1572594327746;
        Fri, 01 Nov 2019 00:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 05/10] mfd: mfd-core: Protect against NULL call-back function pointer
Date:   Fri,  1 Nov 2019 07:45:13 +0000
Message-Id: <20191101074518.26228-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a child device calls mfd_cell_{en,dis}able() without an appropriate
call-back being set, we are likely to encounter a panic.  Avoid this
by adding suitable checking.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/mfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 23276a80e3b4..96d02b6f06fd 100644
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

