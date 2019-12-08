Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96FC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D2620663
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8LjnoaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLHSfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:35:20 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55529 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfLHSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:35:19 -0500
Received: by mail-pg1-f201.google.com with SMTP id v30so7180694pga.22
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ixWIA9Xc+ETFQTzqRrRYkwHRDWzy5HKinpXuACLsz9s=;
        b=X8LjnoaR7GpaoOPBGLL4k3WuIlrf8FLlHQkZ9XafcLIvGj8BeyML+sx8jG7mBCR2oH
         /UV9k8l9nffa3wGxrpHvPgyE8/wQrUm/0pAlDXHmHhLlyxwCZ3mYSypOmqYLPV8w7K3j
         MRSkdR7QZ7VfwYpbHPgQyBi01pcdVbZjuhmWVp2x1zkXo0YOTh04wkF7wP0vBtzXqJ0X
         YE8hDo5nt7ortxZQJZS8crVJXU8h+NKeG3hjaKC2NxPH7ORoglXxXmuxRhIGE8p+bRtF
         iUAvRJXgy1MX4mxbgiYbXhcssEYmrobZXdY7fo4MPxo/kry/W7qje7lDx46zUofdTIuS
         3BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ixWIA9Xc+ETFQTzqRrRYkwHRDWzy5HKinpXuACLsz9s=;
        b=uO8PGKycZ7SgncIVIih0bs6FGLi9Do1uvcouTz9z8j2b7u2AfTTJKhSuEEcVymItIq
         1/IazymNQDpF0KHqh5M/IP9D8BYvhvCQ1lxhwCgkXkVo4aRjYbGp2ImEQMTsJcc6PhOs
         7sFqTxsWYHTtie5UnZgB+44CtA6FV9Ng+wEvtItMzwyJ9cmyPebZyFbyk0ATmGBGbMn0
         3rCmkGEXIplQd4P+UtsW+h2sMPJTYhg0g5SYQjOeXC0tFU8z5od2i9n3i5cpvrpM7BhI
         ZLkWlYcOzEa/HxzL8BlZhqvR6qKfT4p3T/QNUjso4/OuukH4kcAozn8eI7zGZ0GnW0xS
         hihA==
X-Gm-Message-State: APjAAAUlfFPIHM9rQ36uFyTFbD3HSPfgoDMFRp0kjgUhlUA/Vpscrwid
        vDYM0+WZTLAQqVZ4cjXewoB4pkcCwmI=
X-Google-Smtp-Source: APXvYqxJDXiMqtoqT89fWhET1T4Uha1d/oTBLwOyi1Od4C660mnuOKD/jnEMMYHWk8RdBuDq/Y/d37eF1/E=
X-Received: by 2002:a63:3756:: with SMTP id g22mr14745071pgn.375.1575830118968;
 Sun, 08 Dec 2019 10:35:18 -0800 (PST)
Date:   Sun,  8 Dec 2019 11:35:07 -0700
Message-Id: <20191208183508.89177-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH] mm: clean up obsolete check on space in page->flags
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check in linux/mm.h was intended to make sure we don't overrun
page flags. But it's obsolete because it doesn't include
LAST_CPUPID_WIDTH nor KASAN_TAG_WIDTH.

Just remove check since we already have it covered in
linux/page-flags-layout.h (near the end of the file).

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c97ea3b694e6..2e7596cce9d8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -921,10 +921,6 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 
 #define ZONEID_PGSHIFT		(ZONEID_PGOFF * (ZONEID_SHIFT != 0))
 
-#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
-#error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > BITS_PER_LONG - NR_PAGEFLAGS
-#endif
-
 #define ZONES_MASK		((1UL << ZONES_WIDTH) - 1)
 #define NODES_MASK		((1UL << NODES_WIDTH) - 1)
 #define SECTIONS_MASK		((1UL << SECTIONS_WIDTH) - 1)
-- 
2.24.0.393.g34dc348eaf-goog

