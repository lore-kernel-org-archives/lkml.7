Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F90321D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfJDKdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:33:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfJDKdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:33:01 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 041BCC059B7C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 10:33:01 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i10so2503643wrb.20
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 03:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0XRItmM0feIRH6oRRHgQMeNYVcpa+lwa27e7953gw4=;
        b=qCdhUMbRsckZ+pdMy1YGtg3/7O885/HolLxfFE3q5RpHlcwskOgcyCb6amP6pFrGsg
         SpudbHapSWIczDPMwfZ0o9xJNSFtgk/WE3B0OL3NwCJNQcGCTDpvVFd6Fie7C8VIHtEs
         1jH/EzhB/icHRXExpcdSTo1H7sneRhm3/5BOIO03AE480HxA3fxhM9qB22l7aZHEez4d
         iaFnI9pzMygt/WxjwZt31DWjR3I9X/hoExfPZcJD6WotXMN66h3wyZGvDleIRTF5a8/G
         mh50ePAH5QQt4eE7+SjWzN3aesEqmWoavToqwq4B03IPoji5w0m8iLhuOvARa9K9+ZCw
         EGtw==
X-Gm-Message-State: APjAAAXmc8DJNk6ECafyW59jxVsioJ39e9dhVDdADCAoYQD6K4502QB8
        IgyDcK5szKPgq3Dz20RZGr3RTZ6owRJZaAAPV95pcUM+KbOC0th46RpmhDSAGhIVRgsRfvFHVyq
        9q4te1UggZRvOD/0nUKgVaHwH
X-Received: by 2002:a7b:c764:: with SMTP id x4mr10544396wmk.138.1570185178752;
        Fri, 04 Oct 2019 03:32:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzL47z7J01Mlc0Ny4ymOI7hWHv9YGQ8hc0ev/0gQQd41tjTfNscKpDCKG//anTrALeM9ETJwg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr10544377wmk.138.1570185178409;
        Fri, 04 Oct 2019 03:32:58 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id r12sm6225438wrq.88.2019.10.04.03.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 03:32:57 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:32:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>
Subject: Re: [PATCH v2] lib/smp_processor_id: Don't use cpumask_equal()
Message-ID: <20191004103255.GE19588@localhost.localdomain>
References: <20191003203608.21881-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003203608.21881-1-longman@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/10/19 16:36, Waiman Long wrote:
> The check_preemption_disabled() function uses cpumask_equal() to see
> if the task is bounded to the current CPU only. cpumask_equal() calls
> memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
> the slow memcmp() function in lib/string.c is used.
> 
> On a RT kernel that call check_preemption_disabled() very frequently,
> below is the perf-record output of a certain microbenchmark:
> 
>   42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
>   40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp
> 
> We should avoid calling memcmp() in performance critical path. So the
> cpumask_equal() call is now replaced with an equivalent simpler check.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/smp_processor_id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
> index 60ba93fc42ce..bd9571653288 100644
> --- a/lib/smp_processor_id.c
> +++ b/lib/smp_processor_id.c
> @@ -23,7 +23,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
>  	 * Kernel threads bound to a single CPU can safely use
>  	 * smp_processor_id():
>  	 */
> -	if (cpumask_equal(current->cpus_ptr, cpumask_of(this_cpu)))
> +	if (current->nr_cpus_allowed == 1)
>  		goto out;

Makes sense to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,

Juri
