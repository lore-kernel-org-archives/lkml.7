Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A19DCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C1D20679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWexGsVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfJ3Ojv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:39:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfJ3Ojv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572446389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rrLTm81lL/TyYrE8nk8goeT98AN64EgpxDYelXJ85Q=;
        b=eWexGsVsOMptpmG2uyuiwQNKJYbSyiV16DAFyTtZlnphMIeo0yvRX1ANNIZ5G8e4b9YZKS
        VARTdKMUpqymeWATPFeOw2e9WH5S5Uvl1CC1mfkY/Yz4+Hq6pPrSzCCZzz1P8+8DYKZUqR
        nv710LFQqAJeOFYt4KmaLAzHpzL13Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-TwQStB9eO_KstJaw2LrtIg-1; Wed, 30 Oct 2019 10:39:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 915C42EDD;
        Wed, 30 Oct 2019 14:39:42 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B589960872;
        Wed, 30 Oct 2019 14:39:39 +0000 (UTC)
Date:   Wed, 30 Oct 2019 10:39:37 -0400
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
Message-ID: <20191030143937.GC1686@pauld.bos.csb>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb>
 <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: TwQStB9eO_KstJaw2LrtIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Mon, Oct 28, 2019 at 02:03:15PM +0100 Vincent Guittot wrote:
> Hi Phil,
>=20

...

>=20
> The input could mean that this system reaches a particular level of
> utilization and load that is close to the threshold between 2
> different behavior like spare capacity and fully_busy/overloaded case.
> But at the opposite, there is less threads that CPUs in your UCs so
> one group at least at NUMA level should be tagged as
> has_spare_capacity and should pull tasks.

Yes. Maybe we don't hit that and rely on "load" since things look=20
busy. There are only 2 spare cpus in the 156 + 2 case. Is it possible
that information is getting lost with the extra NUMA levels?=20

>=20
> >
> > >
> > > The fix favors the local group so your UC seems to prefer spreading
> > > tasks at wake up
> > > If you have any traces that you can share, this could help to
> > > understand what's going on. I will try to reproduce the problem on my
> > > system
> >
> > I'm not actually sure the fix here is causing this. Looking at the data
> > more closely I see similar imbalances on v4, v4a and v3.
> >
> > When you say slow versus fast wakeup paths what do you mean? I'm still
> > learning my way around all this code.
>=20
> When task wakes up, we can decide to
> - speedup the wakeup and shorten the list of cpus and compare only
> prev_cpu vs this_cpu (in fact the group of cpu that share their
> respective LLC). That's the fast wakeup path that is used most of the
> time during a wakeup
> - or start to find the idlest CPU of the system and scan all domains.
> That's the slow path that is used for new tasks or when a task wakes
> up a lot of other tasks at the same time
>=20

Thanks.=20

>=20
> >
> > This particular test is specifically designed to highlight the imbalanc=
e
> > cause by the use of group scheduler defined load and averages. The thre=
ads
> > are mostly CPU bound but will join up every time step. So if each threa=
d
>=20
> ok the fact that they join up might be the root cause of your problem.
> They will wake up at the same time by the same task and CPU.
>=20

If that was the problem I'd expect issues on other high node count systems.

>=20
> That fact that the 4 nodes works well but not the 8 nodes is a bit
> surprising except if this means more NUMA level in the sched_domain
> topology
> Could you give us more details about the sched domain topology ?
>=20

The 8-node system has 5 sched domain levels.  The 4-node system only=20
has 3.=20


cpu159 0 0 0 0 0 0 4361694551702 124316659623 94736
domain0 80000000,00000000,00008000,00000000,00000000 0 0=20
domain1 ffc00000,00000000,0000ffc0,00000000,00000000 0 0=20
domain2 fffff000,00000000,0000ffff,f0000000,00000000 0 0=20
domain3 ffffffff,ff000000,0000ffff,ffffff00,00000000 0 0=20
domain4 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff 0 0=20

