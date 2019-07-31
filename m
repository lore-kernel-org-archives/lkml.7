Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA02C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49B218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="AHPx62HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfGaHP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:15:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44927 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfGaHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:15:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so31300998pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBb3SjcJAJvGT3ZKVh7XtBW59bi/thuEuHRFZNsNtKI=;
        b=AHPx62HMhQa8hHRMGLqgFiw+CumV6LiEgGPvYRqjcrvfGuwSMk4T9h6ZBLhXoSWrCI
         K8hKp875yeBKlerrIoeiIERsQFuw95uNk88vGcgWCgVb/quRyN0yqEth5OX9ZrewsaRf
         QpRSPaGOI1njJ5BGhn1bmjkrIUghufDipHuDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pBb3SjcJAJvGT3ZKVh7XtBW59bi/thuEuHRFZNsNtKI=;
        b=N5v38SQCCNuk2GRq19qTNLKgPC0y1Yy0YO8NqoWRGLHJAKfywpRqaiDQTkDX8QFW33
         lnM7jfPDE4J0bWh/TmbqCNC2rOfFN6S77lIKBwvI9n6gjuu7NmDW0qZLhuFPcwC8PyRY
         aWvhUusdXwwR7P8kxdxnapwI7k80u56+aFRFeH2Tm3IMVKwuCvyuO3lSPDV9HAfkCNW9
         TA2biflzfF0GQhgmVJWJmFuHdio3WBQ6m1o+qgAWi8cEmtzy2i4SUdbXZ5oGKUR3HQgl
         m8K8///DAqvFoxlYyjkEMrEVz1GmNqsDI8sFIDuLx+rrAvD4QWkXsjp9zDzAt9/bjQ7j
         ANjg==
X-Gm-Message-State: APjAAAXAa3H+JcTzef9X1Ll7AKr8fFOIC92HTCM7MZ94HEApdLcgUtpU
        7+9QAbNdnM9QMpgHsqOOffWynmpI
X-Google-Smtp-Source: APXvYqy/mIDPTuA13zSYqCYHNuz1kgkm/st7Gu7Y8W/1GxIxmP0Q7ged7lvL97JvsdwucbKkDwzDjw==
X-Received: by 2002:a17:90a:29c5:: with SMTP id h63mr1357413pjd.83.1564557355793;
        Wed, 31 Jul 2019 00:15:55 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id x13sm71508648pfn.6.2019.07.31.00.15.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 00:15:55 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 0/3] kasan: support backing vmalloc space with real shadow memory
Date:   Wed, 31 Jul 2019 17:15:47 +1000
Message-Id: <20190731071550.31814-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vmalloc space is backed by the early shadow page. This
means that kasan is incompatible with VMAP_STACK, and it also provides
a hurdle for architectures that do not have a dedicated module space
(like powerpc64).

This series provides a mechanism to back vmalloc space with real,
dynamically allocated memory. I have only wired up x86, because that's
the only currently supported arch I can work with easily, but it's
very easy to wire up other architectures.

This has been discussed before in the context of VMAP_STACK:
 - https://bugzilla.kernel.org/show_bug.cgi?id=202009
 - https://lkml.org/lkml/2018/7/22/198
 - https://lkml.org/lkml/2019/7/19/822

In terms of implementation details:

Most mappings in vmalloc space are small, requiring less than a full
page of shadow space. Allocating a full shadow page per mapping would
therefore be wasteful. Furthermore, to ensure that different mappings
use different shadow pages, mappings would have to be aligned to
KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE.

Instead, share backing space across multiple mappings. Allocate
a backing page the first time a mapping in vmalloc space uses a
particular page of the shadow region. Keep this page around
regardless of whether the mapping is later freed - in the mean time
the page could have become shared by another vmalloc mapping.

This can in theory lead to unbounded memory growth, but the vmalloc
allocator is pretty good at reusing addresses, so the practical memory
usage appears to grow at first but then stay fairly stable.

If we run into practical memory exhaustion issues, I'm happy to
consider hooking into the book-keeping that vmap does, but I am not
convinced that it will be an issue.

v1: https://lore.kernel.org/linux-mm/20190725055503.19507-1-dja@axtens.net/
v2: https://lore.kernel.org/linux-mm/20190729142108.23343-1-dja@axtens.net/
 Address review comments:
 - Patch 1: use kasan_unpoison_shadow's built-in handling of
            ranges that do not align to a full shadow byte
 - Patch 3: prepopulate pgds rather than faulting things in
v3: Address comments from Mark Rutland:
 - kasan_populate_vmalloc is a better name
 - handle concurrency correctly
 - various nits and cleanups
 - relax module alignment in KASAN_VMALLOC case

Daniel Axtens (3):
  kasan: support backing vmalloc space with real shadow memory
  fork: support VMAP_STACK with KASAN_VMALLOC
  x86/kasan: support KASAN_VMALLOC

 Documentation/dev-tools/kasan.rst | 60 ++++++++++++++++++++++
 arch/Kconfig                      |  9 ++--
 arch/x86/Kconfig                  |  1 +
 arch/x86/mm/kasan_init_64.c       | 61 +++++++++++++++++++++++
 include/linux/kasan.h             | 16 ++++++
 include/linux/moduleloader.h      |  2 +-
 kernel/fork.c                     |  4 ++
 lib/Kconfig.kasan                 | 16 ++++++
 lib/test_kasan.c                  | 26 ++++++++++
 mm/kasan/common.c                 | 83 +++++++++++++++++++++++++++++++
 mm/kasan/generic_report.c         |  3 ++
 mm/kasan/kasan.h                  |  1 +
 mm/vmalloc.c                      | 15 +++++-
 13 files changed, 291 insertions(+), 6 deletions(-)

-- 
2.20.1

