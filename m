Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B87C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE42622D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="TdUwLWei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfICOzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:55:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45081 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:55:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id x3so2856080plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZ8tuOmuka1RKOh9uZYxX64asskdg/IRNCGvFNDvGIA=;
        b=TdUwLWei7O2GtGjoJhNuW4vtXToUDnCEFGBEiMFSqOyEYvn6uuCUIwq7PO0SfU3C1K
         4XWtsZ8X8qoN3HlM5ZOtpCNAZJhSObGLt+wAwQpqWRKZcVQAXZKIY/iEco+KRr/iWOAM
         gDhizUh7ejhWyPK/F7TxskflMYw2pUoXZlkDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZ8tuOmuka1RKOh9uZYxX64asskdg/IRNCGvFNDvGIA=;
        b=nPIn4hx3EwloI5rxBVySz+3fycAB6oL63jrdSZgHveCn6rBbUeJljGu8K2rWOCDpd/
         6j4cOaEOxCXSQ1gHW1SowllGLe6aqrmP2kveUSKxZtERO4qUqF5zJiuJOFQznTrQ8hNu
         0Ih14t0mstF7P3Tn6aInyzhlLglics9im5PfDPDlxUm7uPFPqJGP1VF0P5GQ2S3g1aab
         dKPjfUXn8HZN/bhiz9G2yryxPoCGLPReKg9MLRs2HWoveYozDuneZzK7UD/3FO276Ojp
         /k0G4QrvX063yqv60qLtqNIt6LMkrcbwvLiNbKg9jgQZIzbNxCBDJMNCX/myg5Xw5tGO
         77HQ==
X-Gm-Message-State: APjAAAUnZHaerFXQVEkaMnmDPKX+UbvX6FfbyEu94xw7MF9icMXINvFn
        UFt51g0kJmAqgM6v3xX1cOnkqQ==
X-Google-Smtp-Source: APXvYqwX1u+cJ7UBoBnzl610xUDA0ydm4oDNnn1LknkArck/I7ljcJuzAQn/Q64Q0qrb1B+fweaTxQ==
X-Received: by 2002:a17:902:543:: with SMTP id 61mr35725696plf.20.1567522542162;
        Tue, 03 Sep 2019 07:55:42 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 65sm15600780pgf.30.2019.09.03.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:55:41 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v7 0/5] kasan: support backing vmalloc space with real shadow memory
Date:   Wed,  4 Sep 2019 00:55:31 +1000
Message-Id: <20190903145536.3390-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, vmalloc space is backed by the early shadow page. This
means that kasan is incompatible with VMAP_STACK.

This series provides a mechanism to back vmalloc space with real,
dynamically allocated memory. I have only wired up x86, because that's
the only currently supported arch I can work with easily, but it's
very easy to wire up other architectures, and it appears that there is
some work-in-progress code to do this on arm64 and s390.

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

Instead, share backing space across multiple mappings. Allocate a
backing page when a mapping in vmalloc space uses a particular page of
the shadow region. This page can be shared by other vmalloc mappings
later on.

We hook in to the vmap infrastructure to lazily clean up unused shadow
memory.


v1: https://lore.kernel.org/linux-mm/20190725055503.19507-1-dja@axtens.net/
v2: https://lore.kernel.org/linux-mm/20190729142108.23343-1-dja@axtens.net/
 Address review comments:
 - Patch 1: use kasan_unpoison_shadow's built-in handling of
            ranges that do not align to a full shadow byte
 - Patch 3: prepopulate pgds rather than faulting things in
v3: https://lore.kernel.org/linux-mm/20190731071550.31814-1-dja@axtens.net/
 Address comments from Mark Rutland:
 - kasan_populate_vmalloc is a better name
 - handle concurrency correctly
 - various nits and cleanups
 - relax module alignment in KASAN_VMALLOC case
v4: https://lore.kernel.org/linux-mm/20190815001636.12235-1-dja@axtens.net/
 Changes to patch 1 only:
 - Integrate Mark's rework, thanks Mark!
 - handle the case where kasan_populate_shadow might fail
 - poision shadow on free, allowing the alloc path to just
     unpoision memory that it uses
v5: https://lore.kernel.org/linux-mm/20190830003821.10737-1-dja@axtens.net/
 Address comments from Christophe Leroy:
 - Fix some issues with my descriptions in commit messages and docs
 - Dynamically free unused shadow pages by hooking into the vmap book-keeping
 - Split out the test into a separate patch
 - Optional patch to track the number of pages allocated
 - minor checkpatch cleanups
v6: https://lore.kernel.org/linux-mm/20190902112028.23773-1-dja@axtens.net/
 Properly guard freeing pages in patch 1, drop debugging code.
v7: Add a TLB flush on freeing, thanks Mark Rutland.
    Explain more clearly how I think freeing is concurrency-safe.

Daniel Axtens (5):
  kasan: support backing vmalloc space with real shadow memory
  kasan: add test for vmalloc
  fork: support VMAP_STACK with KASAN_VMALLOC
  x86/kasan: support KASAN_VMALLOC
  kasan debug: track pages allocated for vmalloc shadow

 Documentation/dev-tools/kasan.rst |  63 ++++++++
 arch/Kconfig                      |   9 +-
 arch/x86/Kconfig                  |   1 +
 arch/x86/mm/kasan_init_64.c       |  60 ++++++++
 include/linux/kasan.h             |  31 ++++
 include/linux/moduleloader.h      |   2 +-
 include/linux/vmalloc.h           |  12 ++
 kernel/fork.c                     |   4 +
 lib/Kconfig.kasan                 |  16 +++
 lib/test_kasan.c                  |  26 ++++
 mm/kasan/common.c                 | 230 ++++++++++++++++++++++++++++++
 mm/kasan/generic_report.c         |   3 +
 mm/kasan/kasan.h                  |   1 +
 mm/vmalloc.c                      |  45 +++++-
 14 files changed, 497 insertions(+), 6 deletions(-)

-- 
2.20.1

