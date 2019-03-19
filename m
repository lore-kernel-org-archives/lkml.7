Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D236520863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="wcfJm9wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfCSRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:47:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43925 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfCSRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:47:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so23135463qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=kxyE3mIu+XEHYHbUsnJwC2/Ztt/4Hmrkgoi4jlEiiVs=;
        b=wcfJm9wr5WYvX7sHAtrZSIF3n0P/XTwLHRyS3aZrp3H/yjbN81u3+nKLY6uIvJ0Bm3
         aoHrfDe3AllpM4zBTuo6TXkhvJD0vvCezWUZhxUufFFpBPmtrzSpMCA9cLr1SH49Te1K
         8M7isGiUcp1dXRQ9n23oljlOGhTM+xy6DjKWeM198+E1pITDkCbRrDuRs5uvVzh9pGLq
         Y/SPXNU6M1fs2bBlolO8qJSNOgEJ9wMhsten72koHScDA3Deq7SH1Ok1jz1Yn/8LFANC
         pJa/jYlPADruPYVv7hGdYXV5p+EOiqwQdRaaApIZx/Sed86sD4ZOaXI6ArmZrwMEpnBT
         B8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=kxyE3mIu+XEHYHbUsnJwC2/Ztt/4Hmrkgoi4jlEiiVs=;
        b=Qi0fVfZwg893zaF78hKHLZWsIZCFu6brJXOyroBGaGupD4mhycGljC5/sI2YTx0yZ7
         ixVH7Czy52J7kbATK/GopvBpB89fhCV+A4Qylcwd/TKRqE2EnkNO7CAm66wW8M4E7HYO
         Sx7tdVtv46Scjb7GzDPmuqHpjTr2aXZO5YRvuiC/0K3AkPV64Ua1rGIXM6j3pALlt+aM
         r3KukO21eP7rKsVW5FGVfILVtcQonZYlCSD1873nh/WFrA3kjPL1zs+XIo6dXo4YA4u7
         KJa2YTZC/09eYDx/2j4Kr9JId/Y+Nxbx2msWObbS8prfQl+INKrJb+xueI2YdV+MukG8
         xpIg==
X-Gm-Message-State: APjAAAWquQywR3sbn1HrecoRf4ojIzgspMajdMK+Sk+Bs4uZnkJxM1tl
        sgwxujlJ0yRha0QL3u+nhalPlQ==
X-Google-Smtp-Source: APXvYqzBVoCLTy5y8sDlwRR+KqzixXrWEr1pCKahh8mLiK6q7uu5lkPHFmKZntCV76pZaxNU/kaMeQ==
X-Received: by 2002:a0c:d2d4:: with SMTP id x20mr2950908qvh.227.1553017623464;
        Tue, 19 Mar 2019 10:47:03 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l2sm1046205qtc.47.2019.03.19.10.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 10:47:03 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:46:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     pbonzini@redhat.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH] locking/static_key: Fix false positive warnings on
 concurrent dec/inc
Message-ID: <20190319104657.6fa99d82@cakuba.netronome.com>
In-Reply-To: <20190319121856.GE5996@hirez.programming.kicks-ass.net>
References: <20190318215814.3724-1-jakub.kicinski@netronome.com>
        <20190319121856.GE5996@hirez.programming.kicks-ass.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking at the patch!

On Tue, 19 Mar 2019 13:18:56 +0100, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 02:58:14PM -0700, Jakub Kicinski wrote:
> > Even though the atomic_dec_and_mutex_lock() in
> > __static_key_slow_dec_cpuslocked() can never see a negative
> > value in key->enabled the subsequent sanity check is re-reading
> > key->enabled, which may have been set to -1 in the meantime by
> > static_key_slow_inc_cpuslocked().  
> 
> A little extra detail might not hurt, or a diagram or something.

Like this:

                CPU  A                               CPU B

 __static_key_slow_dec_cpuslocked():
 static_key_slow_inc_cpuslocked():
                               # enabled = 1
        atomic_dec_and_mutex_lock() 
                               # enabled = 0
                                              atomic_read() == 0
                                              atomic_set(-1)
                               # enabled = -1
        val = atomic_read() 
        # Oops - val == -1!

?

The test case is TCP's clean_acked_data_enable() /
clean_acked_data_disable() as tickled by ktls (net/ktls).
Which should probably use the delayed version in the first 
place, hopefully I can get to adding delayed version of 
static branches and converting at some point..

