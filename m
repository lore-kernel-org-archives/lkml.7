Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D0C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4D620880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WyEv20ud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfHER7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:59:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfHER7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:59:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3so2919269pgt.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ou5mCElOB4urfT5gwIsyCFAyBUIFq+/ixcrewBEfyI=;
        b=WyEv20ud3mTQTMZYo4VPlCt2OhWL/evbwmkiX6gaKW4IVE35VZzrMhAuKVz/SA0dBd
         vTti6oh9tVzZoTbXREOv0gz5UkxqKz0MmQeP9ROOABm4LMdNjW9JRWqT8zrRizV41old
         3YYzxBnJPras1wDtkc8oF9lTRxkkE9fPiSswT9hG1i5rLI2eXj1hN+kSPUeTj5daSbx5
         1TIxV0gO/XkDROsbbrL34U9lmpMRt78E1TP/ij2X/AGfGvtSSbmb/srEa6v6dVTfxgEi
         UUCVWZzxq5eYQSJ8Pzs1czIILkycqWXYN7pFrAN4zYKHjhO7ZtDxMXkma1dszH253gUi
         dIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ou5mCElOB4urfT5gwIsyCFAyBUIFq+/ixcrewBEfyI=;
        b=MlQ8r5vThtXEwq2YH4s0X/zzq4MGDnnehKe9v66kER1jGrMci27JYmlmByyqAjIkbd
         RNBZr7qJNUOv/FSEDfU7HLq8pBpspHBKhSlugKpbaQPRzQ7wicsk6THbyxL7BwoJzLRQ
         dLuAxxlehxAk+GuU/EJWmZzWVyWJgObNi84EWrPq1LxlUJPEs++GBUWXmatRpUnb7SfS
         2Qx1NTRq14ORUXTKr8izMd7awuR3Rd1PqAxhiqF8kTTqxT3ODekf++Y2+Ed/kK/QGsZG
         O86HlcZd/OUnHPZsjMa+adFPvcPeAF+ZXcIz5mAP3CIwy1C/wFhap1AhbJmEOQW/zl3L
         gvJA==
X-Gm-Message-State: APjAAAV2qPFjnqfSpv0BBaHvr6x6CDcSQqpcKhr0uWxFeI0irxKLIOdJ
        3NWq/ZVMtAjs6RGrgKhVxfw=
X-Google-Smtp-Source: APXvYqwt4F6G3awZ8GzpZxFuhH7YAyo70XcQEsJIlj+LV8NFq5U5n027TZIDTTXi0lhtNY7eCb038w==
X-Received: by 2002:a63:2157:: with SMTP id s23mr21071800pgm.167.1565027984105;
        Mon, 05 Aug 2019 10:59:44 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id f19sm124403670pfk.180.2019.08.05.10.59.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:59:43 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v7 2/3] PM / wakeup: Use wakeup_source_register() in wakelock.c
Date:   Mon,  5 Aug 2019 10:58:47 -0700
Message-Id: <20190805175848.163558-3-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805175848.163558-1-trong@android.com>
References: <20190805175848.163558-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/power/wakelock.c duplicates wakeup source creation and
registration code from drivers/base/power/wakeup.c.

Change struct wakelock's wakeup source to a pointer and use
wakeup_source_register() function to create and register said wakeup
source. Use wakeup_source_unregister() on cleanup path.

Signed-off-by: Tri Vo <trong@android.com>
---
 kernel/power/wakelock.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 4210152e56f0..d1eb7fd98b64 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(wakelocks_lock);
 struct wakelock {
 	char			*name;
 	struct rb_node		node;
-	struct wakeup_source	ws;
+	struct wakeup_source	*ws;
 #ifdef CONFIG_PM_WAKELOCKS_GC
 	struct list_head	lru;
 #endif
@@ -46,7 +46,7 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
 
 	for (node = rb_first(&wakelocks_tree); node; node = rb_next(node)) {
 		wl = rb_entry(node, struct wakelock, node);
-		if (wl->ws.active == show_active)
+		if (wl->ws->active == show_active)
 			str += scnprintf(str, end - str, "%s ", wl->name);
 	}
 	if (str > buf)
@@ -112,16 +112,16 @@ static void __wakelocks_gc(struct work_struct *work)
 		u64 idle_time_ns;
 		bool active;
 
-		spin_lock_irq(&wl->ws.lock);
-		idle_time_ns = ktime_to_ns(ktime_sub(now, wl->ws.last_time));
-		active = wl->ws.active;
-		spin_unlock_irq(&wl->ws.lock);
+		spin_lock_irq(&wl->ws->lock);
+		idle_time_ns = ktime_to_ns(ktime_sub(now, wl->ws->last_time));
+		active = wl->ws->active;
+		spin_unlock_irq(&wl->ws->lock);
 
 		if (idle_time_ns < ((u64)WL_GC_TIME_SEC * NSEC_PER_SEC))
 			break;
 
 		if (!active) {
-			wakeup_source_remove(&wl->ws);
+			wakeup_source_unregister(wl->ws);
 			rb_erase(&wl->node, &wakelocks_tree);
 			list_del(&wl->lru);
 			kfree(wl->name);
@@ -187,9 +187,15 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 		kfree(wl);
 		return ERR_PTR(-ENOMEM);
 	}
-	wl->ws.name = wl->name;
-	wl->ws.last_time = ktime_get();
-	wakeup_source_add(&wl->ws);
+
+	wl->ws = wakeup_source_register(wl->name);
+	if (!wl->ws) {
+		kfree(wl->name);
+		kfree(wl);
+		return ERR_PTR(-ENOMEM);
+	}
+	wl->ws->last_time = ktime_get();
+
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
 	wakelocks_lru_add(wl);
@@ -233,9 +239,9 @@ int pm_wake_lock(const char *buf)
 		u64 timeout_ms = timeout_ns + NSEC_PER_MSEC - 1;
 
 		do_div(timeout_ms, NSEC_PER_MSEC);
-		__pm_wakeup_event(&wl->ws, timeout_ms);
+		__pm_wakeup_event(wl->ws, timeout_ms);
 	} else {
-		__pm_stay_awake(&wl->ws);
+		__pm_stay_awake(wl->ws);
 	}
 
 	wakelocks_lru_most_recent(wl);
@@ -271,7 +277,7 @@ int pm_wake_unlock(const char *buf)
 		ret = PTR_ERR(wl);
 		goto out;
 	}
-	__pm_relax(&wl->ws);
+	__pm_relax(wl->ws);
 
 	wakelocks_lru_most_recent(wl);
 	wakelocks_gc();
-- 
2.22.0.770.g0f2c4a37fd-goog

