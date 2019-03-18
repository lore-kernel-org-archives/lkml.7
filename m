Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4802085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xSv6UGHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfCRV7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:59:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43631 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfCRV7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:59:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so19881079qtc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEI+LxvFMjJUALRi9owyWOI0fihbE6C/e9+itd739GM=;
        b=xSv6UGHKeSYnwqQPFStQfIJtPVqrIdfYYhnL+QBdxApMC29BAC/fsbftKLQKQkoDCF
         3F0HhBNpMHXbPVAMb1jfRLAHDFuSw2Ra/C5HFypQy3pq6Bw931kOjfuGochv4wG95dW0
         LklgQjScV/7/2vC0QpOWwTPnJcJxKh3am6wxbWXM6+eNweYFjOA5QkjUbuJ+dKXbGtQ9
         7ujt4QIRF16jtClBQjOHU+/bMMLPbWAhh98nqp4JM9ZoHtYwM+MNWIsBJErzdXuMeJ7m
         IDMUujPD7do0VpNf+FcjmImViWNv7yOJd6w1tYMkrVUthn602QzlzN/TTnhiu+jWUJjY
         BUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PEI+LxvFMjJUALRi9owyWOI0fihbE6C/e9+itd739GM=;
        b=QUFEh0eIOC/I7yQkJvuH5d8o0PYC770aG9bwBluIJzfj0ewyAlVKjeeI32MrPiEXKi
         bpCLkHwgdDS//NWywCkVgs4uM+tgAt87gANWnRuPAMlBmK1x+wpZfLr6dFqVx1jOrb+N
         nORvOwqlMsspQHdHPeAyzxayhwPLCG2qI1v83i8UdpKYIKWUMm9RUMbjYMaiaTuSydFT
         TdeatVKhV6CS7nTKZWpV4wTgUzICjBN6OluhoTc4385kw/QucdFxJz0Cx4HAs3bgn4WX
         NwlT6AA50k31uydYIwxdg2MaSOo4z4CHECzSbm9YY0BXmZLf5ATFJAO1ZYi7NItFmzsv
         lSKQ==
X-Gm-Message-State: APjAAAUFfZRo7tqrtL2aOcJW4sd9jYPlAuKMk9z7saD3webNiLh3Yx4E
        OXnkCCdvAXP8OiHCR9tBt5HJbg==
X-Google-Smtp-Source: APXvYqzkWXqFSxILOE7RAHR60Jl9OeAWUAL4Ianp0fHwLW+RC6He2WPAWHgd5g1vLM9ptb1W7sKbUg==
X-Received: by 2002:a0c:8a61:: with SMTP id 30mr14625001qvu.110.1552946345528;
        Mon, 18 Mar 2019 14:59:05 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k68sm6638264qkf.16.2019.03.18.14.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 14:59:04 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     peterz@infradead.org
Cc:     pbonzini@redhat.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] locking/static_key: Fix false positive warnings on concurrent dec/inc
Date:   Mon, 18 Mar 2019 14:58:14 -0700
Message-Id: <20190318215814.3724-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the atomic_dec_and_mutex_lock() in
__static_key_slow_dec_cpuslocked() can never see a negative
value in key->enabled the subsequent sanity check is re-reading
key->enabled, which may have been set to -1 in the meantime by
static_key_slow_inc_cpuslocked().

Instead of using -1 as a "enable in progress" constant use
-0xffff, this way we can still treat smaller negative values
as errors.

Alternatively we could implement atomic_dec_and_mutex_lock_return().

Fixes: 4c5ea0a9cd02 ("locking/static_key: Fix concurrent static_key_slow_inc()")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/jump_label.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bad96b476eb6..4a227e70a8f3 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -89,7 +89,7 @@ static void jump_label_update(struct static_key *key);
 int static_key_count(struct static_key *key)
 {
 	/*
-	 * -1 means the first static_key_slow_inc() is in progress.
+	 * -0xffff means the first static_key_slow_inc() is in progress.
 	 *  static_key_enabled() must return true, so return 1 here.
 	 */
 	int n = atomic_read(&key->enabled);
@@ -125,7 +125,10 @@ void static_key_slow_inc_cpuslocked(struct static_key *key)
 
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+		/* Use a large enough negative number so we can still
+		 * catch underflow bugs in static_key_slow_dec().
+		 */
+		atomic_set(&key->enabled, -0xffff);
 		jump_label_update(key);
 		/*
 		 * Ensure that if the above cmpxchg loop observes our positive
@@ -158,7 +161,7 @@ void static_key_enable_cpuslocked(struct static_key *key)
 
 	jump_label_lock();
 	if (atomic_read(&key->enabled) == 0) {
-		atomic_set(&key->enabled, -1);
+		atomic_set(&key->enabled, -0xffff);
 		jump_label_update(key);
 		/*
 		 * See static_key_slow_inc().
@@ -208,15 +211,11 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 {
 	lockdep_assert_cpus_held();
 
-	/*
-	 * The negative count check is valid even when a negative
-	 * key->enabled is in use by static_key_slow_inc(); a
-	 * __static_key_slow_dec() before the first static_key_slow_inc()
-	 * returns is unbalanced, because all other static_key_slow_inc()
-	 * instances block while the update is in progress.
-	 */
 	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
-		WARN(atomic_read(&key->enabled) < 0,
+		int v;
+
+		v = atomic_read(&key->enabled);
+		WARN(v < 0 && v != -0xffff,
 		     "jump label: negative count!\n");
 		return;
 	}
-- 
2.19.2

