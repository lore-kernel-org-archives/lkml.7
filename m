Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF24C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336CB20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCFUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:39:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfCFUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:39:39 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1h1dKD-000468-Dl
        for linux-kernel@vger.kernel.org; Wed, 06 Mar 2019 20:39:37 +0000
Received: by mail-ed1-f69.google.com with SMTP id d31so6939181eda.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdpZkT7R0+dWNs314gvphoexyR7vBHsfYtrJAa8MRmA=;
        b=f/vkR61tkHAkUhlGL5S5zzEKTssWl3EqLYdyIPowBKMZn5HTiAAoxCJfGsykwlYMe2
         P8yMr6ogr4s7MYmrsOZcVVRY0Bh22mV3AFaEHjgPa6+au6O/5E9GngslmMet+v6N/II9
         lE9QiCBGfM+ZFspGgIkC65vOL0Yy5j6QlKNtI6iaIv5hOn8Pb4BTyHqbpPUaIffkfWJW
         tLR7XG39lnwLsTD2QOg/u4hq2C9ylAwZzGyXJxYigeOEX56n5wmBIO3DNlyFvoN10Iqc
         DrZtMPfDkFQDrlHfc1zc7j2oZ7WekpbOMelW74cnXAFCMvP287L4GEe7O/PmsZYEXsXe
         n3xg==
X-Gm-Message-State: APjAAAWKFktkGaUGrn/T7Wt/zwTabWwCtaC9QHSRKImk5UDOBK+IEpqF
        3A2BjpFcydiF4/r62tjWWoqvZJaVXkdULZiKHLPLT67UonSKHFK/BIOZGX+4hi3Y5WDk7C2y/0V
        OlsF8Voo/kejTqXvEy9hd6De1ZlIgINarWHz1KvbPxg==
X-Received: by 2002:a50:8978:: with SMTP id f53mr25244695edf.212.1551904776968;
        Wed, 06 Mar 2019 12:39:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+1nPWVN98CbPLZzXydiux0qZC3nISnqul3y8cj1fN2Y2APsLGaCXQo8/DXIKtDaT2FdkvrQ==
X-Received: by 2002:a50:8978:: with SMTP id f53mr25244678edf.212.1551904776571;
        Wed, 06 Mar 2019 12:39:36 -0800 (PST)
Received: from gmail.com ([2a02:8109:b6c0:76e:3ddf:44fc:d22b:95ce])
        by smtp.gmail.com with ESMTPSA id x36sm725660eda.94.2019.03.06.12.39.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 06 Mar 2019 12:39:36 -0800 (PST)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Wed, 6 Mar 2019 21:39:35 +0100
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
Message-ID: <20190306203932.im7lkblvmd227td3@gmail.com>
References: <20190306201413.14153-1-tycho@tycho.ws>
 <20190306201413.14153-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306201413.14153-2-tycho@tycho.ws>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 01:14:13PM -0700, Tycho Andersen wrote:
> As the comment notes, the return codes for TSYNC and NEW_LISTENER conflict,
> because they both return positive values, one in the case of success and
> one in the case of error. So, let's disallow both of these flags together.
> 
> While this is technically a userspace break, all the users I know of are
> still waiting on me to land this feature in libseccomp, so I think it'll be
> safe. Also, at present my use case doesn't require TSYNC at all, so this
> isn't a big deal to disallow. If someone wanted to support this, a path
> forward would be to add a new flag like
> TSYNC_AND_LISTENER_YES_I_UNDERSTAND_THAT_TSYNC_WILL_JUST_RETURN_EAGAIN, but
> the use cases are so different I don't see it really happening.
> 
> Finally, it's worth noting that this does actually fix a UAF issue: at the end
> of seccomp_set_mode_filter(), we have:
> 
>         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
>                 if (ret < 0) {
>                         listener_f->private_data = NULL;
>                         fput(listener_f);
>                         put_unused_fd(listener);
>                 } else {
>                         fd_install(listener, listener_f);
>                         ret = listener;
>                 }
>         }
> out_free:
>         seccomp_filter_free(prepared);
> 
> But if ret > 0 because TSYNC raced, we'll install the listener fd and then free
> the filter out from underneath it, causing a UAF when the task closes it or
> dies. This patch also switches the condition to be simply if (ret), so that
> if someone does add the flag mentioned above, they won't have to remember
> to fix this too.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> CC: stable@vger.kernel.org # v5.0+
> ---
>  kernel/seccomp.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index d0d355ded2f4..79bada51091b 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -500,7 +500,10 @@ seccomp_prepare_user_filter(const char __user *user_filter)
>   *
>   * Caller must be holding current->sighand->siglock lock.
>   *
> - * Returns 0 on success, -ve on error.
> + * Returns 0 on success, -ve on error, or
> + *   - in TSYNC mode: the pid of a thread which was either not in the correct
> + *     seccomp mode or did not have an ancestral seccomp filter
> + *   - in NEW_LISTENER mode: the fd of the new listener
>   */
>  static long seccomp_attach_filter(unsigned int flags,
>  				  struct seccomp_filter *filter)
> @@ -1256,6 +1259,16 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  	if (flags & ~SECCOMP_FILTER_FLAG_MASK)
>  		return -EINVAL;
>  
> +	/*
> +	 * In the successful case, NEW_LISTENER returns the new listener fd.
> +	 * But in the failure case, TSYNC returns the thread that died. If you
> +	 * combine these two flags, there's no way to tell whether something
> +	 * succeded or failed. So, let's disallow this combination.
> +	 */
> +	if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
> +	    (flags && SECCOMP_FILTER_FLAG_NEW_LISTENER))
> +		return -EINVAL;

May license a manpage entry that this makes it potentially unsafe to use
with multiple threads. But I don't see a use-case for this right now so
it looks sane to me. :)

(Though one simple question below.)

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> +
>  	/* Prepare the new filter before holding any locks. */
>  	prepared = seccomp_prepare_user_filter(filter);
>  	if (IS_ERR(prepared))
> @@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  		mutex_unlock(&current->signal->cred_guard_mutex);
>  out_put_fd:
>  	if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> -		if (ret < 0) {
> +		if (ret) {

Why that change but keep checking if (ret < 0) further up?

>  			listener_f->private_data = NULL;
>  			fput(listener_f);
>  			put_unused_fd(listener);
> -- 
> 2.19.1
> 
