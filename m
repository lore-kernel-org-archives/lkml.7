Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E61CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32F322387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="izWsAZA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfGXP3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:29:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33536 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfGXP3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:29:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so34085787qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQgoJCOESUlvwXLcS69GZd2oa8cw/eE9Wf5RFGROicg=;
        b=izWsAZA0azHmT9wRTbZAVFkqltklhgK1UgHBibwTNSCB9pHei/HARUxzgpAHeSsF/m
         itikD62Pekx0tFI05uHx0UexdgM3+2L65YLZbdB3q01eP7qN18RmfyzsdCsI0TPzA3oD
         8ikRmLbTHiDJODjJai0FM1VuxVkY2EgIQfSipHga+ACdQtczcEarab/NzStLpifIsZfZ
         VoGG4wt3FGsiYOjgZTDrKKE6P73J1yB4htRMrmvGuJR1ctzcx6R3GSgAbbdiBJUcwm19
         kNlyIaCcj1zkdx4nEJCzUKeRvaaGSaXI+TTwtbO8k1V/yineDlWhFJ50b1KGWD6jna0h
         DULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQgoJCOESUlvwXLcS69GZd2oa8cw/eE9Wf5RFGROicg=;
        b=mbsjlH6FtP/LcobXGhFVr2tfTMEC4qC4rlCXcwNdUp6zZAyL20SwlTRPEZX/ftpHxe
         ZdNKSjZ2cCh11jpwB8rOCqs//4Xfv3V9c6vKnQKiiVwveUGT1UaI6LVAht0+Pu/v6oc5
         hY53S8a9+k5fbc7/zx0aUBpAuJsk4T0Ab66sgFJCtFIdtPT6oNY4vPKMvWytd0UuB7iY
         yh3z9bIanfTkddQWv3A3bsSXuudvm5U5G9XmICn+V3x5y8iaW7T2kUqVIBrTYx1251pJ
         wIlhMFHRK8//Su8jPmwEWWcmL5a82fJdikbzrj9SHGbU1XacYviOB0tF1H7CooKea5F+
         K/xA==
X-Gm-Message-State: APjAAAWVT5MX8QLIWx08IEWQrOt2ECj8RhMhgnGymim6dRtXe7A9UHyg
        ooogV/grQuqNrmhzCaVYZLpSYA==
X-Google-Smtp-Source: APXvYqxKi2QLcH3IjvpDTI+hSuWRb995fiJ3mnkWELurbx0D00hm3DWRF/djwMbjIi+ZsrJWjfkkAQ==
X-Received: by 2002:a37:aa10:: with SMTP id t16mr54569419qke.332.1563982141185;
        Wed, 24 Jul 2019 08:29:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j78sm21508733qke.102.2019.07.24.08.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 08:29:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqJCM-0001tB-LL; Wed, 24 Jul 2019 12:28:58 -0300
Date:   Wed, 24 Jul 2019 12:28:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
Message-ID: <20190724152858.GB28493@ziepe.ca>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190724070553.GA2523@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724070553.GA2523@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:05:53AM +0200, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> One comment on a related cleanup:
> 
> >  	list_for_each_entry(mirror, &hmm->mirrors, list) {
> >  		int rc;
> >  
> > -		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> > +		rc = mirror->ops->sync_cpu_device_pagetables(mirror, nrange);
> >  		if (rc) {
> > -			if (WARN_ON(update.blockable || rc != -EAGAIN))
> > +			if (WARN_ON(mmu_notifier_range_blockable(nrange) ||
> > +			    rc != -EAGAIN))
> >  				continue;
> >  			ret = -EAGAIN;
> >  			break;
> 
> This magic handling of error seems odd.  I think we should merge rc and
> ret into one variable and just break out if any error happens instead
> or claiming in the comments -EAGAIN is the only valid error and then
> ignoring all others here.

The WARN_ON is enforcing the rules already commented near
mmuu_notifier_ops.invalidate_start - we could break or continue, it
doesn't much matter how to recover from a broken driver, but since we
did the WARN_ON this should sanitize the ret to EAGAIN or 0

Humm. Actually having looked this some more, I wonder if this is a
problem:

I see in __oom_reap_task_mm():

			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
				tlb_finish_mmu(&tlb, range.start, range.end);
				ret = false;
				continue;
			}
			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
			mmu_notifier_invalidate_range_end(&range);

Which looks like it creates an unbalanced start/end pairing if any
start returns EAGAIN?

This does not seem OK.. Many users require start/end to be paired to
keep track of their internal locking. Ie for instance hmm breaks
because the hmm->notifiers counter becomes unable to get to 0.

Below is the best idea I've had so far..

Michal, what do you think?

From 53638cd1cb02e65e670c5d4edfd36d067bb48912 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Wed, 24 Jul 2019 12:15:40 -0300
Subject: [PATCH] mm/mmu_notifiers: ensure invalidate_start and invalidate_end
 occur in pairs

Many callers of mmu_notifiers invalidate_range callbacks maintain
locking/counters/etc on a paired basis and have long expected that
invalidate_range start/end are always paired.

The recent change to add non-blocking notifiers breaks this assumption as
an EAGAIN return from any notifier causes all notifiers to get their
invalidate_range_end() skipped.

If there is only a single mmu notifier in the list, this may work OK as
the single subscriber may assume that the end is not called when EAGAIN is
returned, however if there are multiple subcribers then there is no way
for a notifier that succeeds to recover if another in the list triggers
EAGAIN and causes the expected end to be skipped.

Due to the RCU locking we can't reliably generate a subset of the linked
list representing the notifiers already called, so the best option is to
call all notifiers in the start path (even if EAGAIN is detected), and
again in the error path to ensure there is proper pairing.

Users that care about start/end pairing must be (re)written so that an
EAGAIN return from their start method expects the end method to be called.

Since incorect return codes will now cause a functional problem, add a
WARN_ON to detect buggy users.

RFC: Need to audit/fix callers to ensure they order their EAGAIN returns
properly. hmm is OK, ODP is not.

Fixes: 93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/mmu_notifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index b5670620aea0fc..7d8eca35f1627a 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -176,6 +176,7 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 		if (mn->ops->invalidate_range_start) {
 			int _ret = mn->ops->invalidate_range_start(mn, range);
 			if (_ret) {
+				WARN_ON(mmu_notifier_range_blockable(range) || rc != -EAGAIN);
 				pr_info("%pS callback failed with %d in %sblockable context.\n",
 					mn->ops->invalidate_range_start, _ret,
 					!mmu_notifier_range_blockable(range) ? "non-" : "");
@@ -183,6 +184,19 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 			}
 		}
 	}
+
+	if (unlikely(ret)) {
+		/*
+		 * If we hit an -EAGAIN then we have to create a paired
+		 * range_end for the above range_start. Callers must be
+		 * arranged so that they can handle the range_end even if the
+		 * range_start returns EAGAIN.
+		 */
+		hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist)
+			if (mn->ops->invalidate_range_end)
+				mn->ops->invalidate_range_end(mn, range);
+	}
+
 	srcu_read_unlock(&srcu, id);
 
 	return ret;
-- 
2.22.0

