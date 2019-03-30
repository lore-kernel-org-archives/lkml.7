Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D0BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4D3218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="I3xJXOnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbfC3AJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:09:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44603 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbfC3AJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:09:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so4399616qtb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wrw68zXcEJEIXFG3jyWiowhZg3CiRfvNKtZTktXM6s=;
        b=I3xJXOnOjBaxsl1zcUSjTQrv3VXKv4+2+6bM3JM0XxT7BdBYRM5/I7uhbhv56U8jhR
         plBzeK43oxuWL3vImYNH/2ZsdNnDqJ3DpAC7TRpioCmZD8A/fJX8X0EC0Vy5Xck6cA+H
         pMbIxTohVJuU87zjpcXZMiaDxGjRlM73YPuw43cDvmCY7U0QzsOsXpE7YBQgfSgu/ghD
         cK871wZ84ld2jPG8wpjHMgZMDX9BpVCvkgHitV4Ys8FVkef8NkUSQoV9d0wZ7sjLoSCb
         peCFZFsu5arzmcrcKOf1OG8SGCNKZYRP3xInTRlnhoreCRjEUfa/QO1Qof+oao76Ituf
         r+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wrw68zXcEJEIXFG3jyWiowhZg3CiRfvNKtZTktXM6s=;
        b=re3hUX/T7UYro7UAkplrjSjEqq8LpDxV5HrPbc/Ab+NZ/5OirEFwjt3q4Rv+7fl4YI
         5kMSAdCm/KjBlseGgr4YpLyMwLJ5YFPuNZTmGh5ok5XkDwIO+8frjJ34MeJuEGx16qTs
         O/Sr9SeJHJ6811+frG9LV0dRYDLxe/b/h/BFG5QUwJzdonughX52M+FhYWHJjwKMsYN9
         FX2jiNIDjqreNJOQOGMkXKKkZ8S9/zfONYDWGDSjH/CnpJReC6tP7T9BzRINyzbIM5UJ
         qOQEqk6Mx5tWZSZP7nkB+FrN7ioroBtXBRbQVk9a5gnX3GsX/NZa+gKTjNwpVQNNHxaq
         6iXw==
X-Gm-Message-State: APjAAAXqx8or0n61owUUZZNmp02x5aliMn8BdCYDDTgFrg6R77ac5X0V
        us/l2FZhZL04HrtWkYqnk53vkw==
X-Google-Smtp-Source: APXvYqwyF73sAtZlEo4gfj7KkANMay5NHeY0sAOHVBhzt8C7NPOrUYo63K0aeS5WYAwHM0/YFCQyRA==
X-Received: by 2002:ac8:33b8:: with SMTP id c53mr33296197qtb.11.1553904551932;
        Fri, 29 Mar 2019 17:09:11 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i63sm1996757qkd.82.2019.03.29.17.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 17:09:11 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     peterz@infradead.org, tglx@linutronix.de
Cc:     ard.biesheuvel@linaro.org, yamada.masahiro@socionext.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        alexei.starovoitov@gmail.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>
Subject: [PATCH 3/3] locking/static_key: don't take sleeping locks in __static_key_slow_dec_deferred()
Date:   Fri, 29 Mar 2019 17:08:54 -0700
Message-Id: <20190330000854.30142-4-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190330000854.30142-1-jakub.kicinski@netronome.com>
References: <20190330000854.30142-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing jump_label state is protected by jump_label_lock().
Rate limited static_key_slow_dec(), however, will never
directly call jump_label_update(), it will schedule a delayed
work instead.  Therefore it's unnecessary to take both the
cpus_read_lock() and jump_label_lock().

This allows static_key_slow_dec_deferred() to be called
from atomic contexts, like socket destructing in net/tls,
without the need for another indirection.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
---
 kernel/jump_label.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 02c3d11264dd..de6efdecc70d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -221,9 +221,7 @@ static bool static_key_slow_try_dec(struct static_key *key)
 	return true;
 }
 
-static void __static_key_slow_dec_cpuslocked(struct static_key *key,
-					   unsigned long rate_limit,
-					   struct delayed_work *work)
+static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
 
@@ -231,23 +229,15 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 		return;
 
 	jump_label_lock();
-	if (atomic_dec_and_test(&key->enabled)) {
-		if (rate_limit) {
-			atomic_inc(&key->enabled);
-			schedule_delayed_work(work, rate_limit);
-		} else {
-			jump_label_update(key);
-		}
-	}
+	if (atomic_dec_and_test(&key->enabled))
+		jump_label_update(key);
 	jump_label_unlock();
 }
 
-static void __static_key_slow_dec(struct static_key *key,
-				  unsigned long rate_limit,
-				  struct delayed_work *work)
+static void __static_key_slow_dec(struct static_key *key)
 {
 	cpus_read_lock();
-	__static_key_slow_dec_cpuslocked(key, rate_limit, work);
+	__static_key_slow_dec_cpuslocked(key);
 	cpus_read_unlock();
 }
 
@@ -255,21 +245,21 @@ void jump_label_update_timeout(struct work_struct *work)
 {
 	struct static_key_deferred *key =
 		container_of(work, struct static_key_deferred, work.work);
-	__static_key_slow_dec(&key->key, 0, NULL);
+	__static_key_slow_dec(&key->key);
 }
 EXPORT_SYMBOL_GPL(jump_label_update_timeout);
 
 void static_key_slow_dec(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec(key, 0, NULL);
+	__static_key_slow_dec(key);
 }
 EXPORT_SYMBOL_GPL(static_key_slow_dec);
 
 void static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec_cpuslocked(key, 0, NULL);
+	__static_key_slow_dec_cpuslocked(key);
 }
 
 void __static_key_slow_dec_deferred(struct static_key *key,
@@ -277,7 +267,11 @@ void __static_key_slow_dec_deferred(struct static_key *key,
 				    unsigned long timeout)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec(key, timeout, work);
+
+	if (static_key_slow_try_dec(key))
+		return;
+
+	schedule_delayed_work(work, timeout);
 }
 EXPORT_SYMBOL_GPL(__static_key_slow_dec_deferred);
 
-- 
2.21.0

