Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0B3CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9142080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKeGNFH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfJaQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:41:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38764 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbfJaQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:41:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so6954028ljc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lAXhbkm1fI58IHQoOD7iG8WVjbc/5WIXxTFckocZUV8=;
        b=QKeGNFH7ZxJzvG7TNbG2ZLu32GexonglVzJ9VFGH673SA0c5u+hnQPv2Ma+U3yZTUp
         9hRxxgzsbI8Q96C47WkVq2a/foeGq7tcPyPh/F+Mm/ZFDhTj3tnQjigxnPywACDq8EE3
         KqMXpO8t2hA/brcPw4KBrjbMVR9kWOfLtaK6jMrvoGB4emWsDzIu906zwYy6XwQxynAQ
         AWFyrDaInQnRg038jJAlwtuhqg+ueYkslegE74bLrY55y1XqrrYxX9vCJKpPKNDOddBJ
         lcVb6L5Ih+Irqu3yyOs3wAgQQxHvN7hjgvskl1ZU0wlQCOUyEsbgudq6SEfnKdwzu8it
         amyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAXhbkm1fI58IHQoOD7iG8WVjbc/5WIXxTFckocZUV8=;
        b=TE2KkdEz0IPkZ5vxT5gfJ+lKReoO1W3B7FLZ34mbGXUexme1zlsnGsh8h2Qd8suo0v
         6PWasi/8qpPO0PFjX9x6RRuCjoynzVXMSZ53U8UmhHBwyHuQa0tLlbPG/WkSPlqV4y3C
         VE+gCk0MQt6yx2s2dEB6sX5btUR/bWTakFUQwnFMKzKzzvyzCMvBiJ6r2pEr2uqcDg0s
         nACw87NtthHfVO9wU7qEHiZ8HO06dTIt/8QCT2lPf7RZx+D3ME20M9838eeWHykpnIOY
         nkyYJLH5LbO9uBl9MfwBIZEC2zqxYI/VuamMs83v6vo9gygYmIRhX12A7f3QoZs65+r4
         DPPw==
X-Gm-Message-State: APjAAAWXGvXLUgArGzdmGYETJi15xQPOcQrFZvwgPhqsKR3PPGch7iPc
        b55VER0CJypIvJolr92F3cSGl7lMZDmRTne/SO4Gmg==
X-Google-Smtp-Source: APXvYqwESGX3nlsFx0Yo/ywnZV+8f9+j4TG6ky0stsoWPC23tO3KBTZMaqEI/cHMTd8qZ6YtwVS+uieeAV38SgB7/fI=
X-Received: by 2002:a05:651c:1024:: with SMTP id w4mr4631728ljm.206.1572540111325;
 Thu, 31 Oct 2019 09:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com> <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb> <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb> <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb> <CAKfTPtCR93MBPjKhMSyMZJTqVS7YWBPCnk3DmSEq2Q0MVxm1ug@mail.gmail.com>
 <20191031135715.GA5738@pauld.bos.csb>
