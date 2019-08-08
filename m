Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF8C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC92821743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fEC/dOGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbfHHR13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:27:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33982 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfHHR13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:27:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so44473077pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9YLoIfF1qp9qWTvROU0/J3K1ZqRt0okGVnMsloYefE4=;
        b=fEC/dOGqoMvutovu84msAhBQcEqwR5gwxh7bGGiAuBIErF5YWxT0y8RzpmnjYaTR8k
         pgLgiWd4QvTWRgYx4U5TNysc8h5klxXyk49IR3BsH29DzJ/tNIz/NIKZxXoMrOu/C8uM
         B8JDaYMq4J6CAMkO7x6aPr9i6dCjB924y0pAn2ur3D6BQVAJ+3QUCrJYBQSwDqFp78IX
         V6qPttQK5ipRSNO1Q1TH5IfEQ47E5ynh5rBQsLNHwSpo/CnTeI+NvLZiEUlS7j0lMYP2
         Kuo7Hd1nC10xSkmzgUxnEcbg6rtIVosCl8llJpl373pXRxQijKmxGU+JtOZ6O6kKq1UP
         J2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9YLoIfF1qp9qWTvROU0/J3K1ZqRt0okGVnMsloYefE4=;
        b=qNUDUXzUgp6Zvt7Qp2FfL1QO+rnfIyVjeWTx6IgxMOOrkH6v/3KQ4oxBwA4UKRYCgZ
         1BN62mTbuVcwMzIWi+4y1sA6jY010MKyijIfU2XWbVdq/tjmEeensEPMGRLk8eoYFxY3
         zmryetWGSAOv+21YoTLOfJkufYuqBP/9LkdPF1RyGrzMphZj+BatYuxl+0zfRepQ61aP
         K6JVzatsM+Ya+paCskGC5CN45pEgpQdhuqB1FhGYeYEpK1mzQGGrOKBKDVPFvbl584PV
         T05th/h57Sc7QJrIYdPlAbB+ZhTJAgNmbpdqtfHFbrrMyS5EKRQ7pSnSIU0BqxdlNTFU
         RaaQ==
X-Gm-Message-State: APjAAAU6vBdHcGHBgRiw0M+Yfx+zUuLWjondVRIdEP25YaPg0yWw2X8C
        EIDDP102+ykykKR0Bm6R3jTDpA==
X-Google-Smtp-Source: APXvYqyIrHW8KRjxVPbe/yC6fAZomiy7/nZfI2Q/DfdAzUgoGHrtww2h3eEym6SaRtv2FvttKZAAwQ==
X-Received: by 2002:a65:52ca:: with SMTP id z10mr14045766pgp.424.1565285248072;
        Thu, 08 Aug 2019 10:27:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:e15f])
        by smtp.gmail.com with ESMTPSA id f7sm92408919pfd.43.2019.08.08.10.27.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:27:26 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:27:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190808172725.GA16900@cmpxchg.org>
References: <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
 <e535fb6a-8af4-3844-34ac-3294eef26ca6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e535fb6a-8af4-3844-34ac-3294eef26ca6@suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 04:47:18PM +0200, Vlastimil Babka wrote:
> On 8/7/19 10:51 PM, Johannes Weiner wrote:
> > From 9efda85451062dea4ea287a886e515efefeb1545 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Mon, 5 Aug 2019 13:15:16 -0400
> > Subject: [PATCH] psi: trigger the OOM killer on severe thrashing
> 
> Thanks a lot, perhaps finally we are going to eat the elephant ;)
> 
> I've tested this by booting with mem=8G and activating browser tabs as
> long as I could. Then initially the system started thrashing and didn't
> recover for minutes. Then I realized sysrq+f is disabled... Fixed that
> up after next reboot, tried lower thresholds, also started monitoring
> /proc/pressure/memory, and found out that after minutes of not being
> able to move the cursor, both avg10 and avg60 shows only around 15 for
> both some and full. Lowered thrashing_oom_level to 10 and (with
> thrashing_oom_period of 5) the thrashing OOM finally started kicking,
> and the system recovered by itself in reasonable time.

