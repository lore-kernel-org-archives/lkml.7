Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F8F20811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtHyCs45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfCYVHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:07:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36920 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:07:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so7017873pfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jKxq5a358qtPvC2yfHbZ6xSjB+OfOwYrzq+4FrfS/wk=;
        b=DtHyCs45F9cb2dtd7Z/gHppc3S7bM0KAD6jNCy8yY+QDj4bFN4Ud9n8G1k4y7GTWB7
         Nqkd+aCki5vc1zoAb5T9lfxFtvJ7coc8BrV1qls39Qnh/DBFVgIGB4tfTASq57FN728o
         gZ/a1elWojzTyYG0IG4DBy4NWCfo/Vczp4aq69MRWNlf3NM78LJKmRByxfi3UgPhjEku
         feec/eonb+BE8kELpirt5jwkSSW7vIhcX/LeKQoc0h1dKKDqefBxksvwUAyn8OCz9OZk
         fQbstFF2oBtvX2bAFDIYRQuOryZBp8hF6Z67iomzyZUXqyFyrUwlMNZCFLqOHC1RXRFw
         cXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jKxq5a358qtPvC2yfHbZ6xSjB+OfOwYrzq+4FrfS/wk=;
        b=nUinwB2Ik4+ibWEwxhtSnUB30SREaEoT/ODcls3+G02+m61HzA5M9HuaFdUmWp3TYh
         b8de8z44f4qh7iql2qOgLctKPpC0Y7azKQHtC5IS+isw5XURDr+oxk/cDOeO4NDc4LFT
         Vvhssl5k3YgE7KPFNtnYKniQgl1lbZhG+yUhzCnw5vK5fCIw1Hq9jFr1VKJHPRtGvJxL
         TtDcL9G3m4OMgRX2+dxQkpjRGTxU1xz89dOBRByWtU5CAJQMcKju9Xn0ij7MKcwwv9SE
         30DqX+u2SEwPr2sBqNYlgIbpIVr2UlUkKuDgeelueWWUfdURuYZ0AxzLpqUsuJCtjQKR
         wRZg==
X-Gm-Message-State: APjAAAUVxnI61eJVVhyWWpBSwAVfwQLCfv3NCLKZ5Va4gUlfUvtZge8Q
        Ri4t0Jz6FEyUX6m1hsdfXVM=
X-Google-Smtp-Source: APXvYqxis8pqxkPna5f+O4Swo8CXa8LhnNmDjTceLSwZoLi3uRDTuMb+xAiVf3R9X4RBzw32GYB0uQ==
X-Received: by 2002:a63:cc03:: with SMTP id x3mr25022440pgf.121.1553548073033;
        Mon, 25 Mar 2019 14:07:53 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id i126sm23958484pfc.101.2019.03.25.14.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:07:52 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 0/6] lib: rework bitmap_parselist and tests
Date:   Tue, 26 Mar 2019 00:07:42 +0300
Message-Id: <20190325210748.6571-1-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitmap_parselist has been evolved from a pretty simple idea for long and
now lacks for refactoring. It is not structured, has nested loops and a
set of opaque-named variables.

Things are more complicated than they may be because bitmap_parselist()
is a part of user interface, and its behavior should not change.

In this patchset
 - __bitmap_parselist() is reworked (patches 2 and 3);
 - time measurement in test_bitmap_parselist switched to ktime_get
   (patch 4);
 - new tests introduced (patch 5), and
 - bitmap_parselist_user() testing enabled with the same testset as
   bitmap_parselist() (patch 6).

Patches 1 and 4 are fixes and may be applied separately.

v1: https://lkml.org/lkml/2018/12/23/50
v2: https://www.spinics.net/lists/kernel/msg3048976.html
v2 RESEND: rebased on next-20190325 and retested. 

Yury Norov (6):
  bitmap_parselist: don't calculate length of the input string
  bitmap_parselist: move non-parser logic to helpers
  bitmap_parselist: rework input string parser
  lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
  lib/test_bitmap: add testcases for bitmap_parselist
  lib/test_bitmap: add tests for bitmap_parselist_user

 lib/bitmap.c      | 294 ++++++++++++++++++++++++++++++----------------
 lib/test_bitmap.c |  67 +++++++++--
 2 files changed, 245 insertions(+), 116 deletions(-)

-- 
2.17.1

