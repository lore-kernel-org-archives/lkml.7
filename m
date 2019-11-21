Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3B0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C0B2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574319513;
	bh=Dq9O5rRzYDfZ50l1B2KXzOEWu+SZmS72L51ApSECga8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=irZxGc3JLwhVXTlO9I/cPUPATmsB24CYMt5AVBBRPFF/IChUh69E/ugNtuwQ1ymS3
	 15zVKRKqxuRvtXFsFNq0ykvfEUwCXS1jHOoiKZQCfAPiupOmKG2Ep3lXdXD5v7mCM2
	 TRRw3GEFItpTUpQRbf7i5zi747II571CkEurFuVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKUG6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:58:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35590 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:58:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id s5so3008439wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 22:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ydWnZbz80hDPHetOcz9VtQf8CG2Ll4S/bjHFOgvmQNA=;
        b=GqJT/7ZgXUOX7PNeD/pbEUbxhw99dd60OOa2w3z1El6FqUKzWt72Ms8jI38gb9UyZG
         gzN/3OMVhqwvUob5mIi6MaolL4GrJsFmzZSqbpqezrCoxF2Tk+zb4FnU0fCRXGSEYpn0
         40H3BGlB9rUgTMNbCQDF9QiY6MmFZNO3uHQfpMdnbUS3RWtY1VSKhZgI/WHHaWRZkE2x
         vMvdF9rXGE5X0QUEF9tIMNjVzh9/cyBexY6aIvNHLlHT5N7v5NbmAIlRZkffYF/cLg3k
         qWTc5na+0iQo3HalhA9UQl6cnvO7SfHP9T7dTGFSEl26eyUA3guWlXsPA2lVsSMjoyEM
         lOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ydWnZbz80hDPHetOcz9VtQf8CG2Ll4S/bjHFOgvmQNA=;
        b=I5mE1929dn0RW5B91V/cZx1aO+qcDWPsrZqxifWLy3cPUI67yM6CvyHQJKMwJAx2it
         5g4z9JwHcqBuE+iwmD62YTpPbGZbc6O1xhbF+xVgKzgNHl8WSLCrK8aZc9vwCc2fNEtT
         37HcRJiHEiAso360NN5AD1+J9isjNoxC6wpalIN2fUlMJ/pjSXAbRM4E2vQITnD1y49N
         ZYVDZEvqtxTZT9llSUzYzu/VQJ8vomzyaurFVM9eleki6sItqZ/8Ufr8vnoUrV7SfEqf
         8TDuQxZOH0Cxkz0CFb11YASf53MWkZ4nXwFdODOP5wP5AEkOepHNQxJK+nNIrGlvN3sC
         avHw==
X-Gm-Message-State: APjAAAVJthlni/auT1kroyj5wxnHqyTTao26ms7nT2nVwJjcPzll4Jtj
        YnnUSMUyvE0aRVFTNMyQdhskNMF+
X-Google-Smtp-Source: APXvYqw1GscIDSkpa7SNxbXnk027wjetCDz9up9QpFuFjVkFLPz13z8616o8U91k4g3GJzZ1StkBGw==
X-Received: by 2002:a5d:570a:: with SMTP id a10mr8311344wrv.107.1574319509534;
        Wed, 20 Nov 2019 22:58:29 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i71sm2301881wri.68.2019.11.20.22.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 22:58:28 -0800 (PST)
Date:   Thu, 21 Nov 2019 07:58:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] leds: Use all-in-one vtime aware kcpustat accessor
Message-ID: <20191121065826.GA3552@gmail.com>
References: <20191121024430.19938-1-frederic@kernel.org>
 <20191121024430.19938-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121024430.19938-6-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> We can now safely read user kcpustat fields on nohz_full CPUs.
> Use the appropriate accessor.
> 
> Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/leds/trigger/ledtrig-activity.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
> index ddfc5edd07c8..6901e3631c22 100644
> --- a/drivers/leds/trigger/ledtrig-activity.c
> +++ b/drivers/leds/trigger/ledtrig-activity.c
> @@ -57,11 +57,15 @@ static void led_activity_function(struct timer_list *t)
>  	curr_used = 0;
>  
>  	for_each_possible_cpu(i) {
> -		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
> -			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
> -			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
> -			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
> -			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
> +		struct kernel_cpustat kcpustat;
> +
> +		kcpustat_fetch_cpu(&kcpustat, i);
> +
> +		curr_used += kcpustat.cpustat[CPUTIME_USER]
> +			  +  kcpustat.cpustat[CPUTIME_NICE]
> +			  +  kcpustat.cpustat[CPUTIME_SYSTEM]
> +			  +  kcpustat.cpustat[CPUTIME_SOFTIRQ]
> +			  +  kcpustat.cpustat[CPUTIME_IRQ];

Not the best tested series:

--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -59,7 +59,7 @@ static void led_activity_function(struct timer_list *t)
 	for_each_possible_cpu(i) {
 		struct kernel_cpustat kcpustat;
 
-		kcpustat_fetch_cpu(&kcpustat, i);
+		kcpustat_cpu_fetch(&kcpustat, i);
 
 		curr_used += kcpustat.cpustat[CPUTIME_USER]
 			  +  kcpustat.cpustat[CPUTIME_NICE]


:-)

Thanks,

	Ingo
