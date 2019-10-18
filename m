Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE5BCA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA7221835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5pZ1Wzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408010AbfJRM3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:29:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44700 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407925AbfJRM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:29:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so6046021wrl.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lPeqEV+lINM78OOoyJTygefplPrg9vOEAay6eoGa0zY=;
        b=U5pZ1Wzg42CoBwAgbqVmeQiaHcABrgHwn+lnnzgxyLfwzL15Ktp2HgdFDTgN04RlrC
         IvP0JqEptUYJWWPlVUvXfZD+bgjWjdjhaeGjTxd55fePxURwUU+bB1PxvMZtfLEYLGSg
         DLGLc1LeWcQ4C1m4uBpNstJI1T2l6T4Na0/be5K9E2JXn/vuZYFC70s1nc1Y8NYU1FRw
         UI5ERVAKaTV3L07XCM+pijgqQyvd1yF4WpTmkwj2lfwMyX0QCbv/1BlU5aNY/v/fEAE8
         FTLuaTMEzJIzTdFzj0buvCfccirxXIqLEkWAtGH/qYDy9HHeyA5UDwPiZjxHXHzRJASz
         qhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lPeqEV+lINM78OOoyJTygefplPrg9vOEAay6eoGa0zY=;
        b=GWWhSMBOpvVXm9/Ivrt7GmlyMcBWzSvO4NpU2WfQl7IOV8HgvtLUoa+0S5K0b7WAJe
         A80Jk6E2owAlRJ7DtWz/ijhBjVAOiTQ9kwruImDTQ9QOl52Ynx2ytlRCj4zMriO1jgCh
         XD3QwVlZa+SRaapXFgjkPjsPoJIR34HjTw+w6uNyci9bfx7Z5RnRanJCVrWHsjiE6qu2
         uT+uT78RQxwcbPT0cTk8/vpM7pRZcP5bcn41qIxu6qtwfuIq3lrJV0MIhQl0wWxsuOPF
         ofKaZjggTeees7locWiypf4ccSNbfkbvupwy19HUAvF5DPdrnOqe+8QAS9bLCrvdviLZ
         OiFQ==
X-Gm-Message-State: APjAAAXQ797tRc3pZcfNk/PvJvQzrH9tqFE/UFJN8Mtnles3ISSZU7bS
        JqHqbcOpf2icv4cLjrouTe0Zmw==
X-Google-Smtp-Source: APXvYqzL9JbPOSxmM5s3WT+BlmpINnZEIQTPxoKol5TOU+ZCkmlP6yZV4bhu90JCXsNTVDTHWX4e8Q==
X-Received: by 2002:adf:c641:: with SMTP id u1mr7714422wrg.361.1571401738224;
        Fri, 18 Oct 2019 05:28:58 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id e3sm5033820wme.39.2019.10.18.05.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:28:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] mfd: mfd-core: Allocate reference counting memory directly to the platform device
Date:   Fri, 18 Oct 2019 13:26:46 +0100
Message-Id: <20191018122647.3849-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018122647.3849-1-lee.jones@linaro.org>
References: <20191018122647.3849-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MFD provides reference counting (for the 2 consumers who actually use it!)
via mfd_cell's 'usage_count' member.  However, since MFD cells become
read-only (const), MFD needs to allocate writable memory and assign it to
'usage_count' before first registration.  It currently does this by
allocating enough memory for all requested child devices (yes, even disabled
ones - but we'll get to that) and assigning the base pointer plus sub-device
index to each device in the cell.

The difficulty comes when trying to free that memory.  During the removal of
the parent device, MFD unregisters each child device, keeping a tally on the
lowest memory location pointed to by a child device's 'usage_count'.  Once
all of the children are unregistered, the lowest memory location must be the
base address of the previously allocated array, right?

Well yes, until we try to honour the disabling of devices via Device Tree
for instance.  If the first child device in the provided batch is disabled,
simply skipping registration (and consequentially deregistration) will mean
that the first device's 'usage_count' pointer will not be accounted for when
attempting to find the base.  In which case, MFD will assume the first non-
disabled 'usage_count' pointer is the base and subsequently attempt to
erroneously free it.

We can avoid all of this hoop jumping by simply allocating memory to each
single child device before it is considered read-only.  We can then free
it on a per-device basis during deregistration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 23276a80e3b4..eafdadd58e8b 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -61,9 +61,10 @@ int mfd_cell_disable(struct platform_device *pdev)
 EXPORT_SYMBOL(mfd_cell_disable);
 
 static int mfd_platform_add_cell(struct platform_device *pdev,
-				 const struct mfd_cell *cell,
-				 atomic_t *usage_count)
+				 const struct mfd_cell *cell)
 {
+	atomic_t *usage_count;
+
 	if (!cell)
 		return 0;
 
@@ -71,7 +72,14 @@ static int mfd_platform_add_cell(struct platform_device *pdev,
 	if (!pdev->mfd_cell)
 		return -ENOMEM;
 
+	usage_count = kcalloc(1, sizeof(*usage_count), GFP_KERNEL);
+	if (!usage_count) {
+		kfree(pdev->mfd_cell);
+		return -ENOMEM;
+	}
+
 	pdev->mfd_cell->usage_count = usage_count;
+
 	return 0;
 }
 
@@ -134,7 +142,7 @@ static inline void mfd_acpi_add_device(const struct mfd_cell *cell,
 #endif
 
 static int mfd_add_device(struct device *parent, int id,
-			  const struct mfd_cell *cell, atomic_t *usage_count,
+			  const struct mfd_cell *cell,
 			  struct resource *mem_base,
 			  int irq_base, struct irq_domain *domain)
 {
@@ -196,7 +204,7 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_alias;
 	}
 
-	ret = mfd_platform_add_cell(pdev, cell, usage_count);
+	ret = mfd_platform_add_cell(pdev, cell);
 	if (ret)
 		goto fail_alias;
 
@@ -286,16 +294,9 @@ int mfd_add_devices(struct device *parent, int id,
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
@@ -306,17 +307,15 @@ int mfd_add_devices(struct device *parent, int id,
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
@@ -327,9 +326,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *c)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
-	/* find the base address of usage_count pointers (for freeing) */
-	if (!*usage_count || (cell->usage_count < *usage_count))
-		*usage_count = cell->usage_count;
+	kfree(cell->usage_count);
 
 	platform_device_unregister(pdev);
 	return 0;
@@ -337,10 +334,7 @@ static int mfd_remove_devices_fn(struct device *dev, void *c)
 
 void mfd_remove_devices(struct device *parent)
 {
-	atomic_t *cnts = NULL;
-
-	device_for_each_child_reverse(parent, &cnts, mfd_remove_devices_fn);
-	kfree(cnts);
+	device_for_each_child_reverse(parent, NULL, mfd_remove_devices_fn);
 }
 EXPORT_SYMBOL(mfd_remove_devices);
 
@@ -404,7 +398,7 @@ int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
 		cell_entry.name = clones[i];
 		/* don't give up if a single call fails; just report error */
 		if (mfd_add_device(pdev->dev.parent, -1, &cell_entry,
-				   cell_entry.usage_count, NULL, 0, NULL))
+				   NULL, 0, NULL))
 			dev_err(dev, "failed to create platform device '%s'\n",
 					clones[i]);
 	}
-- 
2.17.1

