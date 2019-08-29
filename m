Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16E920828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h680x9OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH2Lhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:37:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfH2Lhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:37:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so273602wrv.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wi+aEk/lw/SC/EWGJj1b2gUv3dj2gmXZvpclD3XWmxM=;
        b=h680x9OGpM5D0HrHC0ResvENTHF6DUz9UMMsvEad9yRxXJxJ2pjr+CWYAeXvbwzS9F
         i9dZjIlg5bMGzRIp+RmUFAuq3/xqzNKT8g+JGxOwBjaImT7Js5daWRH3QFb2uO1pURan
         PBBc/11pFcKYs2TkLApCthIChjZPDNk/z3gY1yYOvFvHlM9pBbMRY38KbcX1Qa99R+7k
         h7rHySUJcocyvK0Nd9HjME9/RLiaBVF4GxeE++2aMudRkgxh3IZHl7etfEqX2jwcpddC
         D9O4/+K/j4RqzGO4qnq2nC2S7jM111uS5TsSe4CYwsm7T/b8VDjJ6gfhH2VYU9WP+m2x
         YHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wi+aEk/lw/SC/EWGJj1b2gUv3dj2gmXZvpclD3XWmxM=;
        b=G4rbtuCaVkFcRua9I10Qx6AuRCfxnMpCIIE5RkfOJ6eS0QgyrKE+NjMjgaXYWEQW7m
         wvvyNWV43Gq2E0QcT4D/6sFnEc6BUE8USxPVpNZ6p7UVI9sKCaXVxGWhMEoE2w8gdW86
         gCtYIP4aYxdHgEWXkeAMgGL4a9CzSoFJ1L+xUkbzOY7AGfuJYQ+peNJu7ovCxXdHltuL
         11OMZPr+d6tp5axRzoQtgaBSfSW1GKlz/JUYPGIgr4oD6PDmYmwMqb0AUNbpjTfGg2/a
         MMUXgdXyxWphwD+3C7nEdF7zzOm3FlfisVDwkRs2kSWYP6bmVtghJGRDoYfV3kUs0X7g
         UgyQ==
X-Gm-Message-State: APjAAAX5s7Wkwt2rrdOAwxtNEQkAtRFUL1PccTNvDPZPqx7/Iz96cVNp
        BzTiw6ZnM6FIsYpBTEJ1KTdGJOPKlBEe9jC5ouw=
X-Google-Smtp-Source: APXvYqwp0esAayMYR7QeT6qJZa7H6Kht3QsdHVcep8OrxN4J+qQh8oblAaUjk/f/vf9Wep6v/haceClU1LQfsday0ko=
X-Received: by 2002:a5d:4a11:: with SMTP id m17mr675507wrq.40.1567078653582;
 Thu, 29 Aug 2019 04:37:33 -0700 (PDT)
MIME-Version: 1.0
From:   zhigang lu <luzhigang001@gmail.com>
Date:   Thu, 29 Aug 2019 19:37:22 +0800
Message-ID: <CABNBeK+6C9ToJcjhGBJQm5dDaddA0USOoRFmRckZ27PhLGUfQg@mail.gmail.com>
Subject: [PATCH] mm/hugetlb: avoid looping to the same hugepage if !pages and !vmas
To:     mike.kravetz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tonnylu@tencent.com, hzhongzhang@tencent.com,
        knightzhang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhigang Lu <tonnylu@tencent.com>

This change greatly decrease the time of mmaping a file in hugetlbfs.
With MAP_POPULATE flag, it takes about 50 milliseconds to mmap a
existing 128GB file in hugetlbfs. With this change, it takes less
then 1 millisecond.

Signed-off-by: Zhigang Lu <tonnylu@tencent.com>
Reviewed-by: Haozhong Zhang <hzhongzhang@tencent.com>
Reviewed-by: Zongming Zhang <knightzhang@tencent.com>
---
 mm/hugetlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6d7296d..2df941a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4391,6 +4391,17 @@ long follow_hugetlb_page(struct mm_struct *mm,
struct vm_area_struct *vma,
  break;
  }
  }
+
+ if (!pages && !vmas && !pfn_offset &&
+     (vaddr + huge_page_size(h) < vma->vm_end) &&
+     (remainder >= pages_per_huge_page(h))) {
+ vaddr += huge_page_size(h);
+ remainder -= pages_per_huge_page(h);
+ i += pages_per_huge_page(h);
+ spin_unlock(ptl);
+ continue;
+ }
+
 same_page:
  if (pages) {
  pages[i] = mem_map_offset(page, pfn_offset);
-- 
1.8.3.1
