Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE58721773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5gFtrcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfDXKUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37687 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfDXKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so9167821pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4rNWAWYr0QpbHwbiJysy1fmnMk/MBnOLACWNRE4nzo=;
        b=h5gFtrcqivwuzEg1/9+aho4OTuUIcbSCtXwWHNt7UWW+jrFU5R5QlMOe3pB5LW/iCu
         rr1xXF0bbu+pBUvINyAayGCkp1cgnz41wV44ITNKUypbLbQapEFwf8F8Oz/NHVB+tm8Q
         BX4l1bnbmzj/TZbX7cYW0m/Pgb8UDwrWNj93ds+7ploeuabYhV7aGUHF6X1paghg/7Cf
         YJTFWsg3MPyFcMsQRynf4s3vVAcFbic6XtDt1x8OB6lDbfH1HQlRBWl2glWr5mksDlmR
         FVJ5RoQ0cEcRm0oTymq4Iq1qTSi3iam1C4AHzqLQvSy1DeSIz6AeICM5jWIkqQzgFOxa
         nMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4rNWAWYr0QpbHwbiJysy1fmnMk/MBnOLACWNRE4nzo=;
        b=QHWBl1X9G80TsjwLGzy7dHw7w4RG7U53p1T+UZSkMhbNQrBTY2mt/SSYoCihsi+jiR
         r0hANFIkOczu5BJc6Y7yw2+ijHUtY53bJocSgLfuM/+Aq3xfT0/di8vGCymyakPISQY3
         W3CSJVDNxj/To/4ABYQ7aRWzqsP7pF1Z46EhpPHDbL3f1OwbUKekJ4umUP4yKPMO/ce8
         DL5HfJ5tORZ9ZK2Rro96JgjcQK2YHAlFdRiw71SQL9gBp4V1LymRvtIx/Qqp28M0CwkN
         TmjmoqiBs8CFj8ZvF2bn6THdh7bjGKZGFC23R3byCIbgxWMlCO21aofoTMhmNhpxakXs
         FNMA==
X-Gm-Message-State: APjAAAVthoT3tZgVWbOGTuA7R2rW2VpRzn45m/m6ife9A4yaCqhPYYzW
        nTYEBJpsyRLw6e14V5UCbdg=
X-Google-Smtp-Source: APXvYqyKQYM8wuL9yfz1uJPLKz5zb3JwP5/iYQyj/NB7f17HoRd1lwHA8s4jRceC56sLAYBHeyiEnw==
X-Received: by 2002:a62:1795:: with SMTP id 143mr32120080pfx.104.1556101243425;
        Wed, 24 Apr 2019 03:20:43 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:43 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 05/28] locking/lockdep: Print the right depth for chain key colission
Date:   Wed, 24 Apr 2019 18:19:11 +0800
Message-Id: <20190424101934.51535-6-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since chains are separated by irq context, so when printing a chain the
depth should be consistent with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2cc2a15..e001dfb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2409,10 +2409,11 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 	struct held_lock *hlock;
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
-	int i;
+	int i = get_first_held_lock(curr, hlock_next);
 
-	printk("depth: %u\n", depth + 1);
-	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
-- 
1.8.3.1

