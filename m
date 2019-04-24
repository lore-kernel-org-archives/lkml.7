Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4109C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210D320878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c/UnIzXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfDXUEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:04:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35780 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDXUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:04:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id y67so17094820ede.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5fy/QqTXfiVrBCc7i/vbvC49MYxv9WSyf7jgrR94D0E=;
        b=c/UnIzXJ0EptThuO4REmgP3UliU/BfAYjLkAWy1PbfDBJpgwRYbiW/ChW0QW2yuUFE
         tjDY6VKBcwBgXZ1KPEOuGi1mO54EaqpwMCk4KVLG57cQouuj0xfiAZ4KLD8BECLdstql
         pCFt2fbc1JX9IsrxNaEMoXGcuZJEqLJvS9yLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5fy/QqTXfiVrBCc7i/vbvC49MYxv9WSyf7jgrR94D0E=;
        b=dhk5Pcj3T2BXHN8AC+w3fhVwFGqLzAQVNdBKPFFuMmIjU4oxZlL98T5b0V7qDlhojz
         3ClTbQvNzeEZfyz15aN3M03YJ7koA5smY0kCfx9TQ7lZyk9uWl9Z6SQPDC5cV9QpTwHq
         oSJLAGsGn9DuSOTwbZ/fdaG3ViANvpawcUMML3+6aNbuGwp1NEpumMS5CJ2AjQ6haWyD
         jIhYkgDFfK5jP5hyKoLL/IyGWgV26Sw0RgbgXRno3rc0wpIo379RkwLPB1o5d/MB5KT+
         m75Ak4wWI+rexXX7h+KIIKWaY8AIXECLvD/vM5TglL1WvQ5gYH3s+djFYWku1+19AOxD
         8YpQ==
X-Gm-Message-State: APjAAAUB5tUxWv2OdZyrPS7LqC5rJCi3Jqi2/6n10z7ttDJNhvkk4Vjc
        C8wjxLnmlvUhz+KmQS6uh855zI7yItOeElbo
X-Google-Smtp-Source: APXvYqxFivZwPNxRZ1tpKBIEHEJSYHSqdMwmUD7anh5HI4+aTLb6QmeaShRqLAXhwpYv1+RstRDGgQ==
X-Received: by 2002:a17:906:6c5:: with SMTP id v5mr16745412ejb.214.1556136253276;
        Wed, 24 Apr 2019 13:04:13 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id q57sm5847101eda.25.2019.04.24.13.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 13:04:12 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/user.c: clean up some leftover code
Date:   Wed, 24 Apr 2019 22:04:04 +0200
Message-Id: <20190424200404.9114-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The out_unlock label is misleading; no unlocking happens after it, so
just return NULL directly. Also, nothing between the
kmem_cache_zalloc() that creates new and the two key_put() can
initialize new->uid_keyring or new->session_keyring, so those calls
are no-ops.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/user.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index 0df9b1640b2a..88b834f0eebc 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -185,7 +185,7 @@ struct user_struct *alloc_uid(kuid_t uid)
 	if (!up) {
 		new = kmem_cache_zalloc(uid_cachep, GFP_KERNEL);
 		if (!new)
-			goto out_unlock;
+			return NULL;
 
 		new->uid = uid;
 		refcount_set(&new->__count, 1);
@@ -199,8 +199,6 @@ struct user_struct *alloc_uid(kuid_t uid)
 		spin_lock_irq(&uidhash_lock);
 		up = uid_hash_find(uid, hashent);
 		if (up) {
-			key_put(new->uid_keyring);
-			key_put(new->session_keyring);
 			kmem_cache_free(uid_cachep, new);
 		} else {
 			uid_hash_insert(new, hashent);
@@ -210,9 +208,6 @@ struct user_struct *alloc_uid(kuid_t uid)
 	}
 
 	return up;
-
-out_unlock:
-	return NULL;
 }
 
 static int __init uid_cache_init(void)
-- 
2.20.1

