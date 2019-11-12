Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C1BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40267214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTK8xCwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKLVmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:42:03 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34045 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfKLVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:42:03 -0500
Received: by mail-pf1-f201.google.com with SMTP id a1so16546023pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oTMLN2K3vaMSRsmMQXrA4suNBO0BmQdJkP45+pyVh8o=;
        b=aTK8xCwFy5phw4jK+aJ00QT6kRiwelQFXBFWSg+TfLEZdYFkn1y20zB0bgSC82SU3r
         c1Cic+vuS485o7ckwB4/FdL5VSyvm2cFL5qOrgquUV+KB639qJeUut2FTCHhUE2x1l9v
         hQBiIgajtWKh4is00+22/GiHU24eX3x6jR5qkxg+BPddVkzZ2fqlVQX271H4TFv0e8mQ
         BO1zNIcFBAyUhqKSxTOJCdj33ns6E2gf50orujnG8nItr9TO6f9VfH7xb65NdpIW2w/u
         0TWLQ6h2dZ+0qMW7Sfnvw7LQJwEcwM7rO1M+fkCp1otwWzkXpTkbmBIhhpvpXyqYfant
         bRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oTMLN2K3vaMSRsmMQXrA4suNBO0BmQdJkP45+pyVh8o=;
        b=YfI/sysPzSLkHBO60eMM7JskJjHIk+a6UNMtf/zo7rcQCSfk9LtPb7vh6Ia3JmEQoS
         VpqKxhv4nDVPRq6aW7Kgh5F8jtWFR4k7MIvI7NYCEoGgsNz6uu0mqDLXveovAJgJK9z3
         G0tTKK3VHypfZBDEwW5W6rEDuq2DexkWL3b5My+r+nR5NToy0KFgLrTM53u3rpO+S5gk
         +UtOki9grP4Y1id+Dagq+q0qB0KCUroKtvORmEUH2NIJB5OF1/qTkseesjtUOQsqGgar
         HrtX0qyGBQkE+x/539KCRhXVmlfTSJTW7bZEV23j7PutVEj4N1Y/IJhx1PXsbIdWhtlM
         58Bg==
X-Gm-Message-State: APjAAAVQxC/fuvTKQMVkZswA+hvM7sPOZuWKAAJ/HbAFlqJ8omuJ1plE
        ZrWz65K63lpPoikj7i3LYa40wNN62dyyIl38u7c=
X-Google-Smtp-Source: APXvYqwxfX7vVatjaDv5hHuqJil7Vv+SihlJuPveolSeND2UV/3a6sgf/4KrA3aCMS15ft5nL0GwVfF83uICOXxyuuQ=
X-Received: by 2002:a63:1c0e:: with SMTP id c14mr15942340pgc.96.1573594922516;
 Tue, 12 Nov 2019 13:42:02 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:41:56 -0800
Message-Id: <20191112214156.3430-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH] driver core: platform: use the correct callback type for bus_find_device
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_find_device_by_driver calls bus_find_device and passes
platform_match as the callback function. Casting the function to a
mismatching type trips indirect call Control-Flow Integrity (CFI) checking.

This change adds a callback function with the correct type and instead
of casting the function, explicitly casts the second parameter to struct
device_driver* as expected by platform_match.

Fixes: 36f3313d6bff9 ("platform: Add platform_find_device_by_driver() helper")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/base/platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b230beb6ccb4..3c0cd20925b7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1278,6 +1278,11 @@ struct bus_type platform_bus_type = {
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
 
+static inline int __platform_match(struct device *dev, const void *drv)
+{
+	return platform_match(dev, (struct device_driver *)drv);
+}
+
 /**
  * platform_find_device_by_driver - Find a platform device with a given
  * driver.
@@ -1288,7 +1293,7 @@ struct device *platform_find_device_by_driver(struct device *start,
 					      const struct device_driver *drv)
 {
 	return bus_find_device(&platform_bus_type, start, drv,
-			       (void *)platform_match);
+			       __platform_match);
 }
 EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
 

base-commit: 100d46bd72ec689a5582c2f5f4deadc5bcb92d60
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

