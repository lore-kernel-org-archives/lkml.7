Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B122CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488D321D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtucjMEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440405AbfJYNdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:33:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439593AbfJYNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572010414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fows18MjoJ5qDkigGqJiY/xqu+NHgd33v8ELd74lzzY=;
        b=QtucjMECenm6MMVA9SWuk4yl+xVH+ofOnvEWPs65q1GFMShzodIMk8N0kVznM4nR8Fveug
        H/NOJ/isx9lTh/I/nml/i6KRqojWiwzP4Y7fOvzNU6qguCHOOgBjGOrak6VhqHJkggxOXA
        MGs4T/rdBuPn1rciKQQOluQMeRGgerQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-eRp_IJEmN66mbb49dlnKNg-1; Fri, 25 Oct 2019 09:33:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDDA9107AD31;
        Fri, 25 Oct 2019 13:33:29 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1226210013D9;
        Fri, 25 Oct 2019 13:33:27 +0000 (UTC)
Date:   Fri, 25 Oct 2019 09:33:26 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
Message-ID: <20191025133325.GA2421@pauld.bos.csb>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb>
 <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: eRp_IJEmN66mbb49dlnKNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Vincent,


On Thu, Oct 24, 2019 at 04:59:05PM +0200 Vincent Guittot wrote:
> On Thu, 24 Oct 2019 at 15:47, Phil Auld <pauld@redhat.com> wrote:
> >
> > On Thu, Oct 24, 2019 at 08:38:44AM -0400 Phil Auld wrote:
> > > Hi Vincent,
> > >
> > > On Mon, Oct 21, 2019 at 10:44:20AM +0200 Vincent Guittot wrote:
> > > > On Mon, 21 Oct 2019 at 09:50, Ingo Molnar <mingo@kernel.org> wrote:
> > > > >
>=20
> [...]
>=20
> > > > > A full run on Mel Gorman's magic scalability test-suite would be =
super
> > > > > useful ...
> > > > >
> > > > > Anyway, please be on the lookout for such performance regression =
reports.
> > > >
> > > > Yes I monitor the regressions on the mailing list
> > >
> > >
> > > Our kernel perf tests show good results across the board for v4.
> > >
> > > The issue we hit on the 8-node system is fixed. Thanks!
> > >
> > > As we didn't see the fairness issue I don't expect the results to be
> > > that different on v4a (with the followup patch) but those tests are
> > > queued up now and we'll see what they look like.
> > >
> >
> > Initial results with fix patch (v4a) show that the outlier issues on
> > the 8-node system have returned.  Median time for 152 and 156 threads
> > (160 cpu system) goes up significantly and worst case goes from 340
> > and 250 to 550 sec. for both. And doubles from 150 to 300 for 144
>=20
> For v3, you had a x4 slow down IIRC.
>=20

Sorry, that was a confusing change of data point :)

=20
That 4x was the normal versus group result for v3.  I.e. the usual=20
view of this test case's data.=20

These numbers above are the group vs group difference between=20
v4 and v4a.=20

The similar data points are that for v4 there was no difference=20
in performance between group and normal at 152 threads and a 35%=20
drop off from normal to group at 156.=20

With v4a there was 100% drop (2x slowdown) normal to group at 152=20
and close to that at 156 (~75-80% drop off).

So, yes, not as severe as v3. But significantly off from v4.=20

>=20
> > threads. These look more like the results from v3.
>=20
> OK. For v3, we were not sure that your UC triggers the slow path but
> it seems that we have the confirmation now.
> The problem happens only for this  8 node 160 cores system, isn't it ?

Yes. It only shows up now on this 8-node system.

>=20
> The fix favors the local group so your UC seems to prefer spreading
> tasks at wake up
> If you have any traces that you can share, this could help to
> understand what's going on. I will try to reproduce the problem on my
> system

I'm not actually sure the fix here is causing this. Looking at the data=20
more closely I see similar imbalances on v4, v4a and v3.=20

When you say slow versus fast wakeup paths what do you mean? I'm still
learning my way around all this code.=20

This particular test is specifically designed to highlight the imbalance=20
cause by the use of group scheduler defined load and averages. The threads
are mostly CPU bound but will join up every time step. So if each thread
more or less gets its own CPU (we run with fewer threads than CPUs) they
all finish the timestep at about the same time.  If threads are stuck
sharing cpus then those finish later and the whole computation is slowed
down.  In addition to the NAS benchmark threads there are 2 stress CPU
burners. These are either run in their own cgroups (thus having full "load"=
)
or all in the same cgroup with the benchmarck, thus all having tiny "loads"=
.

In this system, there are 20 cpus per node. We track average number of=20
benchmark threads running in each node. Generally for a balanced case=20
we should not have any much over 20 and indeed in the normal case (every
one in one cgroup) we see pretty nice balance. In the cgroup case we are=20
still seeing numbers much higher than 20.

