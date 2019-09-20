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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DC7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD6208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTINQyBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfITP7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:59:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34139 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfITP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:59:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so4825010pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WhdIfmlSOGNzAA4ChhI9TUrPuOwNKiv/L8I1EQAI0fo=;
        b=eTINQyBbviqymJJ2r4B7tJ0gohSOEFO6kZ/Gp1j62kQaxDnZboCyO9u+G+vs77keD8
         aFjJT80BDCOB/B/A7o3vtkzMmHZ6tJxvSxuYoZtzweiSnh5PwDM7XN6C+hqRRpCHt9dC
         dlQM2oZwm6MtNWV0zy6AplHf9Lgp8dY6DEGzldS38+xbsxF4VYpIYNNKRPkhvJVWh7Pp
         87uWBfJNj6tMwOuatBCzHG8WipE3p06JQEczgKYEgEDFpeULdCWHmqfwwb5sYyINT6wp
         XX3+NALT/isQQyoqHBiGJlP8MJdRH+ptLGOblrhX3SzSxVwTaSAmvVw6mNdZMiU+SjTq
         /XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WhdIfmlSOGNzAA4ChhI9TUrPuOwNKiv/L8I1EQAI0fo=;
        b=jxgkjUDL+Um+mTAZmp0v3VRYCKeqF67T7DUyb5XCe1JBGOsTK9bCihs6gr2WHR7yJO
         NU49Da2VKBRKFBXA+pR6UZzbqLcVYA8F6HFcSNeM6hVD25GbAF9lNyx3l0cak6J73Q3H
         diAuP1IwqKqeTuD+03tv4/ffxGddNBzG6uCjPOC8KRQ8GiIaE7zkfUAFBy63dHBLdYdz
         4RvsScoxNdT2/Lp3LY7slf+Y9nzPinZVDl+4UrCxU3YqRyix/6qT+fgLxVCBsUzOtZqh
         UQMSLARj900viGit350UvEfyVTr+rzjOvBBVhhtByoiosMfbQce5AYn0vr6K97Oqa/GY
         wKaw==
X-Gm-Message-State: APjAAAUdjKc6ezoASwqi5Vs9ljt1eQDZC3uttHaQZfJzczl7vFw/t72J
        rYwEj4bJtt3fJOGH+gJle1o=
X-Google-Smtp-Source: APXvYqx6f6jlW+VViPHDi8bRyJBLA3emHjrLOGrc1KhpwvMF0UV0C3SVVXD0GB6ZOTO8WLPgSCGqDw==
X-Received: by 2002:a63:61c2:: with SMTP id v185mr10437514pgb.96.1568995181525;
        Fri, 20 Sep 2019 08:59:41 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id 1sm3582663pff.39.2019.09.20.08.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 08:59:41 -0700 (PDT)
Date:   Fri, 20 Sep 2019 21:29:34 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Royer <seroyer@linux.ibm.com>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] misc: Use the correct style for SPDX License Identifier
Message-ID: <20190920155931.GA6251@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files for Miscellaneous device drivers.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/misc/hpilo.h  | 2 +-
 drivers/misc/ibmvmc.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index 94dfb9e40e29..1aa433a7f66c 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * linux/drivers/char/hpilo.h
  *
diff --git a/drivers/misc/ibmvmc.h b/drivers/misc/ibmvmc.h
index e140ada8fe2c..0e1756fffeae 100644
--- a/drivers/misc/ibmvmc.h
+++ b/drivers/misc/ibmvmc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * linux/drivers/misc/ibmvmc.h
  *
  * IBM Power Systems Virtual Management Channel Support.
-- 
2.17.1

