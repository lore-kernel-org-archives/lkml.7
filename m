Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C856EC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E092080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5ZR6Xz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbfHZRiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:38:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43816 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbfHZRiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:38:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so12237375pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tTusFdpElP2TSQjgB9wqdpC9r5hygfBOjwSB4cOVhWk=;
        b=V5ZR6Xz1vT1lQEWb5Z9s8YhW85MxT+4EtE5tpZ8PvPPBugGSN8HnbeypGOfAmWJACz
         RcwbsokM9i82NkbABrGCtGqUlL30kFmScE1QiBrB5GczMawXOkSB7LR+6MQIkwXb0025
         yyIMtkIdvWDx8ffZg6cJ4gSOPR0B46+BmXvRMc/L8Kz94f7ixEiyq1x+dZlgOwEwBe4f
         U978IImjCP5Ocdb8825xY8OPQVaw6hCj0HBPW7KUGx9CuFlQ95SKtKlv9QnMuwcKBKeh
         Hkn5oh5FPSjUGR7zH7DWIf6P6D8EcVamo8EmrdpXSnJ6lzzhm8TzdwHguGNXWPTuPKnJ
         NMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tTusFdpElP2TSQjgB9wqdpC9r5hygfBOjwSB4cOVhWk=;
        b=tRaExiv18c3o/uArcAJYlRQ3+oaFjbsbyJX9JE/8SQKNnaXqXJ8X2r7Nt7CAi3y7r/
         /sKhFf7sqri+alEi0xm/iZg32T+nBcFth7egaMgTp4eKJDzX+QFgz8D6RxfQ6Uv0hsR0
         KMUTJbJI3S1Mkn0QVeiGA6TmC2z1dLC9BIsPOtVq3DFEstnSyMYTyhq6TWCh0ZvbiTaD
         IKEzJlUOCrgFaqUpYwgsA7F1WwDL/bAZHZQvaC8kMXIwrie2FJb22Mt7d8js3Rntm7Xi
         gHOfbOjayJ1Pfi7/5Br5OzU8nloxmgRKOnsYKsKZiIJgYsoGHiR/F49PMyQM2HiavCMa
         n86A==
X-Gm-Message-State: APjAAAVUZ7p/D9sAYoNCC1WAJKoO3IeSNdGHXFJmAp0rdfS4jeSbz64W
        V5iVYHQ+3W9RmB3ZZAnJTpAulA==
X-Google-Smtp-Source: APXvYqzLQNC8HuihL9494jGRneLz1dGcEpdYaPSkTMgN6E5IpA2x8wJg5Pt78SCsaRkzKrrvkDWN6w==
X-Received: by 2002:aa7:9393:: with SMTP id t19mr20643596pfe.12.1566841104018;
        Mon, 26 Aug 2019 10:38:24 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id d16sm16768998pfd.81.2019.08.26.10.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 10:38:22 -0700 (PDT)
From:   bsegall@google.com
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Liangyan <liangyan.peng@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH] sched/fair: don't assign runtime for throttled cfs_rq
References: <20190814180021.165389-1-liangyan.peng@linux.alibaba.com>
        <xm26d0gvirdg.fsf@bsegall-linux.svl.corp.google.com>
        <942ae15c-ffa5-74da-208b-7e82df917e16@arm.com>
Date:   Mon, 26 Aug 2019 10:38:02 -0700
In-Reply-To: <942ae15c-ffa5-74da-208b-7e82df917e16@arm.com> (Valentin
        Schneider's message of "Sat, 24 Aug 2019 00:19:02 +0100")
Message-ID: <xm26k1azn7yd.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> writes:

> On 23/08/2019 21:00, bsegall@google.com wrote:
> [...]
>> Could you mention in the message that this a throttled cfs_rq can have
>> account_cfs_rq_runtime called on it because it is throttled before
>> idle_balance, and the idle_balance calls update_rq_clock to add time
>> that is accounted to the task.
>> 
>
> Mayhaps even a comment for the extra condition.
>
>> I think this solution is less risky than unthrottling
>> in this area, so other than that:
>> 
>> Reviewed-by: Ben Segall <bsegall@google.com>
>> 
>
> If you don't mind squashing this in:
>
> -----8<-----
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b1d9cec9b1ed..b47b0bcf56bc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4630,6 +4630,10 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>  		if (!cfs_rq_throttled(cfs_rq))
>  			goto next;
>  
> +		/* By the above check, this should never be true */
> +		WARN_ON(cfs_rq->runtime_remaining > 0);
> +
> +		/* Pick the minimum amount to return to a positive quota state */
>  		runtime = -cfs_rq->runtime_remaining + 1;
>  		if (runtime > remaining)
>  			runtime = remaining;
> ----->8-----
>
> I'm not adamant about the extra comment, but the WARN_ON would be nice IMO.
>
>
> @Ben, do you reckon we want to strap
>
> Cc: <stable@vger.kernel.org>
> Fixes: ec12cb7f31e2 ("sched: Accumulate per-cfs_rq cpu usage and charge against bandwidth")
>
> to the thing? AFAICT the pick_next_task_fair() + idle_balance() dance you
> described should still be possible on that commit.

I'm not sure about stable policy in general, but it seems reasonable.
The WARN_ON might want to be WARN_ON_ONCE, and it seems fine to have it
or not.

>
>
> Other than that,
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> [...]
