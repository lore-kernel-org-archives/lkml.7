Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02ECC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3660206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2J3JfSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLCKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:15:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34660 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLCKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:15:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id t21so1352668pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 02:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YrHITFCHdeD4+yA1cax6B7EYeghey89WnNbNyeOQhYw=;
        b=f2J3JfSjMMQW4lP+yVzQFbEn4Aiben8OJjuINWOcR5DXVhob+s2ix0xLzjwfNxGkyR
         jCx6fz/TB9QQ4IoJ56yCtbbtAOTmG4FEYzyh0B5MDRwDDDDrGrUJrzDjVCCddfzNVECR
         GcVsk8Mc5sv8YOkbWdtvY80b8aAQ7At6I5U3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YrHITFCHdeD4+yA1cax6B7EYeghey89WnNbNyeOQhYw=;
        b=P2d25NUqnzYFkaw9PHV97rJhmAqBMSrRc6ADT5GISYvIMH1HAfgeMGmVfOSad2nBQk
         0ikuVPCKG3P8oEsz9QYoDEOnQGRyZ5YsKb3sECbbcjoTerQve2ki7zKDXBNujS3eqrdM
         D8gmMqAkVRnd5VwjXiqymFRKXpCSK0ULLEcRe2KPvZCYgnHu0rcr/yQeGZIAoT3JeORM
         KQv8cHU+T0wNE5UJdiegguOVqe7zkAkxTf42Z964e5xS9cMH8OgEAAtNjSFMNJ/LRl7h
         3OXRajsIYekIDrRB97/j1Ad8ea1fO6/MbP4md7W42QeZ7W1GXtVtYjUezpqize08B/jn
         jceQ==
X-Gm-Message-State: APjAAAXFa0rqyOt+2aGsumhnKeIy5X8wxIRCIl4wMcqAMlp4f1ynjZOi
        l/hd5v/olgjMhcRPPAv3NII5jQ==
X-Google-Smtp-Source: APXvYqwy1Cn4JTSApVIsHMb6V6BA1uS11JBgw/FaCROu8sNlG7sAcc2JMQI0h0RMKGl+scq8u+oxXw==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr4100209plo.205.1575368156923;
        Tue, 03 Dec 2019 02:15:56 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id 129sm3070545pfw.71.2019.12.03.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 02:15:56 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org
Cc:     GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        IkjoonJang <ikjn@chromium.org>, JohanHovold <johan@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org
Subject: [PATCH v4 2/2] usb: overridable hub bInterval by device node
Date:   Tue,  3 Dec 2019 18:15:52 +0800
Message-Id: <20191203101552.199339-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables hub device to override its own endpoint descriptor's
bInterval when the hub has a device node with "hub,interval" property.

When we know reducing autosuspend delay for built-in HIDs is better for
power saving, we can reduce it to the optimal value. But if a parent hub
has a long bInterval, mouse lags a lot from more frequent autosuspend.
So this enables overriding bInterval for a hard wired hub device only
when we know that reduces the power consumption.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/core/config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 5f40117e68e7..95ec5af42a1c 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -6,6 +6,7 @@
 #include <linux/usb.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/of.h>
 #include <linux/usb/quirks.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -257,6 +258,14 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno, int inum,
 	memcpy(&endpoint->desc, d, n);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
+	/* device node property overrides bInterval */
+	if (usb_of_has_combined_node(to_usb_device(ddev))) {
+		u32 interval = 0;
+		if (!of_property_read_u32(ddev->of_node, "hub,interval",
+				    &interval))
+			d->bInterval = min_t(u8, interval, 255);
+	}
+
 	/*
 	 * Fix up bInterval values outside the legal range.
 	 * Use 10 or 8 ms if no proper value can be guessed.
-- 
2.24.0.393.g34dc348eaf-goog

