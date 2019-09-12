Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCDBC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F36821928
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJDejJWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfILCbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:31:21 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:44685 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfILCbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:31:20 -0400
Received: by mail-yw1-f73.google.com with SMTP id n3so19677594ywh.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VTFLG8eFeKeX5rA9A/RF+SH0kKZbbcZcTGiLOknhM8o=;
        b=mJDejJWULbF2e6+PZwAkN+YGqXTd60leJIfoP5qWwNzJgFkWguAYWTXbJHoH179vfN
         MNo0gETMkGUgE9ahWgfnQnCguxv1zyWyfPQ2DrDntXMldyLa/Eo2kA3/Uq3jteAPcB55
         nTHNFlL0yZ/2vjoKxpDKIwjz1eYcjWO8Lf3MSwzODBLqcW4yQhjRRDjxezY2S4aWPYGy
         xHY7O/sD6nsAljyk2+jSMl+/UwCn8y3E9kB9WBwDIk9tP0gLmlthNDbAH9+ML/wDsIgQ
         EidIO4tIrVes2jrRn+rlnMICcIwA3NOOhfV+FnqdnFh1yhMGwgu7Mfk8vPa0cj1OJJTB
         AYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VTFLG8eFeKeX5rA9A/RF+SH0kKZbbcZcTGiLOknhM8o=;
        b=ohD0vOpzok7rmiyTL7W0urhZ1a7ocofcUZ0foyOu0rD7UaRgaf1ZbyUu9G3YB+Zppn
         eOG2ICYeT2P+DQmgMJeApIxEl3r9AhdQL3QJQ0pKbc8mN/XC1AoaK+0ziDYlD4xfgjTd
         OYFBFcQjFw/tZ99PlMPgK9cFLO8eAtaiDWFHp0+5FPSgneD3RGZD33YSrIKZaMWUERQx
         Xamw4B0HQIsd5lWDMc0wHjNTaw9AkDGM0vwuHdmlbIlBp11e5m3FckTq0oSTiKpfO0b/
         w7129pj1aOV0LkP+qbmo0iXRrmPJd6wWm+HMR7V3Us+HWspIrk4JbAtOQJFCG6EPxbok
         /7gA==
X-Gm-Message-State: APjAAAUQqVlPKI7So4/Rpm1tBMuYUkD1KZVAg8RFRgmYlOMhGxi/mMfV
        FhMr/dikpa0kHrGdUViWRsHQ/iRjVRg=
X-Google-Smtp-Source: APXvYqwFp1R2W1Gg2Sjd02Xx4oKgaWAgWIlzHHZq+eTFExQ7YKzFQaF9vo3upTYjh4PTecTa61D2xskYkN4=
X-Received: by 2002:a81:4e8d:: with SMTP id c135mr28278227ywb.149.1568255478967;
 Wed, 11 Sep 2019 19:31:18 -0700 (PDT)
Date:   Wed, 11 Sep 2019 20:31:11 -0600
In-Reply-To: <20190912023111.219636-1-yuzhao@google.com>
Message-Id: <20190912023111.219636-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20190912004401.jdemtajrspetk3fh@box> <20190912023111.219636-1-yuzhao@google.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: [PATCH v2 4/4] mm: lock slub page when listing objects
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though I have no idea what the side effect of such race would be,
apparently we want to prevent the free list from being changed
while debugging the objects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index baa60dd73942..1c9726c28f0b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4608,11 +4608,15 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 	void *p;
 	unsigned long *map;
 
+	slab_lock(page);
+
 	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects)
 		if (!test_bit(slab_index(p, s, addr), map))
 			add_location(t, s, get_track(s, p, alloc));
 	put_map(map);
+
+	slab_unlock(page);
 }
 
 static int list_locations(struct kmem_cache *s, char *buf,
-- 
2.23.0.162.g0b9fbb3734-goog

