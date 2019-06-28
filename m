Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1702BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD92208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NocxadDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF1JPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:15:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36981 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF1JPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:15:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so2670622pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBYI8cqgWBS0IUXayT/Mp1RSXx8mEdLQVyHKPywQoms=;
        b=NocxadDPTkgqZhlui4wmMdyMOWJJD7x7YKPFEbxNDXYW6t7UmfmrHYQR62kWFysbQR
         LCytDT8z9E4IPCQhysAaUAGMFuE4UZ/23smfzliSL+XHIKco23MvxsAVcyUhQN3Ea6cP
         mtm/AG3z0EcfZdqnqJtW4NN6xOytRGVXAU+M8OEWotxhquKLy9yo8dlaY1G6D9O+3PaT
         IctqOkSQlaR4eeJy9gJYj7xyg3CfAvAIQylF7tcDWpRMN4LVItodtxWpP/g05uP4/rcW
         mPPWYU/EKypf/lQi/XSKtgGK7bg5FxHuuSj4X7jgC/fEF7HX7Lz70PdfHv8X67/mCSMZ
         Yb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBYI8cqgWBS0IUXayT/Mp1RSXx8mEdLQVyHKPywQoms=;
        b=bMFVsrDWWDK1WwIJTm6GBaDXnQI/TyUVX9jx/HpxKTonYTqSfKYKBSZ7WnuJh5dJIX
         SSw1HSS9OFXLRnTkjYVrJjZwNeuuNh19K2IRIUiAyyOcq5F08iiiWMoQ206AeY5avnsR
         1mxJZ6PcOdR2Jvl1M09KQG6Sa01OPgJM0m0XTV0HAEH7o5JJM9al41YMDLSB9f8oLb1z
         EIYDbUCsny+7uIuL42m8kvvijHj/hlBFytivU4ulUlnZQKgcR5euS1mEbCCmcGZVfNdA
         GeN4gliVfmrPX6zlb3gH6BxgwqOAK+jMPpxmZq7e4WteZytyd5qCUwG3mV+jnGL2buTt
         w3UA==
X-Gm-Message-State: APjAAAUzjsPAkqUcrP8XhFcxplcDDPwkw3zNRcEgyqrWWOPoXXh8cOW/
        nuOi++6sWIlkAAoZqSG5aV4=
X-Google-Smtp-Source: APXvYqz0nMzhY9HaGNiIvSICBWqN/nmPowFgQnv/FLYscbuBeYO55ngWtuLaaSN9nt51hd6db2xvvw==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr1288205pgc.303.1561713343224;
        Fri, 28 Jun 2019 02:15:43 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:15:42 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 00/30] Support recursive-read lock deadlock detection
Date:   Fri, 28 Jun 2019 17:14:58 +0800
Message-Id: <20190628091528.17059-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,

Historically, the recursive-read lock is not well supported in lockdep.
This patchset attempts to solve this problem sound and complete.

The bulk of the algorithm is in patch #27. Now that the recursive-read
locks are suppported, we have all the 262 cases passed.

Changes from v2:

 - Handle correctly rwsem locks hopefully.
 - Remove indirect dependency redundancy check.
 - Check direct dependency redundancy before validation.
 - Compose lock chains for those with trylocks or separated by trylocks.
 - Map lock dependencies to lock chains.
 - Consolidate forward and backward lock_lists.
 - Clearly and formally define two-task model for lockdep.

Have a good weekend ;)

Thanks,
Yuyang

--

Yuyang Du (30):
  locking/lockdep: Rename deadlock check functions
  locking/lockdep: Change return type of add_chain_cache()
  locking/lockdep: Change return type of lookup_chain_cache_add()
  locking/lockdep: Pass lock chain from validate_chain() to
    check_prev_add()
  locking/lockdep: Add lock chain list_head field in struct lock_list
    and lock_chain
  locking/lockdep: Update comments in struct lock_list and held_lock
  locking/lockdep: Remove indirect dependency redundancy check
  locking/lockdep: Skip checks if direct dependency is already present
  locking/lockdep: Remove chain_head argument in validate_chain()
  locking/lockdep: Remove useless lock type assignment
  locking/lockdep: Specify the depth of current lock stack in
    lookup_chain_cache_add()
  locking/lockdep: Treat every lock dependency as in a new lock chain
  locking/lockdep: Combine lock_lists in struct lock_class into an array
  locking/lockdep: Consolidate forward and backward lock_lists into one
  locking/lockdep: Add lock chains to direct lock dependency graph
  locking/lockdep: Use lock type enum to explicitly specify read or
    write locks
  locking/lockdep: Add read-write type for a lock dependency
  locking/lockdep: Add helper functions to operate on the searched path
  locking/lockdep: Update direct dependency's read-write type if it
    exists
  locking/lockdep: Introduce chain_hlocks_type for held lock's
    read-write type
  locking/lockdep: Hash held lock's read-write type into chain key
  locking/lockdep: Adjust BFS algorithm to support multiple matches
  locking/lockdep: Define the two task model for lockdep checks formally
  locking/lockdep: Introduce mark_lock_unaccessed()
  locking/lockdep: Add nest lock type
  locking/lockdep: Add lock exclusiveness table
  locking/lockdep: Support read-write lock's deadlock detection
  locking/lockdep: Adjust selftest case for recursive read lock
  locking/lockdep: Add more lockdep selftest cases
  locking/lockdep: Remove irq-safe to irq-unsafe read check

 include/linux/lockdep.h            |   91 ++-
 include/linux/rcupdate.h           |    2 +-
 kernel/locking/lockdep.c           | 1221 ++++++++++++++++++++++++------------
 kernel/locking/lockdep_internals.h |    3 +-
 kernel/locking/lockdep_proc.c      |    8 +-
 lib/locking-selftest.c             | 1109 +++++++++++++++++++++++++++++++-
 6 files changed, 1975 insertions(+), 459 deletions(-)

-- 
1.8.3.1

