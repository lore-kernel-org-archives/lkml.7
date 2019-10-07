Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E02DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D31217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gf1eiBRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfJGWUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:20:31 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56772 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:20:31 -0400
Received: by mail-qt1-f201.google.com with SMTP id m6so16798753qtk.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 15:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wlN9EjPdJPL0a4w0W+nF7Wogpcxb94Am0mW1KAsykOM=;
        b=gf1eiBROFqGGBLV0FzXqK9MYWbtPPBdxeGnpQjM1C66U4p86VdFxYBTz+IVfG3s5V+
         L4nb7hKYq03E3JsliAmA4/dyN6ozjOaa0RYoxfo/fFw9U0MlrRxwGu1YtzslO2zTJ/Mj
         q9T05C55NJMQN3oy93Dlhegk7j760rnimMVFSagdk+pMEFR6sGcUYLcx6pLO9+56ekY2
         acQ5SR5lXz7jLrYwWoKlFbnmK5ObS7Im/t3whYKxY1qicRLXTm+5V4h/JhloHdCkMh9s
         7qwm6Eu+Clk46L90xVZ1dlWHSaoT4iqg53z3mAGqBiurLOa1ayIooPjJdQ8XWU0um6BI
         B4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wlN9EjPdJPL0a4w0W+nF7Wogpcxb94Am0mW1KAsykOM=;
        b=c68OTRMwBVGWBtv2RizBO2wathmy0RDckvmzdx/jU48RWpIxVO2Aq3BDRz6s2r4XzJ
         eRuziW75S1mYQJW2GufoWMR3w59uShhMGFBtkavgKBau9wSTR6cfpGd1+Ft4lGBVOIhy
         yb+leHOxrVamfmyDMkdWIi35d4ikWTKwbwmiPmSaxzPujx2jyFe426Ra/tbgpqk1XQTE
         s3IJB9/ECKpa1nFZze9fBv6MyOL/dtv1Hpm1jzF7Jg1MKyxF4rj7DT8NlBRrRjXfdMiV
         erD9PqYU/5vJhpnx45AY9hKDSzhO6Pe4x9ZcKmK1xLyDucyXeF7Lz7P2wal+CdAWoaYC
         NCpQ==
X-Gm-Message-State: APjAAAUoWB8aLMWuW9M0rQqSrhqW6hI9y8yLzTlRKsvEJJBqywMlcfd3
        JtS3za8NiYYKLS0j0PyWNk9AUdlMkEU=
X-Google-Smtp-Source: APXvYqxna5U/YbHXLmtzy893qlEj+JXOevUDENdZ3H84rjZemNR7AiPksdRy1bMwRjorvUp6vdO/EIMuJaw=
X-Received: by 2002:ac8:27d9:: with SMTP id x25mr30930141qtx.321.1570486830137;
 Mon, 07 Oct 2019 15:20:30 -0700 (PDT)
Date:   Mon,  7 Oct 2019 16:20:23 -0600
Message-Id: <20191007222023.162256-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] mm: update comments in slub.c
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slub doesn't use PG_active and PG_error anymore.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 320a1c375e1b..cfbc839dc2ea 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -93,9 +93,7 @@
  * minimal so we rely on the page allocators per cpu caches for
  * fast frees and allocs.
  *
- * Overloading of page flags that are otherwise used for LRU management.
- *
- * PageActive 		The slab is frozen and exempt from list processing.
+ * page->frozen		The slab is frozen and exempt from list processing.
  * 			This means that the slab is dedicated to a purpose
  * 			such as satisfying allocations for a specific
  * 			processor. Objects may be freed in the slab while
@@ -111,7 +109,7 @@
  * 			free objects in addition to the regular freelist
  * 			that requires the slab lock.
  *
- * PageError		Slab requires special handling due to debug
+ * SLAB_DEBUG_FLAGS	Slab requires special handling due to debug
  * 			options set. This moves	slab handling out of
  * 			the fast path and disables lockless freelists.
  */
-- 
2.23.0.581.g78d2f28ef7-goog

