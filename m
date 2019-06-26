Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED22C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95C3204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVvuA3zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFZMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:23:02 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42063 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:23:02 -0400
Received: by mail-qk1-f202.google.com with SMTP id l16so2352035qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rHwJaORfU9mZJNEEo+jfWN6v6wx9eIm8a8mlUMvLB5Q=;
        b=FVvuA3zJQGuPor4RQmsHdaCKO/pAXJhuQF83hlbKY9iIKR6vfjKfGQ/ETMWnRE81jd
         jePQNF4HBcVZjtFylu5myNQmiHspuGu9vfYpwq5mpUvkM54IRChAsDca97Pj2Fp3pkv4
         RHLK9CR+MwadHsI9+rV6E5kxw8AXWSeQ3M3Zpo479Mioq8UM+sXQYEnXweDwXIcoKLa5
         A/50ckDH7jQn0d13rdkD9sSTML6D67dq+1/2WiASn/N4iuwHh1mRPjrr2ilO4kETxctr
         8+fkMMy7Gg4tHSwDW2ZwA0yQoCOBBiJBjW4RPPmxsnRWtL80rNEknMJ0Y12jLKm/bc0j
         AAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rHwJaORfU9mZJNEEo+jfWN6v6wx9eIm8a8mlUMvLB5Q=;
        b=Ih6VHMv7tpNdDgXwhr/0+0+ScfqDRPP65lPvhNAKqXA3dbZe/PTY8oIzzTuY8cK1Zr
         ENGAdkefJ8m8rcN1iVKQJIE/EiSY+MLjiQw2ugFAK5Ti/mHDoOrXCPOUhZtyT6l1Fi4i
         /jxG27LzDfLRm8RM6/IO4Yph5dAd7kcZozU2pj780/EcG2fSYYShCRY6UqrunjkLD/jd
         1oIDxqeNCw8il7fKSbFH8yLxtI/jnq4Kn587qgglZjYElotcs59SCapUW5FnlKcfBYFg
         zCwTfMXDjadfiSdMztwr7hE8Bu3u3GZKybewCsNW49eLRr5tIvg9PeUlp4qBD8x8EBQj
         qScQ==
X-Gm-Message-State: APjAAAXDdNFfeIDHUSV1QUXPFLD8t1rgNNSFOaFxK/6UbHEOgWhiBaTx
        AuPwSlT+MHlbzvPomD8aMxzZDWTruw==
X-Google-Smtp-Source: APXvYqzl4LpGQmdrj0fZiOBsmG1D5EzH0t7qS8z3VuqQjCIlUkPj6pS/tt/JbkNeDbNPZCT8uxsjq+PytA==
X-Received: by 2002:ac8:197a:: with SMTP id g55mr3301594qtk.320.1561551781196;
 Wed, 26 Jun 2019 05:23:01 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:20:15 +0200
Message-Id: <20190626122018.171606-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/4] mm/kasan: Add object validation in ksize()
From:   Marco Elver <elver@google.com>
To:     aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds proper validation of an object in ksize() --
ksize() has been unconditionally unpoisoning the entire memory region
associated with an allocation. This can lead to various undetected bugs.

To correctly address this for all allocators, and a requirement that we
still need access to an unchecked ksize(), we introduce __ksize(), and
then refactor the common logic in ksize() to slab_common.c.

Furthermore, we introduce __kasan_check_{read,write}, which can be used
even if KASAN is disabled in a compilation unit (as is the case for
slab_common.c). See inline comment for why __kasan_check_read() is
chosen to check validity of an object inside ksize().

Previous version:
http://lkml.kernel.org/r/20190624110532.41065-1-elver@google.com

v2:
* Complete rewrite of patch, refactoring ksize() and relying on
  kasan_check_read for validation.

Marco Elver (4):
  mm/kasan: Introduce __kasan_check_{read,write}
  lib/test_kasan: Add test for double-kzfree detection
  mm/slab: Refactor common ksize KASAN logic into slab_common.c
  mm/kasan: Add object validation in ksize()

 include/linux/kasan-checks.h | 35 ++++++++++++++++++++++------
 include/linux/kasan.h        |  7 ++++--
 include/linux/slab.h         |  1 +
 lib/test_kasan.c             | 17 ++++++++++++++
 mm/kasan/common.c            | 14 +++++------
 mm/kasan/generic.c           | 13 ++++++-----
 mm/kasan/kasan.h             | 10 +++++++-
 mm/kasan/tags.c              | 12 ++++++----
 mm/slab.c                    | 28 +++++-----------------
 mm/slab_common.c             | 45 ++++++++++++++++++++++++++++++++++++
 mm/slob.c                    |  4 ++--
 mm/slub.c                    | 14 ++---------
 12 files changed, 135 insertions(+), 65 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

