Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F364C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AECB2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtS7/W27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDCEqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:46:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37462 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfDCEqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:46:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so3302800pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 21:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GujRPZuMwtaEM7TH+99GzvcY8K4c6i03TTC4G7ZR+GM=;
        b=CtS7/W27tjpyziMmiO4FbkIsj9FhUFaJk0FXbIljCoiT+qNkI+24/nu4M9UP7z7dkb
         7i9WonQ6pTPiVlarww49hpUO+Pp4vhkogHu8Iy9zixtkmJ6hUQUyUMu59OcBvHaFQHyP
         Dfk/YqmmYAqMss9cbMNLwZBFDEHrXrXzT+YhjXmN6CuS+Y4NOBA3JlijfWb99gEIrkQ3
         pT8EfWyj1LxpdRCOmnBZUrG5dmEPnyiHqIwwgua00VJK3/7Uw6HLO5WiNwhtsShOJ0G2
         2LNf5Tclm/ISa2/tnk+Z7f0a1GZ8HJxVMtVvjJOOPV8n/M7cPBas/w9I2zxEO8bO16FG
         rV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GujRPZuMwtaEM7TH+99GzvcY8K4c6i03TTC4G7ZR+GM=;
        b=JRwPH5RlUo1TfvgA9Q3RvLiF9xaCjzs3hsSUjIIj/B4g9wPHnsF304+I1Mw1fYBGlN
         7avpLojElhj6B3ERMJfk7QzxLXxmPrcwM+qW5LnXIDMbqIZeGRafNiOEyOMVQTuiaMUz
         0fcAjrljCIkfSZAqFG5ECT5cwnC7+FLrztW/tvDsLyR8/fDiH27Q+vrx42QeYjbCKN7C
         abfer7u92OpcLaJeAlffjlURnS983Z6BQ3h2D79+FIHcp1DOvykoCWR58x7kFkxDLbKV
         royNPDqHAa6XMwC7qmJZEegKiNQIx+zzgPN8rgsDV7mmKqdGaF/qTqWsc/PnBUGrhQxc
         91Vg==
X-Gm-Message-State: APjAAAWz6zhgjLlVn71W/S+EMPF2IwHqFFeFSKLGuqm/HK5i8g7Q0V57
        3lbZrh6rZuqnD2lCIr40nRY=
X-Google-Smtp-Source: APXvYqwSR2TopIvMi7KoX/HezawDVpdmZP8blshAfBCbXLN3kpdq6wikarK22edNzHj7sIBcN+1B9g==
X-Received: by 2002:a63:6f0a:: with SMTP id k10mr48047260pgc.78.1554266782585;
        Tue, 02 Apr 2019 21:46:22 -0700 (PDT)
Received: from localhost (c-71-202-79-220.hsd1.ca.comcast.net. [71.202.79.220])
        by smtp.gmail.com with ESMTPSA id 4sm20143156pfn.159.2019.04.02.21.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 21:46:21 -0700 (PDT)
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
Date:   Wed,  3 Apr 2019 07:45:35 +0300
Message-Id: <20190403044540.16322-1-ynorov@marvell.com>
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

