Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41932C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F25F2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzHNtGD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfDEUOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:14:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44725 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:14:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so5881459oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IbJ44p0TmjkKm3B0hZhISscVhYhlarjdfZJz5gA7sgc=;
        b=SzHNtGD2iVcWnKkx4+Ift9xOWzcfv2AfOpKTLG2bLSgZLe/AIJQYzTLj8N6+xj4zkD
         /yiZoUaC36xOSj6BP10Clyf1Hc1J6MCVv/L4lqfNpw+tVCixvT9Qs3UUKZgk1LJsqLja
         4k8ZYrHk1m+2j4SfP2xNV6TKU7KzNpvQQTj02sfF1nWECi+8W6v/Yf1E/8rMLmTrLsC6
         OFxXylCjLOfR5XIp6BjnzdECBp+/SfdSGCnPgNrGIPCNkBQfHmUFKsML7A79UGSsL2S5
         ZV68pGGQh6PwcvNk358AnBrTJTQ0zfIsYIF5N5YfPCOjFK6CUQV1c1TfFXR9l895TyQm
         iABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IbJ44p0TmjkKm3B0hZhISscVhYhlarjdfZJz5gA7sgc=;
        b=QslJCrA8VsMar4rmWn8bVChJO3zU+wsI7BeLyWCN/s3A0Ob4dxKeIccrhk+zN+0GvF
         oauOavjmyCkloP+ZT6AqiGQVtTvcCerlWfPHb8xlb1gY4ClSHQ7DMFwoxCiNg1bMgyEE
         U6ccVpzJo9eEFoEkDmziOkNbWM+vfd0yJ2W+wwtSLs5aclUb3E3c8j+ojs9OziK9yJz7
         m0ZQOvCgd2/Fc6opjXOKJM9MSNZ+67UkuuBpXkweX5XL7RuU7YJlVZdGNALZjl/g9mjF
         FZbQOB2w4YpWAMCxi+Azzx+GpVhcVmj9M+0z8adI7IaBsMWUPuFxNkD17D2ZYIwYfzbl
         9+Mw==
X-Gm-Message-State: APjAAAVgJ/Njf5yMTmUiK0iNn0SA0Wt5gv4H2P/h/No00nL4ZmDasSCq
        x9AGP6VVqTTUsR58rQXGy0E=
X-Google-Smtp-Source: APXvYqzSar0LYaGwP4SeECAad6RTV4T6+KhWCaxJzRI3Bfi6kBAeIqV/JGZIU7WDvWFjq8hxCJk9Bw==
X-Received: by 2002:aca:c202:: with SMTP id s2mr8751744oif.91.1554495280415;
        Fri, 05 Apr 2019 13:14:40 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:7549:4e85:9095:b601])
        by smtp.gmail.com with ESMTPSA id 96sm9830315otf.17.2019.04.05.13.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 13:14:39 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH] Staging: greybus: Cleanup in header file control.h
Date:   Fri,  5 Apr 2019 15:14:37 -0500
Message-Id: <20190405201437.3689-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a blank line after function/struct/union/enum
declarations. Also, convert to_gb_control()  macro into an inline
function in order to maintain Linux kernel coding style based
on which the inline function is preferable over the macro.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/greybus/control.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
index 3a29ec05f631..a681ef74e7fe 100644
--- a/drivers/staging/greybus/control.h
+++ b/drivers/staging/greybus/control.h
@@ -24,7 +24,11 @@ struct gb_control {
 	char *vendor_string;
 	char *product_string;
 };
-#define to_gb_control(d) container_of(d, struct gb_control, dev)
+
+static inline struct gb_control *to_gb_control(struct device *d)
+{
+	return container_of(d, struct gb_control, dev);
+}
 
 struct gb_control *gb_control_create(struct gb_interface *intf);
 int gb_control_enable(struct gb_control *control);
-- 
2.17.1