Here are some eye charts:

This is the GROUP numbers from that machine on the v1 series (I don't have =
the=20
NORMAL lines handy for this one):
lu.C.x_152_GROUP_1 Average   18.08  18.17  19.58  19.29  19.25  17.50  21.4=
6  18.67
lu.C.x_152_GROUP_2 Average   17.12  17.48  17.88  17.62  19.57  17.31  23.0=
0  22.02
lu.C.x_152_GROUP_3 Average   17.82  17.97  18.12  18.18  24.55  22.18  16.9=
7  16.21
lu.C.x_152_GROUP_4 Average   18.47  19.08  18.50  18.66  21.45  25.00  15.4=
7  15.37
lu.C.x_152_GROUP_5 Average   20.46  20.71  27.38  24.75  17.06  16.65  12.8=
1  12.19

lu.C.x_156_GROUP_1 Average   18.70  18.80  20.25  19.50  20.45  20.30  19.5=
5  18.45
lu.C.x_156_GROUP_2 Average   19.29  19.90  17.71  18.10  20.76  21.57  19.8=
1  18.86
lu.C.x_156_GROUP_3 Average   25.09  29.19  21.83  21.33  18.67  18.57  11.0=
3  10.29
lu.C.x_156_GROUP_4 Average   18.60  19.10  19.20  18.70  20.30  20.00  19.7=
0  20.40
lu.C.x_156_GROUP_5 Average   18.58  18.95  18.63  18.1   17.32  19.37  23.9=
2  21.08

There are a couple that did not balance well but the overall results were g=
ood.=20

This is v4:
lu.C.x_152_GROUP_1   Average    18.80  19.25  21.95  21.25  17.55  17.25  1=
7.85  18.10
lu.C.x_152_GROUP_2   Average    20.57  20.62  19.76  17.76  18.95  18.33  1=
8.52  17.48
lu.C.x_152_GROUP_3   Average    15.39  12.22  13.96  12.19  25.51  28.91  2=
1.88  21.94
lu.C.x_152_GROUP_4   Average    20.30  19.75  20.75  19.45  18.15  17.80  1=
8.15  17.65
lu.C.x_152_GROUP_5   Average    15.13  12.21  13.63  11.39  25.42  30.21  2=
1.55  22.46
lu.C.x_152_NORMAL_1  Average    17.00  16.88  19.52  18.28  19.24  19.08  2=
1.08  20.92
lu.C.x_152_NORMAL_2  Average    18.61  16.56  18.56  17.00  20.56  20.28  2=
0.00  20.44
lu.C.x_152_NORMAL_3  Average    19.27  19.77  21.23  20.86  18.00  17.68  1=
7.73  17.45
lu.C.x_152_NORMAL_4  Average    20.24  19.33  21.33  21.10  17.33  18.43  1=
7.57  16.67
lu.C.x_152_NORMAL_5  Average    21.27  20.36  20.86  19.36  17.50  17.77  1=
7.32  17.55

lu.C.x_156_GROUP_1   Average    18.60  18.68  21.16  23.40  18.96  19.72  1=
7.76  17.72
lu.C.x_156_GROUP_2   Average    22.76  21.71  20.55  21.32  18.18  16.42  1=
7.58  17.47
lu.C.x_156_GROUP_3   Average    13.62  11.52  15.54  15.58  25.42  28.54  2=
3.22  22.56
lu.C.x_156_GROUP_4   Average    17.73  18.14  21.95  21.82  19.73  19.68  1=
8.55  18.41
lu.C.x_156_GROUP_5   Average    15.32  15.14  17.30  17.11  23.59  25.75  2=
0.77  21.02
lu.C.x_156_NORMAL_1  Average    19.06  18.72  19.56  18.72  19.72  21.28  1=
9.44  19.50
lu.C.x_156_NORMAL_2  Average    20.25  19.86  22.61  23.18  18.32  17.93  1=
6.39  17.46
lu.C.x_156_NORMAL_3  Average    18.84  17.88  19.24  17.76  21.04  20.64  2=
0.16  20.44
lu.C.x_156_NORMAL_4  Average    20.67  19.44  20.74  22.15  18.89  18.85  1=
8.00  17.26
lu.C.x_156_NORMAL_5  Average    20.12  19.65  24.12  24.15  17.40  16.62  1=
7.10  16.83

This one is better overall, but there are some mid 20s abd 152_GROUP_5 is p=
retty bad. =20


