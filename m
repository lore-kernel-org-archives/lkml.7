Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB746CA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB882089C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 12:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="JVnQHtwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfJTMdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 08:33:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38473 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfJTMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 08:33:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id o15so10375158wru.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVdUtdIiIo8QZJ1H1ltXBxEchxvLqSiQXsKdQA4dkCI=;
        b=JVnQHtwcfzGLibv56bs4NqnvmgoA5t2TLwKaEOMxADpLrvMCV6zRci4OdnTb+1C00a
         6NOxwwp+SXRIkZkZI/Z1/a6VqhRc/Yfw4undpsijTbpXK55i2berbh9fgPRb5wDOEZC9
         8dfreepgdjieAo17hZnHknxpqs6X809cBz6R8q1hycRL79JjfpzDsnvWBvoIoAuk+Uv4
         SoUugTJF6h6QYI7oBlZCzXZ/zv/U2aLklY5bSSuPubP2xJdVcaK5teNBDrHfR4VGj9zs
         PyyzPmXUP10GpFy1f76T0fZXVad0dAN3EPNCrKgHa3dcpfAOOVMyxgelAdZ1SRNNVDVF
         PuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TVdUtdIiIo8QZJ1H1ltXBxEchxvLqSiQXsKdQA4dkCI=;
        b=tFlMvaE39lj5txAGRYppgJWlM84UHXcrgatjGy09/WbFhsqPeGAmZU1CKjwOeRR+aI
         3rnaj8AkMOCY7xgxNp+usDouNQ9q+1HlaPxIYxztKnUVXu5vwxGxwJPHtK0Ja2w8H5UQ
         dZgtHHVghLZ3Y5tyxSaAPM4VLK2C5ot953JQa53gpGavVSSXZvqfqFkltRkpN5A5ZtSC
         RJ2hVU2P/PYTAE+aJ1ucjqAv2CKp1uuTy1QNJFySYYYiGICnrAp7sMuiKZEr+gQByTPH
         9wKwNGwDLgGqjcLtUgjVwqw5iabWrNNdKaWq0wgI8ScHAYWfY0MoYOcEYkVjd8rWHP4l
         U8GQ==
X-Gm-Message-State: APjAAAWHBgi7MhiEH/r1aeXkETXzLP8D+867Jr0n7HYI9fBTPycy2Rhe
        DEfnT3pyrdYIrlfRanKkWK65NhHgcyg=
X-Google-Smtp-Source: APXvYqy7klSagyBu146d20zW+4n26g7QgSwHtECvKHKGQxFxLBJI07F4VwOn1UyMc7SpS5krEFHfKA==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr15818748wrp.296.1571574797446;
        Sun, 20 Oct 2019 05:33:17 -0700 (PDT)
Received: from linux.fritz.box (p200300D99703FC00226A5479D1389944.dip0.t-ipconnect.de. [2003:d9:9703:fc00:226a:5479:d138:9944])
        by smtp.googlemail.com with ESMTPSA id t13sm15065400wra.70.2019.10.20.05.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:33:16 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 0/5] V3: Clarify/standardize memory barriers for ipc
Date:   Sun, 20 Oct 2019 14:33:00 +0200
Message-Id: <20191020123305.14715-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Updated series, based on input from Davidlohr and Peter Zijlstra:

- I've dropped the documentation update for wake_q_add, as what it
  states is normal: When you call a function and pass a parameter
  to a structure, you as caller are responsible to ensure that the 
  parameter is valid, and remains valid for the duration of the
  function call, including any tearing due to memory reordering.
  In addition, I've switched ipc to wake_q_add_safe().

- The patch to Documentation/memory_barriers.txt now as first change.
  @Davidlohr: You proposed to have 2 paragraphs: First, one for
  add/subtract, then one for failed cmpxchg. I didn't like that:
  We have one rule (can be combined with non-mb RMW ops), and then
  examples what are non-mb RMW ops. Listing special cases just ask
  for issues later.
  What I don't know is if there should be examples at all in
  Documentation/memory_barriers, or just
  "See Documentation/atomic_t.txt for examples of RMW ops that
  do not contain a memory barrier"

- For the memory barrier pairs in ipc/<whatever>, I have now added
  /* See ABC_BARRIER for purpose/pairing */ as standard comment,
  and then a block near the relevant structure where purpose, pairing
  races, ... are explained. I think this makes it easier to read,
  compared to adding it to both the _release and _acquire branches.

Description/purpose:

The memory barriers in ipc are not properly documented, and at least
for some architectures insufficient:
Reading the xyz->status is only a control barrier, thus
smp_acquire__after_ctrl_dep() was missing in mqueue.c and msg.c
sem.c contained a full smp_mb(), which is not required.

Patches:
Patch 1: Documentation for smp_mb__{before,after}_atomic().

Patch 2: Remove code duplication inside ipc/mqueue.c

Patch 3-5: Update the ipc code, especially add missing
           smp_mb__after_ctrl_dep() and switch to wake_q_add_safe().

Clarify that smp_mb__{before,after}_atomic() are compatible with all
RMW atomic operations, not just the operations that do not return a value.

Open issues:
- More testing. I did some tests, but doubt that the tests would be
  sufficient to show issues with regards to incorrect memory barriers.

What do you think?

--
	Manfred