numactl --hardware
available: 8 nodes (0-7)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 80 81 82 83 84 85 86 87 88 89
node 0 size: 126928 MB
node 0 free: 126452 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 90 91 92 93 94 95 96 97 98 99
node 1 size: 129019 MB
node 1 free: 128813 MB
node 2 cpus: 20 21 22 23 24 25 26 27 28 29 100 101 102 103 104 105 106 107 =
108 109
node 2 size: 129019 MB
node 2 free: 128875 MB
node 3 cpus: 30 31 32 33 34 35 36 37 38 39 110 111 112 113 114 115 116 117 =
118 119
node 3 size: 129019 MB
node 3 free: 128850 MB
node 4 cpus: 40 41 42 43 44 45 46 47 48 49 120 121 122 123 124 125 126 127 =
128 129
node 4 size: 128993 MB
node 4 free: 128862 MB
node 5 cpus: 50 51 52 53 54 55 56 57 58 59 130 131 132 133 134 135 136 137 =
138 139
node 5 size: 129019 MB
node 5 free: 128872 MB
node 6 cpus: 60 61 62 63 64 65 66 67 68 69 140 141 142 143 144 145 146 147 =
148 149
node 6 size: 129019 MB
node 6 free: 128852 MB
node 7 cpus: 70 71 72 73 74 75 76 77 78 79 150 151 152 153 154 155 156 157 =
158 159
node 7 size: 112889 MB
node 7 free: 112720 MB
node distances:
node   0   1   2   3   4   5   6   7=20
  0:  10  12  17  17  19  19  19  19=20
  1:  12  10  17  17  19  19  19  19=20
  2:  17  17  10  12  19  19  19  19=20
  3:  17  17  12  10  19  19  19  19=20
  4:  19  19  19  19  10  12  17  17=20
  5:  19  19  19  19  12  10  17  17=20
  6:  19  19  19  19  17  17  10  12=20
  7:  19  19  19  19  17  17  12  10=20



available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 40 41 42 43 44 45 46 47 48 49
node 0 size: 257943 MB
node 0 free: 257602 MB
node 1 cpus: 10 11 12 13 14 15 16 17 18 19 50 51 52 53 54 55 56 57 58 59
node 1 size: 258043 MB
node 1 free: 257619 MB
node 2 cpus: 20 21 22 23 24 25 26 27 28 29 60 61 62 63 64 65 66 67 68 69
node 2 size: 258043 MB
node 2 free: 257879 MB
node 3 cpus: 30 31 32 33 34 35 36 37 38 39 70 71 72 73 74 75 76 77 78 79
node 3 size: 258043 MB
node 3 free: 257823 MB
node distances:
node   0   1   2   3=20
  0:  10  20  20  20=20
  1:  20  10  20  20=20
  2:  20  20  10  20=20
  3:  20  20  20  10=20




An 8-node system (albeit with sub-numa) has node distances=20

node distances:
node   0   1   2   3   4   5   6   7=20
  0:  10  11  21  21  21  21  21  21=20
  1:  11  10  21  21  21  21  21  21=20
  2:  21  21  10  11  21  21  21  21=20
  3:  21  21  11  10  21  21  21  21=20
  4:  21  21  21  21  10  11  21  21=20
  5:  21  21  21  21  11  10  21  21=20
  6:  21  21  21  21  21  21  10  11=20
  7:  21  21  21  21  21  21  11  10=20

This one does not exhibit the problem with the latest (v4a). But also
only has 3 levels.


> >
> > There's still something between v1 and v4 on that 8-node system that is
> > still illustrating the original problem.  On our other test systems thi=
s
> > series really works nicely to solve this problem. And even if we can't =
get
> > to the bottom if this it's a significant improvement.
> >
> >
> > Here is v3 for the 8-node system
> > lu.C.x_152_GROUP_1  Average    17.52  16.86  17.90  18.52  20.00  19.00=
  22.00  20.19