It sounds like there is a missing annotation. The time has to be going
somewhere, after all. One *known* missing vector I fixed recently is
stalls in submit_bio() itself when refaulting, but it's not merged
yet. Attaching the patch below, can you please test it?

> So my conclusion is that the patch works, but there's something odd with
> suspiciously low PSI memory values on my system. Any idea how to
> investigate this? Also, does it matter that it's a modern desktop, so
> systemd puts everything into cgroups, and the unified cgroup2 hierarchy
> is also mounted?

That shouldn't interfere because 1) pressure is reported recursively
up the cgroup tree, so unless something else runs completely fine on
the system, global pressure should reflect cgroup pressure and 2) the
systemd defaults doesn't set any memory limits or protections, so if
the system is hanging, it's unlikely that anything runs fine.

bcc tools (https://iovisor.github.io/bcc/) has an awesome program
called 'offcputime' that gives you stack traces of sleeping tasks.
This could give an insight into where time is going and point out
operations we might not be annotating correctly yet.

---
From 1b3888bdf075f86f226af4e350c8a88435d1fe8e Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 11 Jul 2019 16:01:40 -0400
Subject: [PATCH] psi: annotate refault stalls from IO submission

psi tracks the time tasks wait for refaulting pages to become
uptodate, but it does not track the time spent submitting the IO. The
submission part can be significant if backing storage is contended or
when cgroup throttling (io.latency) is in effect - a lot of time is
spent in submit_bio(). In that case, we underreport memory pressure.

Annotate submit_bio() to account submission time as memory stall when
the bio is reading userspace workingset pages.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/bio.c               |  3 +++
 block/blk-core.c          | 23 ++++++++++++++++++++++-
 include/linux/blk_types.h |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 29cd6cf4da51..4dd9ea0b068b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -805,6 +805,9 @@ void __bio_add_page(struct bio *bio, struct page *page,
 
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
+
+	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
+		bio_set_flag(bio, BIO_WORKINGSET);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 5d1fc8e17dd1..5993922d63fb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -36,6 +36,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
+#include <linux/psi.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1127,6 +1128,10 @@ EXPORT_SYMBOL_GPL(direct_make_request);
  */
 blk_qc_t submit_bio(struct bio *bio)
 {
+	bool workingset_read = false;
+	unsigned long pflags;
+	blk_qc_t ret;
+
 	/*
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
@@ -1142,6 +1147,8 @@ blk_qc_t submit_bio(struct bio *bio)
 		if (op_is_write(bio_op(bio))) {
 			count_vm_events(PGPGOUT, count);
 		} else {
+			if (bio_flagged(bio, BIO_WORKINGSET))
+				workingset_read = true;
 			task_io_account_read(bio->bi_iter.bi_size);
 			count_vm_events(PGPGIN, count);
 		}
@@ -1156,7 +1163,21 @@ blk_qc_t submit_bio(struct bio *bio)
 		}
 	}
 
-	return generic_make_request(bio);
+	/*
+	 * If we're reading data that is part of the userspace
+	 * workingset, count submission time as memory stall. When the
+	 * device is congested, or the submitting cgroup IO-throttled,
+	 * submission can be a significant part of overall IO time.
+	 */
+	if (workingset_read)
+		psi_memstall_enter(&pflags);
+
+	ret = generic_make_request(bio);
+
+	if (workingset_read)
+		psi_memstall_leave(&pflags);
+
+	return ret;
 }
 EXPORT_SYMBOL(submit_bio);
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6a53799c3fe2..2f77e3446760 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -209,6 +209,7 @@ enum {
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_USER_MAPPED,	/* contains user pages */
 	BIO_NULL_MAPPED,	/* contains invalid user pages */
+	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-- 
2.22.0

