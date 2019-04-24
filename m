Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB187C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB13121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVUDm+Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfDXKWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:22:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33268 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbfDXKVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:21:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so9094131plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qDwchYUEwEWxZipDWoyQdCOIu7W4mr2V2HYbPHT39Q=;
        b=HVUDm+WimHUIiKKSmNd7gAxNjLUsRlA3yvKckHVnhJFwwrsSP6p2v0qqQVn+V+iVNU
         qIvuH01zQ18YiTUzr5auzwNMesemCqDtE+xsw16M2rFeGnOzfhCjyz5fBH5zXJTtzPYG
         3CEmj2HSbPI0ZGMRzuPq9XqFfYfHekj5IgHTr2k474XwiY58QkJLuhXMPNyYn+z8j7dP
         DcYZg0KGmHwcLpolRKfowjIopb7idlfVs4+4ulTJAB04KJJud6H229lOs2/8VJRLDPEQ
         fRUo6loFc8zw66YENNr21jVeC+zxNvfxuE7cszm1t1IRR3/CUsPiJJggxnlJvW/ckHfg
         Xvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qDwchYUEwEWxZipDWoyQdCOIu7W4mr2V2HYbPHT39Q=;
        b=G3KCaQ8FXArRY7XNBkcFZ8crDZtZ+8GeSvistCZmICyPw62fi3/MkyLprpgUMHgsaL
         PB/JP+b7B+U9GqBXVHVoUskNbCgnI/kTn7JRDKFYIqEL9AMWNU6NejqXVhffHXVxZmPC
         EvjehA0CW7K/Du57Ins4hFvhT/5GQ+IboP94qNL4HD2nYoVI6sooSoXeZU84zdet0myL
         hVZP6+M9Jy3gUlYDaqhSfiGn99itgfMd0oX1KFHS3FZvlVt7FbHbewrTSe5nn41jYRZ2
         iLGeWlDt28rDTNHW4L9DefzmJAN4bQ1xwKxWUF3dmf2fkPwt5OE6cuYnccWC0bb1Ljhl
         C0vg==
X-Gm-Message-State: APjAAAVmtDv7wWr7J8mI/Pk4TcyMG0T0320DwtP9sGksEX3yKKgywtmy
        sCOPK7fpJfpDZl6jJUgL1bc=
X-Google-Smtp-Source: APXvYqw18RPNOTYJ/Ru3I7tPIwih3Qc8/9w8Ps1N97P5yvqNOdtwx4tiISnkyP+Y7FvJmTc04MmJCg==
X-Received: by 2002:a17:902:778b:: with SMTP id o11mr8505608pll.333.1556101301846;
        Wed, 24 Apr 2019 03:21:41 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:21:41 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 24/28] locking/lockdep: Remove !dir in lock irq usage check
Date:   Wed, 24 Apr 2019 18:19:30 +0800
Message-Id: <20190424101934.51535-25-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mark_lock_irq(), the following checks are performed:

   ----------------------------------
  |   ->      | unsafe | read unsafe |
  |----------------------------------|
  | safe      |  F  B  |    F* B*    |
  |----------------------------------|
  | read safe |  F? B* |      -      |
   ----------------------------------

Where:
F: check_usage_forwards
B: check_usage_backwards
*: check enabled by STRICT_READ_CHECKS
?: check enabled by the !dir condition

From checking point of view, the special F? case does not make sense,
whereas it perhaps is made for peroformance concern. As later patch will
address this issue, remove this exception, which makes the checks
consistent later.

With STRICT_READ_CHECKS = 1 which is default, there is no functional
change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1b78216..2f24028 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3149,7 +3149,7 @@ typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
 	 * Validate that the lock dependencies don't have conflicting usage
 	 * states.
 	 */
-	if ((!read || !dir || STRICT_READ_CHECKS) &&
+	if ((!read || STRICT_READ_CHECKS) &&
 			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
 		return 0;
 
-- 
1.8.3.1

