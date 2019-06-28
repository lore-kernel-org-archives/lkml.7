Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49138C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF4E208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH6XhvgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfF1JQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44077 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfF1JQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so2308080pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2NFwEWgovxdDn8KDS0qdM/VAyPpaQz3ev0Lm2DlrSI=;
        b=VH6XhvgXbAd1/glp+Hat69Dz0KRejir33Y4ThaqGpXvoaj+uZHuzth8AuqG2X2Oves
         u6cjUlZEVYzosIBg0HPUF2/T8ZHIsxm9oV1Tiz4sQ4bml0fQutl2cswKWDBvQFHiUu2b
         wDYoQDHK8NUfbEN/h6XSntg7SnNKl29PQUxbclw2HQacpW42OjQ/ULssVnNUDZldnmqN
         xVqeJPHMM51o8Ez9KGCXRVXn+VxjTQgCJWgcMzPXMLINHAxNE8yw/uc7eYFE+jF6EV1i
         8FswlILgd6LFoyAxJieuFcgPvC2uCKALOxYt0M2oG60A57hh0ZBJRSFwzK4UB5wuPPut
         pcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2NFwEWgovxdDn8KDS0qdM/VAyPpaQz3ev0Lm2DlrSI=;
        b=mDHLj3w7vIse3xTwErK19TdVUpdIpaYGfI0fzh3SMpNUq7CQKN+NspPAj2hduWYZ6y
         EfCE0LXn+Vs5UUEL+XslKH9A6KGmBTDNk3XTDf4L59KqMVSUBYdzyuIxT1kxDdzPDkM0
         NYvWQrUEnpDTsRrP/8GkF2zBgjRfdPHmZJc7FxTqNsEzYuEDKkrJluDncKXlqHwNaGBz
         WryLQJxpOP96xz42eN7Me3byUieT3HqeCKA9mdHvlHALNPzRMGdI7odmePcum9lL/0Gc
         Tn0t1J1lart7wP0K/bA5ItNjDvTJdhIRsJDHBscVh2o7vikB08/Ti14Ut+5seo0ent7N
         k5Nw==
X-Gm-Message-State: APjAAAV28tMj8/yJG0t/x13bHDs0Lm1M9ZbEBp4ASaksbtCwk4aoUK2T
        OlsBYqT+//VJNUbEsvwLeec=
X-Google-Smtp-Source: APXvYqwLJABxrdqAz+5eB6Jdfn5BZGO9+KqpjaQnE93zhaXrXrFJ4oYdsaMEaAKmWhW7LvwhuH2aGw==
X-Received: by 2002:a65:50c3:: with SMTP id s3mr8182011pgp.177.1561713370679;
        Fri, 28 Jun 2019 02:16:10 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:10 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 06/30] locking/lockdep: Update comments in struct lock_list and held_lock
Date:   Fri, 28 Jun 2019 17:15:04 +0800
Message-Id: <20190628091528.17059-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comments regarding initial chain key and BFS are outdated so update them.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 include/linux/lockdep.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 3c6fb63..5e0a1a9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -198,8 +198,7 @@ struct lock_list {
 	int				distance;
 
 	/*
-	 * The parent field is used to implement breadth-first search, and the
-	 * bit 0 is reused to indicate if the lock has been accessed in BFS.
+	 * The parent field is used to implement breadth-first search.
 	 */
 	struct lock_list		*parent;
 };
@@ -242,7 +241,7 @@ struct held_lock {
 	 * as likely as possible - hence the 64-bit width.
 	 *
 	 * The task struct holds the current hash value (initialized
-	 * with zero), here we store the previous hash value:
+	 * with INITIAL_CHAIN_KEY), here we store the previous hash value:
 	 */
 	u64				prev_chain_key;
 	unsigned long			acquire_ip;
@@ -261,12 +260,12 @@ struct held_lock {
 	/*
 	 * The lock-stack is unified in that the lock chains of interrupt
 	 * contexts nest ontop of process context chains, but we 'separate'
-	 * the hashes by starting with 0 if we cross into an interrupt
-	 * context, and we also keep do not add cross-context lock
-	 * dependencies - the lock usage graph walking covers that area
-	 * anyway, and we'd just unnecessarily increase the number of
-	 * dependencies otherwise. [Note: hardirq and softirq contexts
-	 * are separated from each other too.]
+	 * the hashes by starting with a new chain if we cross into an
+	 * interrupt context, and we also keep not adding cross-context
+	 * lock dependencies - the lock usage graph walking covers that
+	 * area anyway, and we'd just unnecessarily increase the number
+	 * of dependencies otherwise. [Note: hardirq and softirq
+	 * contexts are separated from each other too.]
 	 *
 	 * The following field is used to detect when we cross into an
 	 * interrupt context:
-- 
1.8.3.1

