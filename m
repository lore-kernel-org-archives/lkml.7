Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF29C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC8020830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1i0+EuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEFIUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45161 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfEFIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:19:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so6078128pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMVBTmSR+asjmdXMW52Lr83ftcHwe5LGfvqtjWqKkaM=;
        b=e1i0+EuDJCKj6QbrLdXwMAtjfORD7l/YyGUVw0+RbG9okkNhDe3a1L7Z8wQ9KrhmlN
         Wi6Z/SBSqNjyt2FxalWBywtLKJ22ldcp8D9K5u9N4O42q1kP9RusTGOATAUpcJtD7HTQ
         +hlVr06uzEqhyZ2qT/q8d+F1VtxXMwyLF6yynpFZ/58bfmbRG2/Ch2agsZ4Hr4cTHsh5
         kIkU3368im43o2iPHOnxgy346QzLutxY/i1d9T46OpHkG3z2CIoooAQRzcFPNTERth74
         6RZrKBRqrkK6DQxFoHej1gzSddc0NpkZbrV9Q51mOHdbrOfGo+6PW+0EpNkFYYcbbbvd
         7tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMVBTmSR+asjmdXMW52Lr83ftcHwe5LGfvqtjWqKkaM=;
        b=VilEhZbU2CjrzACyNwEOqEOUySESrUYuwQqF5Pnk5xSexA284aMmk1LfUMve3zK2rC
         0vqD9Cv0LZV/wruekxYpte89K8u43E95JDFRJCJhK3duMoeTTBNvrgIdMj0SMe6edRye
         ATGH1w1CgjYffjIUAeUX/Z0jgTr+fldk6T/tYT/iDEhPgwJ16ODZWCwsR0OYWFRKwPTK
         zkXPY10UlNV61Z8/64WS9hnx3EWk51rAvQ612E0p50kOUtyLhDgQcp05DI0OUWnIIpLP
         a0MNaOJfSmeOBEqm6p48jKGTrwiwBeHEkLX24mLb7ajXC9OHZ21c/7ziCu3+qdc+wCFk
         pmbA==
X-Gm-Message-State: APjAAAUNsEi1KdVURTZrol7+ieEGdkGgK4bAPKUbadgkGWp7u64Vg5ya
        UKe94+tXn5bxGp4vxzPitH0=
X-Google-Smtp-Source: APXvYqxhEfFEF4P0Gr+0Nsv7Y017Gy+tTC88EF48EWWw3v9uuaev/kf9O86n3Np1rXXbNvIdeqP0VA==
X-Received: by 2002:a63:dc50:: with SMTP id f16mr30550408pgj.396.1557130798969;
        Mon, 06 May 2019 01:19:58 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:19:58 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 03/23] locking/lockdep: Adjust lock usage bit character checks
Date:   Mon,  6 May 2019 16:19:19 +0800
Message-Id: <20190506081939.74287-4-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lock usage bit characters are defined and determined with tricks.
Add some explanation to make it a bit clearer, then adjust the logic to
check the usage, which optimizes the code a bit.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a019330..720d195 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -499,15 +499,26 @@ static inline unsigned long lock_flag(enum lock_usage_bit bit)
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
 {
+	/*
+	 * The usage character defaults to '.' (i.e., irqs disabled and not in
+	 * irq context), which is the safest usage category.
+	 */
 	char c = '.';
 
-	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
+	/*
+	 * The order of the following usage checks matters, which will
+	 * result in the outcome character as follows:
+	 *
+	 * - '+': irq is enabled and not in irq context
+	 * - '-': in irq context and irq is disabled
+	 * - '?': in irq context and irq is enabled
+	 */
+	if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK)) {
 		c = '+';
-	if (class->usage_mask & lock_flag(bit)) {
-		c = '-';
-		if (class->usage_mask & lock_flag(bit + LOCK_USAGE_DIR_MASK))
+		if (class->usage_mask & lock_flag(bit))
 			c = '?';
-	}
+	} else if (class->usage_mask & lock_flag(bit))
+		c = '-';
 
 	return c;
 }
-- 
1.8.3.1

