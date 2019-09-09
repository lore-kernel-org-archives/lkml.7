Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B479C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237BD21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 06:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjx4Ou4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfIIGK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:10:26 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:49140 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfIIGK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 02:10:26 -0400
Received: by mail-vs1-f74.google.com with SMTP id h11so2266058vsj.15
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HBimVA7RGAjl4KbkiJUf9oeSQmHtfBwPI4wgakS4OGg=;
        b=jjx4Ou4H+n3dL6wX5DopdQ6gsDiO5Pt20ywBnO+jQcvRKLntZT3+m/DNjc48s7NnKq
         IfxwwtYzCEkuzk6P7grI9QbTj8DNDgCDEtUIKrufeBKOs7ORlkQDKP1Z84d3EM8HVbC+
         aUpk0yZ09r0wEOdB9uF1Ni5562PujB7fFXioy8EtL9Z+9UpsFIoqedQvz1dS3MmJUraE
         8nkQuqd82JBoZ1dnH7VBJ4Lnipaw//+8EHMDw7vvGYq5yJNI/2a5kUuclXV/12MALszQ
         sOCGqSLbhMAupAvtcdO8zFhotp33LzDbVoJV4ewJI7NmdU7gUFsfkjroKbjO69K+aJ7D
         1V+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HBimVA7RGAjl4KbkiJUf9oeSQmHtfBwPI4wgakS4OGg=;
        b=nZhyAItj+lqiBIvpnfNKZ3QdjYB+vyFNB5IZNKtu837a0vRI1BrVysQqb1gX3+sU9M
         XPy97KguQ19IyN9xgKqz1/g09JoR9J+VgEZvWskIPQ5hZYtzU59aWHimFvi5Ks8k7eVA
         PJAc6Z9pVpPNlkUO7FFlvdRWpXiBQa2ItZSUFzor+5eoMIHWtlatV2W4MsmNBr/Skv4+
         iXc1rRUwnsYFhF2+wbEcAC6A/MMAcAclY74qATzlgGqoIzbZLX/ej0i/O4r3CJg8PnbO
         wb3P8OegdNj2WjUxxcGN/EqR1uhDuEHsrLZEg01jZh/iaV/qIXgYUQllh8q1yPzSFvYq
         K9yw==
X-Gm-Message-State: APjAAAUL8XsoYYsq9RPpUxvt9X/eA6N7kQZVf1UBdszhY97n9kB6nPGQ
        tC56Ri9FSgeVlxPxAKUhYv+aRfK2TNA=
X-Google-Smtp-Source: APXvYqxF/OVFaAI692aefwVIYjWorhp0G4V6pek3jNvuhrx3bB9EhyLN8VZ+oIxefHKqp7yjq0PX2SF1+44=
X-Received: by 2002:ab0:20a6:: with SMTP id y6mr5661920ual.119.1568009424530;
 Sun, 08 Sep 2019 23:10:24 -0700 (PDT)
Date:   Mon,  9 Sep 2019 00:10:16 -0600
Message-Id: <20190909061016.173927-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] mm: avoid slub allocation while holding list_lock
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are already under list_lock, don't call kmalloc(). Otherwise we
will run into deadlock because kmalloc() also tries to grab the same
lock.

Instead, allocate pages directly. Given currently page->objects has
15 bits, we only need 1 page. We may waste some memory but we only do
so when slub debug is on.

  WARNING: possible recursive locking detected
  --------------------------------------------
  mount-encrypted/4921 is trying to acquire lock:
  (&(&n->list_lock)->rlock){-.-.}, at: ___slab_alloc+0x104/0x437

  but task is already holding lock:
  (&(&n->list_lock)->rlock){-.-.}, at: __kmem_cache_shutdown+0x81/0x3cb

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&(&n->list_lock)->rlock);
    lock(&(&n->list_lock)->rlock);

   *** DEADLOCK ***

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/slub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8834563cdb4b..574a53ee31e1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3683,7 +3683,11 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = page_address(page);
 	void *p;
-	unsigned long *map = bitmap_zalloc(page->objects, GFP_ATOMIC);
+	int order;
+	unsigned long *map;
+
+	order = get_order(DIV_ROUND_UP(page->objects, BITS_PER_BYTE));
+	map = (void *)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
 	if (!map)
 		return;
 	slab_err(s, page, text, s->name);
@@ -3698,7 +3702,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 		}
 	}
 	slab_unlock(page);
-	bitmap_free(map);
+	free_pages((unsigned long)map, order);
 #endif
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

