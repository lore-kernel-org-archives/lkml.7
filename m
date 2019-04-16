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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6457C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7062A20854
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YraGu5a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfDPBUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:20:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35577 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDPBUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:20:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so9517378pfh.2;
        Mon, 15 Apr 2019 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MfB1avXudyIW6ugF85fX9+AhvoJyhOP6GmQo/+b/zaw=;
        b=YraGu5a0rGf0WHR1VG7WZcHz57F5UWKxXVvvTwkbIYuMgUEYp/YosCisnnOpHBpsv4
         zywx8QsaXJZgZOuTDwboj0mqeFy2tS3YxEBzYoj5UgUdESvaDCTchZEphVugzKWphey/
         jNmXlO3Ptw4nNZ0x4EB0trccgyae4I2MJg7zsv3b7IfLbUsQoXaPPk2Gc40W3XZhc5kX
         7PpAqaj0VO1TFATCR/2A9p7dT8HjyEx09lAz+5pvzheRSEVPNxO5wiefBXJ4cP+XtMG+
         JiHqfub04Q31h8esDfkrUIXNWZiPtMe/ZXX80vaboy/ICdTaSqPysYSC24ZMXL36c3b/
         eLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MfB1avXudyIW6ugF85fX9+AhvoJyhOP6GmQo/+b/zaw=;
        b=jTAUQVSweY61Erko0e9RKJBDMRIM+QIl6r2jini362emDVvC+bj781xLJ+7ofrDA+U
         NfaFBmQdn4n9JFvE23m7xU1K1zJUyNzT6J0DkPo7vtvplTvXaZPpsuAfsyOOMDNO0ZhE
         p6osL7OtSnQ68jBJGqMBHDmjZOELY0ZaTRpKIo5kBsrpB2cjRKbUKzKvtlaAB+wBAQga
         ugqGGvpR82zxkdrD0AIGo4RobRzAbLRoPa4fvf53fy4xZUppEIY9JfvWyXIm7TQIobWj
         xXvEyvFVM9X5x77VxWEQl80u3SpfbbcYhDQqLRfG2rXzrX62GLGwg76qSfpQ9zYgUqU0
         +Vbg==
X-Gm-Message-State: APjAAAXATJtBNspgI5VwbKVVa2R4Aj+r5TVo/NaV/MukjLzRBwlHzVwm
        5wENoLGrSrjaxZsj9wXG3inlhAnj
X-Google-Smtp-Source: APXvYqwCgVKQhfQc+0TsM81Po8JlbBbj5+CbuvgrjZuZwTDrb4jivDryI4UQGHdCabFFL+Hu82dejQ==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr42306778pfr.193.1555377619551;
        Mon, 15 Apr 2019 18:20:19 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id a85sm64206995pfa.166.2019.04.15.18.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 18:20:18 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-edac@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] ras: close the race condition with timer
Date:   Mon, 15 Apr 2019 18:20:01 -0700
Message-Id: <20190416012001.5338-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
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

Fix this by converting the mutex to a spinlock and holding it
inside the timer.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/ras/cec.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 61332c9aab5a..a82c9d08d47a 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -117,7 +117,7 @@ static struct ce_array {
 	};
 } ce_arr;
 
-static DEFINE_MUTEX(ce_mutex);
+static DEFINE_SPINLOCK(ce_lock);
 static u64 dfs_pfn;
 
 /* Amount of errors after which we offline */
@@ -171,7 +171,9 @@ static void cec_mod_timer(struct timer_list *t, unsigned long interval)
 
 static void cec_timer_fn(struct timer_list *unused)
 {
+	spin_lock(&ce_lock);
 	do_spring_cleaning(&ce_arr);
+	spin_unlock(&ce_lock);
 
 	cec_mod_timer(&cec_timer, timer_interval);
 }
@@ -265,9 +267,9 @@ static u64 __maybe_unused del_lru_elem(void)
 	if (!ca->n)
 		return 0;
 
-	mutex_lock(&ce_mutex);
+	spin_lock_bh(&ce_lock);
 	pfn = del_lru_elem_unlocked(ca);
-	mutex_unlock(&ce_mutex);
+	spin_unlock_bh(&ce_lock);
 
 	return pfn;
 }
@@ -288,7 +290,7 @@ int cec_add_elem(u64 pfn)
 
 	ca->ces_entered++;
 
-	mutex_lock(&ce_mutex);
+	spin_lock_bh(&ce_lock);
 
 	if (ca->n == MAX_ELEMS)
 		WARN_ON(!del_lru_elem_unlocked(ca));
@@ -349,7 +351,7 @@ int cec_add_elem(u64 pfn)
 		do_spring_cleaning(ca);
 
 unlock:
-	mutex_unlock(&ce_mutex);
+	spin_unlock_bh(&ce_lock);
 
 	return ret;
 }
@@ -406,7 +408,7 @@ static int array_dump(struct seq_file *m, void *v)
 	u64 prev = 0;
 	int i;
 
-	mutex_lock(&ce_mutex);
+	spin_lock_bh(&ce_lock);
 
 	seq_printf(m, "{ n: %d\n", ca->n);
 	for (i = 0; i < ca->n; i++) {
@@ -431,7 +433,7 @@ static int array_dump(struct seq_file *m, void *v)
 
 	seq_printf(m, "Action threshold: %d\n", count_threshold);
 
-	mutex_unlock(&ce_mutex);
+	spin_unlock_bh(&ce_lock);
 
 	return 0;
 }
-- 
2.20.1

