Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C6F20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChdvSgYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfDPGiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:38:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36202 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDPGiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:38:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so9824899pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 23:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AA1P30wTwwGvbZOQVdXv/j04659r4FkKpJqiA688gg8=;
        b=ChdvSgYf92m138ZST0MbAiWHTOSA7gDw52S3Ec2G/0/AW2vlZwtPmmQ68H9rbK3kUX
         kJsvnqXjyzhha6kzaOHiaU6+8Ns3d7swoqsSmVlIctx8eRbiOnzlh0wCiKd+YTRvK1ly
         Rl34yLdLZ9+IH2F86r0S3DPK1XB+t2jVTyqGdvMNsI989eJ/j6qoXzkr8XZILtaOSKc1
         HmWUb9D9DsE5s6s0xqN5WNh+zSZKhD9+NBeM/UUDySCvA3HgkwseLMRoavefuLTKoyCc
         nqX3iKsn5ErvcwbZPeCFVY0J03t/V7W/cXwNTpFpl5jwwLOSp0uowLt3wthd4SRKzQxz
         7gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AA1P30wTwwGvbZOQVdXv/j04659r4FkKpJqiA688gg8=;
        b=ZuRYTtPN2qAO2iKZJCZ0rTqOe69croygl+9ViVtxJB2CdLiQ80LCVpA1FU/wp6ze5R
         Uwht9asbLKJUwByR5Z/4prDYM/A5nAGRfMc8VOtr+BMqygIjBDt0hq10cN0RfKflebsI
         FV0mtzmHR7Z/h5lgq9To1kElUGzQFCG1kyhY+el8Nmz7zx5VZQ8O0dFJsjusOzb00Zfl
         jcBpTBbdowus87sygPndCRh3K2WHdqugy0Lct+2Dc034tKb5v80khjtc9NViIxpIbng8
         JzeQqXhj7XErlyyzXtHtG2OAWNTE4Rc9o9H+BMjaAnBnljlXuzr51EPN4cYdt17O25U3
         4kiw==
X-Gm-Message-State: APjAAAUOj0x1wDTGjKEWF/73zgw4T0t9twakg4Jygr6F9zEp+esFH22R
        N2F5xtpehUlBvMPvTAGcc24=
X-Google-Smtp-Source: APXvYqykJtf+E7Ca9/PBZyG1JfAdF2VjI04ScHho0GktXPUhH7HgLIzMyEQcmzkgddLM0VJ3RuC/dA==
X-Received: by 2002:a62:604:: with SMTP id 4mr81367043pfg.38.1555396686119;
        Mon, 15 Apr 2019 23:38:06 -0700 (PDT)
Received: from localhost ([2601:648:8303:5c60:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id 6sm40196853pfp.143.2019.04.15.23.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 23:38:05 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Mike Travis <travis@sgi.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] lib: rework bitmap_parselist and tests
Date:   Mon, 15 Apr 2019 23:37:56 -0700
Message-Id: <20190416063801.20134-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
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
v3: https://lkml.org/lkml/2019/4/3/68
v4: https://lkml.org/lkml/2019/4/5/640
v5: - fix sadly missed '* step' in patch 4, as spotted by Guenter Roeck;
    - use _parse_integer() in bitmap_getnum() to avoid opencoding
      mentioned by Andy Shevchenko.

Yury Norov (5):
  lib: make bitmap_parselist_user() a wrapper on bitmap_parselist()
  lib: rework bitmap_parselist
  lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
  lib/test_bitmap: add testcases for bitmap_parselist
  lib/test_bitmap: add tests for bitmap_parselist_user

 lib/bitmap.c      | 274 ++++++++++++++++++++++++++--------------------
 lib/test_bitmap.c |  67 +++++++++---
 2 files changed, 207 insertions(+), 134 deletions(-)

-- 
2.17.1

