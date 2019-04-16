Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89A32075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkAT9tOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfDPVeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:34:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40157 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPVeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:34:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so11035834pfc.7;
        Tue, 16 Apr 2019 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ei7MGJK3cNg6YsIfFndg/Tuj245aikkpJc46gnMQbH8=;
        b=fkAT9tOhau1IIWQqnoJdkumBhNVuxriP/eW70x9oFgP/S2l/dgpIMs8wsSx8YJgkqn
         xgwMKSpXmIbg1kj9234C9vYRig+HveoqQxmoPOGakJrFxtW3HBRh+hCCogfDcOin423H
         QjOIwXkPzm6RrDPctTDrZqqJWJDOrRLZ4oI80ijXEKvcsGjtFEW6Sv7z4cfHybOJ9ppl
         OnKXk8NrwIx/XVCKAESlcf4Kc91g6LXdjmChMGxvVHt0/pjduhsl/6wNyTQ9YE3whM7L
         3R1tcVIn5XqiK6P/1e/mLy5QeRT3aGJuYBTJsJxF1SN6cv+Se5dq7+6b2DXanbhAfUts
         LJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ei7MGJK3cNg6YsIfFndg/Tuj245aikkpJc46gnMQbH8=;
        b=rqtKuBH8s4kSRStEcZ6NjpHEH834UopeqZxEHo2FXHS4mMezSfQNrr/aVpoTGSvfSm
         kEJ1kmT4f4NdYxCQQg4E43xMRmLGHC56NIr+NlI9kwVBeN5WTKIkixWxmmsFw0b8gF9u
         2jVmgsvXASh8hAXpNJgn10S0WX+tH5vICtR8GbmoR3UDvd5bi5WDbS4A7EE4IMPetzYt
         jK2sPB++U27+U1ES4q1CiESlWRq21+sLUFt9DY4A4ST6iXxk7A6mxBw1Oqa/BknhwBcF
         w4+2Tjgu/HaylGuISwPkQiJAnuElCAaPWzbJ59erTxalbOAJTS7Q6BDV1qQqkd6ReT0t
         NGNA==
X-Gm-Message-State: APjAAAUZx1i2MQ6MNb5moiAALwxfxiT+QEeFrzESuUWqlPneGz6kMtEl
        ZNuuUE23iZMrnqhpp/+ySvwkWW6W
X-Google-Smtp-Source: APXvYqzfW/tLmtlr6FiQvHfog3MSaS5juhjYkrjicRx23kTLdaHuyAv1HzRgauE4N6HZnpKD9V938Q==
X-Received: by 2002:a62:1215:: with SMTP id a21mr84356141pfj.126.1555450452824;
        Tue, 16 Apr 2019 14:34:12 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id y23sm74242127pfn.25.2019.04.16.14.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 14:34:10 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-edac@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 2/2] ras: close the race condition with timer
Date:   Tue, 16 Apr 2019 14:33:51 -0700
Message-Id: <20190416213351.28999-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cec_timer_fn() is a timer callback which reads ce_arr.array[]
and updates its decay values. Elements could be added to or
removed from this global array in parallel, although the array
itself will not grow or shrink. del_lru_elem_unlocked() uses
FULL_COUNT() as a key to find a right element to remove,
which could be affected by the parallel timer.

Fix this by converting the timer to a delayed work as suggested
by Borislav, to avoid using spinlock.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/ras/cec.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index a4ff54e50673..5c2040a7389d 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -2,6 +2,7 @@
 #include <linux/mm.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
 
 #include <asm/mce.h>
 
@@ -131,7 +132,7 @@ static unsigned int count_threshold = COUNT_MASK;
 #define CEC_TIMER_DEFAULT_INTERVAL	24 * 60 * 60	/* 24 hrs */
 #define CEC_TIMER_MIN_INTERVAL		 1 * 60 * 60	/* 1h */
 #define CEC_TIMER_MAX_INTERVAL	   30 *	24 * 60 * 60	/* one month */
-static struct timer_list cec_timer;
+static struct delayed_work cec_work;
 static u64 timer_interval = CEC_TIMER_DEFAULT_INTERVAL;
 
 /*
@@ -160,20 +161,21 @@ static void do_spring_cleaning(struct ce_array *ca)
 /*
  * @interval in seconds
  */
-static void cec_mod_timer(struct timer_list *t, unsigned long interval)
+static void cec_mod_work(unsigned long interval)
 {
 	unsigned long iv;
 
-	iv = interval * HZ + jiffies;
-
-	mod_timer(t, round_jiffies(iv));
+	iv = interval * HZ;
+	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
 }
 
-static void cec_timer_fn(struct timer_list *unused)
+static void cec_work_fn(struct work_struct *work)
 {
+	mutex_lock(&ce_mutex);
 	do_spring_cleaning(&ce_arr);
+	mutex_unlock(&ce_mutex);
 
-	cec_mod_timer(&cec_timer, timer_interval);
+	cec_mod_work(timer_interval);
 }
 
 /*
@@ -383,7 +385,7 @@ static int decay_interval_set(void *data, u64 val)
 
 	timer_interval = val;
 
-	cec_mod_timer(&cec_timer, timer_interval);
+	cec_mod_work(timer_interval);
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(decay_interval_ops, u64_get, decay_interval_set, "%lld\n");
@@ -509,8 +511,8 @@ void __init cec_init(void)
 	if (create_debugfs_nodes())
 		return;
 
-	timer_setup(&cec_timer, cec_timer_fn, 0);
-	cec_mod_timer(&cec_timer, CEC_TIMER_DEFAULT_INTERVAL);
+	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
+	schedule_delayed_work(&cec_work, CEC_TIMER_DEFAULT_INTERVAL);
 
 	pr_info("Correctable Errors collector initialized.\n");
 }
-- 
2.20.1

