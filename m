Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D4AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34A220881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srvB1Mtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfEOLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:17:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37577 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbfEOLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:17:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so1207409pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wM7wYEqMSWbWbT0HH2TldP/PCrb03BY7RX3o4249V6E=;
        b=srvB1Mtqkpo69amaKaotUhuA77Zht+tusENlx9c4LEQ39r9wo+XS+YJ5m8b1kGneQt
         Rn1AM+dJiXJGhN3oFC6FeUAEjLMUaV4yC3MtL8c4gigRCdq21zIo9i8Jnqzd1adeBVxS
         eQ6LyqsD2SIQ5oDE33h3FIcW/P6VDyCCpmp4ZFgaCIkk6nLaTvCVNo64GzO5euHbwlvj
         4KQdeZx40Qq0aqDlfHfGcRviwY0n01OHQjXmd5EouoxhikMIUGhq5tm+fQn3kksFc/ST
         oHIqoUZR8l+cG4Rp6Oyeogk1pg3ScuCf8duOpCR4/zoU7lkApwgvqt9dv1nBQGNjWmVH
         YG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wM7wYEqMSWbWbT0HH2TldP/PCrb03BY7RX3o4249V6E=;
        b=IU1XJSVfWcpRGcyJimyMC2LBUZ7SFoGyF4NY4sDwhWbVBxfGAPB8XrmCjpBKRyWfH0
         jAOZW+c5gdaQtsN+fnn/yI+JHnKBrQ07kzt+cgeoPac1McFIAWn6omSIHfGaauIhyCvz
         ceEi0FwJ7usPY4/VUJWdrSCAMmWsJ0adH8Z/yRbFsTDn91QzBKJwLK2uyPT01iISjYv7
         cVNHHoen61t3d4qXZJhMpYCyMBlH0cPA/JdoD2q6zvOI3Y1y6PgT+paMaceoFfulIjGD
         1V2t1Z2s6x4WYndmtis13wcKDZFcqblanspLkVMIQ7wXhtpUzFZ+AuogXmus65dii6rq
         GuDQ==
X-Gm-Message-State: APjAAAWqFmasxWWZyi3AGwLAz4qxnNJg8dUu+4xefyJuFlRm1BLJB+pK
        BUP6zyugXAAG2HvVZ5Vlng/LTQ==
X-Google-Smtp-Source: APXvYqwRyC8jcmkvLe4WrAj4GFRdRTkcvHeFhusZ5mTCeDTCuZeX1k77Xj2fYUSzxA6m4smVDkxt4A==
X-Received: by 2002:a63:5511:: with SMTP id j17mr43763811pgb.449.1557919068190;
        Wed, 15 May 2019 04:17:48 -0700 (PDT)
Received: from localhost ([122.172.118.99])
        by smtp.gmail.com with ESMTPSA id 127sm3111996pfc.159.2019.05.15.04.17.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:17:47 -0700 (PDT)
Date:   Wed, 15 May 2019 16:47:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org,
        liu.song.a23@gmail.com, steven.sistare@oracle.com,
        subhra.mazumdar@oracle.com
Subject: Re: [RFC V2 0/2] sched/fair: Fallback to sched-idle CPU for better
 performance
Message-ID: <20190515111745.dj6jhf4lypppl3tf@vireshk-i7>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="idirfw46cfjal5et"
Content-Disposition: inline
In-Reply-To: <cover.1556182964.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idirfw46cfjal5et
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 25-04-19, 15:07, Viresh Kumar wrote:
> Hi,
> 
> Here is another attempt to get some benefit out of the sched-idle
> policy. The previous version [1] focused on getting better power numbers
> and this version tries to get better performance or lower response time
> for the tasks.
> 
> The first patch is unchanged from v1 and accumulates
> information about sched-idle tasks per CPU.
> 
> The second patch changes the way the target CPU is selected in the fast
> path. Currently, we target for an idle CPU in select_idle_sibling() to
> run the next task, but in case we don't find idle CPUs it is better to
> pick a CPU which will run the task the soonest, for performance reason.
> A CPU which isn't idle but has only SCHED_IDLE activity queued on it
> should be a good target based on this criteria as any normal fair task
> will most likely preempt the currently running SCHED_IDLE task
> immediately. In fact, choosing a SCHED_IDLE CPU shall give better
> results as it should be able to run the task sooner than an idle CPU
> (which requires to be woken up from an idle state).
> 
> Basic testing is done with the help of rt-app currently to make sure the
> task is getting placed correctly.

