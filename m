Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44745C2BBE2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2175E24670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 13:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLFNjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:39:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfLFNjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 08:39:40 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6DWReJ015392
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 08:39:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq905ktrd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:39:39 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 6 Dec 2019 13:39:36 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 13:39:33 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6DdWbd58654918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 13:39:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6AA4A4057;
        Fri,  6 Dec 2019 13:39:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D5D3A404D;
        Fri,  6 Dec 2019 13:39:31 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  6 Dec 2019 13:39:30 +0000 (GMT)
Date:   Fri, 6 Dec 2019 19:09:30 +0530
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
 <20191206081654.GA22330@linux.vnet.ibm.com>
 <CAKfTPtBOVe+-fMBd+oHxZ51q5GtaxR6uyYep+a+NWJArbV9EcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtBOVe+-fMBd+oHxZ51q5GtaxR6uyYep+a+NWJArbV9EcQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19120613-0028-0000-0000-000003C5FFB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120613-0029-0000-0000-00002489257A
Message-Id: <20191206133930.GA25024@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_03:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912060117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

> >
> > Collecting ticks on a Power 9 SMT 8 system around select_idle_core
> > while running schbench shows us that
> >
> > (units are in ticks, hence lesser is better)
> > Without patch
> >     N           Min           Max        Median           Avg        Stddev
> > x 130           151          1083           284     322.72308     144.41494
> >
> >
> > With patch
> >     N           Min           Max        Median           Avg        Stddev   Improvement
> > x 164            88           610           201     225.79268     106.78943        30.03%
> 
> Thanks for the figures. Might be good to include them in the commit message
> 

Since I needed a debug/hack patch on top of upstream/my-patch to get these
numbers, I wasn't sure if this would be ideal to be included in a commit
message. But if you still think it's good to have, I can re-spin the patch
with these numbers included.

> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>

Thanks.

-- 
Thanks and Regards
Srikar Dronamraju

