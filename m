Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6108CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A9F208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKOGWnyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfKAHpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbfKAHpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so8826424wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G66DJ8x191Pz9QU5XLq/zdiIBtE2uKywn/4cMYv/RBg=;
        b=LKOGWnyZ+ssOprnTgp43gChOt34A7AW4ibBfDtuBIW1V9+TM+2J+xFUre8GLvyPFik
         PvpW26uL6ZwlNoNueYi+wocJOmRhRlgnj5JXrog3pPTIQJE4FbgdALfMKZ6vCdPAXwk/
         98gUmHW7r/gDma0V9jhqm2VN4gCns7G+l/8CXDbef88Iy0GnbO0ZxAQZDQXQYE90NoEx
         IfJ9zoyKTTuoyZ4MfXGiv0Yg9dUflza1bwxv/0/l0aYQzomi/SV9fRKVsZNy9uFOcnnd
         QuUiqiESOAOif6zPTLb4/ZmMHIIM5Udx/vPKTJpIRjwE4wD/EDIZCXEXZyXxnbPbb8p0
         CKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G66DJ8x191Pz9QU5XLq/zdiIBtE2uKywn/4cMYv/RBg=;
        b=ntrlflu9VUYrbfc7UFywweqdliJJpDR0FZ7yX0YJBgwyHvSdrhz4dsELhBtDQk9tWJ
         1IRjDOQkTGN6z35CRtIviJbPdXKlKl1RGGQFs4c4luUjZSSwrhE2jDCAi4KHmDcPnwC3
         8tUpzcTaCPkrHgd4ttASpFWFLijEtkk7TGIc3WQySt+sziGq98lV4B0dBT5lzRNlywEO
         Z2VhC6JxPfBvYbUeiHS9ea3/m1FcwObYCLR3+XLGJ18TUEZZO0FU7GHIOCaBz3x2gUy8
         3RAYMVqpbenVF0jIBLxcG7wfaOOcGQKM8xe7WzLPRXGmE/yDnQdz2M24dBeXxD+zhqX4
         Go6g==
X-Gm-Message-State: APjAAAUIdODQsRRZb2NnWJe/uY3aTwIeiNzZhsBP+IYg4dKIDvn7c22N
        3TectjiAb0w7CuOXXwW1WM+Y0Q==
X-Google-Smtp-Source: APXvYqwzlKLx0lqdsmRFuDGhK5TYB9WOrCqeFTMPHtWdc5R3p6MbIGL6snQgGyvqo5TrPN/eU+CBgQ==
X-Received: by 2002:a5d:694d:: with SMTP id r13mr8929386wrw.395.1572594331448;
        Fri, 01 Nov 2019 00:45:31 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:30 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 09/10] mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