This is v4a
lu.C.x_152_GROUP_1   Average    28.64  34.49  23.60  24.48  10.35  11.99  8=
.36  10.09
lu.C.x_152_GROUP_2   Average    17.36  17.33  15.48  13.12  24.90  24.43  1=
8.55  20.83
lu.C.x_152_GROUP_3   Average    20.00  19.92  20.21  21.33  18.50  18.50  1=
6.50  17.04
lu.C.x_152_GROUP_4   Average    18.07  17.87  18.40  17.87  23.07  22.73  1=
7.60  16.40
lu.C.x_152_GROUP_5   Average    25.50  24.69  21.48  21.46  16.85  16.00  1=
4.06  11.96
lu.C.x_152_NORMAL_1  Average    22.27  20.77  20.60  19.83  16.73  17.53  1=
5.83  18.43
lu.C.x_152_NORMAL_2  Average    19.83  20.81  23.06  21.97  17.28  16.92  1=
5.83  16.31
lu.C.x_152_NORMAL_3  Average    17.85  19.31  18.85  19.08  19.00  19.31  1=
9.08  19.54
lu.C.x_152_NORMAL_4  Average    18.87  18.13  19.00  20.27  18.20  18.67  1=
9.73  19.13
lu.C.x_152_NORMAL_5  Average    18.16  18.63  18.11  17.00  19.79  20.63  1=
9.47  20.21

lu.C.x_156_GROUP_1   Average    24.96  26.15  21.78  21.48  18.52  19.11  1=
2.98  11.02
lu.C.x_156_GROUP_2   Average    18.69  19.00  18.65  18.42  20.50  20.46  1=
9.85  20.42
lu.C.x_156_GROUP_3   Average    24.32  23.79  20.82  20.95  16.63  16.61  1=
8.47  14.42
lu.C.x_156_GROUP_4   Average    18.27  18.34  14.88  16.07  27.00  21.93  2=
0.56  18.95
lu.C.x_156_GROUP_5   Average    19.18  20.99  33.43  29.57  15.63  15.54  1=
2.13  9.53
lu.C.x_156_NORMAL_1  Average    21.60  23.37  20.11  19.60  17.11  17.83  1=
8.17  18.20
lu.C.x_156_NORMAL_2  Average    21.00  20.54  19.88  18.79  17.62  18.67  1=
9.29  20.21
lu.C.x_156_NORMAL_3  Average    19.50  19.94  20.12  18.62  19.88  19.50  1=
9.00  19.44
lu.C.x_156_NORMAL_4  Average    20.62  19.72  20.03  22.17  18.21  18.55  1=
8.45  18.24
lu.C.x_156_NORMAL_5  Average    19.64  19.86  21.46  22.43  17.21  17.89  1=
8.96  18.54


This shows much more imblance in the GROUP case. There are some single digi=
ts=20
and some 30s.

For comparison here are some from my 4-node (80 cpu) system:

v4
lu.C.x_76_GROUP_1.ps.numa.hist   Average    19.58  17.67  18.25  20.50
lu.C.x_76_GROUP_2.ps.numa.hist   Average    19.08  19.17  17.67  20.08
lu.C.x_76_GROUP_3.ps.numa.hist   Average    19.42  18.58  18.42  19.58
lu.C.x_76_NORMAL_1.ps.numa.hist  Average    20.50  17.33  19.08  19.08
lu.C.x_76_NORMAL_2.ps.numa.hist  Average    19.45  18.73  19.27  18.55


v4a
lu.C.x_76_GROUP_1.ps.numa.hist   Average    19.46  19.15  18.62  18.77
lu.C.x_76_GROUP_2.ps.numa.hist   Average    19.00  18.58  17.75  20.67
lu.C.x_76_GROUP_3.ps.numa.hist   Average    19.08  17.08  20.08  19.77
lu.C.x_76_NORMAL_1.ps.numa.hist  Average    18.67  18.93  18.60  19.80
lu.C.x_76_NORMAL_2.ps.numa.hist  Average    19.08  18.67  18.58  19.67

Nicely balanced in both kernels and normal and group are basically the=20
same.=20

There's still something between v1 and v4 on that 8-node system that is=20
still illustrating the original problem.  On our other test systems this
series really works nicely to solve this problem. And even if we can't get
to the bottom if this it's a significant improvement.


Here is v3 for the 8-node system
lu.C.x_152_GROUP_1  Average    17.52  16.86  17.90  18.52  20.00  19.00  22=
.00  20.19
lu.C.x_152_GROUP_2  Average    15.70  15.04  15.65  15.72  23.30  28.98  20=
.09  17.52
lu.C.x_152_GROUP_3  Average    27.72  32.79  22.89  22.62  11.01  12.90  12=
.14  9.93
lu.C.x_152_GROUP_4  Average    18.13  18.87  18.40  17.87  18.80  19.93  20=
.40  19.60
lu.C.x_152_GROUP_5  Average    24.14  26.46  20.92  21.43  14.70  16.05  15=
.14  13.16
lu.C.x_152_NORMAL_1 Average    21.03  22.43  20.27  19.97  18.37  18.80  16=
.27  14.87
lu.C.x_152_NORMAL_2 Average    19.24  18.29  18.41  17.41  19.71  19.00  20=
.29  19.65
lu.C.x_152_NORMAL_3 Average    19.43  20.00  19.05  20.24  18.76  17.38  18=
.52  18.62
lu.C.x_152_NORMAL_4 Average    17.19  18.25  17.81  18.69  20.44  19.75  20=
.12  19.75
lu.C.x_152_NORMAL_5 Average    19.25  19.56  19.12  19.56  19.38  19.38  18=
.12  17.62