> > lu.C.x_152_GROUP_2  Average    15.70  15.04  15.65  15.72  23.30  28.98=
  20.09  17.52
> > lu.C.x_152_GROUP_3  Average    27.72  32.79  22.89  22.62  11.01  12.90=
  12.14  9.93
> > lu.C.x_152_GROUP_4  Average    18.13  18.87  18.40  17.87  18.80  19.93=
  20.40  19.60
> > lu.C.x_152_GROUP_5  Average    24.14  26.46  20.92  21.43  14.70  16.05=
  15.14  13.16
> > lu.C.x_152_NORMAL_1 Average    21.03  22.43  20.27  19.97  18.37  18.80=
  16.27  14.87
> > lu.C.x_152_NORMAL_2 Average    19.24  18.29  18.41  17.41  19.71  19.00=
  20.29  19.65
> > lu.C.x_152_NORMAL_3 Average    19.43  20.00  19.05  20.24  18.76  17.38=
  18.52  18.62
> > lu.C.x_152_NORMAL_4 Average    17.19  18.25  17.81  18.69  20.44  19.75=
  20.12  19.75
> > lu.C.x_152_NORMAL_5 Average    19.25  19.56  19.12  19.56  19.38  19.38=
  18.12  17.62
> >
> > lu.C.x_156_GROUP_1  Average    18.62  19.31  18.38  18.77  19.88  21.35=
  19.35  20.35
> > lu.C.x_156_GROUP_2  Average    15.58  12.72  14.96  14.83  20.59  19.35=
  29.75  28.22
> > lu.C.x_156_GROUP_3  Average    20.05  18.74  19.63  18.32  20.26  20.89=
  19.53  18.58
> > lu.C.x_156_GROUP_4  Average    14.77  11.42  13.01  10.09  27.05  33.52=
  23.16  22.98
> > lu.C.x_156_GROUP_5  Average    14.94  11.45  12.77  10.52  28.01  33.88=
  22.37  22.05
> > lu.C.x_156_NORMAL_1 Average    20.00  20.58  18.47  18.68  19.47  19.74=
  19.42  19.63
> > lu.C.x_156_NORMAL_2 Average    18.52  18.48  18.83  18.43  20.57  20.48=
  20.61  20.09
> > lu.C.x_156_NORMAL_3 Average    20.27  20.00  20.05  21.18  19.55  19.00=
  18.59  17.36
> > lu.C.x_156_NORMAL_4 Average    19.65  19.60  20.25  20.75  19.35  20.10=
  19.00  17.30
> > lu.C.x_156_NORMAL_5 Average    19.79  19.67  20.62  22.42  18.42  18.00=
  17.67  19.42
> >
> >
> > I'll try to find pre-patched results for this 8 node system.  Just to k=
eep things
> > together for reference here is the 4-node system before this re-work se=
ries.
> >
> > lu.C.x_76_GROUP_1  Average    15.84  24.06  23.37  12.73
> > lu.C.x_76_GROUP_2  Average    15.29  22.78  22.49  15.45
> > lu.C.x_76_GROUP_3  Average    13.45  23.90  22.97  15.68
> > lu.C.x_76_NORMAL_1 Average    18.31  19.54  19.54  18.62
> > lu.C.x_76_NORMAL_2 Average    19.73  19.18  19.45  17.64
> >
> > This produced a 4.5x slowdown for the group runs versus the nicely bala=
nce
> > normal runs.
> >

Here is the base 5.4.0-rc3+ kernel on the 8-node system:

