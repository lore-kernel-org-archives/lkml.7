Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A52C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0A2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="n04HGGBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCGMS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:18:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40899 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGMS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:18:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id 10so13263608eds.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/cF0hsx9eYRvH4shLkbhHp/ZfdSRLYk8Je8hEsJVgkU=;
        b=n04HGGBKcZLQS/EAo7IdNilfg99ZgZezqJlJZq+R2Ug0dcAMbVUsrD5ziTQWjo10bf
         V5FcVKWCdFyuf6VZb3C8HCX52nM1HeZdo9VjFgf/zMsZjApPZp7QjVppJ1eqhzF7k70L
         E2eHc8AqvVKTnGOoqqaDq4TePdwrF2kdLCDu6DmrPFRHRjXgvamxevKfvaQC921uEbtW
         4vynViLpKDZV7dQmVFXwfZBm3HZ/VjpiOh0w5FJrW1RCRXWVBULDRyo5zVI4j14HkNTm
         ihEQb4o1QXYJFjbBuyt+AwPeMmss3LLHCsPMlFV2cjqyU1OjirFQSjK30rq4BQRYIAt7
         l5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/cF0hsx9eYRvH4shLkbhHp/ZfdSRLYk8Je8hEsJVgkU=;
        b=PvModOjJ7bCxZ1QzqqNuhGmn+K24FsEHorrE1mhe4x2+ZsPDXlpTOqpcC6x55ugWly
         skBGdRXdabAAjZZ+NblQtpiWFuuL7jzXHnPaQhJCxycmEX9TNjssQ6DKUwExJzVWEIBW
         Y1EGz4+cTROYcHsK8A9inArPUPlsoHUvgDxb/pVysb7zKZWS3vwyGrNxYrNcPEWRrswr
         eCypFhQAeRK74ptlLGLITEI8WSxsM5Mhdab4YKVmrwDY/gtb8NesMW20VuDD/ZqFT3sI
         iDT42FyITfS3M6ZaEWY36mG+oOYSM1JK7iMG4MsBw3JbHyB9/dlD+mNSFzYhDRtC7My9
         KXlQ==
X-Gm-Message-State: APjAAAWTSJKjs9oKmvyMwH7F0tgRaOk62v7blIh2F3FzaezHZlQRaPS9
        Tk1SfLhbJrZS+KDi/BFxPrheSA==
X-Google-Smtp-Source: APXvYqz86O9mZ7sl+jG3nsVRz0OutodUFjG5kMCNpTNOEhwQJqf47ALcF5f0YBLqUxqIgkhm2YtSwQ==
X-Received: by 2002:a17:906:b209:: with SMTP id p9mr7686605ejz.39.1551961137525;
        Thu, 07 Mar 2019 04:18:57 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id s12sm1342784edb.11.2019.03.07.04.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:18:56 -0800 (PST)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
Subject: [PATCH] pblk: fix max_io calculation
Date:   Thu,  7 Mar 2019 13:18:53 +0100
Message-Id: <20190307121853.14503-1-javier@javigon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating the maximun I/O size allowed into the buffer, consider
the write size (ws_opt) used by the write thread in order to cover the
case in which, due to flushes, the mem and subm pointers are disaligned
by (ws_opt - 1). This case currently translates into a stall when
an I/O of the largest possible size is submitted.

Fixes: f9f9d1ae2c66 ("lightnvm: pblk: prevent stall due to wb threshold")

Signed-off-by: Javier González <javier@javigon.com>
---

Matias: Can you apply this as a fix to 5.1. This is a case I missed when fixing
the wb threshold, which is also scheduled for 5.1

Thanks,
Javier

 drivers/lightnvm/pblk-rl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index b014957dde0b..a5f8bc2defbc 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -233,10 +233,15 @@ void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
 	/* To start with, all buffer is available to user I/O writers */
 	rl->rb_budget = budget;
 	rl->rb_user_max = budget;
-	rl->rb_max_io = threshold ? (budget - threshold) : (budget - 1);
 	rl->rb_gc_max = 0;
 	rl->rb_state = PBLK_RL_HIGH;
 
+	/* Maximize I/O size and ansure that back threshold is respected */
+	if (threshold)
+		rl->rb_max_io = budget - pblk->min_write_pgs_data - threshold;
+	else
+		rl->rb_max_io = budget - pblk->min_write_pgs_data - 1;
+
 	atomic_set(&rl->rb_user_cnt, 0);
 	atomic_set(&rl->rb_gc_cnt, 0);
 	atomic_set(&rl->rb_space, -1);
-- 
2.17.1

