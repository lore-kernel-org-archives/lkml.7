Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AD0C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68579205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3zV2GeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfD1D3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:29:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39573 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfD1D3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:29:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so3614791pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 20:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=maFyUzj6q8GecybXdbTd3FqRj6RpEwVek/VVf1HuhJI=;
        b=r3zV2GeT+/d4y367o25f+1YUPK2ESOr7zHWIQMY87rEScFIvRVVxte1nYu10zP6iNi
         Mu1qgLoZEIE0I06SIMDQzeHoSClrpK/Bgv2zTNfk63uf1f0d2+apH1I7qcRm07SWGe3+
         iO7XWaZzNFiCqIDpyrrCMC7IDgWId8HkL++kM6WbavwKvU8IamcG1aNYNVoe9fAiooj0
         yOSjjb7U/8MwpRwlEviSfNvfZmgSnRb0jsIxiFBSdGgq3sunOrAazcBwXdruLQZw/uOI
         V6MTuxAdUMflJKvrnZ1HXVPP/CZDuAo2XPM4vqCNGhrVMHqJH+SyZSU+KA+8X6pTpwxC
         D7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=maFyUzj6q8GecybXdbTd3FqRj6RpEwVek/VVf1HuhJI=;
        b=XArRgWzORsgfxtKlmLstDBWtbPqPRUc82LB8Stt22nf3d0HpIN/UqQHSxf2ysfAbgI
         qcCErRrtu0tqpRq8b2zgINPu8uM00LBiP0mFboa3VKmnb+3Y94VmrMrSAeBRf4EA9ZZG
         y13Utdwn4abOjU9KsgmAoZxa4YEjKOTo1dOlCs6dTwIrGiOMb6iKu9pBfb2yPXM611iJ
         i7QPgtXkDd5602aWrRThR5TjioMaJ15nxGpi0tQ7EPn2HRsNt21u68D2XiYb/54ngnKH
         DLiIA3imucfoQwkMH/Cv4SuhCwzBv23ma+MsQPviC7uoH3Y6AeDDovLsDOrMjuK+MT1+
         bVPw==
X-Gm-Message-State: APjAAAXnXEVgMur5uLdGKFV0p4G+0FR9R177MZq9eXxSPiLY2ekILAE5
        Sw0qsMwXNndUJGfmzkIA8kc=
X-Google-Smtp-Source: APXvYqx3Lgpu6cw25xVX7o20IJjCEI8FcMpPWVwM9PNZeJyzImpyN4HPDReYe0R833co7k5S0lQ4Ow==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr51520043pgv.221.1556422180614;
        Sat, 27 Apr 2019 20:29:40 -0700 (PDT)
Received: from localhost ([2601:640:6:3484:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id j67sm66005272pfc.72.2019.04.27.20.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 20:29:39 -0700 (PDT)
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
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 0/4] lib: rework bitmap_parse
Date:   Sat, 27 Apr 2019 20:29:30 -0700
Message-Id: <20190428032936.1317-1-ynorov@marvell.com>
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

[1] https://lkml.org/lkml/2019/4/16/66

Yury Norov (6):
  lib/string: add strnchrnul()
  bitops: more BITS_TO_* macros
  lib/bitmap: make bitmap_parse_user a wrapper on bitmap_parse
  lib: rework bitmap_parse()
  lib: add test for bitmap_parse()
  cpumask: don't calculate length of the input string

 include/linux/bitmap.h       |   8 +-
 include/linux/bitops.h       |   3 +
 include/linux/cpumask.h      |   4 +-
 include/linux/string.h       |   3 +
 lib/bitmap.c                 | 197 +++++++++++++++++------------------
 lib/string.c                 |  20 ++++
 lib/test_bitmap.c            | 102 +++++++++++++++++-
 tools/include/linux/bitops.h |   9 +-
 8 files changed, 230 insertions(+), 116 deletions(-)

-- 
2.17.1

