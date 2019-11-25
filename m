Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F299C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507772075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfKYMsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:48:33 -0500
Received: from foss.arm.com ([217.140.110.172]:50002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYMsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:48:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEED031B;
        Mon, 25 Nov 2019 04:48:31 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70C8C3F68E;
        Mon, 25 Nov 2019 04:48:30 -0800 (PST)
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        riel@surriel.com
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <e33e1896-01e1-665d-862a-e73384b0fbe6@arm.com>
Date:   Mon, 25 Nov 2019 12:48:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2019 14:26, Vincent Guittot wrote:
>            tip/sched/core        w/ this patchset    improvement
> schedpipe      53125 +/-0.18%        53443 +/-0.52%   (+0.60%)
> 
> hackbench -l (2560/#grp) -g #grp
>  1 groups      1.579 +/-29.16%       1.410 +/-13.46% (+10.70%)
>  4 groups      1.269 +/-9.69%        1.205 +/-3.27%   (+5.00%)
>  8 groups      1.117 +/-1.51%        1.123 +/-1.27%   (+4.57%)
> 16 groups      1.176 +/-1.76%        1.164 +/-2.42%   (+1.07%)
> 
> Unixbench shell8
>   1 test     1963.48 +/-0.36%       1902.88 +/-0.73%    (-3.09%)
> 224 tests    2427.60 +/-0.20%       2469.80 +/-0.42%  (1.74%)
> 
> - large arm64 2 nodes / 224 cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe     124084 +/-1.36%       124445 +/-0.67%   (+0.29%)
> 
> hackbench -l (256000/#grp) -g #grp
>   1 groups    15.305 +/-1.50%       14.001 +/-1.99%   (+8.52%)
>   4 groups     5.959 +/-0.70%        5.542 +/-3.76%   (+6.99%)
>  16 groups     3.120 +/-1.72%        3.253 +/-0.61%   (-4.92%)
>  32 groups     2.911 +/-0.88%        2.837 +/-1.16%   (+2.54%)
>  64 groups     2.805 +/-1.90%        2.716 +/-1.18%   (+3.17%)
> 128 groups     3.166 +/-7.71%        3.891 +/-6.77%   (+5.82%)
> 256 groups     3.655 +/-10.09%       3.185 +/-6.65%  (+12.87%)
> 
> dbench
>   1 groups   328.176 +/-0.29%      330.217 +/-0.32%   (+0.62%)
>   4 groups   930.739 +/-0.50%      957.173 +/-0.66%   (+2.84%)
>  16 groups  1928.292 +/-0.36%     1978.234 +/-0.88%   (+0.92%)
>  32 groups  2369.348 +/-1.72%     2454.020 +/-0.90%   (+3.57%)
>  64 groups  2583.880 +/-3.39%     2618.860 +/-0.84%   (+1.35%)
> 128 groups  2256.406 +/-10.67%    2392.498 +/-2.13%   (+6.03%)
> 256 groups  1257.546 +/-3.81%     1674.684 +/-4.97%  (+33.17%)
> 
> Unixbench shell8
>   1 test     6944.16 +/-0.02     6605.82 +/-0.11      (-4.87%)
> 224 tests   13499.02 +/-0.14    13637.94 +/-0.47%     (+1.03%)
> lkp reported a -10% regression on shell8 (1 test) for v3 that 
> seems that is partially recovered on my platform with v4.
> 

I've been busy trying to get some perf numbers on arm64 server~ish systems,
I finally managed to get some specjbb numbers on TX2 (the 2 nodes, 224
CPUs version which I suspect is the same as you used in the above). I only
have a limited number of iterations (5, although each runs for about 2h)
because I wanted to get some (usable) results by today, I'll spin some more
during the week.


This is based on the "critical-jOPs" metric which AFAIU higher is better:

Baseline, SMTOFF:
  mean     12156.400000
  std        660.640068
  min      11016.000000
  25%      12158.000000
  50%      12464.000000
  75%      12521.000000
  max      12623.000000

Patches (+ find_idlest_group() fixup), SMTOFF:
  mean     12487.250000
  std        184.404221
  min      12326.000000
  25%      12349.250000
  50%      12449.500000
  75%      12587.500000
  max      12724.000000


It looks slightly better overall (mean, stddev), but I'm annoyed by that
low iteration count. I also had some issues with my SMTON run and I only
got numbers for 2 iterations, so I'll respin that before complaining.

FWIW the branch I've been using is:

  http://www.linux-arm.org/git?p=linux-vs.git;a=shortlog;h=refs/heads/mainline/load-balance/vincent_rework/tip
