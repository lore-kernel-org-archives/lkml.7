Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D1FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433E820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaVs/v49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDHT7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:59:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42699 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:59:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id w25so6792168pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RSStTgCMJwvCqECwFlnDBhxtF8I569p9e6PuxiQP1oM=;
        b=IaVs/v49W9F4RB08+llfR3LzCZzsnZdb9KI01bTePyyBQrFAkbpQgsu5FDJDr4nZ/m
         YA6tTLHgZuvBGyWo/ywVHmrLflS/IVvDlnqE04G9JZQ6H5X7Xn+Co+j/3YHc5dB4U07s
         hbx3CzJxJZajypW7gQfNirQWke+RqbuAZFyNwtCXf8XQqi4eOU+ydwDNX5yNZ0pO+7N5
         GmmBYlJvxnFG59cHiMFKUAf6KwMbkN173hB3GNxcqSoZtnqFuDaGFZTSblrnWbNsLT/W
         kMw1dwylomWuocQ2hW4ZhH1yohtb86UkZvXeLQtvEK96NHD+YFp2Wh06ZkCcU3MSMPt2
         H3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RSStTgCMJwvCqECwFlnDBhxtF8I569p9e6PuxiQP1oM=;
        b=f/UU+1pXBr8t88+seRcgkVV4DQu/IP7AGVEFYKwrHPMH6I8TFR7mF8ndbGzivhB2Ug
         0r75RHqag8VsgeLofoOY/JDROShTjKJ3txPpV9RkgciA0ZNGeqtSiKG3PX0yOpfIwe/j
         O2IJLdxNEh6q+B5fohkuwnYJUCWy/dG4Ll6bDUrOdjEvmP/fyIhFOFUGjeXkj7NkwDcL
         mh1qr/oYZ5oZk64HVdNvQG8yIWAkrBKEt+EaJ5lNQGdKcnLl3ujphTjCKU6OmW72X849
         HiybvmoIlpJMIWBrJ29jnKrnqBy0rH+Ze5Yfeykm1DtVHKvFyGPXXvaQl3GBht6reEyb
         GGiQ==
X-Gm-Message-State: APjAAAX4HmFIFPgZTcyHtORzewdqEUALTHGBGM3ftlS+pvIsMO9MxwXs
        FCqRYj8nF2TfCI0LHKlAIIowdw==
X-Google-Smtp-Source: APXvYqzfmpdTWEuDsxZC2Dtn2LoyYq29oaMJey0FNJtIvQ4jPQhwzXYeWniqDVNGM3maON9MarpjjA==
X-Received: by 2002:a65:5383:: with SMTP id x3mr12785290pgq.60.1554753574808;
        Mon, 08 Apr 2019 12:59:34 -0700 (PDT)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id j16sm41059643pfi.58.2019.04.08.12.59.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 12:59:33 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:59:32 -0700 (PDT)
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
Subject: [PATCH 3/4] mm: swapoff: take notice of completion sooner
In-Reply-To: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
Message-ID: <alpine.LSU.2.11.1904081258200.1523@eggly.anvils>
References: <alpine.LSU.2.11.1904081249370.1523@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old try_to_unuse() implementation was driven by find_next_to_unuse(),
which terminated as soon as all the swap had been freed.  Add inuse_pages
checks now (alongside signal_pending()) to stop scanning mms and swap_map
once finished.  The same ought to be done in shmem_unuse() too, but never
was before, and needs a different interface: so leave it as is for now.

Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/swapfile.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

--- 5.1-rc4/mm/swapfile.c	2019-04-07 19:15:01.269054187 -0700
+++ linux/mm/swapfile.c	2019-04-07 19:17:13.291957539 -0700
@@ -2051,11 +2051,9 @@ retry:
 
 	spin_lock(&mmlist_lock);
 	p = &init_mm.mmlist;
-	while ((p = p->next) != &init_mm.mmlist) {
-		if (signal_pending(current)) {
-			retval = -EINTR;
-			break;
-		}
+	while (si->inuse_pages &&
+	       !signal_pending(current) &&
+	       (p = p->next) != &init_mm.mmlist) {
 
 		mm = list_entry(p, struct mm_struct, mmlist);
 		if (!mmget_not_zero(mm))
@@ -2082,7 +2080,9 @@ retry:
 	mmput(prev_mm);
 
 	i = 0;
-	while ((i = find_next_to_unuse(si, i, frontswap)) != 0) {
+	while (si->inuse_pages &&
+	       !signal_pending(current) &&
+	       (i = find_next_to_unuse(si, i, frontswap)) != 0) {
 
 		entry = swp_entry(type, i);
 		page = find_get_page(swap_address_space(entry), i);
@@ -2123,8 +2123,11 @@ retry:
 	 * separate lists, and wait for those lists to be emptied; but it's
 	 * easier and more robust (though cpu-intensive) just to keep retrying.
 	 */
-	if (si->inuse_pages)
-		goto retry;
+	if (si->inuse_pages) {
+		if (!signal_pending(current))
+			goto retry;
+		retval = -EINTR;
+	}
 out:
 	return (retval == FRONTSWAP_PAGES_UNUSED) ? 0 : retval;
 }
