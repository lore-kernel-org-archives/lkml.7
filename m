Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3EFC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D9921479
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxa5hFH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfEMJOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:14:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33623 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfEMJOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:14:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id z28so6879880pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KOg0plYJEIKIEl9QAJQRD24ArXQQiymCSaNyEeEZPgs=;
        b=Yxa5hFH5i4ECoatvq7sYcuAI/7jP1Huc8JoK2ZOmPFJs7+5SazgnIF93HSke9iNqUJ
         HOJHAXorLqY4rq8eu9+R8C+V+EPSBtdCtAYsUvcp+4G2LKXLdNo9Pb49nqslkdrPCLzz
         P0AqytI3Ca7C5fJyLTwTuM6WtpWuAd9e7K80rDLo7RERteVGOE2imHbCFfuIN7m4ky6j
         fWQtCi47lrsGQEUsssuh4hx3aFm1E6qaPIPVmlf97jg4CeBu9rgcxbe/c+h/jxrsRj56
         71G49l5/FQmyHKGj85zKctWDVY/6lDnk0H1QqMDzDNipAm0/lOdKPUcAGLYhf5qJPZAl
         Y3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KOg0plYJEIKIEl9QAJQRD24ArXQQiymCSaNyEeEZPgs=;
        b=fGGSnqcR/B4BMLFhRTxWzm72oP0BGVmATQEjJoz0UKlYTf9YnXnPWf4ZFfXVgAeQz5
         tu5iGh5zZ6wQ6E3EXJuWtZ8kaln9AF4wglacjcrnCrnfbWN3rV+v4Pis5Ujczqbw80u1
         o5aaJJG389rKUCghKMc1kkjnf9+17GIJDiloTdAg9/s4VJF/MpuTlgempOuSjiGXiVea
         nfV6zOvNq5Lz5t4252reEo2NWPki/0c7v/T9iel7qU0GIEDZ9jJYaNzLJmsGhX1VqWC+
         C5nueoSoRZgHwTVGVyU3OlEe6F/k4oY1G52hLOznLLluiII3I2Lizs/RwP/piMS5tCiu
         13ww==
X-Gm-Message-State: APjAAAXv+ktsOEAVoCQIhZrOEv1dBeMOKT6x2SId7v7XhLodDbt48JM9
        aoLqnMQo8+l6yUzeQaXLYHM=
X-Google-Smtp-Source: APXvYqwyNFUNO5tMz6KVNO2+tpEUsII5K+HLs4AaO61Qrp2FYF0M2ZcdYCM0CCfkLsN7kMPumNlyEA==
X-Received: by 2002:aa7:8296:: with SMTP id s22mr32304005pfm.52.1557738847208;
        Mon, 13 May 2019 02:14:07 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:14:06 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 15/17] locking/lockdep: Adjust selftest case for recursive read lock
Date:   Mon, 13 May 2019 17:12:01 +0800
Message-Id: <20190513091203.7299-16-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190513091203.7299-1-duyuyang@gmail.com>
References: <20190513091203.7299-1-duyuyang@gmail.com>
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

