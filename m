Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236D3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E527020651
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6dvpJDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfEAHYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 03:24:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34793 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 03:24:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so7020229pgt.1;
        Wed, 01 May 2019 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=m1GeGpsRNV7tQnPz4nTWgbx3ceHpuOFlzFfyw2XpdLI=;
        b=A6dvpJDb/Da6D8BBViQpv65enZHjwPkgcTC7QS0pVdhmX+9KJeRJkqiU5kfinDmDFL
         SNv5Knoz1xUsKDU4BouPAr9vb0u0lKnHxoJi/sgbckXWueGqlQqm9J5UouPJollGUo18
         8kuZjNbMl2kITsGyYSYGUtEcMj5m0QSuM0FBb9odQfIEe8D6NI3zCSh7mp2wv9OnejEh
         wbLDXDQqCKkui/HoBYYAOzEqgEsxfUnFx4OVmWYw62neqw8doFgDEEoZKA/s+A2xFWTZ
         UDF7eDm7mjcZsa1A6x2e+rGqXLEapxSCl6idZqRto6tOg5VvGygR9PUqgt+aNxKOXmmf
         xacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m1GeGpsRNV7tQnPz4nTWgbx3ceHpuOFlzFfyw2XpdLI=;
        b=nhDuskn1w9/fDFntQ6LiA7xs0vOOYbqknaVGOqj6ruF44VHlN3ZLzwoTVE1w1G4Uj5
         AuQHrsLfP/UvtPekkeYCaaK1YXA6npGqmU3kNi0LKJVzKafaeqzT2OagjgRcMczS1Okk
         Uyo6S71c6tkYJhP8XaLpGGVONR+2j5q1ZY/u44RpMDOUsyXOoVAllIPtPePVbvj+Eh9A
         BlIRGIYKhv7ZQHNgf7WxWLHeaYg6vqWc5nIss3H06v1kTBgoP1kSR37eLpls2EUwmp6B
         XEl/cTpB6TfxN86oDPJPSaSF/kbDgGsKF6hLli2OIpfqy6EylIWiVjmFN2slvGZw9Km1
         RBnw==
X-Gm-Message-State: APjAAAWBHRIlYndeN+4SBTwUA7qQBW4TsoHtJlY+P8bEG8bswQIBTSYr
        Pl3nJOFwgnzV3HCWIjDmxDE=
X-Google-Smtp-Source: APXvYqz80tIDFzZEX3rYyOjprXVMVlzky18nBKg+hUs4Qa8rRVg3lsKTHWyLoHxdmpI03yHAeofIwQ==
X-Received: by 2002:a63:c243:: with SMTP id l3mr41826504pgg.448.1556695490396;
        Wed, 01 May 2019 00:24:50 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id f13sm72043488pgr.35.2019.05.01.00.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 00:24:49 -0700 (PDT)
Date:   Wed, 1 May 2019 12:54:43 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: davinci: Use the correct style for SPDX License
 Identifier
Message-ID: <20190501072439.GA6378@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to Clock Drivers for Davinci Socs.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/clk/davinci/pll.h | 2 +-
 drivers/clk/davinci/psc.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 7cc354dd29e2..c2a453caa131 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Clock driver for TI Davinci PSC controllers
  *
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index cc5614567a70..69070f834391 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Clock driver for TI Davinci PSC controllers
  *
-- 
2.17.1

