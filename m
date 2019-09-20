Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ABAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DCD208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdmXUSoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393384AbfITQSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:18:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40166 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390271AbfITQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:18:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so3407286pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LzFrqPQBDwdXmQkSuu8KsIj5oRAPGrw4JRLMdlkzg/s=;
        b=FdmXUSoYQVg4zFefv12JxYtGNAaoDsOdUsRjf9g6/5FNTQ7wRh5WH+BpMjuSVKNvXI
         UxS7ihGz7Yy6lQl5dtcuaFGCjkTDEV29U6eGY9hjgG+TkzxBXZWkzb/e+OpeR/y5zsM1
         7MP/ocSY6EgCG/5xtTxcHbGCxCNdktO+F+2wVPpPognyAjPkixpst1Nq5oYMhAuCRVnP
         N7nD9QbfSZ2+qnc1SwUbQ7ov7tZ639c0YIQHu4WIitYSMrbkon2Zi1xXILmJjESkRb8S
         VtuMoD+Ip4dx/DzUzDLnONK1EzMB6PWgLq5uRJHFAlgBvxBswwRYoATBD8duB0K3N+fo
         jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LzFrqPQBDwdXmQkSuu8KsIj5oRAPGrw4JRLMdlkzg/s=;
        b=b7hgR1MaFDmmPhaAt2ZC5RfLsL7BBvlHlZObUU/Y0MLWfbeIEiFzsdP+5gZGUM49mC
         TxhzLu4BkDshXlppgtc5vIxP+35j5ny0YmkjZFXCNLbVZ2etSKau9Wx1oK3kBt4Lz56O
         iS7qfLant9wMKJvzWnHIOVGQBJTD2liJCHTiXk0dBh4fSGbWmCUCjAIYNXdXdijp7f+U
         Ke5rrCYdcEFy1GwyWx70qVunpeQU2f6aJBVdRRVYiAuNgryNLGFJQ5kZ5Ju3bqcAY5X5
         YeQ2aDgSFIlpQNJkkyyNioq2b3K7is7kuOKIVStGjXRiwZYHoPmfHZSeySE/XzoVI8LQ
         kQIA==
X-Gm-Message-State: APjAAAVrbyWL4P1BvqaarGbDyWpXtep2UdOj9j1H2POTj2aMWtZ5tLlM
        aZA3A78l/n4s2bcanYs9cNQ=
X-Google-Smtp-Source: APXvYqxwjCVURm9DK7zOJITte1sP/f6LHs0VLXylGM1ogKUzVMvMZepcrd+bCdCxyw0K5KRu5fjf/w==
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr17524414plp.255.1568996318341;
        Fri, 20 Sep 2019 09:18:38 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id e192sm3526981pfh.83.2019.09.20.09.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 09:18:37 -0700 (PDT)
Date:   Fri, 20 Sep 2019 21:48:30 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Royer <seroyer@linux.ibm.com>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocxl: Use the correct style for SPDX License Identifier
Message-ID: <20190920161826.GA6894@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files for Open Coherent Accelerator (OCXL) compatible device
drivers. For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/misc/ocxl/ocxl_internal.h | 2 +-
 drivers/misc/ocxl/trace.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 97415afd79f3..345bf843a38e 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _OCXL_INTERNAL_H_
 #define _OCXL_INTERNAL_H_
diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
index 024f417e7e01..17e21cb2addd 100644
--- a/drivers/misc/ocxl/trace.h
+++ b/drivers/misc/ocxl/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM ocxl
-- 
2.17.1

