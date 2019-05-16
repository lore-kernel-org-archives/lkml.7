Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC00C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B912205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoOiEiU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEPIAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:00:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38335 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfEPIAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:00:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id b76so1420427pfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qt6Ac1pksxjiwvx3dMonP/o+vxTUaZcZRFsJt0WMmbM=;
        b=hoOiEiU5dxl2DoI77mL5xYPGCumtbpIot6kN5iOzIpflYMtO2VBzG1Hna+ipuAsFjX
         UWSxRrzP1IV/l01F0H18c8vskJYg1N79gXd2/k4qrBP7r/Z9tSFP9k4MV2K6Fsqs0Qzk
         tyeihJMC60aEGn/kxgN8f7GCskUpfBArRrZewGE0n68IgnpN/ZWnBqFEelxO473bjkNm
         W1Eu0utbhg0N4xLDy4GymEjRSG8xuUZZiEB8uIuDg532rU6+XreN5hPR4O89RPSZqWug
         MLP+swb/p2m9e7QbEEV1+4oZVR9BSgMBh9y24FTfUEElyaJrELx9FHe3rtYKtp5utxpM
         4vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qt6Ac1pksxjiwvx3dMonP/o+vxTUaZcZRFsJt0WMmbM=;
        b=aIGWGYSv2SfTEvnC84ddu0g1I9yL1j9uveBLLl0J6HDh7hJEbr8ZKFbNWZtl5onu3/
         tuLRYjxSYYPWuLxjbtvyKTwkKyPJzjShpKv2DGPYfZsaBksdpU8rdjOXQFdIs4SLeHWy
         /rKTyi5T9SVBYy/6iCRe6iIYfho1sPvNJfWRG7xkN+JI8Ulwd/LL7DJkPq1raqkGB4ZF
         l6fEO0dZcONn/JDfwfcG9qddiZZb0uxPfVfjJsX6CHUaPUhv+Fg/nF19+buYbgtluin4
         f+HaRzs+l2PYfPotynS2OH3vXu2PCYRGqYG4hDxZILwXRWZ0wIFoDylypt1KmggXZWaA
         DIog==
X-Gm-Message-State: APjAAAUknzoZtNXzlSWL132vCh9iNUeGQ+HeACo1l2U5/CIlnK9BGnFQ
        5JTSlDsgb0CpLDwe/SwO0daFBV7PGYzdjw==
X-Google-Smtp-Source: APXvYqxxnURG7vNe20X1AqENn/XJqhoYTM4uBZTGNEeHt6wTEjNGFXPJMzb0vUFbufYc6EfibXiQmA==
X-Received: by 2002:a63:e50c:: with SMTP id r12mr34808440pgh.284.1557993623102;
        Thu, 16 May 2019 01:00:23 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id p7sm2051471pgb.92.2019.05.16.01.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 01:00:22 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 00/17] Support for read-write lock deadlock detection
Date:   Thu, 16 May 2019 15:59:58 +0800
Message-Id: <20190516080015.16033-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,

Historically, the read-write lock (recursive-read locks included) is not
well supported in lockdep. This patchset attempts to solve this problem
sound and complete.

The bulk of the algorithm is in patch #10, which is actually not complex at
all. Hopefully, it simply works.

Now that we have read-write locks suppported, we have all the 262 cases
passed, though I have to flip some cases which, I think, are wrong.

P.S. To Boqun, I haven't got time to read your patchset except that I did
carefully read your design doc and learnt from it a lot. It is helpful.
Please give this patchset at least a look.

Change from v1:

 - As Peter pointed out the assumption that a lock class cannot ever be read
   and recursive read does not hold. The value of LOCK_TYPE_RECURSIVE is
   changed to 3 from 2, which maintains that if type1 and type2 are exclusive
   then type1 & type2 == 0. And since it is legal for a task can have a read
   and then a recursive read lock, we allow this in deadlock check.

 - Some typo fixes and rewording in comments or changelog.


Thanks,
Yuyang

--

Yuyang Du (17):
  locking/lockdep: Add lock type enum to explicitly specify read or
    write locks
  locking/lockdep: Add read-write type for dependency
  locking/lockdep: Add helper functions to operate on the searched path
  locking/lockdep: Update direct dependency's read-write type if it
    exists
  locking/lockdep: Rename deadlock check functions
  locking/lockdep: Adjust BFS algorithm to support multiple matches
  locking/lockdep: Introduce mark_lock_unaccessed()
  locking/lockdep: Introduce chain_hlocks_type for held lock's
    read-write type
  locking/lockdep: Hash held lock's read-write type into chain key
  locking/lockdep: Support read-write lock's deadlock detection
  locking/lockdep: Adjust lockdep selftest cases
  locking/lockdep: Remove useless lock type assignment
  locking/lockdep: Add nest lock type
  locking/lockdep: Support recursive read locks
  locking/lockdep: Adjust selftest case for recursive read lock
  locking/lockdep: Add more lockdep selftest cases
  locking/lockdep: Remove irq-safe to irq-unsafe read check

 include/linux/lockdep.h            |   57 +-
 include/linux/rcupdate.h           |    2 +-
 kernel/locking/lockdep.c           |  464 +++++++++++----
 kernel/locking/lockdep_internals.h |    4 +
 lib/locking-selftest.c             | 1099 +++++++++++++++++++++++++++++++++++-
 5 files changed, 1489 insertions(+), 137 deletions(-)

-- 
1.8.3.1

