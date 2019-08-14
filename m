Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B03C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA022064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SVq5cWxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHNUUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:20:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38977 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfHNUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:20:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id g8so359213edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWZWsKOfmIl4yNVyC1A/XslquByM6vO1WGS7Kz0bD8U=;
        b=SVq5cWxfnMTCbnzjMxfAenRqPrywZHCY7aSYPqhjndhFoxhSpIaewsuAAbQ+hxRege
         LlE77zS9n3UHrI63NXV/R4kzhjhCsYIyspu6VzmOq3rB3oTT4FTYaoEIf2AXE4TNZw67
         EpRfZR5Lx03CDLH2/rXob/8M+d0YAjVHOhE5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWZWsKOfmIl4yNVyC1A/XslquByM6vO1WGS7Kz0bD8U=;
        b=nFRQV/lr01ZkPS5zvC4JwBnGaQ+oz8D6RIV/VH4sNT80o/SDV4Q16tYfX3PU1HVdpL
         AVUGqw3s/SprTDAIJTvad7C7g9CPY4UcSy6L0KBZVGudueDLXhB/J3wl+VqYbrtpwKvJ
         Xh6quIZBY70GkAEs0uWcrTWfSS7GdEEkm83Q+1m5h3V2/Z7Om0OF1VPGJRH6gqMgEXFO
         u2vXIfzzcLjxeBulE1cQF0NVvswj1Mrd7TWg4UNLX46DN39/zjO34VBTW3lwb6xXtTsq
         9YDK5BTxY9BHcrqYlbqD8KBRQnRCyC2BVa3/xien/w6rzkSHhwKkrunQ6WHdXmEa4KLp
         U7hQ==
X-Gm-Message-State: APjAAAUb++TblIt19qYqJiEqZBJ9QHkFtbsYtwAu2QCh9In3vgSCJdLp
        pmc269jy+/8zDz8TQaEL9652vMea7/Qtmg==
X-Google-Smtp-Source: APXvYqw0SI+1ky3oT9vQxF5bI61NxCDkMXiJWr+jVakG6fqDm3c/lfxYyJWqP0bvugFJUIGMMW1jXQ==
X-Received: by 2002:a17:906:5042:: with SMTP id e2mr1299846ejk.220.1565814033793;
        Wed, 14 Aug 2019 13:20:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ns22sm84342ejb.9.2019.08.14.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:20:33 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/5] hmm & mmu_notifier debug/lockdep annotations
Date:   Wed, 14 Aug 2019 22:20:22 +0200
Message-Id: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all (but I guess mostly Jason),

Finally gotten around to rebasing the previous version, fixing the rebase
fail in there, update the commit message a bit and give this a spin with
some tests. Nicely caught a lockdep splat that we're now discussing in
i915, and seems to not have misfired anywhere else (including a few oom).

Review, comments and everything very much appreciated. Plus I'd really
like to land this, there's more hmm_mirror users in-flight, and I've seen
some that get things wrong which this patchset should catch.

Thanks, Daniel

Daniel Vetter (5):
  mm: Check if mmu notifier callbacks are allowed to fail
  kernel.h: Add non_block_start/end()
  mm, notifier: Catch sleeping/blocking for !blockable
  mm, notifier: Add a lockdep map for invalidate_range_start
  mm/hmm: WARN on illegal ->sync_cpu_device_pagetables errors

 include/linux/kernel.h       | 10 +++++++++-
 include/linux/mmu_notifier.h |  6 ++++++
 include/linux/sched.h        |  4 ++++
 kernel/sched/core.c          | 19 ++++++++++++++-----
 mm/hmm.c                     |  3 +++
 mm/mmu_notifier.c            | 17 ++++++++++++++++-
 6 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.22.0

