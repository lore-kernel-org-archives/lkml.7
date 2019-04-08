Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C93C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B3120880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMkTDxs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDHT4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:56:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41612 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDHT4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:56:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 188so8231974pfd.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=E+yVjhVz7hUuMuUS71zV31X7NgehVdKX9ZgoshuaFks=;
        b=AMkTDxs1LHsHlchUXT3nGVvExN68Rr2G6ioVk0vWn79VfbBGuSrXUKd0aMLgaapNL1
         v2UgpFjkjxIgHdLsqbOBzBU50FtFFja71QzwlDk7EijQZPac6FpLeM3eb7tfVnxSegBt
         UZJMawK98mMNgFOw76z8wQ3XeaqLIIGjxMwYxN4YRuGV1chNg7vvVra6khsBGAPMng0V
         Jq8ABXsISFdSvxCqsySwOBNubuEm8b3l4OGlUgUt7PiXncdwGtTGxaYiYY01N3rhpQHk
         Bkl4UDP+Pzn3WTQVSemDaW9Wv3kiln6EvB8xyIVnVNjQJcpXPzpK21u7vZCAkMWruZHu
         /HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=E+yVjhVz7hUuMuUS71zV31X7NgehVdKX9ZgoshuaFks=;
        b=B4bjONJdzjRl4CJE6cFvKvYzRDjWazaMnza9gyW4dDEGGEfsvCwPHh78IT3j2HNepE
         oALBYKh+bidmvurvUTWRWBEEHpwMyhxabhlz/N8zrtHxBsZLbVebiI3ssEMG+FmMx1qS
         CY+aQ/c4qxlQVxwPOgzJ3CqwHtgTGa/GhOflIVAORSjQ4B8Q3Oae5CJrT9A2wc0zst1u
         bUCDNyOvr46ZFE0/z6n6srBKBmtqTVmplBy4wWp3YF3hfGTrFHPI8gvMcpLg39YZj9uY
         UlUAoFNZj+AAlA+xoAUediRxGBiSMpQOUEXPdtU0199sB5TZ88om4qGcnWY4C9VjPZIv
         rjag==
X-Gm-Message-State: APjAAAUfkOBp0VEn3RYrMkhsu8Y3mTIe33Ov6YlL6qIz4FgyU85JlAQE
        fuiEHo+BkC6vqCFatYwSD+ELxA==
X-Google-Smtp-Source: APXvYqyr6Nw2aE69+Sv05HhyzHpd5PPgyTc/AzcorrzgRuqd+2YHFvCQexJLbjXUeRLfMimlQ5muiQ==
X-Received: by 2002:a62:4e86:: with SMTP id c128mr31870152pfb.39.1554753373844;
        Mon, 08 Apr 2019 12:56:13 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id j16sm41054868pfi.58.2019.04.08.12.56.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 12:56:13 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:56:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/4] mm: swapoff: shmem_find_swap_entries() filter out other
 types
In-Reply-To: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1904081254470.1523@eggly.anvils>
References: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swapfile "type" was passed all the way down to shmem_unuse_inode(), but
then forgotten from shmem_find_swap_entries(): with the result that
removing one swapfile would try to free up all the swap from shmem - no
problem when only one swapfile anyway, but counter-productive when more,
causing swapoff to be unnecessarily OOM-killed when it should succeed.

Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- 5.1-rc4/mm/shmem.c	2019-03-17 16:18:15.701823872 -0700
+++ linux/mm/shmem.c	2019-04-07 19:12:23.603858531 -0700
@@ -1099,10 +1099,11 @@ extern struct swap_info_struct *swap_inf
 static int shmem_find_swap_entries(struct address_space *mapping,
 				   pgoff_t start, unsigned int nr_entries,
 				   struct page **entries, pgoff_t *indices,
-				   bool frontswap)
+				   unsigned int type, bool frontswap)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
+	swp_entry_t entry;
 	unsigned int ret = 0;
 
 	if (!nr_entries)
@@ -1116,13 +1117,12 @@ static int shmem_find_swap_entries(struc
 		if (!xa_is_value(page))
 			continue;
 
-		if (frontswap) {
-			swp_entry_t entry = radix_to_swp_entry(page);
-
-			if (!frontswap_test(swap_info[swp_type(entry)],
-					    swp_offset(entry)))
-				continue;
-		}
+		entry = radix_to_swp_entry(page);
+		if (swp_type(entry) != type)
+			continue;
+		if (frontswap &&
+		    !frontswap_test(swap_info[type], swp_offset(entry)))
+			continue;
 
 		indices[ret] = xas.xa_index;
 		entries[ret] = page;
@@ -1194,7 +1194,7 @@ static int shmem_unuse_inode(struct inod
 
 		pvec.nr = shmem_find_swap_entries(mapping, start, nr_entries,
 						  pvec.pages, indices,
-						  frontswap);
+						  type, frontswap);
 		if (pvec.nr == 0) {
 			ret = 0;
 			break;
