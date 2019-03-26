Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95082084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXq6lIz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbfCZU3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:29:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40679 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbfCZU3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:29:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so8601300pfc.7;
        Tue, 26 Mar 2019 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CcDCttWQQRDFnDGuctKlblg/7Ea1ohw3g/GU0uxyTOE=;
        b=FXq6lIz99Mam0RoeP8qISwnQAqGIozaOBfNn0sGdjRySvPV2zLaGxq9oq6VdixmR7N
         geb9f6zO+f5ivmven2kSFQISnUOUARovoTYuzYUoGC6Lyrmfi5qDgV5maSBXrWGUQv89
         Z78TfzoBNAuWIUxZPs1GwJSXy1RtY5yx/wiSKEURZH9PzBTvpwbSVAgVWLQkpviez3vc
         H3B7Gq3qtZSD/uD239edUWHRE0Zr8zVwyWOmf+sYXaONz+z0xhMI/iQNTlulU8AVPKQ+
         zZTg5d+xHLlbJ61g5H95BUQZl0TZf1aEbyOUCoHFcfNUWzeFHFXAUw3A7HiLHDDZOp8W
         OoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CcDCttWQQRDFnDGuctKlblg/7Ea1ohw3g/GU0uxyTOE=;
        b=dHEkToxG39YjjXK7Dml/NshjyfVmJN39Jd5EC6l6ntbWjvu7QbNozfiS4MPXn85yNa
         iz3pw96ZWbwhIt1wiVhI+Uzkk+hGTT/yb3pDtMzf4xEUW0SGDaYqjiEJOj6uAQvkWYVU
         Lmrn9OE1cQse+tY+Fz3d2GoBex6BgIpoWqrHBjjBp6YB7qZOgzEaEtBwnIT8mYNVX0Wg
         9lPSQKOaOz8hcwCwaW732pylksNTf5PrxiDnCfD+3ibru96saNvw/CzU4WZ9OSBT22Gz
         VcKAKzbsbonD8BE5A4YZX+EMDpSG2KREGqUeYyl3gFDK5HgqWS8xUBj111JLSIOxmoe9
         jigg==
X-Gm-Message-State: APjAAAVOBKeHWVbm8eDBan+vM+4HTXl3Kc837kOJUTiQXkdOEV1dl+rX
        sJLjIhDP9GyfPNqlfuYJ7Xk=
X-Google-Smtp-Source: APXvYqym3YVpE2KrDtfWQFRRDdlr6q1ymTZTff2aq/sHSRu7vrLs6D2iAVL5WbJDxnCV3LQeO4r3LA==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr30767413pfb.226.1553632155568;
        Tue, 26 Mar 2019 13:29:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e13sm35613527pgb.37.2019.03.26.13.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 13:29:14 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH] platform/x86: intel_pmc_core: Mark local function static
Date:   Tue, 26 Mar 2019 13:29:12 -0700
Message-Id: <1553632152-18888-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day reports:

drivers/platform/x86/intel_pmc_core.c:833:5: sparse:
	symbol 'quirk_xtal_ignore' was not declared. Should it be static?

Mark the function static since it is indeed only called locally.

Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Fixes: 238f9c11351f ("platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/x86/intel_pmc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f2c621b55f49..9908d233305e 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -828,7 +828,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
  * the platform BIOS enforces 24Mhx Crystal to shutdown
  * before PMC can assert SLP_S0#.
  */
-int quirk_xtal_ignore(const struct dmi_system_id *id)
+static int quirk_xtal_ignore(const struct dmi_system_id *id)
 {
 	struct pmc_dev *pmcdev = &pmc;
 	u32 value;
-- 
2.7.4