lu.C.x_156_GROUP_1  Average    10.87  0.00   0.00   11.49  36.69  34.26  30=
.59  32.10
lu.C.x_156_GROUP_2  Average    20.15  16.32  9.49   24.91  21.07  20.93  21=
.63  21.50
lu.C.x_156_GROUP_3  Average    21.27  17.23  11.84  21.80  20.91  20.68  21=
.11  21.16
lu.C.x_156_GROUP_4  Average    19.44  6.53   8.71   19.72  22.95  23.16  28=
.85  26.64
lu.C.x_156_GROUP_5  Average    20.59  6.20   11.32  14.63  28.73  30.36  22=
.20  21.98
lu.C.x_156_NORMAL_1 Average    20.50  19.95  20.40  20.45  18.75  19.35  18=
.25  18.35
lu.C.x_156_NORMAL_2 Average    17.15  19.04  18.42  18.69  21.35  21.42  20=
.00  19.92
lu.C.x_156_NORMAL_3 Average    18.00  18.15  17.55  17.60  18.90  18.40  19=
.90  19.75
lu.C.x_156_NORMAL_4 Average    20.53  20.05  20.21  19.11  19.00  19.47  19=
.37  18.26
lu.C.x_156_NORMAL_5 Average    18.72  18.78  19.72  18.50  19.67  19.72  21=
.11  19.78

Including the actual benchmark results.=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
1564.63=093003.87=093928.23=095411.13=098386.66
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
243.12=09376.82=09519.06=09678.79=091303.18
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
13845.6=0918013.8=0918545.5=0919359.9=0919647.4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
103.78=09105.32=09109.95=09113.19=09147.27

You can see the ~5x slowdown of the pre-rework issue. v4a is much improved =
over
mainline.

I'll try to find some other machines as well.=20


> >
> >
> > I can try to get traces but this is not my system so it may take a litt=
le
> > while. I've found that the existing trace points don't give enough info=
rmation
> > to see what is happening in this problem. But the visualization in kern=
elshark
> > does show the problem pretty well. Do you want just the existing sched =
tracepoints
> > or should I update some of the traceprintks I used in the earlier trace=
s?
>=20
> The standard tracepoint is a good starting point but tracing the
> statistings for find_busiest_group and find_idlest_group should help a
> lot.
>=20

I have some traces which I'll send you directly since they're large.


Cheers,
Phil



> Cheers,
> Vincent
>=20
> >
> >
> >
> > Cheers,
> > Phil
> >
> >
> > >
> > > >
> > > > We're re-running the test to get more samples.
> > >
> > > Thanks
> > > Vincent
> > >
> > > >
> > > >
> > > > Other tests and systems were still fine.
> > > >
> > > >
> > > > Cheers,
> > > > Phil
> > > >
> > > >
> > > > > Numbers for my specific testcase (the cgroup imbalance) are basic=
ally
> > > > > the same as I posted for v3 (plus the better 8-node numbers). I.e=
. this
> > > > > series solves that issue.
> > > > >
> > > > >
> > > > > Cheers,
> > > > > Phil
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Also, we seem to have grown a fair amount of these TODO entri=
es:
> > > > > > >
> > > > > > >   kernel/sched/fair.c: * XXX borrowed from update_sg_lb_stats
> > > > > > >   kernel/sched/fair.c: * XXX: only do this for the part of ru=
nnable > running ?
> > > > > > >   kernel/sched/fair.c:     * XXX illustrate
> > > > > > >   kernel/sched/fair.c:    } else if (sd_flag & SD_BALANCE_WAK=
E) { /* XXX always ? */
> > > > > > >   kernel/sched/fair.c: * can also include other factors [XXX]=
.
> > > > > > >   kernel/sched/fair.c: * [XXX expand on:
> > > > > > >   kernel/sched/fair.c: * [XXX more?]
> > > > > > >   kernel/sched/fair.c: * [XXX write more on how we solve this=
.. _after_ merging pjt's patches that
> > > > > > >   kernel/sched/fair.c:             * XXX for now avg_load is =
not computed and always 0 so we
> > > > > > >   kernel/sched/fair.c:            /* XXX broken for overlappi=
ng NUMA groups */
> > > > > > >
> > > > > >
> > > > > > I will have a look :-)
> > > > > >
> > > > > > > :-)
> > > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > >         Ingo
> > > > >
> > > > > --
> > > > >
> > > >
> > > > --
> > > >
> >
> > --
> >

--=20

