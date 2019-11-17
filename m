Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE69CC432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 04:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805712084D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 04:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573963974;
	bh=1KqB/zMSU2iTXsYSttCOTkQa4Dh1lUInMJQyT27baT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ldY80hzR9UOSw5h1397+j1JuFEwW3xAMgRmyUUTy3yTBSrK7DeK8KqmcWI37Sfbz3
	 wXNeG9AkOj1jagaQ4E5Xn0yFqEkWxuCO5RdQrDmbIVa7p5UMFo+MeteDuI6hLksWxr
	 +/3eq5Mfx2T18spDF3hXam/sFzSda7ikec5KYYfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfKQELT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 23:11:19 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39329 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfKQELT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 23:11:19 -0500
Received: by mail-qt1-f194.google.com with SMTP id t8so16000592qtc.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 20:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+PZTaRA1mU40HjFBjNchvW+YA6/l0wxEgHNp4GKjfNY=;
        b=I8CTJVIWtO/j71FA4jPg4tnDQd9rbYJquo/446OibiSI0hgivSWXv++skOSC7exOur
         JoAvps9J+gb/XTDoQYq8J+/1rqZhdLuv2TinAlC/OoQ0kKUQrR4MOElJ+RQtThww/sVf
         /4roXLrPD8adjLLzCD9K34BUPS/1WkhLvLyphJ0UgZ0a1K/ysO7IGOU6yrxPRfMpdfkg
         eqh0jn3d6sbfN88lZGwy2fFFTFZzHnm0HjkDiR/rNXriXZegz/TXrqs8zEKWHj5Sx6lW
         /WiQvMt25+ps3wfIM7sKDzPuZ9InUNtqTL6CJEgRFCuhTKPG7GymDflUoBCdVe+eDatS
         r6Bw==
X-Gm-Message-State: APjAAAVlszxbYUClBt0J6B2MExRuGehsjT2ZPju3I5JxSKVTz1vxbyHD
        W0Pi0xLAu27kBkVEnKgpdMw=
X-Google-Smtp-Source: APXvYqwFcM7pZ2brU2Z9hf4G1rMvy7Eo4SeIFrNWcGQsYIsDozcqE6lbH1fQsf1QfdlxzR3Vc11aLw==
X-Received: by 2002:ac8:16b5:: with SMTP id r50mr17267138qtj.389.1573963876560;
        Sat, 16 Nov 2019 20:11:16 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:480::7e82])
        by smtp.gmail.com with ESMTPSA id g25sm7916595qtc.90.2019.11.16.20.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 20:11:15 -0800 (PST)
Date:   Sat, 16 Nov 2019 23:11:13 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191117041113.GA39597@dennisz-mbp>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
 <20191107165519.GA99408@dennisz-mbp>
 <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
 <20191107173653.GA1242@dennisz-mbp>
 <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108173553.lxsdic6wa4y3ifsr@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 06:35:53PM +0100, Sebastian Andrzej Siewior wrote:
> This is a revert of commit
>    a4244454df129 ("percpu-refcount: use RCU-sched insted of normal RCU")
> 
> which claims the only reason for using RCU-sched is
>    "rcu_read_[un]lock() … are slightly more expensive than preempt_disable/enable()"
> 
> and
>     "As the RCU critical sections are extremely short, using sched-RCU
>     shouldn't have any latency implications."
> 
> The problem with using RCU-sched here is that it disables preemption and
> the release callback (called from percpu_ref_put_many()) must not
> acquire any sleeping locks like spinlock_t. This breaks PREEMPT_RT
> because some of the users acquire spinlock_t locks in their callbacks.
> 
> Using rcu_read_lock() on PREEMPTION=n kernels is not any different
> compared to rcu_read_lock_sched(). On PREEMPTION=y kernels there are
> already performance issues due to additional preemption points.
> Looking at the code, the rcu_read_lock() is just an increment and unlock
> is almost just a decrement unless there is something special to do. Both
> are functions while disabling preemption is inlined.
> Doing a small benchmark, the minimal amount of time required was mostly
> the same. The average time required was higher due to the higher MAX
> value (which could be preemption). With DEBUG_PREEMPT=y it is
> rcu_read_lock_sched() that takes a little longer due to the additional
> debug code.
> 
> Convert back to normal RCU.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On 2019-11-07 12:36:53 [-0500], Dennis Zhou wrote:
> > > some RCU section here invoke callbacks which acquire spinlock_t locks.
> > > This does not work on RT with disabled preemption.
> > > 
> > 
> > Yeah, so adding a bit in the commit message about why it's an issue for
> > RT kernels with disabled preemption as I don't believe this is an issue
> > for non-RT kernels.
> 
> I realized that I had partly in the commit message so I rewrote the
> second chapter hopefully covering it all now more explicit.
> 
> v1…v2: Slightly rewriting the second paragraph regarding RT
> implications.
> 
>  include/linux/percpu-refcount.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
> index 7aef0abc194a2..390031e816dcd 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -186,14 +186,14 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_add(*percpu_count, nr);
>  	else
>  		atomic_long_add(nr, &ref->count);
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  }
>  
>  /**
> @@ -223,7 +223,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  	unsigned long __percpu *percpu_count;
>  	bool ret;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count)) {
>  		this_cpu_inc(*percpu_count);
> @@ -232,7 +232,7 @@ static inline bool percpu_ref_tryget(struct percpu_ref *ref)
>  		ret = atomic_long_inc_not_zero(&ref->count);
>  	}
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  
>  	return ret;
>  }
> @@ -257,7 +257,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  	unsigned long __percpu *percpu_count;
>  	bool ret = false;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count)) {
>  		this_cpu_inc(*percpu_count);
> @@ -266,7 +266,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
>  		ret = atomic_long_inc_not_zero(&ref->count);
>  	}
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  
>  	return ret;
>  }
> @@ -285,14 +285,14 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
>  {
>  	unsigned long __percpu *percpu_count;
>  
> -	rcu_read_lock_sched();
> +	rcu_read_lock();
>  
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_sub(*percpu_count, nr);
>  	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
>  		ref->release(ref);
>  
> -	rcu_read_unlock_sched();
> +	rcu_read_unlock();
>  }
>  
>  /**
> -- 
> 2.24.0
> 
> 

Sorry for sitting on this for so long. I've applied it to for-5.5.

Thanks,
Dennis
