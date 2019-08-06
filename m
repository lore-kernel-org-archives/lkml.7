Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD362075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfHFRgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:36:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50245 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfHFRgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:36:53 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1hv3OF-0004u6-6h
        for linux-kernel@vger.kernel.org; Tue, 06 Aug 2019 17:36:51 +0000
Received: by mail-wr1-f71.google.com with SMTP id g8so42465976wrw.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 10:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k8160bX0AxtMu26pGIgkyDQWX/jNyhf79KSwyNs478o=;
        b=VOxzUJDxIpSVMqCWN6wYU/eeQ5G2tfRGMM0e042UEeqMo5tSto+kS+EV+hQGzXlhyb
         HhtxRFIkGzFe8PR2MKg+BNePdHiuoFnTeFUz5N79u7Pl9lBUVhXvbzrzEm9NLwEw4+Lw
         fdqu3ziCuO2CVRgcf5YF1K/drFUN56TjnCwyBw4N2TpV0cT+RbyjI0m17FP6Q3mNj+DI
         hBoEyaMaCYR7Wo2WNg7NMJxzyojYJhsdicWgv9kFq9x2kVL87T76/VDfDCpEnWIubVte
         b/Y/jG8X97IVNOn4Hob8cLKF1Bvviv4wgWifo5QgP5cgC5fCnuuj6Elxb2/2UcWKeWki
         Oqkg==
X-Gm-Message-State: APjAAAUtfDi+l03VEIHo9MoDjq9sUtluqLZjydPtSprw73yaUjEafGhR
        iBQggTL3dyXbGSwatXysgFGQZaUyq8x9JEmnBJdCac5GqVQQghFJdNjK/83NmGljuB6dDuFiFO+
        CwhobnFEmQ3ncRsiktM0ejcu/dbfwHkzmVudpFH9Cjw==
X-Received: by 2002:adf:fb8e:: with SMTP id a14mr5757122wrr.263.1565113010859;
        Tue, 06 Aug 2019 10:36:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYJp403TRPYY3zd/y/fwObneeFGKmHHtTn6IwcDMPaLZy9dcv4UGBUxm4X+BuRKTGcDEQpnA==
X-Received: by 2002:adf:fb8e:: with SMTP id a14mr5757103wrr.263.1565113010488;
        Tue, 06 Aug 2019 10:36:50 -0700 (PDT)
Received: from localhost (host21-131-dynamic.46-79-r.retail.telecomitalia.it. [79.46.131.21])
        by smtp.gmail.com with ESMTPSA id e19sm122697381wra.71.2019.08.06.10.36.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 10:36:49 -0700 (PDT)
