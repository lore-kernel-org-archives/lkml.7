Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C0AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8241421019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="2Cvm2iOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbfEWMv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41630 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfEWMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id d8so4303813lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9ejD9Dmbikyh/E/C2ffOjcSNuWRasGmPKqlousO2AI=;
        b=2Cvm2iOLdW2zG+hEE7WnSyyadypZpHlWc7YNTc8b8WgJcvLxzJ6v5d+t5TFvjaDd5r
         V6QazTM8O3so3YIG1hBBhFKAGq26HFgRXQ3oq1WFxadqLr8MoC6ovjnMq2HAJheX80xi
         zWBf3P/sih7Rs2VP58sFBZJ3QPesb7GwUyr/yHhc9oObeQU6JdiGWTi8zGoybGTYOqr7
         D1T32fesG31q5rU5AOBC1haHpKMubGyOji7/vS4Qfsr60vK+vwk2PQeOHXyAhcgZhyW2
         547RMgVd9pC5Kribrnez7P/n9fEmfmRfjku4gb+ZYs7E4n4v55yoR5eGN1tMY2CVPdam
         FGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9ejD9Dmbikyh/E/C2ffOjcSNuWRasGmPKqlousO2AI=;
        b=kwDYbq9qlDQ9gVBKo/Cvy7OGV7S9Ne5iLqCJ36AOEsN7c4CpyPQngNF9wdXWlzX67V
         +7/q9W5jUDDpxkMYrjgFfDs227SFxD5mQdN8IZ5QKBCfelMyEoggeiPqKSg8FRk9KAkU
         4bzNx5vCga5XJkjddEQ0XW7jIUIcvIWf9S+S+Bz+bjN83iRB9VMFQjn9yTf48PvDSYXA
         4ACdeJ1bTONWpxdiagHzcOY5dEEAmpoVv5iC3req3EMnoDTp5xcUZuRTOpezXLYSIAMy
         Y4i+e/tBmTSXRb6fFZVOGbSnSQrrIVlzNGi2F2SyW6OkEFA/Ko9LwAbyTjMHfmlwVQrz
         I0kQ==
X-Gm-Message-State: APjAAAXRNzPqlhS4g99Nc75vQMUXIzhVj9rWI9nrgXBXJQhdqU8go4m8
        xGNPOuDWJLGhB3j/fwFPESh/Iw==
X-Google-Smtp-Source: APXvYqwuga05QEEZFv966dAEMfP4nQxKq+vT82FqzWnvc4YmVcR8kfm5koljHuehptbDMAzunB8ncw==
X-Received: by 2002:ac2:4209:: with SMTP id y9mr8382103lfh.83.1558615914197;
        Thu, 23 May 2019 05:51:54 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:53 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] staging: kpc2000: remove unnecessary include in cell_probe.c
Date:   Thu, 23 May 2019 14:51:42 +0200
Message-Id: <20190523125143.32511-9-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Use #include <linux/io.h> instead of
<asm/io.h>".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 682d61da5369..5e65bd56d66e 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/slab.h>
-#include <asm/io.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/mfd/core.h>
-- 
2.20.1