More results here:

- Tested on Octacore Hikey platform (all CPUs change frequency
  together).

- rt-app json attached here. It creates few tasks and we monitor the
  scheduling latency for them by looking at "wu_lat" field (usec).

- The histograms are created using
  https://github.com/adkein/textogram: textogram -a 0 -z 1000 -n 10

- the stats are accumulated using: https://github.com/nferraz/st

- NOTE: The % values shown don't add up, just look at total numbers
  instead


Test 1: Create 8 CFS tasks (no SCHED_IDLE tasks) without this
patchset:

           0 - 100  : ##################################################   72% (3688)
         100 - 200  : ################                                     24% (1253)
         200 - 300  : ##                                                    2% (149)
         300 - 400  :                                                       0% (22)
         400 - 500  :                                                       0% (1)
         500 - 600  :                                                       0% (3)
         600 - 700  :                                                       0% (1)
         700 - 800  :                                                       0% (1)
         800 - 900  :
         900 - 1000 :                                                       0% (1)
              >1000 : 0% (17)

        N       min     max     sum     mean    stddev
        5136    0       2452    535985  104.358 104.585


Test 2: Create 8 CFS tasks and 5 SCHED_IDLE tasks:

        A. Without sched-idle patchset:

           0 - 100  : ##################################################   88% (3102)
         100 - 200  : ##                                                    4% (148)
         200 - 300  :                                                       1% (41)
         300 - 400  :                                                       0% (27)
         400 - 500  :                                                       0% (33)
         500 - 600  :                                                       0% (32)
         600 - 700  :                                                       1% (36)
         700 - 800  :                                                       0% (27)
         800 - 900  :                                                       0% (19)
         900 - 1000 :                                                       0% (26)
              >1000 : 34% (1218)

        N       min     max     sum             mean    stddev
        4710    0       67664   5.25956e+06     1116.68 2315.09


        B. With sched-idle patchset:

           0 - 100  : ##################################################   99% (5042)
         100 - 200  :                                                       0% (8)
         200 - 300  :
         300 - 400  :
         400 - 500  :                                                       0% (2)
         500 - 600  :                                                       0% (1)
         600 - 700  :
         700 - 800  :                                                       0% (1)
         800 - 900  :                                                       0% (1)
         900 - 1000 :
              >1000 : 0% (40)

        N       min     max     sum     mean    stddev
        5095    0       7773    523170  102.683 475.482


The mean latency dropped to 10% and the stddev to around 25% with this
patchset.

I have tried more combinations of CFS and SCHED_IDLE tasks and see
expected improvement in scheduling latency for all of them.

-- 
viresh

--idirfw46cfjal5et
Content-Type: application/json
Content-Disposition: attachment; filename="sched-idle.json"
Content-Transfer-Encoding: quoted-printable

{=0A        "tasks" : {=0A                "cfs_thread" : {=0A              =
          "instance" : 8,=0A                        "run" :   5333,=0A     =
                   "timer" : { "ref" : "unique", "period" : 7777 },=0A     =
                   "policy" : "SCHED_OTHER"=0A                },=0A        =
        "idle_thread" : {=0A                        "instance" : 5,=0A     =
                   "run" :   3000,=0A                        "policy" : "SC=
HED_IDLE"=0A                }=0A        },=0A        "global" : {=0A       =
         "duration" : 5,=0A                "calibration" : "CPU0",=0A      =
          "default_policy" : "SCHED_OTHER",=0A                "pi_enabled" =
: false,=0A                "lock_pages" : false,=0A                "logdir"=
 : "./",=0A                "logsize" : 4,=0A                "log_basename" =
: "rt-app",=0A                "gnuplot" : false=0A        }=0A}=0A=0A
--idirfw46cfjal5et--
