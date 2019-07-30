Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80CA208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DxGrOo8f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gLF4QvzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731224AbfG3QZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:25:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46656 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3QZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:25:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE28A60735; Tue, 30 Jul 2019 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564503945;
        bh=jrTrzLZvjR+zrbgpBKuS7VVUUp3NBIbM0xrG8JDVCDs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DxGrOo8f754RwfHewPhgPNNu0PbjiJVIg2+/GOfWpV53ANUjv9TZy/1Hwy3rC/bZQ
         /41IsTCmpyRNsNwrrMAq9EssXEbNOq/OFuYEbzuPoPUosRJsKclf4RA50kNkMkfBts
         R3GU5uE8MCcdbSt4Gxq9zpoTUkw461ugLS3ZI7F4=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7508760350;
        Tue, 30 Jul 2019 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564503944;
        bh=jrTrzLZvjR+zrbgpBKuS7VVUUp3NBIbM0xrG8JDVCDs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gLF4QvzFZRnFbYlh7xArNHw5yrY7PJHGeGCHgA/aFHw5GJCtAP4/BBtnGaTnH2Mez
         2PmOPEacPK38RYI7HDx7D/fOMZ42R/EDb7naTwKoNNL7vyA4dR350bPwAGDElpBqwQ
         AM16X6s8cvE+PZfAqRFw4u/6bmxuPFIlOdlIiarw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7508760350
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard
 code value
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
 <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
 <20190729110727.GB31398@hirez.programming.kicks-ass.net>
 <a80972a1-8e24-33cb-0088-49ef0e680540@codeaurora.org>
 <20190730080308.GF31381@hirez.programming.kicks-ass.net>
 <6b0fd5fd-b3e2-585e-286d-de8ed3c21e66@codeaurora.org>
 <20190730160236.GN31381@hirez.programming.kicks-ass.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <849e8fd6-882a-9691-e116-48b2d98b5128@codeaurora.org>
Date:   Tue, 30 Jul 2019 21:55:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730160236.GN31381@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/30/2019 9:32 PM, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 06:10:49PM +0530, Mukesh Ojha wrote:
>
>> To make it static , i have to export mutex_is_locked() after moving it
>> inside mutex.c, so that other module can use it.
> Yep, see below -- completely untested.
>
>> Also are we thinking of removing
>> static inline /* __deprecated */ __must_check enum
>> mutex_trylock_recursive_enum
>> mutex_trylock_recursive(struct mutex *lock)
>>
>> inside linux/mutex.h in future ?
>>
>> As i see it is used at one or two places and there is a check inside
>> checkpatch guarding its further use .
> That was the idea; recursive locking is evil, but we have these two
> legacy sites.
>
> ---
>
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index dcd03fee6e01..eb8c62aba263 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -65,29 +65,6 @@ struct mutex {
>   #endif
>   };
>   
> -/*
> - * Internal helper function; C doesn't allow us to hide it :/
> - *
> - * DO NOT USE (outside of mutex code).
> - */
> -static inline struct task_struct *__mutex_owner(struct mutex *lock)
> -{
> -	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
> -}
> -
> -/*
> - * This is the control structure for tasks blocked on mutex,
> - * which resides on the blocked task's kernel stack:
> - */
> -struct mutex_waiter {
> -	struct list_head	list;
> -	struct task_struct	*task;
> -	struct ww_acquire_ctx	*ww_ctx;
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	void			*magic;
> -#endif
> -};
> -
>   #ifdef CONFIG_DEBUG_MUTEXES
>   
>   #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
> @@ -144,10 +121,7 @@ extern void __mutex_init(struct mutex *lock, const char *name,
>    *
>    * Returns true if the mutex is locked, false if unlocked.
>    */
> -static inline bool mutex_is_locked(struct mutex *lock)
> -{
> -	return __mutex_owner(lock) != NULL;
> -}
> +extern bool mutex_is_locked(struct mutex *lock);
>   
>   /*
>    * See kernel/locking/mutex.c for detailed documentation of these APIs.
> @@ -220,13 +194,7 @@ enum mutex_trylock_recursive_enum {
>    *  - MUTEX_TRYLOCK_SUCCESS   - lock acquired,
>    *  - MUTEX_TRYLOCK_RECURSIVE - we already owned the lock.
>    */
> -static inline /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
> -mutex_trylock_recursive(struct mutex *lock)
> -{
> -	if (unlikely(__mutex_owner(lock) == current))
> -		return MUTEX_TRYLOCK_RECURSIVE;
> -
> -	return mutex_trylock(lock);
> -}
> +extern /* __deprecated */ __must_check enum mutex_trylock_recursive_enum
> +mutex_trylock_recursive(struct mutex *lock);
>   
>   #endif /* __LINUX_MUTEX_H */
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 5e069734363c..2f73935a6053 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -36,6 +36,19 @@
>   # include "mutex.h"
>   #endif
>   
> +/*
> + * This is the control structure for tasks blocked on mutex,
> + * which resides on the blocked task's kernel stack:
> + */
> +struct mutex_waiter {
> +	struct list_head	list;
> +	struct task_struct	*task;
> +	struct ww_acquire_ctx	*ww_ctx;
> +#ifdef CONFIG_DEBUG_MUTEXES
> +	void			*magic;
> +#endif
> +};

i already did in v2  except this above waiter struct, will do it in v3.

Cheers,

Mukesh

> +
>   void
>   __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
>   {
> @@ -65,6 +78,16 @@ EXPORT_SYMBOL(__mutex_init);
>   
>   #define MUTEX_FLAGS		0x07
>   
> +/*
> + * Internal helper function; C doesn't allow us to hide it :/
> + *
> + * DO NOT USE (outside of mutex code).
> + */
> +static inline struct task_struct *__mutex_owner(struct mutex *lock)
> +{
> +	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
> +}
> +
>   static inline struct task_struct *__owner_task(unsigned long owner)
>   {
>   	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
> @@ -75,6 +98,22 @@ static inline unsigned long __owner_flags(unsigned long owner)
>   	return owner & MUTEX_FLAGS;
>   }
>   
> +bool mutex_is_locked(struct mutex *lock)
> +{
> +	return __mutex_owner(lock) != NULL;
> +}
> +EXPORT_SYMBOL(mutex_is_locked);
> +
> +__must_check enum mutex_trylock_recursive_enum
> +mutex_trylock_recursive(struct mutex *lock)
> +{
> +	if (unlikely(__mutex_owner(lock) == current))
> +		return MUTEX_TRYLOCK_RECURSIVE;
> +
> +	return mutex_trylock(lock);
> +}
> +EXPORT_SYMBOL(mutex_trylock_recursive);
> +
>   /*
>    * Trylock variant that retuns the owning task on failure.
>    */
