Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A6AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D0720882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaIJkXaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDCElh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:41:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44190 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:41:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so7644587pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GujRPZuMwtaEM7TH+99GzvcY8K4c6i03TTC4G7ZR+GM=;
        b=MaIJkXaRgU7Kpq+tAhc9kBZBS90TiQUv8Vy1/7y6oZfz87PraiP1oxZrsKAwpiVi1a
         fz8UYNgpPMyCbsRdqiei40Sh+w/klzkjHy4BsQ9n/mujQRvV3j1d6nggu86An0iO6rkE
         xwMGoJ8ZgYFnzUWx8aay/OI4ABxEO4fpBGaVZ5MjD94286IwtjC3Fm1L1avaJLxSusGS
         Ep3/KmXqge9l2caZHnv/AZRGBesmqWkeGAMvD085bKlyWFu6iIENVZ+H5shMVEarMaGG
         2frQpBbn45JPcBcggLsudfX/xBaO00mfgQk9BbPIcTr2BiSJgyR3HZ+jMGM8+kUhYy+J
         r83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GujRPZuMwtaEM7TH+99GzvcY8K4c6i03TTC4G7ZR+GM=;
        b=pe6E99k2YJKeLYtJVTJIkPYcbgS4pXzhMbTfCOl9MNVhWYU5tKG25Q/AF7YmxHyMjF
         DCzhQgAuWMdwCd/2DbEBJzdrBC+KTdYpex3taCyGmMHpKs884R1ew3iQrW44DtN4CLC4
         SQCh6BTxn1ZwYHvFkCh7iPyL3EBxX/h56yfyxCrtA0/cbtGN74CiMQiI3yps5cbdwZJ8
         2w48LwBTrywtUXAo37cQ+7g0TZV85v93F3W47jsAN940rYL6+wsxHBggt8/offSdWmKN
         RA3PsuaAPfdAzGdHNNmI269XD6A3IuLuuWRZhqtu+8oGO1N3n8zXABZ7DcNO8nxEpznG
         OBBA==
X-Gm-Message-State: APjAAAWmSt1BnZ303+eP4Vzm17enTXaAj4mBZj4/KNn7aWI5V9Qk7KdS
        sBJdMMcQ92Bo7+LlC6b8D7Q=
X-Google-Smtp-Source: APXvYqyvf1bbeeFiCXRhFzyRqxySZa1o0GEZeeigWxAk58c4g56CJmGsYcN0xCJHAVTSPk0NB6s9zg==
X-Received: by 2002:a63:4101:: with SMTP id o1mr17759469pga.17.1554266496094;
        Tue, 02 Apr 2019 21:41:36 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id d129sm20945461pfa.142.2019.04.02.21.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:41:35 -0700 (PDT)
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
Date:   Wed,  3 Apr 2019 07:40:27 +0300
Message-Id: <20190403044032.15965-1-ynorov@marvell.com>
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

