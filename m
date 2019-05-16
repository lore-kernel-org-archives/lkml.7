Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA25C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40102205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl4WaBv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfEPIBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:01:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43161 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfEPIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:01:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so1204048plp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOg0plYJEIKIEl9QAJQRD24ArXQQiymCSaNyEeEZPgs=;
        b=Dl4WaBv/rUPiSgrv8hqukESTtQ3BtX3IMIhBIrI6/I89DzAccguBeEs8CpsUh2akKr
         YwKk0YB5fFRsTp2p1Z/wFzO9zXzem2teUr8cG3iTWAt8fkROOA/56dojTLmcMs9SyhKc
         1Tw1C2fShhPGkxWK+r+ypnjKhvVnOLBhpbEV9KnvqjYdu16L5nsLydiYLb5pPrs7PjJ+
         qp/0VU1oaAOzPwPhtGrMjqGCDHNbzSvtBbv+okJ/LLEV3n4NutvhcvzAF0mOL50e7Ip1
         oohIsvf/sNwiz43H1eJXdtWcZQg07tyFjiBDKlbZgtm9oTAcZu1ZkgYJ2z+a7Q5ULHsp
         s0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOg0plYJEIKIEl9QAJQRD24ArXQQiymCSaNyEeEZPgs=;
        b=Bz+0mo104HmmsmwKwE/92iafRvvAf39sV8YAwXA4NI72FFsvhWHCC0jzOmw5D274LN
         0jh4YvUI4qNhkdDYikXGnajW2YfiGZrqacZBWwCqhbPRuwV2CEPxXp/c+hoG8uyMsuIM
         phlb37GZ8YRVfA+CiUZXswhmU8S1cKsiy5U3bezZoZXXr+IyGNRJYRKiC9Fn2FJzvSEe
         T/lwboVyddk+tbRGLS/wESif4PBCjPZrbThtsunydiR6jRXv/IvFvwsEM8KC5UsFFCaF
         Mkw5DwJHogLexf3DR0M2Qtf1MPZrbqBZO2hgaB0kEQ4J7Fm28QP9jjEH9X85RH1xpIzf
         vhag==
X-Gm-Message-State: APjAAAXVq7SM+NAolast3+kR5PzRbxgpFApIPD6PiH2ZnOsAvTYoeoPg
        gBTbm0LZT8PA/2MsFZGecss=
X-Google-Smtp-Source: APXvYqzDyo2/bu/2FH6hrqR8N7SvWav9/kjqOIfdWbkYFxu7Yz/bKv0IJI7M1YQbmns6hFTdBVJtdg==
X-Received: by 2002:a17:902:bf07:: with SMTP id bi7mr10777735plb.248.1557993676885;
        Thu, 16 May 2019 01:01:16 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:01:16 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 15/17] locking/lockdep: Adjust selftest case for recursive read lock
Date:   Thu, 16 May 2019 16:00:13 +0800
Message-Id: <20190516080015.16033-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190516080015.16033-1-duyuyang@gmail.com>
References: <20190516080015.16033-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we support recursive read locks, a previously failed case:

 ----------------------------------------------------------------------------
                                  | spin |wlock |rlock |mutex | wsem | rsem |
   --------------------------------------------------------------------------
   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |

can be added back. Now we have:

	Good, all 262 testcases passed!

See the case in: e91498589746065e3a ("Add mixed read-write ABBA tests")

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 lib/locking-selftest.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index f83f047..4c6dd8a 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2055,13 +2055,6 @@ void locking_selftest(void)
 	print_testname("mixed read-lock/lock-write ABBA");
 	pr_cont("             |");
 	dotest(rlock_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
-#ifdef CONFIG_PROVE_LOCKING
-	/*
-	 * Lockdep does indeed fail here, but there's nothing we can do about
-	 * that now.  Don't kill lockdep for it.
-	 */
-	unexpected_testcase_failures--;
-#endif
 
 	pr_cont("             |");
 	dotest(rwsem_ABBA1, FAILURE, LOCKTYPE_RWSEM);
-- 
1.8.3.1

