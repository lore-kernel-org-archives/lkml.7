Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF32075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzANNnfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDCEj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:39:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33987 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCEj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:39:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so7669280pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GujRPZuMwtaEM7TH+99GzvcY8K4c6i03TTC4G7ZR+GM=;
        b=IzANNnfHUSZYgVwaBi5R4l7RmEU6g12r9FbV34LwlynJItiErDZncxtbk1xgeVqw86
         lILQfUrV2Bmmr+l8/7LAwRss1EW7joREXIWghV+/521SJdZ8jiDKjRaY0XLH4DCz0rpn
         hxp/1haeojd9yN+Td4NGSqmbxYpr3TfSbiT+LSDfQQ7s3vAa18DBSuopfpb2P5Zi5nUH
         xewvqV6QG3JxOdmt/dBXp6zrH5m3Mnu7G6Ht0antScOHK/0dROKf2cJnoBouhuE3g+d+
         hMsH4TOX4xCMlWwBYspf8oUmXgp5OYeD+wfoPIzGLiM0M6xaQJrAU2cQKj44aWmxEkMq
         7Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GujRPZuMwtaEM7TH+99GzvcY8K4c6i03TTC4G7ZR+GM=;
        b=sQ724TG9h1q4Gn5SKZcRu0i9XpiKnM4X2qpl8/rlftlXfSBnuIGFgLy+hdY8X8Fdxi
         +9Bh6hWYgDoTWA00WHymwmXuPHHeHDwn9pPwWxjGGqS3MT58KRg9z9cv4OfAM4PTMp+z
         KmyZeS4klMD7GSHzwgyocC09U60OTrZfp5WzVrAnC4TxU0brSDLS0fn/f4FUO0EgfU8O
         4H9JtIAo9f2I/YQthFMoL3rLs9h4+6RjMzuI38lnWG5I4GdyqSu9225RWKq6xb7Dw673
         6bxBteNsGbjioykvuuDfhA949C+L9Mled20xXOYPqO+GYMKoq3p3eMopoXGbRjYNA9RV
         4wDg==
X-Gm-Message-State: APjAAAURI7ulZ2W4ny6M290ckfOwZ+UN51dQn2A0+zXGrh4o21fR30Cm
        Gl6LAN5Ayo7Xg98pdU5uUTs=
X-Google-Smtp-Source: APXvYqwnjhNjDDCzQ+bcmGpgLalobIsp4MtJKO1b0Yvixyw4cDJor7DunTwVUiN5I4WOAWYOImx9Zg==
X-Received: by 2002:a63:5466:: with SMTP id e38mr43196834pgm.340.1554266395210;
        Tue, 02 Apr 2019 21:39:55 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id v15sm19531699pff.105.2019.04.02.21.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:39:54 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] lib: rework bitmap_parselist and tests
Date:   Wed,  3 Apr 2019 07:39:00 +0300
Message-Id: <20190403043905.15785-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist has been evolved from a pretty simple idea for long and
now lacks for refactoring. It is not structured, has nested loops and a
set of opaque-named variables.

Things are more complicated because bitmap_parselist() is a part of user
interface, and its behavior should not change.

In this patchset
 - bitmap_parselist_user() made a wrapper on bitmap_parselist();
 - bitmap_parselist() reworked (patch 2);
 - time measurement in test_bitmap_parselist switched to ktime_get
   (patch 3);
 - new tests introduced (patch 4), and
 - bitmap_parselist_user() testing enabled with the same testset as
   bitmap_parselist() (patch 5).

v1: https://lkml.org/lkml/2018/12/23/50
v2: https://www.spinics.net/lists/kernel/msg3048976.html
v3: Implementation of an approach with copying the data to
    kernel space in bitmap_parselist_user() instead of parsing
    user data byte by byte. For me, it looks better than v2.

Yury Norov (5):
  lib: make bitmap_parselist_user() a wrapper on bitmap_parselist()
  lib: rework bitmap_parselist
  lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
  lib/test_bitmap: add testcases for bitmap_parselist
  lib/test_bitmap: add tests for bitmap_parselist_user

 lib/bitmap.c      | 285 ++++++++++++++++++++++++++--------------------
 lib/test_bitmap.c |  67 ++++++++---
 2 files changed, 218 insertions(+), 134 deletions(-)

-- 
2.17.1

