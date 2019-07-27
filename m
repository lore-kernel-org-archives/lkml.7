Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA3CC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC40208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAneFrV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbfG0QAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:00:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36485 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387673AbfG0QAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:00:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so25879672plt.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jdn1GTUAHwy8oZ2R+rRzEBL/BpQMokE5xKY5/H3jvbU=;
        b=XAneFrV8UQujKwVGL+MLKyAMbE+ZZlhJpMWmxSRGOyaXo9A3uVibsoMV9m+AlghyA+
         I44l0N+iZwJrhzSYi4dzdci+aimiFFXBMw7Ynx70wJCNqwq6CVCDpU5Auo6TahgOTM+e
         KLMDEcJr8zNM7rkDXPECySLghCL0lbzEltFQ/cSzVKr+NaH+Oy44ab6B6IpI0gEZpCfJ
         dRevQhS4cw1SvUzPq8iA4wLTWnGxtsrfAyhGdoRFoNK70gyMWB2YW/23XWG1BANHjHtW
         Ymu56zZe+bzn/lcywE1fTxYvsg5zWRQBXsntavhZt+N5o+DSPu8ZyKFex3l70pf/oKGS
         6+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jdn1GTUAHwy8oZ2R+rRzEBL/BpQMokE5xKY5/H3jvbU=;
        b=MNDsfLa5k5y/keOjdtPqC0Y4TirKsVCmI4KAhoRTI7osPmJmHHCgpks6fn5cMCF+aY
         o02mcAA7ByEVwEftef2SaOW50duAtiCEqBtkqvOw/4WLu/DDzEJbv0VABTyW6xzwH8i2
         oz0SnNhNxaQmTKJHx6UKe7iRNWUi5CEsF8VusJJPVmW09xgrPOWzCxlezpMYMEBVqHlS
         +bSuE1FTuB0XhvpInfgPyhRECx7UZKEXcASbdzakoHeODAzQknpYdUKGHqGEbs9u0uXM
         4GlkyfwHGTeSjN8p4yDcklP1gbBvOi3nA//B0Ds1W2e9uyli+G/cqwxkYCnuga6YTOxU
         2pTg==
X-Gm-Message-State: APjAAAWBIo8HGUMHDM8snPI6aYwv2onJaNwWC5FwHBQueDxDzZpFNfdo
        cxwM6OOYXCzTRZSVzbHlENo=
X-Google-Smtp-Source: APXvYqzQoO8HnqlzS6r/5MbslhpK7CQ7r3K37MFdR1WeqlojeaHvOypY1nbj1SfyDSUILiI0vxxMuQ==
X-Received: by 2002:a17:902:d81:: with SMTP id 1mr105945760plv.323.1564243219722;
        Sat, 27 Jul 2019 09:00:19 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:d1fb:8d6c:15fe:b4a])
        by smtp.gmail.com with ESMTPSA id c98sm54964994pje.1.2019.07.27.09.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 09:00:19 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 2/2] devcoredump: fix typo in comment
Date:   Sun, 28 Jul 2019 00:59:06 +0900
Message-Id: <1564243146-5681-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
References: <1564243146-5681-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/dev_coredumpmsg/dev_coredumpsg/

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/base/devcoredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 3c960a6..e42d0b5 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -314,7 +314,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 EXPORT_SYMBOL_GPL(dev_coredumpm);
 
 /**
- * dev_coredumpmsg - create device coredump that uses scatterlist as data
+ * dev_coredumpsg - create device coredump that uses scatterlist as data
  * parameter
  * @dev: the struct device for the crashed device
  * @table: the dump data
-- 
2.7.4

