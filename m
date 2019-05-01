Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C267C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619320866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCcNqPMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEABGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:06:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40932 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEABGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so3961616pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FBpspKqtB6Cvvvzr/dG91c04txThI+kPiiBnwR/7ZrQ=;
        b=oCcNqPMrKW0ZWbYsDAA+i/b9auPXFzjrVIWioE6H4uPMd9w3hFe7hvpunsJSV9q8Fd
         doke6ij+7T16U+rw4IOnPEf8nTZbtOB5cJum7K7amq3YUMt5rCvDJGY+r1jVm/qLH+ai
         6Oh05Dcdv9kBC4dPgc+rlnvn2jiUfJ/cTPfAeFsEzcTY8c+szEB1PrX2BfwJPId0hSGL
         Upu3IBC9+N05ECCVIm69MJ3EMOOjxIPVqRsO9ceKvBoIt53uQbLo7CX6L/uns3Up9HYY
         er7dv3lLeVBI7Tlb/U+eM/AmODNUKExJpz4YFbHv0X0iPnjo/PhcR9HUYup8QUpRR09D
         9gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FBpspKqtB6Cvvvzr/dG91c04txThI+kPiiBnwR/7ZrQ=;
        b=ago463MndEBSN9qZbQAGsjM6xlqmvO/OJxykT65Wry0MK1NXHvKb54QlGIFtcDBs9R
         ei374CRZOHYelBceFccj1e74sTvge4fVcv34y+rRka7pJHNTVBMQk6/WLS+ATea1Bo3R
         TktzRDOn54n5Qz0xS31O01uFJli3zj63OG+SpDc+PX6FABtwx2Gthx0n+6k38SUWoGUp
         +VNv8oBrDbIIxsCqxzcj8u0WcsxQItN0RKsjsLITvVvjHRub16v7IY1j09r4i33kDaXi
         eE+5Yz4/7RecrAV/jEaGt/8u830dEd6p4S6VRnCyFFbjE1EnfGvBlAQcq2VKyHmrRc74
         mTHw==
X-Gm-Message-State: APjAAAXJiBb77fdlowvoy43M03RzP41EHO7HuBk5VKmhp7ziwlS9OoO7
        iwNfrp1QmiABjM9ZRsasg/Y=
X-Google-Smtp-Source: APXvYqzJem6s1aKMstloN2GPnWEbELZrW7XarZl0UQbYHQzVHdQsK4aS+edzEz2eI2Ol+hsp2VHmDQ==
X-Received: by 2002:aa7:800e:: with SMTP id j14mr73896979pfi.157.1556672801531;
        Tue, 30 Apr 2019 18:06:41 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id o66sm45518891pfb.184.2019.04.30.18.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:40 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 0/7] lib: rework bitmap_parse
Date:   Tue, 30 Apr 2019 18:06:29 -0700
Message-Id: <20190501010636.30595-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of next-20190418.

Similarly to recently revisited bitmap_parselist() [1],
bitmap_parse() is ineffective and overcomplicated.  This
series reworks it, aligns its interface with bitmap_parselist()
and makes usage simpler.

The series also adds a test for the function and fixes usage of it
in cpumask_parse() according to new design - drops the calculating
of length of an input string.

The following users would also consider to drop the length argument,
if possible:
drivers/block/drbd/drbd_main.c:2608
kernel/padata.c:924
net/core/net-sysfs.c:726
net/core/net-sysfs.c:1309
net/core/net-sysfs.c:1391

bitmap_parse() takes the array of numbers to be put into the map in
the BE order which is reversed to the natural LE order for bitmaps.
For example, to construct bitmap containing a bit on the position 42,
we have to put a line '400,0'. Current implementation reads chunk
one by one from the beginning ('400' before '0') and makes bitmap
shift after each successful parse. It makes the complexity of the
whole process as O(n^2). We can do it in reverse direction ('0'
before '400') and avoid shifting, but it requires reverse parsing
helpers.

Tested on arm64 and BE mips.

v1: https://lkml.org/lkml/2019/4/27/597
v2:
 - strnchrnul() signature and description changed, ifdeffery and
   exporting removed;
 - test split for better demonstration of before/after changes;
 - minor naming and formatting issues fixed.

[1] https://lkml.org/lkml/2019/4/16/66

Yury Norov (7):
  lib/string: add strnchrnul()
  bitops: more BITS_TO_* macros
  lib: add test for bitmap_parse()
  lib: make bitmap_parse_user a wrapper on bitmap_parse
  lib: rework bitmap_parse()
  lib: new testcases for bitmap_parse{_user}
  cpumask: don't calculate length of the input string

 include/linux/bitmap.h       |   8 +-
 include/linux/bitops.h       |   5 +-
 include/linux/cpumask.h      |   4 +-
 include/linux/string.h       |   1 +
 lib/bitmap.c                 | 197 +++++++++++++++++------------------
 lib/string.c                 |  17 +++
 lib/test_bitmap.c            | 102 +++++++++++++++++-
 tools/include/linux/bitops.h |   9 +-
 8 files changed, 226 insertions(+), 117 deletions(-)

-- 
2.17.1