> > Instead of using -1 as a "enable in progress" constant use
> > -0xffff, this way we can still treat smaller negative values
> > as errors.  
> 
> Those offset games always hurt my brain, but see below.
> 
> > Fixes: 4c5ea0a9cd02 ("locking/static_key: Fix concurrent static_key_slow_inc()")
> > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > ---
> >  kernel/jump_label.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > index bad96b476eb6..4a227e70a8f3 100644
> > --- a/kernel/jump_label.c
> > +++ b/kernel/jump_label.c
> > @@ -89,7 +89,7 @@ static void jump_label_update(struct static_key *key);
> >  int static_key_count(struct static_key *key)
> >  {
> >  	/*
> > -	 * -1 means the first static_key_slow_inc() is in progress.
> > +	 * -0xffff means the first static_key_slow_inc() is in progress.
> >  	 *  static_key_enabled() must return true, so return 1 here.
> >  	 */
> >  	int n = atomic_read(&key->enabled);
> > @@ -125,7 +125,10 @@ void static_key_slow_inc_cpuslocked(struct static_key *key)
> >  
> >  	jump_label_lock();
> >  	if (atomic_read(&key->enabled) == 0) {
> > -		atomic_set(&key->enabled, -1);
> > +		/* Use a large enough negative number so we can still
> > +		 * catch underflow bugs in static_key_slow_dec().
> > +		 */  
> 
> Broken comment style.

Ah, sorry, netdev.

> > +		atomic_set(&key->enabled, -0xffff);
> >  		jump_label_update(key);
> >  		/*
> >  		 * Ensure that if the above cmpxchg loop observes our positive
> > @@ -158,7 +161,7 @@ void static_key_enable_cpuslocked(struct static_key *key)
> >  
> >  	jump_label_lock();
> >  	if (atomic_read(&key->enabled) == 0) {
> > -		atomic_set(&key->enabled, -1);
> > +		atomic_set(&key->enabled, -0xffff);
> >  		jump_label_update(key);
> >  		/*
> >  		 * See static_key_slow_inc().
> > @@ -208,15 +211,11 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
> >  {
> >  	lockdep_assert_cpus_held();
> >  
> > -	/*
> > -	 * The negative count check is valid even when a negative
> > -	 * key->enabled is in use by static_key_slow_inc(); a
> > -	 * __static_key_slow_dec() before the first static_key_slow_inc()
> > -	 * returns is unbalanced, because all other static_key_slow_inc()
> > -	 * instances block while the update is in progress.
> > -	 */
> >  	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
> > -		WARN(atomic_read(&key->enabled) < 0,
> > +		int v;
> > +
> > +		v = atomic_read(&key->enabled);
> > +		WARN(v < 0 && v != -0xffff,
> >  		     "jump label: negative count!\n");
> >  		return;
> >  	}  
> 
> > Alternatively we could implement atomic_dec_and_mutex_lock_return().  
> 
> I think I like that better, something like:

That indeed looks far cleanest, thanks!

Tested-by: Jakub Kicinski <jakub.kicinski@netronome.com>

>  kernel/jump_label.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index bad96b476eb6..a799b1ac6b2f 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -206,6 +206,8 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
>  					   unsigned long rate_limit,
>  					   struct delayed_work *work)
>  {
> +	int val;
> +
>  	lockdep_assert_cpus_held();
>  
>  	/*
> @@ -215,17 +217,20 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
>  	 * returns is unbalanced, because all other static_key_slow_inc()
>  	 * instances block while the update is in progress.
>  	 */
> -	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
> -		WARN(atomic_read(&key->enabled) < 0,
> -		     "jump label: negative count!\n");
> +	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
> +	if (val != 1) {
> +		WARN(val < 0, "jump label: negative count!\n");
>  		return;
>  	}
>  
> -	if (rate_limit) {
> -		atomic_inc(&key->enabled);
> -		schedule_delayed_work(work, rate_limit);
> -	} else {
> -		jump_label_update(key);
> +	jump_label_lock();
> +	if (atomic_dec_and_test(&key->enabled)) {
> +		if (rate_limit) {
> +			atomic_inc(&key->enabled);
> +			schedule_delayed_work(work, rate_limit);
> +		} else {
> +			jump_label_update(key);
> +		}
>  	}
>  	jump_label_unlock();
>  }

