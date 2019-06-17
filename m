Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EBC31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DA221881
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 04:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfFQEJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 00:09:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfFQEJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 00:09:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF02730832E1;
        Mon, 17 Jun 2019 04:09:37 +0000 (UTC)
Received: from xz-x1 (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14FBD80949;
        Mon, 17 Jun 2019 04:09:32 +0000 (UTC)
Date:   Mon, 17 Jun 2019 12:09:29 +0800
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base properly
Message-ID: <20190617040929.GB12456@xz-x1>
References: <20190603132944.9726-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190603132944.9726-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 17 Jun 2019 04:09:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:29:44PM +0800, Peter Xu wrote:
> get_target_base() in the timer code is not using the "base" parameter
> at all.  My gut feeling is that instead of removing that extra
> parameter, what we really want to do is "return the old base if it
> does not suite for a new one".

Ping?

Note that as reference hrtimer is using the same logic as in this
patch. 

> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: John Stultz <john.stultz@linaro.org>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Luiz Capitulino <lcapitulino@redhat.com>
> CC: Marcelo Tosatti <mtosatti@redhat.com>
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  kernel/time/timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 343c7ba33b1c..6ff6ffd2c719 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -868,7 +868,7 @@ get_target_base(struct timer_base *base, unsigned tflags)
>  	    !(tflags & TIMER_PINNED))
>  		return get_timer_cpu_base(tflags, get_nohz_timer_target());
>  #endif
> -	return get_timer_this_cpu_base(tflags);
> +	return base;
>  }
>  
>  static inline void forward_timer_base(struct timer_base *base)
> -- 
> 2.17.1
> 

Regards,

-- 
Peter Xu
