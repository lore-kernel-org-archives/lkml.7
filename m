Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20516C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99E92075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 10:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uvhJeGyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfD1K3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 06:29:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39166 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfD1K3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 06:29:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id d12so5727747lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orqbThcrTT265dedHcs4IGIq8jzMqEhBgUtDP8c9Bl4=;
        b=uvhJeGylFCYqJSNKeqFI3jEYZG4TwE26QVpKl/mXkV+K2ND10HW/KulkUt/lkTuh/D
         bK+uFfHHqB5RO1+3rnwirvsGC/Bqb/SSFuxUu3GKhYSQtFhE6UUQQM8yqeulE+4mR1AO
         dwxdwc+pwg6TfKTTfp260G6L1+OO4/HaOdnGZtXDaM9ff/PO9nSMOPUUVkABMmBVhlhs
         igrjTvEbHo3COd74ESdH8v9E4OJptctShDBCPOK1LGovpU42X7ZSxWqJbLKyHVzCkaL7
         zXQWW3oIr8+RIDA5sk5pBQ42UD+0ZWxnnRYg9DK0XY24PRJ1wypqt4yyaadpf15KglHq
         /yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orqbThcrTT265dedHcs4IGIq8jzMqEhBgUtDP8c9Bl4=;
        b=BVQvt4zZ0qaQoZk1MGWsr77+jGvH9vwOxCmeA9uhQTrBUHNc23hApA7KGcFkcuyfAh
         Hywrcc7xgXq31XkWP5RK1VYp2200HN8HmB8VC4BvOxBvmzhzTeNzReGQJHzorHl3wolu
         Vl3BLq3XPlYHzqOzdWyVjZOJmbEikgMegi+LZtxmcyeZKNMFsCxvKpMe6iVO8Mc0HSdi
         9t2zww4WyY7m/na3YTZ/AKaC9m0UXbBObxnjaJyYtSZ27KB/5xuzyGXwVXZqHPoMAso9
         IxaB9VBSXw2HTIyL1N4Nd1dEUKcNElcVIowUiVEoemNMHrjzFE+1/BXGoxgBnbUV4HON
         Qnwg==
X-Gm-Message-State: APjAAAX6FnUsh/Oq/FFmG3ILirfTZdSbv3INtuAc//hgNA9c1f662WBJ
        XBdwQSEN2iLtl/X+GT3LvGVYig4OT54j9UvMazQ=
X-Google-Smtp-Source: APXvYqypp7oB/QvWM5Kl7B8UOZZGsn8wV3wWsyCcGHZJQdd/FcK3Y5KKXrYckiseObI/Vx4cowfxsu6TvvUe0bu/1kI=
X-Received: by 2002:a19:c113:: with SMTP id r19mr29577708lff.64.1556447386889;
 Sun, 28 Apr 2019 03:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <CAERHkrtOCbLQ-tFq9ujjnyaudtd_e0UaSA2GQG64JqdS6cuTKg@mail.gmail.com>
 <20190424140013.GA14594@sinkpad> <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com> <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com> <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com> <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
In-Reply-To: <20190428093304.GA7393@gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sun, 28 Apr 2019 18:29:34 +0800
Message-ID: <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 5:33 PM Ingo Molnar <mingo@kernel.org> wrote:
> So because I'm a big fan of presenting data in a readable fashion, here
> are your results, tabulated:

I thought I tried my best to make it readable, but this one looks much better,
thanks, ;-)
>
>  #
>  # Sysbench throughput comparison of 3 different kernels at different
>  # load levels, higher numbers are better:
>  #
>
>  .--------------------------------------|----------------------------------------------------------------.
>  |  NA/AVX     vanilla-SMT    [stddev%] |coresched-SMT   [stddev%]   +/-  |   no-SMT    [stddev%]   +/-  |
>  |--------------------------------------|----------------------------------------------------------------|
>  |   1/1             508.5    [  0.2% ] |        504.7   [  1.1% ]   0.8% |    509.0    [  0.2% ]   0.1% |
>  |   2/2            1000.2    [  1.4% ] |       1004.1   [  1.6% ]   0.4% |    997.6    [  1.2% ]   0.3% |
>  |   4/4            1912.1    [  1.0% ] |       1904.2   [  1.1% ]   0.4% |   1914.9    [  1.3% ]   0.1% |
>  |   8/8            3753.5    [  0.3% ] |       3748.2   [  0.3% ]   0.1% |   3751.3    [  0.4% ]   0.1% |
>  |  16/16           7139.3    [  2.4% ] |       7137.9   [  1.8% ]   0.0% |   7049.2    [  2.4% ]   1.3% |
>  |  32/32          10899.0    [  4.2% ] |      10780.3   [  4.4% ]  -1.1% |  10339.2    [  9.6% ]  -5.1% |
>  |  64/64          15086.1    [ 11.5% ] |      14262.0   [  8.2% ]  -5.5% |  11168.7    [ 22.2% ] -26.0% |
>  | 128/128         15371.9    [ 22.0% ] |      14675.8   [ 14.4% ]  -4.5% |  10963.9    [ 18.5% ] -28.7% |
>  | 256/256         15990.8    [ 22.0% ] |      12227.9   [ 10.3% ] -23.5% |  10469.9    [ 19.6% ] -34.5% |
>  '--------------------------------------|----------------------------------------------------------------'
>
> One major thing that sticks out is that if we compare the stddev numbers
> to the +/- comparisons then it's pretty clear that the benchmarks are
> very noisy: in all but the last row stddev is actually higher than the
> measured effect.
>
> So what does 'stddev' mean here, exactly? The stddev of multipe runs,
> i.e. measured run-to-run variance? Or is it some internal metric of the
> benchmark?
>

The benchmark periodically reports intermediate statistics in one second,
the raw log looks like below:
[ 11s ] thds: 256 eps: 14346.72 lat (ms,95%): 44.17
[ 12s ] thds: 256 eps: 14328.45 lat (ms,95%): 44.17
[ 13s ] thds: 256 eps: 13773.06 lat (ms,95%): 43.39
[ 14s ] thds: 256 eps: 13752.31 lat (ms,95%): 43.39
[ 15s ] thds: 256 eps: 15362.79 lat (ms,95%): 43.39
[ 16s ] thds: 256 eps: 26580.65 lat (ms,95%): 35.59
[ 17s ] thds: 256 eps: 15011.78 lat (ms,95%): 36.89
[ 18s ] thds: 256 eps: 15025.78 lat (ms,95%): 39.65
[ 19s ] thds: 256 eps: 15350.87 lat (ms,95%): 39.65
[ 20s ] thds: 256 eps: 15491.70 lat (ms,95%): 36.89

I have a python script to parse eps(events per second) and lat(latency)
out, and compute the average and stddev. (And I can draw a curve locally).

It's noisy indeed when tasks number is greater than the CPU number.
It's probably caused by high frequent load balance and context switch.
Do you have any suggestions? Or any other information I can provide?

Thanks,
-Aubrey
