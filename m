Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B8C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF772070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="h0ssI4U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbfG2OVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:21:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40052 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbfG2OVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:21:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so28114506pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR80kuJNJTZu3hsDXBNA4q0a6EH0Ziu81Ow2DeGUsWQ=;
        b=h0ssI4U9wjp1jVnPVOHReehDKSp/8jrXd6kfiCYoB88CDRXMFy2VsMgLb+53mXG8bG
         3ujADxDfBwHH4B+TJVQ6UAg5vsOk4SuC11JrrYhLuSrXg95iTBogwJtxcsGAcXjeIKnL
         KaxuntdgTbDi+hdcJ2sKgSBYjdoV9yWT8GYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MR80kuJNJTZu3hsDXBNA4q0a6EH0Ziu81Ow2DeGUsWQ=;
        b=uOTXrxH0vjSbuxhIpjPDA8lgb/iswRag1y+5niskVbLCNJ45TJnJPvbjH3ansNgl3u
         78+NRGIFDH4+nNc3olwB5n0WtUHY/L7EBOZOADiHjlsAk0rY3rv6mU0G/d9odGxaVLQR
         UTKqkTqpFZQP0P//AEggMiva3Qc5wIO59az2xukZVJu0E+eJKyf+ARSJ4uU8Ztza6Fjc
         4+MOkWjX3fVkmv+JejVoBCsRv0QAH4uvZcqjZmkmotar5RdsDfTXnqd+oG20sqJbKqvb
         sMKG9q/jzsvO4GgXLo5MCb+RK9Tmz5xTumdawxqC9CxdInmMi0ZlvBf7PSo1R4mjLEvx
         2aHA==
X-Gm-Message-State: APjAAAWNRWk4IARZulx2QBfwY3pkS/qu2uvTI38i6lHc4NFrGxVWpNPp
        crI13Mpf0RNN3WFTDDZav3c=
X-Google-Smtp-Source: APXvYqwIXlupdIi6PkUXUFGu9oV4z+WuZwgZVgPFpcMgqr1bkVfNbExq9CxRoUE4mt0Rvi0fm5ynYA==
X-Received: by 2002:a63:c008:: with SMTP id h8mr102953637pgg.427.1564410075414;
        Mon, 29 Jul 2019 07:21:15 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id i3sm67061225pfo.138.2019.07.29.07.21.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:21:14 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 0/3] kasan: support backing vmalloc space with real shadow memory
Date:   Tue, 30 Jul 2019 00:21:05 +1000
Message-Id: <20190729142108.23343-1-dja@axtens.net>
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

v1: https://lore.kernel.org/linux-mm/20190725055503.19507-1-dja@axtens.net/T/
v2: address review comments:
 - Patch 1: use kasan_unpoison_shadow's built-in handling of
            ranges that do not align to a full shadow byte
 - Patch 3: prepopulate pgds rather than faulting things in

Daniel Axtens (3):
  kasan: support backing vmalloc space with real shadow memory
  fork: support VMAP_STACK with KASAN_VMALLOC
  x86/kasan: support KASAN_VMALLOC

 Documentation/dev-tools/kasan.rst | 60 ++++++++++++++++++++++++++++++
 arch/Kconfig                      |  9 +++--
 arch/x86/Kconfig                  |  1 +
 arch/x86/mm/kasan_init_64.c       | 61 +++++++++++++++++++++++++++++++
 include/linux/kasan.h             | 16 ++++++++
 kernel/fork.c                     |  4 ++
 lib/Kconfig.kasan                 | 16 ++++++++
 lib/test_kasan.c                  | 26 +++++++++++++
 mm/kasan/common.c                 | 51 ++++++++++++++++++++++++++
 mm/kasan/generic_report.c         |  3 ++
 mm/kasan/kasan.h                  |  1 +
 mm/vmalloc.c                      | 15 +++++++-
 12 files changed, 258 insertions(+), 5 deletions(-)

-- 
2.20.1

