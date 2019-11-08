Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59626FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F912084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="u3f2l8qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfKHWLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:11:11 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37997 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:11:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id v24so6534151otp.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5KpRmywjJeE+4W6tQj+g4HCES1tRk6e1MGgIomASk0A=;
        b=u3f2l8qnQa4IB/3bCa5xVtOxB9hQlyfGZC3zvshPZU6EkSGeZgNZ0ao5kua009oqsy
         44lV49NstYWPOS/t3pOdD0wUQTsDYyrJYoLgnNb8kDLKGCsFOT61W/vttRyuY8Ds7jmX
         cVi5CpRfF0FNzNk3HYsGg643eP6VD9KcB1Aatsy9z1xZlCKHO9VLtxgvLfxGxqDKytEk
         15kgYRFhJw2nLMpeyHVND/eWC67for5H6u93z/D516LEnBP+XSf8kalORoS/ZriSoPpE
         4gzzls4GHaE+ZxCLv36wZBjjd0pNH17Juj347I6GJLkpfV80X/fOlnS0hy1uFXs1tMc0
         al7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5KpRmywjJeE+4W6tQj+g4HCES1tRk6e1MGgIomASk0A=;
        b=Q7ixhq8nfQm6Xw/mW5SVCot+vXbUhS14lo/F0SHZoRC/CEwQm1esRZ6ilTrIdr3kpv
         CEiYHIXHWr6jEDIxjw7tqUVv3+eEREWt00G4758YdcyIdedvlmimy+MIhxwiHTwuEO5R
         fAzMqlZOIGB/ppEAeyB/TueVVfuFJoJzE8veBzhoHfki9Z3VW7Sj4q7pJr790hv5V9AS
         CjnFUyTliptyxSZ+8thoejGtUZSG4n5l0sN44cWWl7uM7WXxxryvWeIhZZBZhkk7rJfb
         fcaUsKnsdOAtrb6I/pKA0Uoj/ZyDWGnfrRRt2vR5Z7eL8OJi3C18Xj6/1ZeTiwaKmd8k
         AEfw==
X-Gm-Message-State: APjAAAUEcvIs6ZcF2Q2SDSALCEEC+7R5G96MnY7g94bDsMpj3o/Nv+p3
        54mI5QIgm9IAf8or6i9/3Re7Eg==
X-Google-Smtp-Source: APXvYqyodqON+OMREpWCiY78XW1yFB1s64QQ/7TZd35N1EsiNbbU7RBvAcSguKkEqtQhVcRLMvXUYQ==
X-Received: by 2002:a9d:634d:: with SMTP id y13mr6625886otk.202.1573251068916;
        Fri, 08 Nov 2019 14:11:08 -0800 (PST)
Received: from minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id e62sm2206504oif.12.2019.11.08.14.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 14:11:08 -0800 (PST)
Date:   Fri, 8 Nov 2019 16:11:06 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH 4/8] ipmi: kill off 'timespec' usage again
Message-ID: <20191108221106.GT10313@minyard.net>
Reply-To: cminyard@mvista.com
References: <20191108203435.112759-1-arnd@arndb.de>
 <20191108203435.112759-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108203435.112759-5-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 09:34:27PM +0100, Arnd Bergmann wrote:
> 'struct timespec' is getting removed from the kernel. The usage in ipmi
> was fixed before in commit 48862ea2ce86 ("ipmi: Update timespec usage
> to timespec64"), but unfortunately it crept back in.
> 
> The busy looping code can better use ktime_t anyway, so use that
> there to simplify the implementation.

Thanks, this is a big improvement.  I have this queued, but if you
are going to submit this, I can remove it, and:

Reviewed-by: Corey Minyard <cminyard@mvista.com>

Do you think this should go in to 5.4?

-corey

> 
> Fixes: cbb19cb1eef0 ("ipmi_si: Convert timespec64 to timespec")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 40 +++++++++++---------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 6b9a0593d2eb..c7cc8538b84a 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -265,10 +265,10 @@ static void cleanup_ipmi_si(void);
>  #ifdef DEBUG_TIMING
>  void debug_timestamp(char *msg)
>  {
> -	struct timespec t;
> +	struct timespec64 t;
>  
> -	ktime_get_ts(&t);
> -	pr_debug("**%s: %ld.%9.9ld\n", msg, (long) t.tv_sec, t.tv_nsec);
> +	ktime_get_ts64(&t);
> +	pr_debug("**%s: %lld.%9.9ld\n", msg, t.tv_sec, t.tv_nsec);
>  }
>  #else
>  #define debug_timestamp(x)
> @@ -935,38 +935,25 @@ static void set_run_to_completion(void *send_info, bool i_run_to_completion)
>  }
>  
>  /*
> - * Use -1 in the nsec value of the busy waiting timespec to tell that
> - * we are spinning in kipmid looking for something and not delaying
> - * between checks
> + * Use -1 as a special constant to tell that we are spinning in kipmid
> + * looking for something and not delaying between checks
>   */
> -static inline void ipmi_si_set_not_busy(struct timespec *ts)
> -{
> -	ts->tv_nsec = -1;
> -}
> -static inline int ipmi_si_is_busy(struct timespec *ts)
> -{
> -	return ts->tv_nsec != -1;
> -}
> -
> +#define IPMI_TIME_NOT_BUSY ns_to_ktime(-1ull)
>  static inline bool ipmi_thread_busy_wait(enum si_sm_result smi_result,
>  					 const struct smi_info *smi_info,
> -					 struct timespec *busy_until)
> +					 ktime_t *busy_until)
>  {
>  	unsigned int max_busy_us = 0;
>  
>  	if (smi_info->si_num < num_max_busy_us)
>  		max_busy_us = kipmid_max_busy_us[smi_info->si_num];
>  	if (max_busy_us == 0 || smi_result != SI_SM_CALL_WITH_DELAY)
> -		ipmi_si_set_not_busy(busy_until);
> -	else if (!ipmi_si_is_busy(busy_until)) {
> -		ktime_get_ts(busy_until);
> -		timespec_add_ns(busy_until, max_busy_us * NSEC_PER_USEC);
> +		*busy_until = IPMI_TIME_NOT_BUSY;
> +	else if (*busy_until == IPMI_TIME_NOT_BUSY) {
> +		*busy_until = ktime_get() + max_busy_us * NSEC_PER_USEC;
>  	} else {
> -		struct timespec now;
> -
> -		ktime_get_ts(&now);
> -		if (unlikely(timespec_compare(&now, busy_until) > 0)) {
> -			ipmi_si_set_not_busy(busy_until);
> +		if (unlikely(ktime_get() > *busy_until)) {
> +			*busy_until = IPMI_TIME_NOT_BUSY;
>  			return false;
>  		}
>  	}
> @@ -988,9 +975,8 @@ static int ipmi_thread(void *data)
>  	struct smi_info *smi_info = data;
>  	unsigned long flags;
>  	enum si_sm_result smi_result;
> -	struct timespec busy_until = { 0, 0 };
> +	ktime_t busy_until = IPMI_TIME_NOT_BUSY;
>  
> -	ipmi_si_set_not_busy(&busy_until);
>  	set_user_nice(current, MAX_NICE);
>  	while (!kthread_should_stop()) {
>  		int busy_wait;
> -- 
> 2.20.0
> 
