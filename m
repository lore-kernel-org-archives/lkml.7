Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461CC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDED2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P8OUdo8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfD2UPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:15:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36445 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfD2UPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:15:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id o4so5942378wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qoPhwxCnRaVr9cai5wKe4b1V5A2KQPjXKSnDtAcDvUo=;
        b=P8OUdo8UPIv3zxfHb7pkxEwuxNptvaW5X7QI83j5Sg5C8rfUdp5KhQNmk23fo833N+
         2FpjkvpuEXtHdDsgQB9JrY1oP1ohtObD7wOkzhRt22jydxsbJX0/OJ/OqH5gC7GaIggy
         jGHirOkf88vdIIgrgkajIVIKNOG9UKmAlx7x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qoPhwxCnRaVr9cai5wKe4b1V5A2KQPjXKSnDtAcDvUo=;
        b=i/+5Npdy+eCDMWk8PJPOBk8eFyJZwooJLXkBs6piZAJ41HXAW/vM1mbmOdj8tqM2Je
         OrxrBW6slAP5VgyaDdSt1fDi7P1r6TCBLoPycp7OzFgtKMn6y14vnF3i/1VqC5Ffg3c6
         +S5aDsufggu8GFM4NxiT7En+s/8RUKNQrnMwNXZrTKJiGPgYFYpg9qp8Ri4kVJn/qPM1
         ixvrpNPlLodvAJp/18ONOfJFavkNQCgAD5nL+yaJRy3gIlv/kYfQ2qPbrLR0yTS9sHB6
         xobj38BhGavVQVvYi409m2UcgN3fdhO9dGeuyGvwyB67wAhmtkSz4yAfwS0qO23yh6Q3
         Y4jA==
X-Gm-Message-State: APjAAAUtlw2LHLq9SrYkqUafbxbLSLDp9A3slCV5yPTRj407+oC73zSp
        S4zDMhCnnwn8H67chyZQE/namTgj51o=
X-Google-Smtp-Source: APXvYqzUEpX7yipW5xTA0Sbj75BY2rWXrtjwy3muihRFT100EBiDOoIbU//AXYPKNxWtx8v4mai3JA==
X-Received: by 2002:adf:f102:: with SMTP id r2mr13780264wro.136.1556568921489;
        Mon, 29 Apr 2019 13:15:21 -0700 (PDT)
Received: from localhost.localdomain (ip-93-97.sn2.clouditalia.com. [83.211.93.97])
        by smtp.gmail.com with ESMTPSA id k6sm22864019wrd.20.2019.04.29.13.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 13:15:20 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 0/5] Fix improper uses of smp_mb__{before,after}_atomic()
Date:   Mon, 29 Apr 2019 22:14:56 +0200
Message-Id: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

A relatively common misuse of these barriers is to apply these to
operations which are not read-modify-write operations, such as
atomic_set() and atomic_read(); examples were discussed in [1].

This series attempts to fix those uses by (conservatively) replacing
the smp_mb__{before,after}_atomic() barriers with full memory barriers.

Applies on 5.1-rc7.

Thanks,
  Andrea

Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>

[1] http://lkml.kernel.org/r/20190420085440.GK14111@linux.ibm.com

Andrea Parri (5):
  drm/msm: Fix improper uses of smp_mb__{before,after}_atomic()
  bio: fix improper use of smp_mb__before_atomic()
  sbitmap: fix improper use of smp_mb__before_atomic()
  ceph: fix improper use of smp_mb__before_atomic()
  IB/hfi1: Fix improper uses of smp_mb__before_atomic()

 drivers/gpu/drm/msm/adreno/a5xx_preempt.c | 4 ++--
 drivers/infiniband/sw/rdmavt/qp.c         | 6 +++---
 fs/ceph/super.h                           | 2 +-
 include/linux/bio.h                       | 2 +-
 lib/sbitmap.c                             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4

