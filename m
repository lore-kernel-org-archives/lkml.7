Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E6C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B4B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LMg93wbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfD2LgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:36:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33426 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfD2Lf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:35:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so5038663pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 04:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuTJNEBUxIXVy/jkPavKDissHj1o1WU2Fh3f2uBGdzU=;
        b=LMg93wbRYuKdSDc9paygKJ489CBVqczTEyfJjZzh2LIpSmgeicLLCj9VptDH3QHao1
         XFOR6DHuRYYNuA/B6IdP4wF0uKib5VrD+sWQcCfKXG1rHNiyAUh5vPNwVijAutSSqC5v
         gYy57GYGkNETPrTZqKlW6Ne/3hs5LZePqLm7dR/0z1Oxc/cZjDi8EnZVjViQaEshU6ku
         DYpLiH1hxlzjEjJ1hhIhRE09LlMf6/qRciA+OOp42sejJzvGAfHmIU//cpo0Kanf5sGA
         wMQyXh4HvdE870boKk9A64UyJCgmLzVHZPh7Gm2MV6j6qdPI1OE65vInOozKJQKn7O0W
         Q/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuTJNEBUxIXVy/jkPavKDissHj1o1WU2Fh3f2uBGdzU=;
        b=rCHEyuQLpk8b3RuwOcOTVLM0+0ESfSDd0Yp2NzGBQkbGymQZQFywjwoer+Q6vcZPzD
         r462SyDElDsUoKGbXHniuEzApoQbuAoDx7FPDjWGSInUlwwsmtcmqmd2s3JuYB0y8JP6
         fZMvhofXTtsgWy5U1JD+zQZ1V9PmWVo0ePHA+8e6R7d1ZT+PY65vuMbcKgLNd3obLZ2w
         OV8pZqfIfejEHNmPrS3Oeyt50IIerx1FWFyjt0jfwVQgeQ8qmJ/XAJoZ8+4mHOazOGQl
         cVKXjOLSwW8YbR8wfmJOEkpnTNDlwFFS/0SrBH473yBgBz1J0VD7664hxHRoKxoFSqYX
         1JIw==
X-Gm-Message-State: APjAAAXSDIG5+i4+zpE3z8v2Q/WoUFAUQePrtcOD1OZBlMawi57esr0d
        mbN8MnBVao1NNa3RJR8t5XIfUA==
X-Google-Smtp-Source: APXvYqzOJMP1gy39115HBlFV255byrdw9v/LOMd4avadg0aq9//p0ZgYQwgoFilydb75nUgnO53jbw==
X-Received: by 2002:a63:5349:: with SMTP id t9mr21552505pgl.327.1556537757473;
        Mon, 29 Apr 2019 04:35:57 -0700 (PDT)
Received: from localhost.localdomain (118-171-142-181.dynamic-ip.hinet.net. [118.171.142.181])
        by smtp.gmail.com with ESMTPSA id b13sm45058844pfd.12.2019.04.29.04.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 04:35:56 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pawel Moll <pawel.moll@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: vexpress: Switch to SPDX identifier
Date:   Mon, 29 Apr 2019 19:35:42 +0800
Message-Id: <20190429113542.476-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429113542.476-1-axel.lin@ingics.com>
References: <20190429113542.476-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/vexpress-regulator.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index a15a1319436a..1235f46e633e 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -1,15 +1,6 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * Copyright (C) 2012 ARM Limited
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2012 ARM Limited
 
 #define DRVNAME "vexpress-regulator"
 #define pr_fmt(fmt) DRVNAME ": " fmt
-- 
2.20.1

