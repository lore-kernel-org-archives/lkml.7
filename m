Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4CF21850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5UPxsrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbfGZO2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:28:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43803 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGZO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:28:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so17850169pld.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AywXpVA9eEQdh4e64Qxw0MV6l84k+dcZJfaiN2GFza4=;
        b=O5UPxsrchS8uJf5DO5i9wXEPdW/7gqrCA6tp5mNe1RUw3CDIxpsjqVLyTyd/77A+Ou
         HJ0aRyABVBOHVB0XFeFc2wGX4KZFc5fkl1JGPUUBxsR8SAX/hBN0NOIc28YG5fBWDajO
         en9efv+CxSbCVSLVKVM1Eih4uDbeYcK1inEfmqE04ZFTjf0uTgw+wat3f20yUMZ7kJU6
         zO4AWQYlpgdp2oUnoUhGt3QlHiwju7AAxljaUgG27LgH+fOdrzuXB708VvYGZdG0mcPf
         RKgOjD2yjDbboPeOVH3ul7Q8Wj586Cvz/GN8lOaadT0Sookp1yUPZPSGNchhj+0cLdaN
         p2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AywXpVA9eEQdh4e64Qxw0MV6l84k+dcZJfaiN2GFza4=;
        b=Fny88BxczxmIbsqhdA+mYAYnwh5G2MadTr4AirI2LmxNbYK/t+LBuXpcVh8fK9valb
         38cxLdOM6wfUwIyzGyhIrJEEQ5A+NZd6p1K+YX4kaezPFx2CCCa30Knnhk1gmrtMI8bC
         RyqHgXG51NXnFMld98S9twsRtPGRcnzU2HtpILA9LiIA6hkX0Pzmk2YkDrRaDCkzJPdU
         8O6G6aeG1VyVvlQgFfuK82tdhWD968PodW6hsrwmm73zechehRK/B88s3IWpJehHSDDK
         xFMjca45Gej6LnBfjm3S+pZqTd+mWfaYkESSXe/NbfAHLOqrS0uI979ANbg+bVn8LEV4
         PY3A==
X-Gm-Message-State: APjAAAV3kaA164SnDgHgveXY3q0kpJKbc9nXQ8nCmZn4elqPInhx3uYj
        3b2qMdNsAM+jCjhCQri4LhA=
X-Google-Smtp-Source: APXvYqzHsMFRbn8puBe7XPgpzFiXahWIR2zO76FCFbzc8zZO3ine5KtDmSN3xu9BOCRCugaiAtVDMQ==
X-Received: by 2002:a17:902:28c9:: with SMTP id f67mr57532143plb.19.1564151331930;
        Fri, 26 Jul 2019 07:28:51 -0700 (PDT)
Received: from nishad (p3261240-ipngn21201hodogaya.kanagawa.ocn.ne.jp. [153.202.122.240])
        by smtp.gmail.com with ESMTPSA id q21sm37369904pgb.48.2019.07.26.07.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 07:28:51 -0700 (PDT)
Date:   Fri, 26 Jul 2019 19:58:45 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] intel_th: Use the correct style for SPDX License Identifier
Message-ID: <20190726142840.GA4301@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header files related to Drivers for Intel(R) Trace Hub
controller.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/hwtracing/intel_th/msu.h | 2 +-
 drivers/hwtracing/intel_th/pti.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.h b/drivers/hwtracing/intel_th/msu.h
index 3f527dd4d727..e771f509bd02 100644
--- a/drivers/hwtracing/intel_th/msu.h
+++ b/drivers/hwtracing/intel_th/msu.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub Memory Storage Unit (MSU) data structures
  *
diff --git a/drivers/hwtracing/intel_th/pti.h b/drivers/hwtracing/intel_th/pti.h
index e9381babc84c..7dfc0431333b 100644
--- a/drivers/hwtracing/intel_th/pti.h
+++ b/drivers/hwtracing/intel_th/pti.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Intel(R) Trace Hub PTI output data structures
  *
-- 
2.17.1

