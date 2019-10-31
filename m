Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14832087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht5JeoWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJaN52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:57:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25968 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727567AbfJaN52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572530246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hlw2FHFgcO50FYb572XbVbMxaokmCkLnZef1Z5ItUig=;
        b=ht5JeoWIXdHFVjdmUmCVVKMaVEPQhMAsUp7fQdnFHU7LekcJXJvN37vBOVUnqyZzZWmKqs
        KzGct/OqY4ySpiCSgRBGsbCFgKXugyO/aKlYIEoSaKe5tbhrKSCMi2RfZeqX7+CGEO85Jf
        8cWAWI0HXAcf+YbnWFVh9Y9LIQzEu2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-gOazBAWzPPSi3tGMyg4XbA-1; Thu, 31 Oct 2019 09:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954922B8;
        Thu, 31 Oct 2019 13:57:20 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A71F919C5B;
        Thu, 31 Oct 2019 13:57:17 +0000 (UTC)
Date:   Thu, 31 Oct 2019 09:57:15 -0400
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
Message-ID: <20191031135715.GA5738@pauld.bos.csb>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com>
 <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb>
 <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb>
 <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
 <CAKfTPtCR93MBPjKhMSyMZJTqVS7YWBPCnk3DmSEq2Q0MVxm1ug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCR93MBPjKhMSyMZJTqVS7YWBPCnk3DmSEq2Q0MVxm1ug@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: gOazBAWzPPSi3tGMyg4XbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Wed, Oct 30, 2019 at 06:25:49PM +0100 Vincent Guittot wrote:
> On Wed, 30 Oct 2019 at 15:39, Phil Auld <pauld@redhat.com> wrote:
> > > That fact that the 4 nodes works well but not the 8 nodes is a bit
> > > surprising except if this means more NUMA level in the sched_domain
> > > topology
> > > Could you give us more details about the sched domain topology ?
> > >
> >
> > The 8-node system has 5 sched domain levels.  The 4-node system only
> > has 3.
>=20
> That's an interesting difference. and your additional tests on a 8
> nodes with 3 level tends to confirm that the number of level make a
> difference
> I need to study a bit more how this can impact the spread of tasks

So I think I understand what my numbers have been showing.=20

I believe the numa balancing is causing problems.

Here's numbers from the test on 5.4-rc3+ without your series:=20

echo 1 >  /proc/sys/kernel/numa_balancing=20
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

(This one above is especially bad... we don't usually see 0.00s, but overal=
l it's=20
basically on par. It's reflected in the spread of the results).
=20

echo 0 >  /proc/sys/kernel/numa_balancing=20
lu.C.x_156_GROUP_1  Average    17.75  19.30  21.20  21.20  20.20  20.80  18=
.90  16.65
lu.C.x_156_GROUP_2  Average    18.38  19.25  21.00  20.06  20.19  20.31  19=
.56  17.25
lu.C.x_156_GROUP_3  Average    21.81  21.00  18.38  16.86  20.81  21.48  18=
.24  17.43
lu.C.x_156_GROUP_4  Average    20.48  20.96  19.61  17.61  17.57  19.74  18=
.48  21.57
lu.C.x_156_GROUP_5  Average    23.32  21.96  19.16  14.28  21.44  22.56  17=
.00  16.28
lu.C.x_156_NORMAL_1 Average    19.50  19.83  19.58  19.25  19.58  19.42  19=
.42  19.42
lu.C.x_156_NORMAL_2 Average    18.90  18.40  20.00  19.80  19.70  19.30  19=
.80  20.10
lu.C.x_156_NORMAL_3 Average    19.45  19.09  19.91  20.09  19.45  18.73  19=
.45  19.82
lu.C.x_156_NORMAL_4 Average    19.64  19.27  19.64  19.00  19.82  19.55  19=
.73  19.36
lu.C.x_156_NORMAL_5 Average    18.75  19.42  20.08  19.67  18.75  19.50  19=
.92  19.92

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
14956.3=0916346.5=0917505.7=0918440.6=0922492.7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
90.65=09110.57=09116.48=09124.74=09136.33
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
29801.3=0930739.2=0931967.5=0932151.3=0934036
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
59.91=0963.42=0963.78=0966.33=0968.42


Note there is a significant improvement already. But we are seeing imbalanc=
e due to
using weighted load and averages. In this case it's only 55% slowdown rathe=
r than
the 5x. But the overall performance if the benchmark is also much better in=
 both cases.



Here's the same test, same system with the full series (lb_v4a as I've been=
 calling it):

