Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F7DC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC99C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfFFP2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:28:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfFFP2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:28:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2268685A04;
        Thu,  6 Jun 2019 15:28:44 +0000 (UTC)
Received: from amt.cnet (ovpn-112-18.gru2.redhat.com [10.97.112.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06B9559158;
        Thu,  6 Jun 2019 15:28:37 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 42D3710514E;
        Thu,  6 Jun 2019 12:28:13 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x56FS96m003840;
        Thu, 6 Jun 2019 12:28:09 -0300
Date:   Thu, 6 Jun 2019 12:28:08 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] timers: Fix up get_target_base() to use old base properly
Message-ID: <20190606152805.GA3652@amt.cnet>
References: <20190603132944.9726-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603132944.9726-1-peterx@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 06 Jun 2019 15:28:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:29:44PM +0800, Peter Xu wrote:
> get_target_base() in the timer code is not using the "base" parameter
> at all.  My gut feeling is that instead of removing that extra
> parameter, what we really want to do is "return the old base if it
> does not suite for a new one".

Hi Peter,

I think its a dead parameter: you always want to use the local base
if the timer is not pinned.

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
