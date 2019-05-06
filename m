Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97017C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635962087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcA9ZzQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEFITv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:19:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42368 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEFITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:19:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so6039910pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ZzsprVlH/rAh31u0YyujrUwhCIhoNeizPbgx/2GDCU=;
        b=kcA9ZzQ64uqyNmvomtYQ9Kej2Z5HJhpWJBUMRu4iHVPmMvwLv/w7qRBBx5IGA/6vPy
         8LP3XxXUHpCQyirs+TdNtC01Y3o2gAQXhczgTvhzNLfOXoRBytOA+xudmqTgTzvd5wz9
         WuvhW5mXG+BWTLHOMC9b8T0QJHmOubVsjRckiOppKP5vxkvXbbiCIeJVPoJYCS/Xek8y
         H1DQ6Ps8EXwcupTxcKNGu86ICno4D2vvLngJKYwKlsWfvLdmS5c9lXbkGu9s9EbfABWR
         BXbKyjlPPsjTnMlp2ORSge61ibmuq7GEMtjLpUXRSDtbKV+6hyzp6pfbNdF+bIjynIL6
         yR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ZzsprVlH/rAh31u0YyujrUwhCIhoNeizPbgx/2GDCU=;
        b=ksWUVpBE2BGBzYlEiWxqeY//laKS12VmhPeV8rIf+PDYWcw+w/RdhEHdqhepa/Of8l
         b5eDlhNQKBQhO7ODp4/gW/p5YSz8crwRD4sHGlVf24QRhLV+2FCLd0iAYrqjsCwWz1dm
         zDW3E5vkEeha9WCHardVNPODf6rCVRkPIv85S57tbcdZCf3b0H143xh4Az0U6Ta9Nj89
         vzsgjWKBAi7+RyApMFgJ6QWit511SOdRbLQrv833PHIfIoP+gJEjk3jTeUHGwmVfLbKf
         SAfcmL2ltqOOij1hkwHAkJP7Ctco8Ud8LEwWS1s5JqOUtS1y2Bkk1kVXysnAF5dxiam3
         KuTw==
X-Gm-Message-State: APjAAAWu84VEDIDcpHd98n4t7XUG9I7uC3oj+txWjihRQDb6Lqa2+/88
        NuZ3FXZqaVEw/0FWtovhDlZehZfBl/Jdrw==
X-Google-Smtp-Source: APXvYqxB009qA8PO5u55hqNGrRE6jCX3feX6+42PpX2usVffhsXGjdOpzH7Ev4G6lO6ETawk9RNuag==
X-Received: by 2002:a63:7982:: with SMTP id u124mr30038906pgc.352.1557130790086;
        Mon, 06 May 2019 01:19:50 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:19:49 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 00/23] locking/lockdep: Small improvements
Date:   Mon,  6 May 2019 16:19:16 +0800
Message-Id: <20190506081939.74287-1-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Let me post these small bits first while waiting for Frederic's patches
to be merged.

This version should have addressed the comments you made. Thanks so much
for the review.

Thanks,
Yuyang

--

Yuyang Du (23):
  locking/lockdep: Change all print_*() return type to void
  locking/lockdep: Add description and explanation in lockdep design doc
  locking/lockdep: Adjust lock usage bit character checks
  locking/lockdep: Remove useless conditional macro
  locking/lockdep: Print the right depth for chain key colission
  locking/lockdep: Update obsolete struct field description
  locking/lockdep: Use lockdep_init_task for task initiation
    consistently
  locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
  locking/lockdep: Change the range of class_idx in held_lock struct
  locking/lockdep: Remove unused argument in validate_chain() and
    check_deadlock()
  locking/lockdep: Update comment
  locking/lockdep: Change type of the element field in circular_queue
  locking/lockdep: Change the return type of __cq_dequeue()
  locking/lockdep: Avoid constant checks in __bfs by using offset
    reference
  locking/lockdep: Update comments on dependency search
  locking/lockdep: Add explanation to lock usage rules in lockdep design
    doc
  locking/lockdep: Remove redundant argument in check_deadlock
  locking/lockdep: Remove unused argument in __lock_release
  locking/lockdep: Refactorize check_noncircular and check_redundant
  locking/lockdep: Check redundant dependency only when
    CONFIG_LOCKDEP_SMALL
  locking/lockdep: Consolidate lock usage bit initialization
  locking/lockdep: Adjust new bit cases in mark_lock
  locking/lockdep: Remove !dir in lock irq usage check

 Documentation/locking/lockdep-design.txt | 112 ++++--
 include/linux/lockdep.h                  |  32 +-
 init/init_task.c                         |   2 +
 kernel/fork.c                            |   3 -
 kernel/locking/lockdep.c                 | 607 ++++++++++++++++++-------------
 5 files changed, 461 insertions(+), 295 deletions(-)

-- 
1.8.3.1

