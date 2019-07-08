Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EAC606C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D421707
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="su70wQ6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfGHRI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:08:56 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:37421 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfGHRI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:08:56 -0400
Received: by mail-vk1-f201.google.com with SMTP id v135so6839275vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rkb+RBbpaLSwWUUB7g0A+rsu7yIfnRDIumBvHSjiI6g=;
        b=su70wQ6/2hTT+J8ES8WXMRV7++oOFKiaJoXI1tHyVzzTCdE5I1E5DVYHktmK7xoyLH
         iZb/vfep+BIeL3PrullH6dkk5V4/AmuWTC4WBFI/bMTAhsjNYBYn6ySN8XAKZYkF+uiP
         /QutnYKWRFTxmwrZGCr6CmPBC/PSe9LZI5m5LU2EeHPCw7wxiCOF0TAe+0xJSMxjHVFE
         4y24R1PdKke1XPauJk+Z6WuRwhl7JisBrF/xvMt0cdsXlh+0PZiu45rvNKxWd1vmthVU
         h0d4arZgDyJcJRGTZnIyatkhKFDNCFMlQpm5jbPlJtLFtTpWD0P6d5SUFIGnBwSgWvB4
         dCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rkb+RBbpaLSwWUUB7g0A+rsu7yIfnRDIumBvHSjiI6g=;
        b=oDNx5HT9PUttcBFkhaxMmApUM4/JXpZ0yq4FD/3lHSzHg/rM9OsXnUtLFwSINspad4
         iqzz8RukIF047V+fAHxUHazu1yvXRVW/JssAdc/+DE1IBX+kkor4lDSWlsMvfMSNvr2c
         nPX9ucw1RDFxYXD0Lx/Z0smOaSM27ZLnIfxyaqhrHlGQmzX8vfb2fCXyQJpjg8x4cqJQ
         bRICpancpJwv1h/A4JoxnO+1z6uve5hXu0N3HNwdk4SrzfXPJiBvzXqB5trvOSoqElwk
         4FB5X1Uhb3AFwYZ1750U7zmcH4JhgKy8NkO7FDAjOPEoAmavIgFohqHrZKFiNRrJdAIm
         WJfw==
X-Gm-Message-State: APjAAAW0AsEaxnVDMzmbZFvFaaRUxfRuxs6YfKKJYGiOp9VPTIRdWL0T
        1fgsHJh8JKWJa81eYXoTOdApUPSuwA==
X-Google-Smtp-Source: APXvYqxlNqCP7Is+7VGSJcZtIKkF90xpT2ulacUW8J0j4jU3IIAPg9yY4ZS6OegNMF29BsHeoXjMsqH8RA==
X-Received: by 2002:ab0:7143:: with SMTP id k3mr10372932uao.91.1562605734773;
 Mon, 08 Jul 2019 10:08:54 -0700 (PDT)
Date:   Mon,  8 Jul 2019 19:07:02 +0200
Message-Id: <20190708170706.174189-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 0/5] Add object validation in ksize()
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Qian Cai <cai@lca.pw>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version fixes several build issues --
Reported-by: kbuild test robot <lkp@intel.com>

Previous version here:
http://lkml.kernel.org/r/20190627094445.216365-1-elver@google.com

Marco Elver (5):
  mm/kasan: Introduce __kasan_check_{read,write}
  mm/kasan: Change kasan_check_{read,write} to return boolean
  lib/test_kasan: Add test for double-kzfree detection
  mm/slab: Refactor common ksize KASAN logic into slab_common.c
  mm/kasan: Add object validation in ksize()

 include/linux/kasan-checks.h | 43 +++++++++++++++++++++++++++------
 include/linux/kasan.h        |  7 ++++--
 include/linux/slab.h         |  1 +
 lib/test_kasan.c             | 17 +++++++++++++
 mm/kasan/common.c            | 14 +++++------
 mm/kasan/generic.c           | 13 +++++-----
 mm/kasan/kasan.h             | 10 +++++++-
 mm/kasan/tags.c              | 12 ++++++----
 mm/slab.c                    | 28 +++++-----------------
 mm/slab_common.c             | 46 ++++++++++++++++++++++++++++++++++++
 mm/slob.c                    |  4 ++--
 mm/slub.c                    | 14 ++---------
 12 files changed, 144 insertions(+), 65 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

