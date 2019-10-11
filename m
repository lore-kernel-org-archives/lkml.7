Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7BECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8C214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtQ7RuQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfJKTPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 15:15:39 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:38695 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbfJKTPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 15:15:38 -0400
Received: by mail-vk1-f202.google.com with SMTP id k132so3814747vka.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fuET3qNc4z015mh4xj4NLz17joYOgUCh9UCVZC00VJQ=;
        b=KtQ7RuQAgEe2d9wcSmFDcLBsRoaaxGnpESOpf/q6dteBQqfkJ6FlI7FsfVyrTIxA5z
         xwZTZVQZlDQ7S/gzwJjZus5nZx3GJjO6hkhrkgUqORg8jTVxIt+s0y88CkAOFOTUIpRI
         0Pzt39RFgrUq2XIP4cHJaFu8U0+NpHeQM7pfJw6eTNiKtASKlEgUMTfTY9F2RVJtnEFn
         QFT/ef3CgPcb9DsR5oYYhAAL8hYt4W/XFs81+D/zCGDiiNyfGHoL54m7RQCMwlIb7DXR
         P/W0KYOmCkgg16488maeLjzDGxalw2QDxZWb880tI/rMhZWrR+NypPxIgCWcm2dDL2uj
         qDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fuET3qNc4z015mh4xj4NLz17joYOgUCh9UCVZC00VJQ=;
        b=XltsyHQrA9b1xHILuypABMDwWzJ3ukrkrZXvqLhABK8MVdQXNQFCecw+R656l/dLyt
         vtCBbSwrgi3ZlGA4Ap0sn+UaG+25shZ4qlqvGgOB6M66wyHxWzLtzUt2wu/NLIwnqY62
         1oT3Kfe6oO1HdfpNm7rw+3oywazYlLqhRQQnJr/8WOhW3cQzcTote2DXtEVzE6A2Rxay
         q84AZK0ihun8cfYCnTkkhOm2QPRQUhcfux7oxqGV6mLrgTfi1zlHwJ6nrYSoGYxD48iA
         kFkS5oNaLQghjzAvmZMt0YX0ZqvimzJaYY1u/AN7KqMgRQEhVwvjEJQcxQnDnK0a3tLt
         VNdw==
X-Gm-Message-State: APjAAAUf1r4CBNgyRPLuHSwTwylreHk6sS61lD8dMHCMpwIXQeRnhoYY
        adQ0AlGkVb9y1KXfmgtsen7KcMAwO+OphX8=
X-Google-Smtp-Source: APXvYqyKbyMInaL/TiLznxFZpaDnmd4A+1ivZ+irQgGm2Xkw+CFqTG49xHbf8Z1vqOMgRdvb2xnG1jQBb3eetEU=
X-Received: by 2002:a1f:f445:: with SMTP id s66mr9324346vkh.62.1570821335385;
 Fri, 11 Oct 2019 12:15:35 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:15:21 -0700
In-Reply-To: <20191011191521.179614-1-saravanak@google.com>
Message-Id: <20191011191521.179614-4-saravanak@google.com>
Mime-Version: 1.0
References: <20191011191521.179614-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v1 3/3] docs: driver-model: Add documentation for sync_state
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync_state() driver callback was added recently, but the
documentation was missing.  Adding it now.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../driver-api/driver-model/driver.rst        | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
index 11d281506a04..baa6a85c8287 100644
--- a/Documentation/driver-api/driver-model/driver.rst
+++ b/Documentation/driver-api/driver-model/driver.rst
@@ -169,6 +169,49 @@ A driver's probe() may return a negative errno value to indicate that
 the driver did not bind to this device, in which case it should have
 released all resources it allocated::
 
+	void (*sync_state)(struct device *dev);
+
+sync_state is called only once for a device. It's called when all the consumer
+devices of the device have successfully probed. The list of consumers of the
+device is obtained by looking at the device links connecting that device to its
+consumer devices.
+
+The first attempt to call sync_state() is made during late_initcall_sync() to
+give firmware and drivers time to link devices to each other. During the first
+attempt at calling sync_state(), if all the consumers of the device at that
+point in time have already probed successfully, sync_state() is called right
+away. If there are no consumers of the device during the first attempt, that
+too is considered as "all consumers of the device have probed" and sync_state()
+is called right away.
+
+If during the first attempt at calling sync_state() for a device, there are
+still consumers that haven't probed successfully, the sync_state() call is
+postponed and reattempted in the future only when one or more consumers of the
+device probe successfully. If during the reattempt, the driver core finds that
+there are one or more consumers of the device that haven't probed yet, then
+sync_state() call is postponed again.
+
+A typical use case for sync_state() is to have the kernel cleanly take over
+management of devices from the bootloader. For example, if a device is left on
+and at a particular hardware configuration by the bootloader, the device's
+driver might need to keep the device in the boot configuration until all the
+consumers of the device have probed. Once all the consumers of the device have
+probed, the device's driver can synchronize the hardware state of the device to
+match the aggregated software state requested by all the consumers. Hence the
+name sync_state().
+
+While obvious examples of resources that can benefit from sync_state() include
+resources such as regulator, sync_state() can also be useful for complex
+resources like IOMMUs. For example, IOMMUs with multiple consumers (devices
+whose addresses are remapped by the IOMMU) might need to keep their mappings
+fixed at (or additive to) the boot configuration until all its consumers have
+probed.
+
+While the typical use case for sync_state() is to have the kernel cleanly take
+over management of devices from the bootloader, the usage of sync_state() is
+not restricted to that. Use it whenever it makes sense to take an action after
+all the consumers of a device have probed.
+
 	int 	(*remove)	(struct device *dev);
 
 remove is called to unbind a driver from a device. This may be
-- 
2.23.0.700.g56cf767bdb-goog

