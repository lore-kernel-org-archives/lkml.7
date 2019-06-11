Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BC2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao3zmTFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406040AbfFKR0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:26:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405718AbfFKR0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:26:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so7321933pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x7gqKLfRpHe9vrXM3bCbycR5QKc3TzKUjSsuTFhy9SI=;
        b=ao3zmTFVyhfDJBUo70qvU+vSx1HAy01AACcLy3QNsUXuzvSz3PjExFYbwsfHMfRIH0
         DVRZkzjyGYTIfn9Mv5FjmvmJWt9jfcyn1YrU294GHPD/kIqqhBXkcgrmsEvW6eGUOFgn
         w9HuweP7oLaOvfM+XUs9QDlzzwB00FqxMUTkH2w1szEtPDz8wInJYfZZXw/v0Rr8Bj3/
         At96LJQO+5dLVCsRitJCyKoeGYROP4e3RZXmZFE2+6syNJubBqSXDHQbB7clUP1K5zQh
         uARg6BqXaQ9k7rN1MvtkoPekOBPqMIRyVK6Qdz9WAq7PLSX8UtOqSo1zy+4XV4oez/Pb
         gdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=x7gqKLfRpHe9vrXM3bCbycR5QKc3TzKUjSsuTFhy9SI=;
        b=eT5tiKi8xOWVBrJ+na8HhClkEYX28JDBqKmsmscct23fxE0fcVIAmd7SqvmVLOmyhH
         o8wsTcRuGkKQW+Qy310lAdwYXYWiQQ/ITA3cggGhm+0709VxT4W5QiCAzRQ31jtwOfLE
         ngN3aDWcJ1QyHmQnVay3WJMhr+9+F6QJSo4sCV5a94DIHMTTr6GEAgwtjgvb0nCNBrvt
         o+akEkkmQyWocWugV7kWoVqlRiEWOwXuAV4jMOSB/T3KR8xHMPdLdn3+O2X7jaQioeg4
         ToVqqbT7Sr3EA4b0nvY5d+I3UPA1iknSEd6yolJq8nXVsEpJWGw4S4hUf1uX15ddrrH3
         vm4g==
X-Gm-Message-State: APjAAAXXQ+YZ3sm88o5C1hWeAo9SnN1eFiJmnA6GCLomFnd32+8i92Dy
        WLCg6qHV2+wLRNziiCw0P/dhOQ==
X-Google-Smtp-Source: APXvYqwLEf55MiRdjUPi8ZLbozB/LLlGffxQkoaU94QGRlwrY6Lm36ujIyAxg++aJQNhI6OoklLf1A==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr28047722pjb.143.1560273970636;
        Tue, 11 Jun 2019 10:26:10 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id k184sm4181822pgk.7.2019.06.11.10.26.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 10:26:09 -0700 (PDT)
From:   bsegall@google.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/fair: don't push cfs_bandwith slack timers forward
References: <xm26ef47yeyh.fsf@bsegall-linux.svl.corp.google.com>
        <eafe846f-d83c-b2f3-4458-45e3ae6e5823@linux.alibaba.com>
        <xm26a7euy6iq.fsf_-_@bsegall-linux.svl.corp.google.com>
        <20190611135325.GY3436@hirez.programming.kicks-ass.net>
Date:   Tue, 11 Jun 2019 10:26:08 -0700
In-Reply-To: <20190611135325.GY3436@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 11 Jun 2019 15:53:25 +0200")
Message-ID: <xm2636kgxccv.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Jun 06, 2019 at 10:21:01AM -0700, bsegall@google.com wrote:
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index efa686eeff26..60219acda94b 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -356,6 +356,7 @@ struct cfs_bandwidth {
>>  	u64			throttled_time;
>>  
>>  	bool                    distribute_running;
>> +	bool                    slack_started;
>>  #endif
>>  };
>
> I'm thinking we can this instead? afaict both idle and period_active are
> already effecitively booleans and don't need the full 16 bits.
>
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -338,8 +338,10 @@ struct cfs_bandwidth {
>  	u64			runtime_expires;
>  	int			expires_seq;
>  
> -	short			idle;
> -	short			period_active;
> +	u8			idle;
> +	u8			period_active;
> +	u8			distribute_running;
> +	u8			slack_started;
>  	struct hrtimer		period_timer;
>  	struct hrtimer		slack_timer;
>  	struct list_head	throttled_cfs_rq;
> @@ -348,9 +350,6 @@ struct cfs_bandwidth {
>  	int			nr_periods;
>  	int			nr_throttled;
>  	u64			throttled_time;
> -
> -	bool                    distribute_running;
> -	bool                    slack_started;
>  #endif
>  };
>  


Yeah, that makes sense to me, should I spin up another version of the
patch doing this too or do you have it from here?
