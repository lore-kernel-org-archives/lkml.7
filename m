Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA796C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C9D20820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 22:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfIDWMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 18:12:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 18:12:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so403078wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 15:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RVYDeHbKBGun4f+UKrUmf76hgNLAoFPf0BMYGjpN1us=;
        b=eJecNKUFSF4Sj5nDpm6pK6SgQLRG3WSWZuOf6y6esFn/dBQM7GBUNpNSd6uJ36Id98
         OHjhUTTO91S+6jpvxaZvzJB15nSxrFu2z5zy6eeQ8nJqg5TuZryc74OjbPtTqNSrBhNx
         0/Gl+CdJQBVNpvRa1u/ugW0LRAsprPHBDe0VEo0qADkqxCAuZipJRLlaJSBb7Kn1azf1
         aSxuszAyH8L58+V5/OhKzH8pcP+MFXjuyeo9RIFeB7mBmlNVliTRFOQb87yVx6p2VfNK
         hZY6lzHt3t3efTp93Jhnq2JlgvvTMRirGnxx4jasX0oaIcSrTkGvZGRrDsq6BRi7oVhV
         eShA==
X-Gm-Message-State: APjAAAUvwx/vNYNwljmU0KEQdaCtlH+0vYi3h8qxVwnR9T/T9H54/Hwk
        YbWGYi9al2Pp5lmgoKmkmynZ2aZH
X-Google-Smtp-Source: APXvYqwx/VEL317aGfMsOhxPHNUnAy4qJ7vMCUuU8iNMdlAiHwrZVzZ+6jROGhNfejzqOW44J8VZ+A==
X-Received: by 2002:adf:f011:: with SMTP id j17mr34814430wro.131.1567635160085;
        Wed, 04 Sep 2019 15:12:40 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id s26sm156204wrs.63.2019.09.04.15.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 15:12:39 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Coccinelle <cocci@systeme.lip6.fr>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] coccinelle: check for integer overflow in binary search
Date:   Thu,  5 Sep 2019 01:12:23 +0300
Message-Id: <20190904221223.5281-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an RFC. I will resend the patch after feedback. Currently
I'm preparing big patchset with bsearch warnings fixed. The rule will
be a part of this patchset if it will be considered good enough for
checking.

There is a known integer overflow error [1] in the binary search
algorithm. Google faced it in 2006 [2]. This rule checks midpoint
calculation in binary search for overflow, i.e., (l + h) / 2.
Not every match is an actual error since the array could be small
enough. However, a custom implementation of binary search is
error-prone and it's better to use the library function (lib/bsearch.c)
or to apply defensive programming for midpoint calculation.

[1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
[2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/bsearch.cocci | 80 +++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 scripts/coccinelle/misc/bsearch.cocci

diff --git a/scripts/coccinelle/misc/bsearch.cocci b/scripts/coccinelle/misc/bsearch.cocci
new file mode 100644
index 000000000000..a99d9a8d3ee5
--- /dev/null
+++ b/scripts/coccinelle/misc/bsearch.cocci
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Check midpoint calculation in binary search algorithm for integer overflow
+/// error [1]. Google faced it in 2006 [2]. Not every match is an actual error
+/// since the array can be small enough. However, a custom implementation of
+/// binary search is error-prone and it's better to use the library function
+/// (lib/bsearch.c) or to apply defensive programming for midpoint calculation.
+///
+/// [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
+/// [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
+//
+// Confidence: Medium
+// Copyright: (C) 2019 Denis Efremov, ISPRAS
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@r depends on org || report@
+identifier l, h, m;
+statement S;
+position p;
+// to match 1 in <<
+// to match 2 in /
+// Can't use exact values, e.g. 2, because it fails to match 2L.
+// TODO: Is there an isomorphism for 2, 2L, 2U, 2UL, 2ULL, etc?
+constant c;
+// TODO: Is there an isomorphism for (a / 2) === (a >> 1)?
+@@
+(
+ while (\(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\)) {
+  ...
+(
+  ((l + h)@p / c)
+|
+  ((l + h)@p >> c)
+)
+  ...
+ }
+//TODO: Is it possible to match "do {} while ();" loops?
+// |
+//  do {
+//   ...
+// (
+//   ((l + h)@p / c)
+// |
+//   ((l + h)@p >> c)
+// )
+//   ...
+//  } while (\(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\));
+|
+ for (...; \(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\);
+      m = \(((l + h)@p / c)\|((l + h)@p >> c)\)) S
+|
+ for (...; \(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\); ...) {
+  ...
+(
+  ((l + h)@p / c)
+|
+  ((l + h)@p >> c)
+)
+  ...
+ }
+)
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for bsearch() or 'm = l + (h - l) / 2;'")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: custom implementation of bsearch is error-prone. "
+msg+="Consider using lib/bsearch.c or fix the midpoint calculation "
+msg+="as 'm = l + (h - l) / 2;' to prevent the arithmetic overflow."
+coccilib.report.print_report(p[0], msg)
+
-- 
2.21.0

