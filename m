Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0032CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76FB2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TbqiDTw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCSMTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:19:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfCSMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k2P5H6WhEDRYxFMTTXi2S8gyTfIv2F+pfTVbJYH6hCo=; b=TbqiDTw17+5GUdPAp6Xq33CeW
        E7YRTZGkOJASDgPiSmT+vlGT8lPbbSnJbzlpog9M04jf7FbqJlbeujEnIMMpXRbSmQGOJM0JBhSVj
        Wl5jlDRzd1jjgNGlY6KhwqoOypFGGhTnLnOuSJHMJyymY0WEAIS6MBkvMRYKAn464SP4cosdhFirF
        JIGfz5lqR0Iz2ErGFYj2Obrf/sD1ue1HTHLy5zomKGGDgSKJn7UoUmNBv4/sI48LKfLP2eyurzNu6
        uMTw7dVCNZBxeG6fK2Glvj1LGFsAzY/QMunFOz9PrXeRWv6RWex8ldbUd/jWF5wlR66OLeV+PBxkq
        IjFZGaQqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6Dhr-00021o-Kn; Tue, 19 Mar 2019 12:18:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0611D23E8CA31; Tue, 19 Mar 2019 13:18:56 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:18:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     pbonzini@redhat.com, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH] locking/static_key: Fix false positive warnings on
 concurrent dec/inc
Message-ID: <20190319121856.GE5996@hirez.programming.kicks-ass.net>
References: <20190318215814.3724-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318215814.3724-1-jakub.kicinski@netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 02:58:14PM -0700, Jakub Kicinski wrote:
> Even though the atomic_dec_and_mutex_lock() in
> __static_key_slow_dec_cpuslocked() can never see a negative
> value in key->enabled the subsequent sanity check is re-reading
> key->enabled, which may have been set to -1 in the meantime by
> static_key_slow_inc_cpuslocked().

A little extra detail might not hurt, or a diagram or something.

> Instead of using -1 as a "enable in progress" constant use
> -0xffff, this way we can still treat smaller negative values
> as errors.

Those offset games always hurt my brain, but see below.

> Fixes: 4c5ea0a9cd02 ("locking/static_key: Fix concurrent static_key_slow_inc()")
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> ---
>  kernel/jump_label.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index bad96b476eb6..4a227e70a8f3 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -89,7 +89,7 @@ static void jump_label_update(struct static_key *key);
>  int static_key_count(struct static_key *key)
>  {
>  	/*
> -	 * -1 means the first static_key_slow_inc() is in progress.
> +	 * -0xffff means the first static_key_slow_inc() is in progress.
>  	 *  static_key_enabled() must return true, so return 1 here.
>  	 */
>  	int n = atomic_read(&key->enabled);
> @@ -125,7 +125,10 @@ void static_key_slow_inc_cpuslocked(struct static_key *key)
>  
>  	jump_label_lock();
>  	if (atomic_read(&key->enabled) == 0) {
> -		atomic_set(&key->enabled, -1);
> +		/* Use a large enough negative number so we can still
> +		 * catch underflow bugs in static_key_slow_dec().
> +		 */

Broken comment style.

> +		atomic_set(&key->enabled, -0xffff);
>  		jump_label_update(key);
>  		/*
>  		 * Ensure that if the above cmpxchg loop observes our positive
> @@ -158,7 +161,7 @@ void static_key_enable_cpuslocked(struct static_key *key)
>  
>  	jump_label_lock();
>  	if (atomic_read(&key->enabled) == 0) {
> -		atomic_set(&key->enabled, -1);
> +		atomic_set(&key->enabled, -0xffff);
>  		jump_label_update(key);
>  		/*
>  		 * See static_key_slow_inc().
> @@ -208,15 +211,11 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
>  {
>  	lockdep_assert_cpus_held();
>  
> -	/*
> -	 * The negative count check is valid even when a negative
> -	 * key->enabled is in use by static_key_slow_inc(); a
> -	 * __static_key_slow_dec() before the first static_key_slow_inc()
> -	 * returns is unbalanced, because all other static_key_slow_inc()
> -	 * instances block while the update is in progress.
> -	 */
>  	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
> -		WARN(atomic_read(&key->enabled) < 0,
> +		int v;
> +
> +		v = atomic_read(&key->enabled);
> +		WARN(v < 0 && v != -0xffff,
>  		     "jump label: negative count!\n");
>  		return;
>  	}

> Alternatively we could implement atomic_dec_and_mutex_lock_return().

I think I like that better, something like:

---
 kernel/jump_label.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index bad96b476eb6..a799b1ac6b2f 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -206,6 +206,8 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 					   unsigned long rate_limit,
 					   struct delayed_work *work)
 {
+	int val;
+
 	lockdep_assert_cpus_held();
 
 	/*
@@ -215,17 +217,20 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 	 * returns is unbalanced, because all other static_key_slow_inc()
 	 * instances block while the update is in progress.
 	 */
-	if (!atomic_dec_and_mutex_lock(&key->enabled, &jump_label_mutex)) {
-		WARN(atomic_read(&key->enabled) < 0,
-		     "jump label: negative count!\n");
+	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
+	if (val != 1) {
+		WARN(val < 0, "jump label: negative count!\n");
 		return;
 	}
 
-	if (rate_limit) {
-		atomic_inc(&key->enabled);
-		schedule_delayed_work(work, rate_limit);
-	} else {
-		jump_label_update(key);
+	jump_label_lock();
+	if (atomic_dec_and_test(&key->enabled)) {
+		if (rate_limit) {
+			atomic_inc(&key->enabled);
+			schedule_delayed_work(work, rate_limit);
+		} else {
+			jump_label_update(key);
+		}
 	}
 	jump_label_unlock();
 }
