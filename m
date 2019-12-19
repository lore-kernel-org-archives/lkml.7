Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4944BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF8624672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDCWrfuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfLSOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:30:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39761 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLSOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:30:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id z3so2635522plk.6;
        Thu, 19 Dec 2019 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5t4vAswEOX1SfsHlXsZAbvag2JXNNPB0kS5z+7nIlZU=;
        b=tDCWrfuq6GSykvPgq+3DTz7yLWgt428pu+ADVZtMN2o9F/u5Tnj8gX6CQeYGuktLsC
         njzdRXgF0oTS/HuHW8zZ0/Hi5hPeqtulhwE2eH27XZCbFKg6Rqj6w/depYVtdH+I0ZtW
         CBAEp7mW2pnG4LJ4/vIjUjYTfsq3j9JLjMYjD49wMWk6vmHF58WdLMP9rrXIj9gHAnSP
         yB9kfCxsLq0qFb+Q2fhrSueZe649Da4jLqjvIYUe1drVFvQdt7kd/0ikyMax7IImcSaE
         7PSpGTmKIXuznobgi3GtLJmIBgIZ3/L0kKOMMPfWPzXk+sXh0EeCkNozIBJhsD03eBrf
         RsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5t4vAswEOX1SfsHlXsZAbvag2JXNNPB0kS5z+7nIlZU=;
        b=h0f9p1K2tStMWjmVRygQ8D37x2rWO9BJe/lFcOi242CjNDQJH9S4K30r5G7sm2B8At
         BzQgqo9bk3cqwVsJWzkGvg07Bq9pMcp3OR4KBctb6aLYAK5W06e/HkrOwe0oHnfbVgen
         NnUz3SSa8xV1Kq7bV8xXLrIlpXw3hQKCRpk6JFaFAakIL9NS1k6MJe4r8Hyf7J5xUdRU
         X373oxKz3G9ondFxR3J+TQBIjxBwV4yJoQEpgw0aXkahKJ2T5c4n7UUvu4wySni4gVUB
         dccdUpXT2JODueEIFvnWFpmLeMH1Nm/Bh5WPKeX6+W98bCHTvk3BlMFw2d6RsGne2MFo
         fKlg==
X-Gm-Message-State: APjAAAVyUncjIPn0iwrxKf5CCbHQoLazGZEEisJpjtk01Mrh55i2CVwC
        ygcdnKBzGjQBV8RR7IUtV3Q=
X-Google-Smtp-Source: APXvYqyR3kU9o7p3yM9RBMiJysPdrvk8AFBebRAa9eURJu+LWRNgvXRALah0eRgoTy4lTKmXGZITUQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr9185759plo.291.1576765809019;
        Thu, 19 Dec 2019 06:30:09 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id r2sm7639129pgv.16.2019.12.19.06.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 06:30:08 -0800 (PST)
Date:   Thu, 19 Dec 2019 20:00:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel-ips: Use the correct style for SPDX
 License Identifier
Message-ID: <20191219142958.GA3594@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to x86 Platform Specific Drivers.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/platform/x86/intel_ips.h      | 2 +-
 drivers/platform/x86/intel_pmc_core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_ips.h b/drivers/platform/x86/intel_ips.h
index 512ad234ad0d..35ed9711c7b9 100644
--- a/drivers/platform/x86/intel_ips.h
+++ b/drivers/platform/x86/intel_ips.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2010 Intel Corporation
  */
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index fdee5772e532..8203ae38dc46 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel Core SoC Power Management Controller Header File
  *
-- 
2.17.1

