Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37875C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046DB20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 09:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN5c4itJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfEMJNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 05:13:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46804 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfEMJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 05:13:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so6845344pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 02:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GrzD48/0H20pnGeAymn4MjdZQwhzRIM9PYbo+ZtA28=;
        b=MN5c4itJqnAX7eHunm9cYRTqxcPgqOisC5Glu4DPtXdbyXg/rkABUK5vAJHRuWVX4I
         912mdojz7hzSP2cvCPcPfxP3piwbDy6PJ6pghj7k+Bh+t4TQotHelwkAReHRffLOVS0j
         Ynve7zRti7V3LHZFK3OUJy8RFsoaLhv8KJkInUmMkKgpTmg3CIW1ee8R5wojD3si9aIP
         hYTLFyE4afY8JuX8m0Ubjk3AOVC5Qk8NbHtBg53H99PkNhRQ/rYYDqIr0TkDyPql/AUz
         ZD/X7lHDpXnlRehOup2HCip4u1bm9ac8qOxyk8zvgX9SKrp8/4luq9cqpz4sL9McUMYq
         QxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GrzD48/0H20pnGeAymn4MjdZQwhzRIM9PYbo+ZtA28=;
        b=kvbC8KDs5rrMKHBqOT/MHN4xK5mqY19qJ0Q7c+isqjGtTunSsXRZ+7YwcZ5tnGeFo6
         +x3rxZLavCiLXxMPVsAJNj1eBy1T4O5KcEIZMqlgzrApaTkioX7DaXUitmCnzakBO1Ka
         akDTHANrc71esIzkSoHRIc2kSDdrz1o5NKvoVn8xeQbVDUKWOYv7j1s9i5b0BqdYVWne
         VD4DfqnPeqXnX+xXKLRhgw1DwRpRPlDPRIxGZhTw0tISPwNQS+8ZDgLpT+YWxCO4xMIX
         Ba+rik6+vidyRGVRqBtncl3vQSqXO5S2cCB315o54HWbHjbfw4N9iqkOtXRejyaz3ioC
         bilA==
X-Gm-Message-State: APjAAAVX56yTSJuA7wj4fnjXNa4Fwc6e9AU50XA8GIzqq1BTmZSNsroi
        dV8XgA4OUFXKea67VP2yLqYNQnCiknY=
X-Google-Smtp-Source: APXvYqzBM2idGDB22GlNmp3g2o3X7wN7Sc7//t/avNUA6QE6BsuTaoHE57yHx1nzZaeHC/eJ1vnW8g==
X-Received: by 2002:a63:40b:: with SMTP id 11mr13405528pge.31.1557738797196;
        Mon, 13 May 2019 02:13:17 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id n18sm35500837pfi.48.2019.05.13.02.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:13:16 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 00/17] Support for read-write lock deadlock detection
Date:   Mon, 13 May 2019 17:11:46 +0800
Message-Id: <20190513091203.7299-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,

Historically, the read-write locks (recursive-read locks included) are not
well supported in lockdep. This patchset attempts to solve this problem
sound and complete.

The bulk of the algorithm is in patch #10, which is actually not complex at
all. Hopefully, it simply works.

Now that we have read-write locks suppported, we have all the 262 cases
passed, though I have to flip some cases which, I think, are wrong.

P.S. To Boqun, I haven't got time to read your patchset except that I did
carefully read your design doc and learnt from it a lot. It is helpful.
Please give this patchset at least a look.

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

 include/linux/lockdep.h            |   40 +-
 kernel/locking/lockdep.c           |  454 +++++++++++----
 kernel/locking/lockdep_internals.h |    4 +
 lib/locking-selftest.c             | 1099 +++++++++++++++++++++++++++++++++++-
 4 files changed, 1464 insertions(+), 133 deletions(-)

-- 
1.8.3.1

