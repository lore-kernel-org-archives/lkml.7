Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6ABC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E280B2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIFX/g4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbfKGPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:38:55 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55878 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:38:54 -0500
Received: by mail-wm1-f47.google.com with SMTP id b11so2952854wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=td8ivn6HMnYDeB2Y4ofVQkcwrmwl8/xF8VLFkmr1OIg=;
        b=wIFX/g4H++tVslYBfqNzX9niYmHhyN4lzaes3nyaEfZvmusoG1QwL8pMOKwWogqoI6
         hI+6340m9Wn6BfWDdWBlQwyx+sj/y0fp6LwSkZrsfhvIryrNUM0HCKHzh5uTsqhi07m4
         gE6wiDVpuyLn8Xm84+5OY7wjAcjr0Pnjr3oV+0mUpMRSoJYiPEvdCyVOKEL1utra2eeT
         UIY9EfBrHG9j0NpR+gbJl7yOTk8isqj5ctwRZHePh3qQPx3UYu+7xfDmDY+rb8yoPMXu
         7qnMdkkyOi1tCbtvvfAP0oTzokqgnpPOGLZenu0EyLvblzWsfDI1qPO+2NRNYE6PXPgf
         TIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=td8ivn6HMnYDeB2Y4ofVQkcwrmwl8/xF8VLFkmr1OIg=;
        b=lEcoc5WJPrs9MhLg+l5dbbvFIYglBjWDmuCb9CaohJ1o1tHxyLyLyFAVLI3AO1T7im
         MizYbYjeytKfXO37Wzj6MBvVZK3MWT4fPr10HQrbTl1LKlLqM96bPAt2KaapWEc5Q4vb
         RJJJBGdRZxv0B09PhLbKWYTA/enbxlK8xH/Hm/v0m675gIUUYidQp/4+tfqRQtKsnR66
         Q6fRi6OtOYyzRu0eDr3nUp6Y/hIZVKsjOyhLduAMKO5iqfPK7G9+RhOarSx06CeRueHQ
         MwcysnqGpstgaFWRb1MPpz+kw+uhlwH39OnzNsceJT/iX9gAHxFXpo4vxSdwxP2mAGHe
         FoGQ==
X-Gm-Message-State: APjAAAUkIWLm7uWpAMl1ZZOHRlD26G8JrTyVYClnDnFCX+/LtbsLmdcs
        0FkMlzpIbyJ6kjYIslbrWE7lLg==
X-Google-Smtp-Source: APXvYqww9cIAJydXkh6COrb6XBiX8uy26MoHTMWwZjN7I9k136PrmP5xRVrQX1wqR7CSK5x2wc9UdA==
X-Received: by 2002:a1c:411:: with SMTP id 17mr3293231wme.122.1573141132210;
        Thu, 07 Nov 2019 07:38:52 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 65sm4362281wrs.9.2019.11.07.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 07:38:51 -0800 (PST)
Date:   Thu, 7 Nov 2019 15:38:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        aaron.lwe@gmail.com, valentin.schneider@arm.com, mingo@kernel.org,
        pauld@redhat.com, jdesfossez@digitalocean.com,
        naravamudan@digitalocean.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        kernel-team@android.com, john.stultz@linaro.org
Subject: Re: NULL pointer dereference in pick_next_task_fair
Message-ID: <20191107153848.GA31774@google.com>
References: <20191028174603.GA246917@google.com>
 <20191106120525.GX4131@hirez.programming.kicks-ass.net>
 <33643a5b-1b83-8605-2347-acd1aea04f93@virtuozzo.com>
 <20191106165437.GX4114@hirez.programming.kicks-ass.net>
 <20191106172737.GM5671@hirez.programming.kicks-ass.net>
 <831c2cd4-40a4-31b2-c0aa-b5f579e770d6@virtuozzo.com>
 <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107132628.GZ4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Nov 2019 at 14:26:28 (+0100), Peter Zijlstra wrote:
> Given that we're stuck with this order, the only solution is fixing
> the 'change' pattern. The simplest fix seems to be to 'absuse'
> p->on_cpu to carry more state. Adding more state to p->on_rq is
> possible but is far more invasive and also ends up duplicating much of
> the state we already carry in p->on_cpu.

I think there is another solution, which is to 'de-factorize' the call
to put_prev_task() (that is, have each class do it). I gave it a go and
I basically end up with something equivalent to reverting 67692435c411
("sched: Rework pick_next_task() slow-path"), which isn't the worst
solution IMO. I'm thinking at least we should consider it.

Now, 67692435c411 _is_ a nice clean-up, it's just a shame that the fix
on top isn't as nice (IMO). It might just be a matter of personal taste,
so I don't have a strong opinion on this :)

Thanks,
Quentin
