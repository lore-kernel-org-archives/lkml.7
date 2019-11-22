Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194F6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 04:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26BB20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 04:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aD1jwx6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKVEZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 23:25:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46982 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKVEZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 23:25:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so2543192plt.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 20:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TaUjGR1ZK3h0U41Xrlyjvus/YvOSCFkyRPWGIeHKfc=;
        b=aD1jwx6z+f92KHKX9yFRTVyInNQGgPastRMpBKSMyxmF2ijG8yfcbYaFjNY/T0Od60
         PjZVloFTMviB3NolgoCvOibRwFT2q48VSBw4RoS5Y3uv4HEPgAoa19m6hUClXA/2AXIP
         oN/mzFwnwtEV57HtZ4f66U+f4j9e/ng+/5fC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TaUjGR1ZK3h0U41Xrlyjvus/YvOSCFkyRPWGIeHKfc=;
        b=fV4OtwJparJLpaJLeNO1ayJq9J2P7kviRLSCu1r2xwtF0Ry+lxDZUcKpbpR3ER2EIx
         sBT38FDjyGM01F1gNVxyYG/7LnaUzxva5+d6x04ITRiG7/bBy769HI6RjHBkWXMhlGJf
         WbXwdPB3sXqhONS9JJANNY4CMzAhGyeQJOmYexVz5O2OeJXgZfq1lEvct4AfBK5hCCmP
         FvWmt8bLiLGm/Tzs9fpUmHlEliEAeD4fKy1O64XlS9MiKoggfNjHp8J5nPbT1vclqW/p
         e6g/49LTvYxRlBr/b+zXsZOSaFC3KbOIzRLA9rUb7aGcWyXVkGDHbpP3slVswTbD0yHH
         JKeg==
X-Gm-Message-State: APjAAAXNrHCJhv8L1kOdBbfJI0c7FogeLr99CyAbINdCakGdly6M/L57
        3lj8wihoVKrJw+VNlHOtFzYqHQ==
X-Google-Smtp-Source: APXvYqw0xEIHeWcFvt2KpNgve53FlnVWf404GB3ugZXsdS5M/ZbW3Sav8UMHXT9d/R+RDe02HDJFzg==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr12522360pll.333.1574396710980;
        Thu, 21 Nov 2019 20:25:10 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id d11sm5680854pfq.72.2019.11.21.20.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 20:25:10 -0800 (PST)
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
Subject: [PATCH v3 2/2] usb: overridable hub bInterval by device node
Date:   Fri, 22 Nov 2019 12:25:07 +0800
Message-Id: <20191122042507.205716-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
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
 drivers/usb/core/config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 5f40117e68e7..1939f2ff87ef 100644
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
@@ -257,6 +258,11 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno, int inum,
 	memcpy(&endpoint->desc, d, n);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
+	/* device node property overrides bInterval */
+	if (usb_of_has_combined_node(to_usb_device(ddev)))
+		of_property_read_u8(ddev->of_node, "hub,interval",
+				    &d->bInterval);
+
 	/*
 	 * Fix up bInterval values outside the legal range.
 	 * Use 10 or 8 ms if no proper value can be guessed.
-- 
2.24.0.432.g9d3f5f5b63-goog