Date:   Fri,  1 Nov 2019 07:45:17 +0000
Message-Id: <20191101074518.26228-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD implementation for reference counting was complex and unnecessary.
There was only one bona fide user which has now been converted to handle
the process in a different way. Any future resource protection, shared
enablement functions should be handed by the parent device, rather than
through the MFD subsystem API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/mfd-core.c   | 57 +++++++---------------------------------
 include/linux/mfd/core.h |  2 --
 2 files changed, 9 insertions(+), 50 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index e38e411ca775..2535dd3605c0 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -26,53 +26,31 @@ static struct device_type mfd_dev_type = {
 int mfd_cell_enable(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
-	int err = 0;
 
 	if (!cell->enable) {
 		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
 		return 0;
 	}
 
-	/* only call enable hook if the cell wasn't previously enabled */
-	if (atomic_inc_return(cell->usage_count) == 1)
-		err = cell->enable(pdev);
-
-	/* if the enable hook failed, decrement counter to allow retries */
-	if (err)
-		atomic_dec(cell->usage_count);
-
-	return err;
+	return cell->enable(pdev);
 }
 EXPORT_SYMBOL(mfd_cell_enable);
 
 int mfd_cell_disable(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
-	int err = 0;
 
 	if (!cell->disable) {
 		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
 		return 0;
 	}
 
-	/* only disable if no other clients are using it */
-	if (atomic_dec_return(cell->usage_count) == 0)
-		err = cell->disable(pdev);
-
-	/* if the disable hook failed, increment to allow retries */
-	if (err)
-		atomic_inc(cell->usage_count);
-
-	/* sanity check; did someone call disable too many times? */
-	WARN_ON(atomic_read(cell->usage_count) < 0);
-
-	return err;
+	return cell->disable(pdev);
 }
 EXPORT_SYMBOL(mfd_cell_disable);
 
 static int mfd_platform_add_cell(struct platform_device *pdev,
-				 const struct mfd_cell *cell,
-				 atomic_t *usage_count)
+				 const struct mfd_cell *cell)
 {
 	if (!cell)
 		return 0;
@@ -81,7 +59,6 @@ static int mfd_platform_add_cell(struct platform_device *pdev,
 	if (!pdev->mfd_cell)
 		return -ENOMEM;
 
-	pdev->mfd_cell->usage_count = usage_count;
 	return 0;
 }
 
@@ -144,7 +121,7 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
 #endif
 
 static int mfd_add_device(struct device *parent, int id,
-			  const struct mfd_cell *cell, atomic_t *usage_count,
+			  const struct mfd_cell *cell,
 			  struct resource *mem_base,
 			  int irq_base, struct irq_domain *domain)
 {
@@ -206,7 +183,7 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
-	ret = mfd_platform_add_cell(pdev, cell, usage_count);
+	ret = mfd_platform_add_cell(pdev, cell);
 	if (ret)
 		goto fail_alias;
 
@@ -296,16 +273,9 @@ int mfd_add_devices(struct device *parent, int id,
 {
 	int i;
 	int ret;
-	atomic_t *cnts;
-
-	/* initialize reference counting for all cells */
-	cnts = kcalloc(n_devs, sizeof(*cnts), GFP_KERNEL);
-	if (!cnts)
-		return -ENOMEM;
 
 	for (i = 0; i < n_devs; i++) {
-		atomic_set(&cnts[i], 0);
-		ret = mfd_add_device(parent, id, cells + i, cnts + i, mem_base,
+		ret = mfd_add_device(parent, id, cells + i, mem_base,
 				     irq_base, domain);
 		if (ret)
 			goto fail;
@@ -316,17 +286,15 @@ int mfd_add_devices(struct device *parent, int id,
 fail:
 	if (i)
 		mfd_remove_devices(parent);
-	else
-		kfree(cnts);
+
 	return ret;
 }
 EXPORT_SYMBOL(mfd_add_devices);
 
-static int mfd_remove_devices_fn(struct device *dev, void *c)
+static int mfd_remove_devices_fn(struct device *dev, void *data)
 {
 	struct platform_device *pdev;
 	const struct mfd_cell *cell;
-	atomic_t **usage_count = c;
 
 	if (dev->type != &mfd_dev_type)
 		return 0;
@@ -337,20 +305,13 @@ static int mfd_remove_devices_fn(struct device *dev, void *c)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-	/* find the base address of usage_count pointers (for freeing) */
-	if (!*usage_count || (cell->usage_count < *usage_count))
-		*usage_count = cell->usage_count;
-
 	platform_device_unregister(pdev);
 	return 0;
 }
 
 void mfd_remove_devices(struct device *parent)
 {
-	atomic_t *cnts = NULL;
-
-	device_for_each_child_reverse(parent, &cnts, mfd_remove_devices_fn);
-	kfree(cnts);
+	device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
 }
 EXPORT_SYMBOL(mfd_remove_devices);
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index bd8c0e089164..919f09fb07b7 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -30,8 +30,6 @@ struct mfd_cell {
 	const char		*name;
 	int			id;
 
-	/* refcounting for multiple drivers to use a single cell */
-	atomic_t		*usage_count;
 	int			(*enable)(struct platform_device *dev);
 	int			(*disable)(struct platform_device *dev);
 
-- 
2.17.1