Date:   Tue, 6 Aug 2019 19:36:48 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bcache: fix deadlock in bcache_allocator
Message-ID: <20190806173648.GB27866@xps-13>
References: <20190806091801.GC11184@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806091801.GC11184@xps-13>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:18:01AM +0200, Andrea Righi wrote:
> bcache_allocator() can call the following:
> 
>  bch_allocator_thread()
>   -> bch_prio_write()
>      -> bch_bucket_alloc()
>         -> wait on &ca->set->bucket_wait
> 
> But the wake up event on bucket_wait is supposed to come from
> bch_allocator_thread() itself => deadlock:
> 
> [ 1158.490744] INFO: task bcache_allocato:15861 blocked for more than 10 seconds.
> [ 1158.495929]       Not tainted 5.3.0-050300rc3-generic #201908042232
> [ 1158.500653] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 1158.504413] bcache_allocato D    0 15861      2 0x80004000
> [ 1158.504419] Call Trace:
> [ 1158.504429]  __schedule+0x2a8/0x670
> [ 1158.504432]  schedule+0x2d/0x90
> [ 1158.504448]  bch_bucket_alloc+0xe5/0x370 [bcache]
> [ 1158.504453]  ? wait_woken+0x80/0x80
> [ 1158.504466]  bch_prio_write+0x1dc/0x390 [bcache]
> [ 1158.504476]  bch_allocator_thread+0x233/0x490 [bcache]
> [ 1158.504491]  kthread+0x121/0x140
> [ 1158.504503]  ? invalidate_buckets+0x890/0x890 [bcache]
> [ 1158.504506]  ? kthread_park+0xb0/0xb0
> [ 1158.504510]  ret_from_fork+0x35/0x40
> 
> Fix by making the call to bch_prio_write() non-blocking, so that
> bch_allocator_thread() never waits on itself.
> 
> Moreover, make sure to wake up the garbage collector thread when
> bch_prio_write() is failing to allocate buckets.
> 
> BugLink: https://bugs.launchpad.net/bugs/1784665
> BugLink: https://bugs.launchpad.net/bugs/1796292
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
> Changes in v2:
>  - prevent retry_invalidate busy loop in bch_allocator_thread()
> 
>  drivers/md/bcache/alloc.c  |  5 ++++-
>  drivers/md/bcache/bcache.h |  2 +-
>  drivers/md/bcache/super.c  | 13 +++++++++----
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
> index 6f776823b9ba..a1df0d95151c 100644
> --- a/drivers/md/bcache/alloc.c
> +++ b/drivers/md/bcache/alloc.c
> @@ -377,7 +377,10 @@ static int bch_allocator_thread(void *arg)
>  			if (!fifo_full(&ca->free_inc))
>  				goto retry_invalidate;
>  
> -			bch_prio_write(ca);
> +			if (bch_prio_write(ca, false) < 0) {
> +				ca->invalidate_needs_gc = 1;
> +				wake_up_gc(ca->set);
> +			}
>  		}
>  	}
>  out:
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index 013e35a9e317..deb924e1d790 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -977,7 +977,7 @@ bool bch_cached_dev_error(struct cached_dev *dc);
>  __printf(2, 3)
>  bool bch_cache_set_error(struct cache_set *c, const char *fmt, ...);
>  
> -void bch_prio_write(struct cache *ca);
> +int bch_prio_write(struct cache *ca, bool wait);
>  void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent);
>  
>  extern struct workqueue_struct *bcache_wq;
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 20ed838e9413..716ea272fb55 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -529,7 +529,7 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
>  	closure_sync(cl);
>  }
>  
> -void bch_prio_write(struct cache *ca)
> +int bch_prio_write(struct cache *ca, bool wait)
>  {
>  	int i;
>  	struct bucket *b;
> @@ -564,8 +564,12 @@ void bch_prio_write(struct cache *ca)
>  		p->magic	= pset_magic(&ca->sb);
>  		p->csum		= bch_crc64(&p->magic, bucket_bytes(ca) - 8);
>  
> -		bucket = bch_bucket_alloc(ca, RESERVE_PRIO, true);
> -		BUG_ON(bucket == -1);
> +		bucket = bch_bucket_alloc(ca, RESERVE_PRIO, wait);
> +		if (bucket == -1) {
> +			if (!wait)
> +				return -ENOMEM;
> +			BUG_ON(1);
> +		}

Coly,

looking more at this change, I think we should handle the failure path
properly or we may leak buckets, am I right? (sorry for not realizing
this before). Maybe we need something like the following on top of my
previous patch.

I'm going to run more stress tests with this patch applied and will try
to figure out if we're actually leaking buckets without it.

---
Subject: bcache: prevent leaking buckets in bch_prio_write()

Handle the allocation failure path properly in bch_prio_write() to avoid
leaking buckets from the previous successful iterations.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/md/bcache/super.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 716ea27..727266f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -531,7 +531,7 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 
 int bch_prio_write(struct cache *ca, bool wait)
 {
-	int i;
+	int i, j, ret = 0;
 	struct bucket *b;
 	struct closure cl;
 
@@ -566,9 +566,11 @@ int bch_prio_write(struct cache *ca, bool wait)
 
 		bucket = bch_bucket_alloc(ca, RESERVE_PRIO, wait);
 		if (bucket == -1) {
-			if (!wait)
-				return -ENOMEM;
-			BUG_ON(1);
+			if (!wait) {
+				ret = -ENOMEM;
+				break;
+			}
+			BUG();
 		}
 
 		mutex_unlock(&ca->set->bucket_lock);
@@ -590,14 +592,14 @@ int bch_prio_write(struct cache *ca, bool wait)
 	 * Don't want the old priorities to get garbage collected until after we
 	 * finish writing the new ones, and they're journalled
 	 */
-	for (i = 0; i < prio_buckets(ca); i++) {
-		if (ca->prio_last_buckets[i])
+	for (j = prio_buckets(ca) - 1; j > i; --j) {
+		if (ca->prio_last_buckets[j])
 			__bch_bucket_free(ca,
-				&ca->buckets[ca->prio_last_buckets[i]]);
+				&ca->buckets[ca->prio_last_buckets[j]]);
 
-		ca->prio_last_buckets[i] = ca->prio_buckets[i];
+		ca->prio_last_buckets[j] = ca->prio_buckets[j];
 	}
-	return 0;
+	return ret;
 }
 
 static void prio_read(struct cache *ca, uint64_t bucket)
-- 
2.7.4