In-Reply-To: <20191031135715.GA5738@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 31 Oct 2019 17:41:39 +0100
Message-ID: <CAKfTPtCm5dM4G0D6jSenNQSbpnKkUpOev24Ms02aszPyxyfuuQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2019 at 14:57, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Wed, Oct 30, 2019 at 06:25:49PM +0100 Vincent Guittot wrote:
> > On Wed, 30 Oct 2019 at 15:39, Phil Auld <pauld@redhat.com> wrote:
> > > > That fact that the 4 nodes works well but not the 8 nodes is a bit
> > > > surprising except if this means more NUMA level in the sched_domain
> > > > topology
> > > > Could you give us more details about the sched domain topology ?
> > > >
> > >
> > > The 8-node system has 5 sched domain levels.  The 4-node system only
> > > has 3.
> >
> > That's an interesting difference. and your additional tests on a 8
> > nodes with 3 level tends to confirm that the number of level make a
> > difference
> > I need to study a bit more how this can impact the spread of tasks
>
> So I think I understand what my numbers have been showing.
>
> I believe the numa balancing is causing problems.
>
> Here's numbers from the test on 5.4-rc3+ without your series:
>
> echo 1 >  /proc/sys/kernel/numa_balancing
> lu.C.x_156_GROUP_1  Average    10.87  0.00   0.00   11.49  36.69  34.26  30.59  32.10
> lu.C.x_156_GROUP_2  Average    20.15  16.32  9.49   24.91  21.07  20.93  21.63  21.50
> lu.C.x_156_GROUP_3  Average    21.27  17.23  11.84  21.80  20.91  20.68  21.11  21.16
> lu.C.x_156_GROUP_4  Average    19.44  6.53   8.71   19.72  22.95  23.16  28.85  26.64
> lu.C.x_156_GROUP_5  Average    20.59  6.20   11.32  14.63  28.73  30.36  22.20  21.98
> lu.C.x_156_NORMAL_1 Average    20.50  19.95  20.40  20.45  18.75  19.35  18.25  18.35
> lu.C.x_156_NORMAL_2 Average    17.15  19.04  18.42  18.69  21.35  21.42  20.00  19.92
> lu.C.x_156_NORMAL_3 Average    18.00  18.15  17.55  17.60  18.90  18.40  19.90  19.75
> lu.C.x_156_NORMAL_4 Average    20.53  20.05  20.21  19.11  19.00  19.47  19.37  18.26
> lu.C.x_156_NORMAL_5 Average    18.72  18.78  19.72  18.50  19.67  19.72  21.11  19.78
>
> ============156_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 1564.63 3003.87 3928.23 5411.13 8386.66
> ============156_GROUP========time====================================
> min     q1      median  q3      max
> 243.12  376.82  519.06  678.79  1303.18
> ============156_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 13845.6 18013.8 18545.5 19359.9 19647.4
> ============156_NORMAL========time====================================
> min     q1      median  q3      max
> 103.78  105.32  109.95  113.19  147.27
>
> (This one above is especially bad... we don't usually see 0.00s, but overall it's
> basically on par. It's reflected in the spread of the results).
>
>
> echo 0 >  /proc/sys/kernel/numa_balancing
> lu.C.x_156_GROUP_1  Average    17.75  19.30  21.20  21.20  20.20  20.80  18.90  16.65
> lu.C.x_156_GROUP_2  Average    18.38  19.25  21.00  20.06  20.19  20.31  19.56  17.25
> lu.C.x_156_GROUP_3  Average    21.81  21.00  18.38  16.86  20.81  21.48  18.24  17.43
> lu.C.x_156_GROUP_4  Average    20.48  20.96  19.61  17.61  17.57  19.74  18.48  21.57
> lu.C.x_156_GROUP_5  Average    23.32  21.96  19.16  14.28  21.44  22.56  17.00  16.28
> lu.C.x_156_NORMAL_1 Average    19.50  19.83  19.58  19.25  19.58  19.42  19.42  19.42
> lu.C.x_156_NORMAL_2 Average    18.90  18.40  20.00  19.80  19.70  19.30  19.80  20.10
> lu.C.x_156_NORMAL_3 Average    19.45  19.09  19.91  20.09  19.45  18.73  19.45  19.82
> lu.C.x_156_NORMAL_4 Average    19.64  19.27  19.64  19.00  19.82  19.55  19.73  19.36
> lu.C.x_156_NORMAL_5 Average    18.75  19.42  20.08  19.67  18.75  19.50  19.92  19.92
>
> ============156_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 14956.3 16346.5 17505.7 18440.6 22492.7
> ============156_GROUP========time====================================
> min     q1      median  q3      max
> 90.65   110.57  116.48  124.74  136.33
> ============156_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 29801.3 30739.2 31967.5 32151.3 34036
> ============156_NORMAL========time====================================
> min     q1      median  q3      max
> 59.91   63.42   63.78   66.33   68.42
>
>
> Note there is a significant improvement already. But we are seeing imbalance due to
> using weighted load and averages. In this case it's only 55% slowdown rather than
> the 5x. But the overall performance if the benchmark is also much better in both cases.
>
>
>
> Here's the same test, same system with the full series (lb_v4a as I've been calling it):
>
> echo 1 >  /proc/sys/kernel/numa_balancing
> lu.C.x_156_GROUP_1  Average    18.59  19.36  19.50  18.86  20.41  20.59  18.27  20.41
> lu.C.x_156_GROUP_2  Average    19.52  20.52  20.48  21.17  19.52  19.09  17.70  18.00
> lu.C.x_156_GROUP_3  Average    20.58  20.71  20.17  20.50  18.46  19.50  18.58  17.50
> lu.C.x_156_GROUP_4  Average    18.95  19.63  19.47  19.84  18.79  19.84  20.84  18.63
> lu.C.x_156_GROUP_5  Average    16.85  17.96  19.89  19.15  19.26  20.48  21.70  20.70
> lu.C.x_156_NORMAL_1 Average    18.04  18.48  20.00  19.72  20.72  20.48  18.48  20.08
> lu.C.x_156_NORMAL_2 Average    18.22  20.56  19.50  19.39  20.67  19.83  18.44  19.39
> lu.C.x_156_NORMAL_3 Average    17.72  19.61  19.56  19.17  20.17  19.89  20.78  19.11
> lu.C.x_156_NORMAL_4 Average    18.05  19.74  20.21  19.89  20.32  20.26  19.16  18.37
> lu.C.x_156_NORMAL_5 Average    18.89  19.95  20.21  20.63  19.84  19.26  19.26  17.95
>
> ============156_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 13460.1 14949   15851.7 16391.4 18993
> ============156_GROUP========time====================================
> min     q1      median  q3      max
> 107.35  124.39  128.63  136.4   151.48
> ============156_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 14418.5 18512.4 19049.5 19682   19808.8
> ============156_NORMAL========time====================================
> min     q1      median  q3      max
> 102.93  103.6   107.04  110.14  141.42
>
>
> echo 0 >  /proc/sys/kernel/numa_balancing
> lu.C.x_156_GROUP_1  Average    19.00  19.33  19.33  19.58  20.08  19.67  19.83  19.17
> lu.C.x_156_GROUP_2  Average    18.55  19.91  20.09  19.27  18.82  19.27  19.91  20.18
> lu.C.x_156_GROUP_3  Average    18.42  19.08  19.75  19.00  19.50  20.08  20.25  19.92
> lu.C.x_156_GROUP_4  Average    18.42  19.83  19.17  19.50  19.58  19.83  19.83  19.83
> lu.C.x_156_GROUP_5  Average    19.17  19.42  20.17  19.92  19.25  18.58  19.92  19.58
> lu.C.x_156_NORMAL_1 Average    19.25  19.50  19.92  18.92  19.33  19.75  19.58  19.75
> lu.C.x_156_NORMAL_2 Average    19.42  19.25  17.83  18.17  19.83  20.50  20.42  20.58
> lu.C.x_156_NORMAL_3 Average    18.58  19.33  19.75  18.25  19.42  20.25  20.08  20.33
> lu.C.x_156_NORMAL_4 Average    19.00  19.55  19.73  18.73  19.55  20.00  19.64  19.82
> lu.C.x_156_NORMAL_5 Average    19.25  19.25  19.50  18.75  19.92  19.58  19.92  19.83
>
> ============156_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 28520.1 29024.2 29042.1 29367.4 31235.2
> ============156_GROUP========time====================================
> min     q1      median  q3      max
> 65.28   69.43   70.21   70.25   71.49
> ============156_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 28974.5 29806.5 30237.1 30907.4 31830.1
> ============156_NORMAL========time====================================
> min     q1      median  q3      max
> 64.06   65.97   67.43   68.41   70.37
>
>
> This all now makes sense. Looking at the numa balancing code a bit you can see
> that it still uses load so it will still be subject to making bogus decisions
> based on the weighted load. In this case it's been actively working against the
> load balancer because of that.

Thanks for the tests and interesting results

>
> I think with the three numa levels on this system the numa balancing was able to
> win more often.  We don't see the same level of this result on systems with only
> one SD_NUMA level.
>
> Following the other part of this thread, I have to add that I'm of the opinion
> that the weighted load (which is all we have now I believe) really should be used
> only in extreme cases of overload to deal with fairness. And even then maybe not.
> As far as I can see, once the fair group scheduling is involved, that load is
> basically a random number between 1 and 1024.  It really has no bearing on how
> much  "load" a task will put on a cpu.   Any comparison of that to cpu capacity
> is pretty meaningless.
>
> I'm sure there are workloads for which the numa balancing is more important. But
> even then I suspect it is making the wrong decisions more often than not. I think
> a similar rework may be needed :)

Yes , there is probably space for a better collaboration between the
load and numa balancing

>
> I've asked our perf team to try the full battery of tests with numa balancing
> disabled  to see what it shows across the board.
>
>
> Good job on this and thanks for the time looking at my specific issues.

Thanks for your help


>
>
> As far as this series is concerned, and as far as it matters:
>
> Acked-by: Phil Auld <pauld@redhat.com>
>
>
>
> Cheers,
> Phil
>
> --
>
