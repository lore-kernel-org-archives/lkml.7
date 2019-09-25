Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D053AC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FCA2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569448209;
	bh=f2VsHzDgfHKPQJjy5uERfWdkVE2F7Dh1mkiKR8+QDtg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=U9b0QDoLYEUVI6YGfBfC4+aEDqTY7yal1PBzcTD7kzWoQDFnqn90pEvERvo8KMA+W
	 PayKM0gEn+XCHiwPiAOA1dS3dB75yuwfXoeZOlDzGzNBqohgnut8ixWJuMhB8llEBL
	 3r5wGzwUCb0i2J4C0rQ85g7RRZ+ukAsFsHKHgbIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfIYVuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 17:50:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41955 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfIYVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:50:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so149743otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 14:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6cXLFB02TykvVAB5VHeIiQg5E1YhhmuVezg1VTNWACM=;
        b=Mr87FURxyUahuC89iivXotmIn3m9jsmffi3rhXRNZ8IdIgXnL/diQe+jBm+8n9PIqR
         PJ9ihUaiySlzjUZUhs61IRTO0qulcP/lQ0ZQYZ+DgNXNdEBRdPNT1MaeeuOQPjVle92I
         oSZgkbahIb4Ok2TN0MKBqnRNUjq+UkHoLvW9NRk7R6tWGm81JGB5zz3bN3trCpJO8LNe
         SWjRwvmyZmIo8ziq0KZQ+odJhydcehQIJ/ZfGsNzaclJYarKndIZ6HrMLCE1kfLwlIfh
         /03yGK8RZqSpCYkqP3uq4baEnccATioYqSCI5caMyQ2/g9umY8z4jeS5c8LKiAGF0cQW
         k6oA==
X-Gm-Message-State: APjAAAVoNwaAdE+n05X7txQ8GOBysvRx7eBJM/BDt+3PcZsNSaKhcUqu
        BnHOuv50BaWRBJLvhESQwg==
X-Google-Smtp-Source: APXvYqyz7lSYS26abdEhCGr1U2uy0uBmZ56y9Lbe3N7QnPUQ3gDyYFxELSUCIBwmOSdt/05qrxpCYg==
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr215060ota.217.1569448207485;
        Wed, 25 Sep 2019 14:50:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q199sm78792oic.16.2019.09.25.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:50:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
Date:   Wed, 25 Sep 2019 16:50:06 -0500
Message-Id: <20190925215006.12056-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment says, this isn't a DT based device. of_dma_configure()
is going to stop allowing a NULL DT node, so this needs to be fixed.

Not sure exactly what setup besides arch_setup_dma_ops is needed...

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Julien Grall <julien.grall@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/xen/gntdev.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index a446a7221e13..59906f9a40e4 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -34,9 +34,6 @@
 #include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/refcount.h>
-#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
-#include <linux/of_device.h>
-#endif
 
 #include <xen/xen.h>
 #include <xen/grant_table.h>
@@ -625,14 +622,6 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	flip->private_data = priv;
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	priv->dma_dev = gntdev_miscdev.this_device;
-
-	/*
-	 * The device is not spawn from a device tree, so arch_setup_dma_ops
-	 * is not called, thus leaving the device with dummy DMA ops.
-	 * Fix this by calling of_dma_configure() with a NULL node to set
-	 * default DMA ops.
-	 */
-	of_dma_configure(priv->dma_dev, NULL, true);
 #endif
 	pr_debug("priv %p\n", priv);
 
-- 
2.20.1

