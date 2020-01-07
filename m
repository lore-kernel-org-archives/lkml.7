Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D014C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C53420715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ul1VNMWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgAGXGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:06:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56223 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgAGXGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:06:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so566302wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TO4ro9G4vD3zIHyJt/0agdTa39l4m1TB7ZW3wf7lrf0=;
        b=ul1VNMWdK7uKGRgck+BrFSydL/s/Tw5QhgyBT4DSfsstUAyGpFR/AU4EDOx+DdfG37
         Y8hsECeqX1FLtrkERluaTjYnbnoJXVYK/+2+EI5+/5eAvHRVVQ4DZE/GY7QsOi1AZkOy
         ub87rujVUaGCIcTefUUmY/uIS7J0zxSUrl2apAjNU+xig9grpK5nrGlzUtcthKZCXmYG
         24pxMeo/tVCAL9pKLtCC522yVhyRmaYVefxrdeoPOam/uyFSLiQqFAC5CTsp0p/5scnN
         mOYq06dZzoJlLIMiBr6QKAWbmoYzQpBiIFyWOEaphB465iDqgpqeJ0NY3W0Gi7xJdDCD
         iDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TO4ro9G4vD3zIHyJt/0agdTa39l4m1TB7ZW3wf7lrf0=;
        b=GzflsvFSC1SWAHd5zIxzTt+wxGO8PUEHFFRi/zHFOknNsJmjUWGDRUPt1OcKSY34yo
         92hA+shFdn7uJ3F0NmKwevY18PwmQP3eUUmvh9kkO7a7ugJY5JfOdekOPqi7wF2JTfWl
         18zkClaV9yw1cM5inoWjuP/Yn1JaUaNfIuHblf5j9lnl0vGROd9BoVoMq/ebm+lFE8H/
         kdYfVrwDnInoSMYMv6onYcRGpo6pSZZXZTTc/GPEgW0/7eOG9hB5LGWz42H43h0NFYH/
         Xai32Oj9Pt+2XjFAQ8uXgJiBLr2NE8drttqNV9LCM86Xa6r33Oo562mTFEmaKs6ZlNJ4
         3rcA==
X-Gm-Message-State: APjAAAVf1eNx0y5GkEfZ4B/tkTe7nm5jobNGifvbdHGSCdsbaopWQjPp
        RVKKz0xM9Thc75deCoaKqDk=
X-Google-Smtp-Source: APXvYqziatvpyvGspQje2BctNA8J7jf+6weefVXmBYuKgiScnQp6glZ8jwEo1oXP5q9Pe6xVNOUXEA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr597432wmk.172.1578438409183;
        Tue, 07 Jan 2020 15:06:49 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g21sm1335912wmh.17.2020.01.07.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:06:48 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        robin.murphy@arm.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFT v1 1/3] drm/panfrost: enable devfreq based the "operating-points-v2" property
Date:   Wed,  8 Jan 2020 00:06:24 +0100
Message-Id: <20200107230626.885451-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decouple the check to see whether we want to enable devfreq for the GPU
from dev_pm_opp_set_regulators(). This is preparation work for adding
back support for regulator control (which means we need to call
dev_pm_opp_set_regulators() before dev_pm_opp_of_add_table(), which
means having a check for "is devfreq enabled" that is not tied to
dev_pm_opp_of_add_table() makes things easier).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 413987038fbf..1471588763ce 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -5,6 +5,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/clk.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 #include "panfrost_device.h"
@@ -79,10 +80,12 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct devfreq *devfreq;
 	struct thermal_cooling_device *cooling;
 
-	ret = dev_pm_opp_of_add_table(dev);
-	if (ret == -ENODEV) /* Optional, continue without devfreq */
+	if (!device_property_present(dev, "operating-points-v2"))
+		/* Optional, continue without devfreq */
 		return 0;
-	else if (ret)
+
+	ret = dev_pm_opp_of_add_table(dev);
+	if (ret)
 		return ret;
 
 	panfrost_devfreq_reset(pfdev);
-- 
2.24.1

