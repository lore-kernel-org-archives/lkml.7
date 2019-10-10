Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C412FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570745474;
	bh=fzEcT7YIFyV9quh3KUI7NWGGSvDt1jmwq0LovhO5hRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JLaii9sez8n4V4ABsdWc0/6JBcqbhvb3yUi/cJM6MvXZNcYbjiRhE81W+I0+ayq19
	 QouhNyVifhnoLHqbx2eIQTAGOx104xHtu8Fddd9rVQ3MF6dqgOhk8djqc9TULJu3kF
	 JVntzw1RlEZLEjqAguMfGFrbDxy1SmgX4c+WNFWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfJJWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:11:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40435 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfJJWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:11:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so4780989pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qADNUvS+wZZ6b+j5JoGWu2BAJFTWzwEv5YCmhezwwyw=;
        b=fVwJWfw/rBVm5lRe9ccZX00npdQe8P/eERP1qH9jIUfFRV9oW07CqNO0fDap1OVIoP
         WouVMv3TJTuIbIP9fmP6SwNo/gEEWkPQP/qNmJmIJc0tmWFzCLIS/yF5oB2fZcTzmvMo
         J3vi1oQT3dnPW73HGUIiwpMQJKZwEQ/I5UulEVNRWTj7qYuRFs6kO6Y660sUnVGPm+o+
         bbl7OMCk8dWD0nHP/K9lhAoZzCTc7LlYLH+pUxYyFN3TRrGTZ2ZnQqDb8cJAplpF4kM6
         v2b4EnNNO6cT/KkxagyotDRQ0SdJmJYxmMHKxN2MQuBNZGhvnmNxBKPx16jcYVxD7+Yr
         1w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qADNUvS+wZZ6b+j5JoGWu2BAJFTWzwEv5YCmhezwwyw=;
        b=ZuUG8rjUxttCp5hqIKMlJTLv2SEuJV+NH5HNn6pUeIlI++HC8xrPLtNLcLqpHRoqQH
         UsZ/cnwoq7wLDu2NhM5I1Wr3B25flGi/I0HMTz0A1CjHueN8ZBS5KAnIcfjjiJUX4CvC
         gpYCx3TdPbyP4kPvY6G2yWeMK0Bv0orR4SKIcGGL5kxR8H+IqGIpYH5wXRJIlyf1ZgLq
         GR7ujow6ONkpTkIfbIeHa6qMMfdwIzOPWxO6G8jC1v9N6IbkEFvl6rQ/lv+T7hd6vm3n
         vn2UwrZWWrlxEdrznDzep36z+C9mqkV3BztnixHfrQ0LQXd6TtQG3pTunFn1L+yDrVf0
         93Dw==
X-Gm-Message-State: APjAAAXRTF1fNa/DOyqOrQk33st2rs8Mr+eWF3NWx5lxFgVZd/rSmOzv
        Y0I6Otj6vq/L6kRenQYPdtc=
X-Google-Smtp-Source: APXvYqzop87ZTzzB99HjTwcbSSciQldMFCBfalaSatXuR5YGQPv2TAzUEKonTsc4F+9asgcVJLdhDQ==
X-Received: by 2002:a65:4bc2:: with SMTP id p2mr13345227pgr.177.1570745468371;
        Thu, 10 Oct 2019 15:11:08 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id f12sm5793353pgo.85.2019.10.10.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:11:06 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:11:05 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sahkeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] mm: annotate refault stalls from swap_readpage
Message-ID: <20191010221105.GA115307@google.com>
References: <20191010152134.38545-1-minchan@kernel.org>
 <20191010191747.GA31673@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010191747.GA31673@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:17:47PM -0400, Johannes Weiner wrote:
> On Thu, Oct 10, 2019 at 08:21:34AM -0700, Minchan Kim wrote:
> > From: Minchan Kim <minchan@google.com>
> > 
> > If block device supports rw_page operation, it doesn't submit bio
> > so annotation in submit_bio for refault stall doesn't work.
> > It happens with zram in android, especially swap read path which
> > could consume CPU cycle for decompress. It is also a problem for
> > zswap which uses frontswap.
> > 
> > Annotate swap_readpage() to account the synchronous IO overhead
> > to prevent underreport memory pressure.
> > 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Minchan Kim <minchan@google.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks, Johannes!

> 
> Can you please add a comment to the caller? Lifted from submit_bio():

Sure, I added a little about zram.

> 
> 	/*
> 	 * Count submission time as memory stall. When the device is
> 	 * congested, or the submitting cgroup IO-throttled,
> 	 * submission can be a significant part of overall IO time.
> 	 */


From a8ae7cbc2d3f050aca810fd68285d45cb933b825 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@google.com>
Date: Thu, 10 Oct 2019 08:09:06 -0700
Subject: [PATCH v2] mm: annotate refault stalls from swap_readpage

If block device supports rw_page operation, it doesn't submit bio
so annotation in submit_bio for refault stall doesn't work.
It happens with zram in android, especially swap read path which
could consume CPU cycle for decompress. It is also a problem for
zswap which uses frontswap.

Annotate swap_readpage() to account the synchronous IO overhead
to prevent underreport memory pressure.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/page_io.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600f9131..18f1f8e1d27f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -22,6 +22,7 @@
 #include <linux/writeback.h>
 #include <linux/frontswap.h>
 #include <linux/blkdev.h>
+#include <linux/psi.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 #include <asm/pgtable.h>
@@ -354,10 +355,20 @@ int swap_readpage(struct page *page, bool synchronous)
 	struct swap_info_struct *sis = page_swap_info(page);
 	blk_qc_t qc;
 	struct gendisk *disk;
+	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageUptodate(page), page);
+
+	/*
+	 * Count submission time as memory stall. When the device is
+	 * congested, the submitting cgroup IO-throttled, or backing
+	 * device works synchronously(e.g., zram), submission can be
+	 * a significant part of overall IO time.
+	 */
+	psi_memstall_enter(&pflags);
+
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
 		unlock_page(page);
@@ -371,7 +382,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		ret = mapping->a_ops->readpage(swap_file, page);
 		if (!ret)
 			count_vm_event(PSWPIN);
-		return ret;
+		goto out;
 	}
 
 	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
@@ -382,7 +393,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		}
 
 		count_vm_event(PSWPIN);
-		return 0;
+		goto out;
 	}
 
 	ret = 0;
@@ -418,6 +429,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_put(bio);
 
 out:
+	psi_memstall_leave(&pflags);
 	return ret;
 }
 
-- 
2.23.0.581.g78d2f28ef7-goog

