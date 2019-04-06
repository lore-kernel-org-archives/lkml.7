Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3595C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 05:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB1521855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 05:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzdkRPNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDFF7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 01:59:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35281 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFF7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 01:59:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id d8so4756280vsp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 22:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uLtgzl+y47IAFLBMiAJzXtmdzwQQQv6bFkF049bGo8Q=;
        b=XzdkRPNxN+E5x7cMA147ngi9PqZF1Uulpanlf8yImKQjWpEefMF/L3UhwvU79Zhyf3
         Cu6yM8QemSeOF3qjWl+fctVrVwo1VHt/XtLMUUlJIdATsTQgmQhQDbye5HdROlrw41oj
         pdw2W4+rvE4xd3uXdVhH1OAKh1XfEtTtrh6CDQQw4qJ7L7I4It+rrnKTrvXC/ZNH7m0J
         UUlzRAo1/zEA7hKwMCEWN6t670kPKS6Wu12VTeLtSkaVUyUH4kCTzPVZuMXC9jie3uOD
         JZnAVzT7KyNrCS6zUEN5BltudarfyIWHCZeEo8L34OzjJzZQbLtkexTW0oH56hS+nf29
         A5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uLtgzl+y47IAFLBMiAJzXtmdzwQQQv6bFkF049bGo8Q=;
        b=IWYmDSDp5n36ez4sbriEaO955X8+uOYx2aDjYjrZyi9shK2aPtVI3AiHf0fmscz+dL
         RCOlQ65evnoqCMtgobKtt0g9COc/APZJDcGB7/QHH3hpRTugypX4wojr35wRjc4MdVYI
         FdG1rPnDZRPpxOJu3jDJ5y+RyEdiakthJ9LdXGeKzuuyJGH+I8XYnIfv++Ab0qmnx0Sj
         SUvaN2v65f6HDfwMU3/uAK4Wlqvd+vjNnK+H3FAhlO7RaPIlv7bC3KLe02kowFanX3pc
         HwjFoPNMBmnO2fTZBWGo3V/j6FRr6Ctz2ILswqBKju+eJc+MHRV+IjVcm5lJZ/ymoBnL
         ijZQ==
X-Gm-Message-State: APjAAAUIqxNbp0V9Ac5aoXNfDzNE/ByAQXd8rLWl0EGf27KVFSZnvWW+
        42SdsydflZY718bJAptWgqIg6LFiOgt6dq7qia7DRbtl+8U=
X-Google-Smtp-Source: APXvYqy4UKsunqxI/fOpkTdAf8nulfxruUmZd2oXxfHy79RjFPK3mjgLdImOcFpEPP4V3Z1y7Dg04kwZfrCS0jpr630=
X-Received: by 2002:a67:f582:: with SMTP id i2mr11133517vso.33.1554530371758;
 Fri, 05 Apr 2019 22:59:31 -0700 (PDT)
MIME-Version: 1.0
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Sat, 6 Apr 2019 11:29:27 +0530
Message-ID: <CACDBo57pEVRjOBf0yLMQ+KuGPeOuFcMufGVzjPJVnwfLFjzFSA@mail.gmail.com>
Subject: vmscan.c: Reclaim unevictable pages.
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernelnewbies@kernelnewbies.org, vbabka@suse.cz, mhocko@kernel.org,
        minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

shrink_page_list() returns , number of pages reclaimed, when pages is
unevictable it returns VM_BUG_ON_PAGE(PageLRU(page) ||
PageUnevicatble(page),page);

We can add the unevictable pages in reclaim list in
shrink_page_list(), return total number of reclaim pages including
unevictable pages, let the caller handle unevictable pages.

I think the problem is shrink_page_list is awkard. If page is
unevictable it goto activate_locked->keep_locked->keep lables, keep
lable list_add the unevictable pages and throw the VM_BUG instead of
passing it to caller while it relies on caller for
non-reclaimed-non-unevictable  page's putback.
I think we can make it consistent so that shrink_page_list could
return non-reclaimed pages via page_list and caller can handle it. As
an advance, it could try to migrate mlocked pages without retrial.


Below is the issue i observed of CMA_ALLOC of large size buffer :
(Kernel version - 4.14.65 With Android Pie.

[   24.718792] page dumped because: VM_BUG_ON_PAGE(PageLRU(page) ||
PageUnevictable(page))
[   24.726949] page->mem_cgroup:bd008c00
[   24.730693] ------------[ cut here ]------------
[   24.735304] kernel BUG at mm/vmscan.c:1350!
[   24.739478] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM


Below is the patch which solved this issue :

diff --git a/mm/vmscan.c b/mm/vmscan.c
index be56e2e..12ac353 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -998,7 +998,7 @@ static unsigned long shrink_page_list(struct
list_head *page_list,
                sc->nr_scanned++;

                if (unlikely(!page_evictable(page)))
-                       goto activate_locked;
+                      goto cull_mlocked;

                if (!sc->may_unmap && page_mapped(page))
                        goto keep_locked;
@@ -1331,7 +1331,12 @@ static unsigned long shrink_page_list(struct
list_head *page_list,
                } else
                        list_add(&page->lru, &free_pages);
                continue;
-
+cull_mlocked:
+                if (PageSwapCache(page))
+                        try_to_free_swap(page);
+                unlock_page(page);
+                list_add(&page->lru, &ret_pages);
+                continue;
 activate_locked:
                /* Not a candidate for swapping, so reclaim swap space. */
                if (PageSwapCache(page) && (mem_cgroup_swap_full(page) ||




It fixes the below issue.

1. Large size buffer allocation using cma_alloc successful with
unevictable pages.

cma_alloc of current kernel will fail due to unevictable page

Please let me know if anything i am missing.

Regards,
Pankaj