echo 1 >  /proc/sys/kernel/numa_balancing=20
lu.C.x_156_GROUP_1  Average    18.59  19.36  19.50  18.86  20.41  20.59  18=
.27  20.41
lu.C.x_156_GROUP_2  Average    19.52  20.52  20.48  21.17  19.52  19.09  17=
.70  18.00
lu.C.x_156_GROUP_3  Average    20.58  20.71  20.17  20.50  18.46  19.50  18=
.58  17.50
lu.C.x_156_GROUP_4  Average    18.95  19.63  19.47  19.84  18.79  19.84  20=
.84  18.63
lu.C.x_156_GROUP_5  Average    16.85  17.96  19.89  19.15  19.26  20.48  21=
.70  20.70
lu.C.x_156_NORMAL_1 Average    18.04  18.48  20.00  19.72  20.72  20.48  18=
.48  20.08
lu.C.x_156_NORMAL_2 Average    18.22  20.56  19.50  19.39  20.67  19.83  18=
.44  19.39
lu.C.x_156_NORMAL_3 Average    17.72  19.61  19.56  19.17  20.17  19.89  20=
.78  19.11
lu.C.x_156_NORMAL_4 Average    18.05  19.74  20.21  19.89  20.32  20.26  19=
.16  18.37
lu.C.x_156_NORMAL_5 Average    18.89  19.95  20.21  20.63  19.84  19.26  19=
.26  17.95

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
13460.1=0914949=0915851.7=0916391.4=0918993
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
107.35=09124.39=09128.63=09136.4=09151.48
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
14418.5=0918512.4=0919049.5=0919682=0919808.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
102.93=09103.6=09107.04=09110.14=09141.42


echo 0 >  /proc/sys/kernel/numa_balancing=20
lu.C.x_156_GROUP_1  Average    19.00  19.33  19.33  19.58  20.08  19.67  19=
.83  19.17
lu.C.x_156_GROUP_2  Average    18.55  19.91  20.09  19.27  18.82  19.27  19=
.91  20.18
lu.C.x_156_GROUP_3  Average    18.42  19.08  19.75  19.00  19.50  20.08  20=
.25  19.92
lu.C.x_156_GROUP_4  Average    18.42  19.83  19.17  19.50  19.58  19.83  19=
.83  19.83
lu.C.x_156_GROUP_5  Average    19.17  19.42  20.17  19.92  19.25  18.58  19=
.92  19.58
lu.C.x_156_NORMAL_1 Average    19.25  19.50  19.92  18.92  19.33  19.75  19=
.58  19.75
lu.C.x_156_NORMAL_2 Average    19.42  19.25  17.83  18.17  19.83  20.50  20=
.42  20.58
lu.C.x_156_NORMAL_3 Average    18.58  19.33  19.75  18.25  19.42  20.25  20=
.08  20.33
lu.C.x_156_NORMAL_4 Average    19.00  19.55  19.73  18.73  19.55  20.00  19=
.64  19.82
lu.C.x_156_NORMAL_5 Average    19.25  19.25  19.50  18.75  19.92  19.58  19=
.92  19.83

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
28520.1=0929024.2=0929042.1=0929367.4=0931235.2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_GROUP=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
65.28=0969.43=0970.21=0970.25=0971.49
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3DMop/s=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
28974.5=0929806.5=0930237.1=0930907.4=0931830.1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D156_NORMAL=3D=3D=3D=3D=3D=3D=3D=3Dtime=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
min=09q1=09median=09q3=09max
64.06=0965.97=0967.43=0968.41=0970.37


This all now makes sense. Looking at the numa balancing code a bit you can =
see=20
that it still uses load so it will still be subject to making bogus decisio=
ns=20
based on the weighted load. In this case it's been actively working against=
 the=20
load balancer because of that.

I think with the three numa levels on this system the numa balancing was ab=
le to=20
win more often.  We don't see the same level of this result on systems with=
 only=20
one SD_NUMA level.

Following the other part of this thread, I have to add that I'm of the opin=
ion=20
that the weighted load (which is all we have now I believe) really should b=
e used=20
only in extreme cases of overload to deal with fairness. And even then mayb=
e not. =20
As far as I can see, once the fair group scheduling is involved, that load =
is=20
basically a random number between 1 and 1024.  It really has no bearing on =
how=20
much  "load" a task will put on a cpu.   Any comparison of that to cpu capa=
city=20
is pretty meaningless.=20

I'm sure there are workloads for which the numa balancing is more important=
. But=20
even then I suspect it is making the wrong decisions more often than not. I=
 think=20
a similar rework may be needed :)

I've asked our perf team to try the full battery of tests with numa balanci=
ng=20
disabled  to see what it shows across the board.


Good job on this and thanks for the time looking at my specific issues.=20


As far as this series is concerned, and as far as it matters:=20

Acked-by: Phil Auld <pauld@redhat.com>



Cheers,
Phil

--=20

