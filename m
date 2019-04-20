Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D613C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E89E2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="E7hKOzVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfDTHUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:20:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDTHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:20:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so3447928pfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hxiDFq7XRCSfJcR8XGrV9GMZHdT859fYNRXkCpzw2Q=;
        b=E7hKOzVBVcvwfqxlWmm3bneXx/YWiZazHjPqa4s9wXsvl2IpIoAc6T3X0az9qjFjPA
         JglvOl4mAX+kj/RoQvLs226wzdtGysZr2ZRz87lyvah2hoedbt5/JCVaoScFJfyqiHIj
         Jiwj6FZv6uaFLCWlFCJxhG6SN3l4Sys3jkT10RcjTWhmdzB4HH0k3i+BN1+24CEkASml
         dmYtzTIWyzQXGfi9S6Cpphr3DGUA/tsjqwilXWWvlEnXjxvkC+doqgSXhdokuavsEHyD
         qVPKLqooXtfs4b7UDaBwOHSl0nE/80VgDHsuyvYSoiviXpxux7OtXBkuWfoeCy3vphYI
         8HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8hxiDFq7XRCSfJcR8XGrV9GMZHdT859fYNRXkCpzw2Q=;
        b=GGznUCa2kyGsEum9Pz62sFFgjXoqqrL1z1eymkLmlyZQd/hkZ6f+FZfMWhno4iy9eN
         LMBcylZB+iBZtqt5ucwi6WggQ0aBmOMscEFMheIrwv4Ur/UloVFpLlDuXSUIMWlPYG1s
         UTvEH617+DU2SRwG2+Ns/Bf2aExzEF6PqzxjaHLLAmOmSFobIA78Y8ey+r46F5NmuerR
         Yj5xmt9x/YO9OzV1yI2HW02ejrj48rTPe4a9wPFwvoWQ3PSW9mU7CQheHfU5rt90+rQZ
         tO3LAdRzfFJiZuSIWePGxSh71J4bM9ipmwuuOJ1P0bNvbkBCVgV31LwnNkukT18iZkZ8
         23qg==
X-Gm-Message-State: APjAAAXaW06JseLwOaggSJ3wH1hjZsTgat/it4wKqfK9HJF7Re6zBhu7
        XvzmECnj0+avLtoZgdF0ZiP1ng==
X-Google-Smtp-Source: APXvYqyQbplDQHLQyUMrZcqAtuyqJYJy5h4Glm5RA9uDYlly8+GBMicCvYhv7VKojfh4BuzycDaPow==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr8097829pgv.159.1555744816333;
        Sat, 20 Apr 2019 00:20:16 -0700 (PDT)
Received: from localhost.localdomain (36-239-215-67.dynamic-ip.hinet.net. [36.239.215.67])
        by smtp.gmail.com with ESMTPSA id g10sm7661852pgq.54.2019.04.20.00.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 00:20:15 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Gyungoh Yoo <gyungoh@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: sky81452: Switch to SPDX identifier
Date:   Sat, 20 Apr 2019 15:20:01 +0800
Message-Id: <20190420072001.16900-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420072001.16900-1-axel.lin@ingics.com>
References: <20190420072001.16900-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sky81452-regulator.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index eb2b60968a1a..177dede82a61 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -1,21 +1,9 @@
-/*
- * sky81452-regulator.c	SKY81452 regulator driver
- *
- * Copyright 2014 Skyworks Solutions Inc.
- * Author : Gyungoh Yoo <jack.yoo@skyworksinc.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// sky81452-regulator.c	SKY81452 regulator driver
+//
+// Copyright 2014 Skyworks Solutions Inc.
+// Author : Gyungoh Yoo <jack.yoo@skyworksinc.com>
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-- 
2.17.1

