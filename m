Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB57C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5411320651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/bmPI9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfDERcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:32:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40434 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbfDERcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:32:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id c207so3646416pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LDVqGk/pc13nypN9YNFIYr7uKQtUql3bFvdCx7UN2Ho=;
        b=R/bmPI9eEe6UquyMT61v1eb+EG7JyUHRtAFWfMnZMvSNIo3HTgAsSXpCcCeVFtk1P2
         nX3LRMPlcCqEzVvTknYphWQbliUwy/urMXEnkbdawFlh+3LTZhNNPl9Yvb8ndCygs3yq
         24yfHzv5ZUiTdCDSkci9huYb4z7iyx9BcI3Ox9uHSSrETe+J1xPbxytcDruBgq+hWGre
         G3UgPNqY5n5q+th4T8OGwVjF9aVCWSIHMN+6qnQrFjW0KeAmE06XiqU6C5QK6WtIPpGl
         nzYdSTYe7mEVgTVP9R2pPjvn3paA3c+73Gmwl4umIBfOKd4dYiqtVBeO5dIQPf2RfiOU
         NOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LDVqGk/pc13nypN9YNFIYr7uKQtUql3bFvdCx7UN2Ho=;
        b=ZqV1n/ekjo9zWR2czbrT+Ue0ZQU3N5Iovh0kGRH5A2L9fM8Llx6vheNiXKM7M0gO/y
         WxtVqRyRiM7iNFmS+2XELQo24lnFPskGxs2BZ/9VnDrixkukA31xBPwIH/GSdiejT7nu
         lClCyoInhhheKmcR5fJm5wZZuhkhsZBRysfs8e+5WNE5Mpn5xtC2rir43rWQCo/Zckmv
         NSpIP0B2SNHUizhSOD0fbXNQS8pDgxIjal+Y7G8h+eS3NzwU5OJkzLye9YhQs3feibXq
         YVGkzt21PQaPcFUGQZUTvvrrXkss3hIszUjRd1yeMZMFcIIOm7iEIwKZ1gGGk0PQBRDn
         MyUw==
X-Gm-Message-State: APjAAAVhC23/Sld/F440EgE64bHVjoWRld+f9IutV3I4aFHoLVnPdOqb
        vxJs6qXSc2LAxpwXRHzoREA=
X-Google-Smtp-Source: APXvYqyDjuKIZSkKMGQQDppoF1DFRex9idrSKCFxIRzvRCjKDBilTITWDyW3HXnS1sktrdwRRdQO4Q==
X-Received: by 2002:a63:2ec6:: with SMTP id u189mr13773525pgu.170.1554485535863;
        Fri, 05 Apr 2019 10:32:15 -0700 (PDT)
Received: from localhost ([169.229.22.206])
        by smtp.gmail.com with ESMTPSA id o67sm38236888pga.55.2019.04.05.10.32.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 10:32:14 -0700 (PDT)
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
Subject: [PATCH v4 0/5] lib: rework bitmap_parselist and tests
Date:   Fri,  5 Apr 2019 20:32:06 +0300
Message-Id: <20190405173211.11373-1-ynorov@marvell.com>
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
v4: - use handy memdup_user_nul() instead of copy_from_user() in patch 1;
    - comments indentation fixed.


Yury Norov (5):
  lib: make bitmap_parselist_user() a wrapper on bitmap_parselist()
  lib: rework bitmap_parselist
  lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
  lib/test_bitmap: add testcases for bitmap_parselist
  lib/test_bitmap: add tests for bitmap_parselist_user

 lib/bitmap.c      | 277 ++++++++++++++++++++++++++--------------------
 lib/test_bitmap.c |  67 ++++++++---
 2 files changed, 210 insertions(+), 134 deletions(-)

-- 
2.17.1

