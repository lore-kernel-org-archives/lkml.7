Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA59FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A9D2467A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 08:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfLFIRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 03:17:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfLFIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:17:04 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB68Df3d032580
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 03:17:03 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9g5srqd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 03:17:03 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 6 Dec 2019 08:17:01 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 08:16:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB68GuAh55115856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 08:16:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAA0F52054;
        Fri,  6 Dec 2019 08:16:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 36B9E5204F;
        Fri,  6 Dec 2019 08:16:55 +0000 (GMT)
Date:   Fri, 6 Dec 2019 13:46:54 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <CAKfTPtBH9ff=efTeJbM4UdzrHCXZs7wwn=pdE4As8pB859e++Q@mail.gmail.com>
 <20191205175153.GA14172@linux.vnet.ibm.com>
 <CAKfTPtDp097ww0war7H1THtRxDWzA3CDuokDQSUoqzRDcD1d3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtDp097ww0war7H1THtRxDWzA3CDuokDQSUoqzRDcD1d3g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19120608-0016-0000-0000-000002D2084C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120608-0017-0000-0000-0000333410FF
Message-Id: <20191206081654.GA22330@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_01:2019-12-04,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2019-12-05 19:52:40]:

> On Thu, 5 Dec 2019 at 18:52, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > * Vincent Guittot <vincent.guittot@linaro.org> [2019-12-05 18:27:51]:
> >
> > > Hi Srikar,
> > >
> > > On Thu, 5 Dec 2019 at 18:23, Srikar Dronamraju
> > > <srikar@linux.vnet.ibm.com> wrote:
> > > >
> > > > Currently we loop through all threads of a core to evaluate if the core
> > > > is idle or not. This is unnecessary. If a thread of a core is not
> > > > idle, skip evaluating other threads of a core.
> > >
> > > I think that the goal is also to clear all CPUs of the core from the
> > > cpumask  of the loop above so it will not try the same core next time
> > >
> > > >
> >
> > That goal we still continue to maintain by the way of cpumask_andnot.
> > i.e instead of clearing CPUs one at a time, we clear all the CPUs in the
> > core at one shot.
> 
> ah yes sorry, I have been to quick and overlooked the cpumask_andnot line
> 

Just to reiterate why this is necessary.
Currently, even if the first thread of a core is not idle, we iterate
through all threads of the core and individually clear the CPU from the core
mask.

Collecting ticks on a Power 9 SMT 8 system around select_idle_core
while running schbench shows us that

(units are in ticks, hence lesser is better)
Without patch
    N           Min           Max        Median           Avg        Stddev
x 130           151          1083           284     322.72308     144.41494


With patch
    N           Min           Max        Median           Avg        Stddev   Improvement
x 164            88           610           201     225.79268     106.78943        30.03%

-- 
Thanks and Regards
Srikar Dronamraju

