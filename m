Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C989AC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928D220644
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp2HAxF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfGUV2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37400 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfGUV2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so16372661pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwJM3c0gaWg0zGSILw2AF3ai5zXNRsZUALz5h/E3eZ0=;
        b=Hp2HAxF0bbaDK0XwTA65uLk++76frJkdHY4Fn55wcJleF5X8JA9HT0r4kCuHVJk1ig
         LD44q1GFEfRlVMY77yiGyNgWdzwowz+qUAxFN0Qjv95rpiq8zmLRtlvFeH6pnGLHaYKd
         1rj71SV1VmCjnvAGR98srmYNlI3FSP7b7rf3QCNyKocbOt3fTtUnLk+YREkULc3K9zCe
         J5VayiGgJbGb5k0tJPbtBqgTeGOvMuxNS2oEIQoqXY46VHzn1kRMjI83cQUyB7KumNXF
         gSqLdkcsjUTfUb9oWzCH7P+WjpNTZkw237si2YHaptG0il2DQfxFU+hcts3HyP+WXhZ6
         QnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwJM3c0gaWg0zGSILw2AF3ai5zXNRsZUALz5h/E3eZ0=;
        b=AtR2/+MfeUq1hCXR0M80yLSsBIiS4WUNL4LpcC6TcgzHHTmTC4+R/lSSTX8nMDiCfW
         xkpMjdGxqWexTArlEMnI0X79pxHOqL51hIHnOXz8reTMstPNUgnxT/+fsQZCN5MiKk1k
         psTKcxaHmfKAgmwfRP9DLc2Qhbjm9DbU1QLAr+qumEMuFjNLktx28YF5e0mfLvBx2WGs
         xO9kBeL/NZbEI2IGYu8xaICwqFHTOCZVzOheObCl/QvvBhT4N0asHUjyXg/5PFtQ+dOF
         ShFoMGIGQS/riGn6l+fHXmOoGv6/vLeOhaN4AmtOVqsbJrJEY7NhXIjrKPNlNTCB4mj3
         PDPQ==
X-Gm-Message-State: APjAAAXPyjjoDYGIjYspTrQcPsreeEsqtWaSfeI06G5pVf9oy6Kxbco/
        CWoSSIPrlFVKxT0fdDroMz8=
X-Google-Smtp-Source: APXvYqy7df/bHQj+/KeVJZzbxsfYyySceINjhMVfFUTtbM/06sbquVq5FFbQbeORpi0dW1kqxsyjYg==
X-Received: by 2002:a63:5f95:: with SMTP id t143mr8266157pgb.304.1563744511027;
        Sun, 21 Jul 2019 14:28:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:30 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
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
Cc:     Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH v3 0/7] lib: rework bitmap_parse
Date:   Sun, 21 Jul 2019 14:27:46 -0700
Message-Id: <20190721212753.3287-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <ynorov@marvell.com>

On top of next-20190717.

Similarly to recently revisited bitmap_parselist() [1],
bitmap_parse() is ineffective and overcomplicated.  This
series reworks it, aligns its interface with bitmap_parselist()
and makes usage simpler.

The series also adds a test for the function and fixes usage of it
in cpumask_parse() according to new design - drops the calculating
of length of an input string.

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
v3:
  - fix bitmap_clear() misuse.
  - opencode in_str() helper
  - simplify while() in bitmap_parse()


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
 lib/bitmap.c                 | 196 +++++++++++++++++------------------
 lib/string.c                 |  17 +++
 lib/test_bitmap.c            | 102 +++++++++++++++++-
 tools/include/linux/bitops.h |   9 +-
 8 files changed, 225 insertions(+), 117 deletions(-)

-- 
2.20.1

