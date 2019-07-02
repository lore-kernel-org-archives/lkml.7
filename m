Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74556C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A78B218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCnekBuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfGCAnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:43:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35050 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGCAns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:43:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so727907qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/H70/FePQbdKZEz0YI3H5/o3CPPkZQZGrIygUbL5uE=;
        b=TCnekBuPYD3hUrz8zIp0zu2L4/GpJvf48ABFai2kUMx5JRSj+cJ9F4qllXaSyBUW3P
         jUaysD401DDUnfOo3Klccf/XsoXJ16g19L5I8D93FmKem3TenRjTAPawa623RFJCL6qK
         d63Y6sMyeBjwYA4P/+VM58+DDKEo538UFqKZCsoF75gu8J+6hJVvOWOGyd58UpTYAb57
         q5Ld3cG0P/Xnf8kMmLLMqTAZ1oqG80KTqDM7j+N5I9qC+N6LWOdROwCPko32+cCB7Ltn
         Y3vEBK04m3JwgwmnrrbIBtdJmXO9XPmSAo0oShklDieS2klivlvOqFdhJBLIoDcBywvk
         KvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/H70/FePQbdKZEz0YI3H5/o3CPPkZQZGrIygUbL5uE=;
        b=ggg6U2vaal+NR3nIscEYmu3uUTwlN9Rv2vhRefMVKrowF/YtrcszxYhDJlpgSsb4+T
         zw8eLXSVV9ZAdNjja5vVbvRytaVZXTHDR2T2nmuv3EQSzArPe5nIhBPzwZ8iLEZ7lzVy
         V73X8MXDPVC/ZZyG5DagFNyTeAykoa+bxVesvExOoWP2IQIghmBPzspaaMHTWVzq3jw0
         N8jKSMUQz+uZWUzXJvB1GgD/u8N4nihGtYEDoXtLdPMcv8YLLjcUyKcp5hg2IZXRZYjT
         zRJ5v6FwrnGI4MM9yp6gqYmu3MnYyauppA2wNgzidfjTASeXHCp6ZUOjdUEBYXRqB0tt
         L4Xg==
X-Gm-Message-State: APjAAAUxsfOkIkhXcZUDa7TbFvYGluzO2Iau2rqpG1eWBsCsE/589v+Q
        gZgaXU+Fby6JiCr2h9snxUsXaKy3y31GuA==
X-Google-Smtp-Source: APXvYqwBpRrG3Pu/9gU8tjH7/kzX84pSdwZg+HHw7dt535o3fbveN8pbp8WelpaRmR8Le4djtZu+DQ==
X-Received: by 2002:ac8:36b9:: with SMTP id a54mr27547900qtc.300.1562099216912;
        Tue, 02 Jul 2019 13:26:56 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id d38sm7249904qtb.95.2019.07.02.13.26.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 13:26:56 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
Cc:     aarch64-laptops@lists.linaro.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joe Perches <joe@perches.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu: add support for drivers that manage iommu explicitly
Date:   Tue,  2 Jul 2019 13:26:18 -0700
Message-Id: <20190702202631.32148-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702202631.32148-1-robdclark@gmail.com>
References: <20190702202631.32148-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Avoid attaching any non-driver managed domain if the driver indicates
that it manages the iommu directly.

This solves a couple problems that drm/msm + arm-smmu has with the iommu
framework:

1) In some cases the bootloader takes the iommu out of bypass and
   enables the display.  This is in particular a problem on the aarch64
   laptops that exist these days, and modern snapdragon android devices.
   (Older devices also enabled the display in bootloader but did not
   take the iommu out of bypass.)  Attaching a DMA or IDENTITY domain
   while scanout is active, before the driver has a chance to intervene,
   makes things go *boom*

2) We are currently blocked on landing support for GPU per-context
   pagetables because of the domain attached before driver's ->probe()
   is called.

This solves both problems.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/iommu.c  | 11 +++++++++++
 include/linux/device.h |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..efa0957f9772 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1573,6 +1573,17 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	    domain->ops->is_attach_deferred(domain, dev))
 		return 0;
 
+	/*
+	 * If driver is going to manage iommu directly, then avoid
+	 * attaching any non driver managed domain.  There could
+	 * be already active dma underway (ie. scanout in case of
+	 * bootloader enabled display), and interfering with that
+	 * will make things go *boom*
+	 */
+	if ((domain->type != IOMMU_DOMAIN_UNMANAGED) &&
+	    dev->driver && dev->driver->driver_manages_iommu)
+		return 0;
+
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
diff --git a/include/linux/device.h b/include/linux/device.h
index e138baabe01e..d98aa4d3c8c3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -282,7 +282,8 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
-	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
+	bool driver_manages_iommu:1;	/* driver manages IOMMU explicitly */
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.20.1

