Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D21CC48BD3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766472075B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 13:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOZym21L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfGFNCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 09:02:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37045 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGFNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 09:02:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so2758601ljn.4;
        Sat, 06 Jul 2019 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=52BprqlVDWbCsQ1NEtnXaXZ+0CoB00f6xjSj2np3pDk=;
        b=OOZym21LfegewVwvfPzS4p2BWszlZBxyEaf5OrjoKdJMoOMFaoeRhWC7SGcjkW553B
         Nj7Dht7dpVbXidrhR8WF9Ld1OlssB/qscLYtPa68BG7PjLJmTl5HuCBhtSa6+7SZQAea
         wCn3a6zkuvX2GF/Es9/2rC2t4hn8Pp+gB8r08ASOZKx6Tbc5AfIOuY/jBPh5UUamE+sP
         0W9yOemJgQFAr2rhSnPWeg3bI3ULx2l5tG66cSAsLrq8fPCpjoL1yoq/VQSZssz4fIJh
         iL4G2abfIWZpG7nu1b70RFbAv8tAI1sk5sgmPop8JjL1ZOoj5KvdKDa3Z/gaDVil/B3H
         T5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=52BprqlVDWbCsQ1NEtnXaXZ+0CoB00f6xjSj2np3pDk=;
        b=sKH1CrRxKPhiro9n9tm2wAvUKtIUAI3smN3qgOIwmzzr6mQ7r/93pKZWAAdzZ2kVUK
         1dCgPtI3ViNf+vD1VX03Ct/FKBuJqqigtUM6olYFGcKTlcAXVq5YpZFjwH9R4wJbcTCk
         Rhhw7eMLjV1e+tQio1jzXWF/Jv2ytSo2+L/F3CQ185wJ3ceSbQhirkG4BkqRWwvoU4mq
         MAHxKb8+mCXgP4+sCp3XSFr4fAMNeIeIpyhDJ8DiqbrWfbKYVaKikrlp5BjM5cknyo2b
         MwH2d2TfpRhV1fbLNqtnU/UXeLXX5BNWMiGwqT/GziIEA4qzRvqr4ehsP6pMul5KffGu
         nWtg==
X-Gm-Message-State: APjAAAVZxri0IoNdHBXjeuiG+fH7yaCJOvIaz9N7JbNWX74FIGM+AS3f
        0k6dhIuqI9h9IsIk/MDJN2U=
X-Google-Smtp-Source: APXvYqz4qfro3InUvcboilJbr5sl9HxVbSVzAjfzVQCOKAI7VHrE9ryz53nWUSdpmsDOMeRzmhHV6Q==
X-Received: by 2002:a2e:894a:: with SMTP id b10mr4249623ljk.99.1562418133466;
        Sat, 06 Jul 2019 06:02:13 -0700 (PDT)
Received: from [84.217.169.237] (c-74afd954.51034-0-757473696b74.bbcust.telenor.se. [84.217.169.237])
        by smtp.gmail.com with ESMTPSA id b27sm450300ljb.11.2019.07.06.06.02.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 06:02:12 -0700 (PDT)
Subject: Re: The tick is active on idle adaptive-tick CPUs when
 /dev/cpu_dma_latency is used
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <79b247b3-e056-610e-9a07-e685dfdaa6c9@gmail.com>
 <CAJZ5v0grOas+Wh0h09fKZmUnOJ3PRX2Fc=2fv7=zCFJiZ09-Bg@mail.gmail.com>
 <7332404.L1nL2KBT3s@kreacher>
From:   Thomas Lindroth <thomas.lindroth@gmail.com>
Message-ID: <6ef6b96e-1772-6e80-60cf-eb57af618e99@gmail.com>
Date:   Sat, 6 Jul 2019 15:02:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7332404.L1nL2KBT3s@kreacher>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/19 1:06 PM, Rafael J. Wysocki wrote:
> The patch is below, but note that it adds the tick stopping overhead to the idle loop
> for CPUs that are not adaptive-tick and when PM QoS latency constraints are used
> which is not desirable in general.
> 
> Please test it, but as I said above, the real solution appears to be to treat adaptive-tick
> CPUs in a special way in the idle loop.
> 
> ---
>   drivers/cpuidle/governors/menu.c |   16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -302,9 +302,10 @@ static int menu_select(struct cpuidle_dr
>   	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
>   		/*
>   		 * In this case state[0] will be used no matter what, so return
> -		 * it right away and keep the tick running.
> +		 * it right away and keep the tick running if state[0] is a
> +		 * polling one.
>   		 */
> -		*stop_tick = false;
> +		*stop_tick = !!(drv->states[0].flags & CPUIDLE_FLAG_POLLING);
>   		return 0;
>   	}
>   
> @@ -395,16 +396,9 @@ static int menu_select(struct cpuidle_dr
>   
>   			return idx;
>   		}
> -		if (s->exit_latency > latency_req) {
> -			/*
> -			 * If we break out of the loop for latency reasons, use
> -			 * the target residency of the selected state as the
> -			 * expected idle duration so that the tick is retained
> -			 * as long as that target residency is low enough.
> -			 */
> -			predicted_us = drv->states[idx].target_residency;
> +		if (s->exit_latency > latency_req)
>   			break;
> -		}
> +
>   		idx = i;
>   	}

I tested the patch and it appears to work. Idle CPUs now have ticks disabled even
when /dev/cpu_dma_latency is used.

I also want to thank you for your work on the idle loop redesign. Overall it works
much better than before. I used to have a problem where idle CPUs would end up
doing C0 polling for a long time resulting in a big performance drop on the HT
sibling. When benchmarking I always had to offline siblings to get consistent
results. That problem was fixed in the redesign.
