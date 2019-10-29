Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF5D2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="kjSFsu5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfJ2EVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:21:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46370 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfJ2EVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:21:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id b25so8558634pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 21:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQ4pMzGN2GdDuONqdL7jGr9z3ckVwTP2I22ymxPUf70=;
        b=kjSFsu5lfogxvrqtja7CdREfAAJGFvDZhN5x/U9HPImneeDVXbXL3+UXKvS/p9hLF8
         qOq64dVqVl0+oZE+pEioENvIgZhVgt5IwHKz2kGiGcoGsETAe/Q75KpYNo6B9UMwX+me
         7fkD1R+k2EDmZaP0QuAB4yrDjLVhcIT/8wiEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQ4pMzGN2GdDuONqdL7jGr9z3ckVwTP2I22ymxPUf70=;
        b=Cs2ePxRP5mbaaiXdJ80tOp4KeQGdDorCz9emZTw/WL6RmEviM9htoZl2F4+DR6Nf2h
         1kISIQykKuKE34M6o2KCWtwpSvp3JETFWp3Ij+yUfuSxb/rfvHGRhnnRkJkZYVgbSUE9
         OUYnhX9LsfigT5Ff39gb0jtbATD1nSiU76e9Xx9laEnK0W+obiBfb4/fEHdb1PAxeozc
         PBUpxKUmZXOqLwny02Jvd2FpSOzY4Z+9p/V/6BxIYT0aU/AyKKKn1qkQN+PLRQrbgJnh
         zwe36+d1Q7WF4EjrRQd156aTKK0y9ddG6d0z9Jpz97gyN9o5PnjiVp8dasovwD/WHXV9
         9BLw==
X-Gm-Message-State: APjAAAXwbwD4bn54+t+KfB0Tf8bZIMtawiKTRTvfEjuBfo6DGXNQq2FT
        LYaxXsnlQ8rEy8BVooGk/JeebA==
X-Google-Smtp-Source: APXvYqyBpRaSgYBzIdz3dtaj3H2tdNpX20my5AQ2b8q9icz+RK1eMt6UEIZ/h0E1Rd0JstGCqWa+LA==
X-Received: by 2002:a63:311:: with SMTP id 17mr24417658pgd.327.1572322866102;
        Mon, 28 Oct 2019 21:21:06 -0700 (PDT)
Received: from localhost ([2001:44b8:802:1120:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id c1sm1013409pjc.23.2019.10.28.21.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 21:21:05 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 0/5] kasan: support backing vmalloc space with real shadow memory
Date:   Tue, 29 Oct 2019 15:20:54 +1100
Message-Id: <20191029042059.28541-1-dja@axtens.net>
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

Daniel Axtens (5):
  kasan: support backing vmalloc space with real shadow memory
  kasan: add test for vmalloc
  fork: support VMAP_STACK with KASAN_VMALLOC
  x86/kasan: support KASAN_VMALLOC
  kasan debug: track pages allocated for vmalloc shadow

 Documentation/dev-tools/kasan.rst |  63 ++++++++
 arch/Kconfig                      |   9 +-
 arch/x86/Kconfig                  |   1 +
 arch/x86/mm/kasan_init_64.c       |  60 +++++++
 include/linux/kasan.h             |  31 ++++
 include/linux/moduleloader.h      |   2 +-
 include/linux/vmalloc.h           |  12 ++
 kernel/fork.c                     |   4 +
 lib/Kconfig.kasan                 |  16 ++
 lib/test_kasan.c                  |  26 +++
 mm/kasan/common.c                 | 254 ++++++++++++++++++++++++++++++
 mm/kasan/generic_report.c         |   3 +
 mm/kasan/kasan.h                  |   1 +
 mm/vmalloc.c                      |  53 ++++++-
 14 files changed, 522 insertions(+), 13 deletions(-)

-- 
2.20.1

