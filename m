Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDBBC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D818217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM1VzFAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgABEbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40172 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgABEbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so30614848qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C7vqdvOVkcCV6TQUOU2EDm+a1PuU4xGb4U1yWcJLYw=;
        b=NM1VzFAJ+qtBPFHCl97CbDX7IboZMPWPwDjAfFMlRWk4k8axSRQseh0ja9OawGiPXL
         4p1Sx92WQcs6547PEk3PNfhG1c2VxM+u2sKYTdvpuQvkQ6wJdGb4HvXphs0AvJD/AL0K
         HM/3dIY4c1Z6ktmFTfR84K2BOzNg3OpYZvSYpHFS70Je/qZoBmwUsC6UEV1flOoL9m9h
         c9VBWbTtj4eu2BfanIsUk3sztT6asttP8zJsV6aZOTpd90majnOrYXxgxafGAnEhuco4
         2Nl9dVt+Ebs8DfqSy/PzpvkXlPngbJi78ULqJeqa3HwM3mLGENqYXWOVtnicbcj1LHu9
         GRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7C7vqdvOVkcCV6TQUOU2EDm+a1PuU4xGb4U1yWcJLYw=;
        b=i/EglIvd4AvITRBvHt+de5onuyf9rV4+EqSNm1xOnHsRzFzAAiX5Opm+oLGIg9dm/r
         xJiGOCKrIxDks+rPh7CAdFrMZ24hsoFdO5UaQ9zi1uNJH4TlCS7UjUO1QIo/nFWNyCRV
         isiL0wTldmDQT8fvHNQD9mewNDdJLxWhC4LDbveSJ04JvsO1mPXp5De124nLFeSdb+tO
         il1SuOAySiiq3t2JXKKO+LMziXzRQzfDN53FQJTJsCo4J4DsGxE0a0fZyp6tTvsGv2sl
         Bq6u4gJmN9MZvtS9/DvCs74DI2ddkTZPKLnVhelMaJZX3nhVf4TBgE49Wfdxgwz9BxWc
         TDWw==
X-Gm-Message-State: APjAAAXB/u3kNaAlDpjgCPMxKlGdK9S6DWnRHpdnhlg0ekGR7plwFNub
        x+JkIx5/74pExWIzroJsH04=
X-Google-Smtp-Source: APXvYqw8OaX/9yXsGpfwhB/K32zxhH19rgoIpggvB8lKBM5HBSstyQHqCDWuU4Yh7tYQaU6yN+4pBw==
X-Received: by 2002:a37:a5d7:: with SMTP id o206mr65294634qke.227.1577939471232;
        Wed, 01 Jan 2020 20:31:11 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:10 -0800 (PST)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH v5 0/7] lib: rework bitmap_parse 
Date:   Wed,  1 Jan 2020 20:30:24 -0800
Message-Id: <20200102043031.30357-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of next-20191220.

Similarly to recently revisited bitmap_parselist(), bitmap_parse()
is ineffective and overcomplicated. This series reworks it, aligns
its interface with bitmap_parselist() and makes it simpler to use.

The series also adds a test for the function and fixes usage of it
in cpumask_parse() according to the new design - drops the calculating
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
  - opencode in_str() helper.
  - simplify while() in bitmap_parse()
v4:
  - use isxdigit() where appropriate.
  - clean signed-off-by list.
v5:
  - remove isxdigit() with hex_to_bin() to avoid cache use by ctype
  table.
  - rebase on top of next-20191220.
 
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
 lib/bitmap.c                 | 193 +++++++++++++++++------------------
 lib/string.c                 |  17 +++
 lib/test_bitmap.c            | 102 +++++++++++++++++-
 tools/include/linux/bitops.h |   9 +-
 8 files changed, 222 insertions(+), 117 deletions(-)

-- 
2.20.1