lu.C.x_156_GROUP_1  Average    18.62  19.31  18.38  18.77  19.88  21.35  19=
.35  20.35
lu.C.x_156_GROUP_2  Average    15.58  12.72  14.96  14.83  20.59  19.35  29=
.75  28.22
lu.C.x_156_GROUP_3  Average    20.05  18.74  19.63  18.32  20.26  20.89  19=
.53  18.58
lu.C.x_156_GROUP_4  Average    14.77  11.42  13.01  10.09  27.05  33.52  23=
.16  22.98
lu.C.x_156_GROUP_5  Average    14.94  11.45  12.77  10.52  28.01  33.88  22=
.37  22.05
lu.C.x_156_NORMAL_1 Average    20.00  20.58  18.47  18.68  19.47  19.74  19=
.42  19.63
lu.C.x_156_NORMAL_2 Average    18.52  18.48  18.83  18.43  20.57  20.48  20=
.61  20.09
lu.C.x_156_NORMAL_3 Average    20.27  20.00  20.05  21.18  19.55  19.00  18=
.59  17.36
lu.C.x_156_NORMAL_4 Average    19.65  19.60  20.25  20.75  19.35  20.10  19=
.00  17.30
lu.C.x_156_NORMAL_5 Average    19.79  19.67  20.62  22.42  18.42  18.00  17=
.67  19.42


I'll try to find pre-patched results for this 8 node system.  Just to keep =
things
together for reference here is the 4-node system before this re-work series=
.

lu.C.x_76_GROUP_1  Average    15.84  24.06  23.37  12.73
lu.C.x_76_GROUP_2  Average    15.29  22.78  22.49  15.45
lu.C.x_76_GROUP_3  Average    13.45  23.90  22.97  15.68
lu.C.x_76_NORMAL_1 Average    18.31  19.54  19.54  18.62
lu.C.x_76_NORMAL_2 Average    19.73  19.18  19.45  17.64

This produced a 4.5x slowdown for the group runs versus the nicely balance
normal runs. =20



I can try to get traces but this is not my system so it may take a little
while. I've found that the existing trace points don't give enough informat=
ion
to see what is happening in this problem. But the visualization in kernelsh=
ark
does show the problem pretty well. Do you want just the existing sched trac=
epoints
or should I update some of the traceprintks I used in the earlier traces?



Cheers,
Phil =20


>=20
> >
> > We're re-running the test to get more samples.
>=20
> Thanks
> Vincent
>=20
> >
> >
> > Other tests and systems were still fine.
> >
> >
> > Cheers,
> > Phil
> >
> >
> > > Numbers for my specific testcase (the cgroup imbalance) are basically
> > > the same as I posted for v3 (plus the better 8-node numbers). I.e. th=
is
> > > series solves that issue.
> > >
> > >
> > > Cheers,
> > > Phil
> > >
> > >
> > > >
> > > > >
> > > > > Also, we seem to have grown a fair amount of these TODO entries:
> > > > >
> > > > >   kernel/sched/fair.c: * XXX borrowed from update_sg_lb_stats
> > > > >   kernel/sched/fair.c: * XXX: only do this for the part of runnab=
le > running ?
> > > > >   kernel/sched/fair.c:     * XXX illustrate
> > > > >   kernel/sched/fair.c:    } else if (sd_flag & SD_BALANCE_WAKE) {=
 /* XXX always ? */
> > > > >   kernel/sched/fair.c: * can also include other factors [XXX].
> > > > >   kernel/sched/fair.c: * [XXX expand on:
> > > > >   kernel/sched/fair.c: * [XXX more?]
> > > > >   kernel/sched/fair.c: * [XXX write more on how we solve this.. _=
after_ merging pjt's patches that
> > > > >   kernel/sched/fair.c:             * XXX for now avg_load is not =
computed and always 0 so we
> > > > >   kernel/sched/fair.c:            /* XXX broken for overlapping N=
UMA groups */
> > > > >
> > > >
> > > > I will have a look :-)
> > > >
> > > > > :-)
> > > > >
> > > > > Thanks,
> > > > >
> > > > >         Ingo
> > >
> > > --
> > >
> >
> > --
> >

--=20

