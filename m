Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371CBC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFB121920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZapepkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbfIIDdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:33:10 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46120 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733222AbfIIDdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id t8so9248540lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWBgQyYa6OlqLzRx+/qs5VDJtxqfy2lKdFM4eRN2Ae0=;
        b=RZapepkWuAXbHGMZA6nR74g89tee3UeRo+ms6YrW0LxhPaION7XmXGhnbsqHI1av7m
         FsdoGrbU65Ura/5QDaodxszgQm0T4LHTK0YS3Jq/IgCzW3YLmEK6VTSJ8QR6Rh0peolW
         AFMdqWFl9sG3ou7jYTC7VSULwr+9g2Hwmt7sV8kv9ei7iZbCOzsYTpKnC1E9eksvr/Ma
         Bn9NnxNtflQfITI6yEe4XZSbp4b376blljyUZuG6/uczSddV4reT12vJPeblYrr7GNlx
         yG0y/XG4TqKx+soPD33W+ifFU+PFdxu9WvVGJ5w6we1AeU4UBOyw2AQVMGoefgC7D5Rf
         CgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MWBgQyYa6OlqLzRx+/qs5VDJtxqfy2lKdFM4eRN2Ae0=;
        b=P5QdPAa/UQTpjtXdrb0CKKBYp4lNQM1kMGoIFZRlL27+MYj/dvrc1LCdL1JwrpDIEu
         woWqUnnegyqk8DAJss92OnyMSDLpJJ1KBLeVnoZjVTk9MQRHXcbXNlO1o4zaCQTskFmm
         x43UZ5d+ZV5un4F80P1bAut/VyYuD13Eh1r31twOm5EUVPS3PnpDD+MZJgJfs8ipncXc
         D10Z5hTdPkvatZOo2QPQL4+O2L0oLpDX7Sns/niggrVPYNOewmLgZwPnwnBAxxu7ubNs
         DkoyQj9GMZyBS7V/7QdxPiVp+qA4MAZ82I5sCu6nUth8FjMBPg5tIz5iyctHpb5cfz9r
         ULag==
X-Gm-Message-State: APjAAAVafqQr+KsKJtVbz6wrrbOWXVtQZUokXsGppFfp75rrd0NGwtEv
        op4QnLldgb7t65ZL+U0HAac=
X-Google-Smtp-Source: APXvYqxyfTf4uO4/RYD21JRts6dMk86+hoafjH+8fGjGpNGkDAotSNexni3Lxv0IWmFGVxP4XK3QAg==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr15459085lfc.28.1567999987879;
        Sun, 08 Sep 2019 20:33:07 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:06 -0700 (PDT)
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
Subject: [PATCH v4 0/7] lib: rework bitmap_parse
Date:   Sun,  8 Sep 2019 20:30:14 -0700
Message-Id: <20190909033021.11600-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm sorry for long delay with re-submission of this series
As Andy mentioned in review for v3, I switched to isxdigit()
where appropriate. I also removed my Marvell's signed-off-by
since I don't work for them anymore.

Thanks,
Yury

On top of next-20190904.

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
  - opencode in_str() helper.
  - simplify while() in bitmap_parse()
v4:
  - use isxdigit() where appropriate.
  - clean signed-off-by list.


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

