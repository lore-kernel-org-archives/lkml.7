Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA9CC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 03:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A447320866
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 03:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="akRkk8HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKQDdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 22:33:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38334 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfKQDdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 22:33:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so7865831pgh.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 19:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NoD3EUOCGUvMC6d9X/brhPNv/r5QebdFkK7wUmW6FA=;
        b=akRkk8HH2AXBy3S4qn4X4qmVpyG5H/A21FhC71FZ7xJj0WZ183dhITiiJNfScujL2P
         C1s/NVshiZIFI+Nixj/MX8rloZeYG6NQbwsv2IeNQa2x9wOIxBA9HvSwYE7c8qFAOC7X
         d68X85meG3xL4SToBO/4eDl4HoPhioyYvFb2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+NoD3EUOCGUvMC6d9X/brhPNv/r5QebdFkK7wUmW6FA=;
        b=p4CbhDJFCgtsypJCI71aQUDWIhtbOjx56glhpI2ykjTflNiEcrSikPF8Hye1ZT2yV5
         QwFIJuMleJ7RY4c5p72VnmvXeXEmVqm4BkLw0zJtcNmxCoo2TFuEFnleUIwas/ywgNeh
         j1bxAPcLcvdhwOg7C5le93jfFSAtQiforB7Omz2HjLpGe4dXRNMlZu/res7U7AXgnGx4
         wNPnyS2et+hmFZzZMt3D1BPzE6AlieO9g+wrNPQXOtWydrCSUgNcSjOhNJbohO5v82ob
         30reno5N9w96CtnTVap+Z8rHQ+UBKA7xys4v9cMn6BtG69nXfEMkoNUPh9b/3Y1JSJR9
         GREg==
X-Gm-Message-State: APjAAAVSZDXj9dvU18hSLWbDmyS5SSb4hghxtxArrgTCnySh3e4nonbT
        OanJa4/GwlvpymxhbUu7d5g9Qw==
X-Google-Smtp-Source: APXvYqyJ3AadsblxQaCmis/WfFKQ1ihIy+pUanb3b5iZ1mEtzyFLXa81fQMeHeVGvcWlWocjY/WKGA==
X-Received: by 2002:a63:dd51:: with SMTP id g17mr771867pgj.388.1573961593006;
        Sat, 16 Nov 2019 19:33:13 -0800 (PST)
Received: from ikjn-glaptop.roam.corp.google.com (2001-b400-e27e-4718-13bf-d274-f5e0-91a5.emome-ip6.hinet.net. [2001:b400:e27e:4718:13bf:d274:f5e0:91a5])
        by smtp.gmail.com with ESMTPSA id j7sm13780748pgl.38.2019.11.16.19.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 19:33:12 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>,
        Nicolas Boitchat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 2/2] usb: overridable hub bInterval by device node
Date:   Sun, 17 Nov 2019 11:33:05 +0800
Message-Id: <20191117033305.259789-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables hub device to override its own endpoint descriptor's
bInterval when the hub has a device node with "hub,interval" property,

Some existing hub devices have adjustable interval so the device is
allowed to use different bInterval. This is useful when the hub's default
bInterval is too big, so child device's waking up from autosuspend
takes much time.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/usb/core/config.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 5f40117e68e7..234ca6124c98 100644
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
+	if (unlikely(usb_of_has_combined_node(to_usb_device(ddev))))
+		of_property_read_u8(ddev->of_node, "hub, interval",
+				    &d->bInterval);
+
 	/*
 	 * Fix up bInterval values outside the legal range.
 	 * Use 10 or 8 ms if no proper value can be guessed.
-- 
2.24.0.432.g9d3f5f5b63-goog

