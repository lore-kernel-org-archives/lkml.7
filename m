Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7975C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21CB21743
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfIEGPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:15:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725921AbfIEGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:15:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8568JA0139451
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 02:15:46 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utsv5xhsf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:15:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 5 Sep 2019 07:15:44 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 07:15:39 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x856FcVs51642502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 06:15:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D22AE053;
        Thu,  5 Sep 2019 06:15:38 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7F93AE051;
        Thu,  5 Sep 2019 06:15:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 06:15:35 +0000 (GMT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, mgorman@techsingularity.net,
        patrick.bellasi@arm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <11aaa3a8-e6b9-cf1f-08bb-0f8e1b63942b@linux.intel.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 5 Sep 2019 11:45:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <11aaa3a8-e6b9-cf1f-08bb-0f8e1b63942b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090506-0012-0000-0000-00000346F0B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090506-0013-0000-0000-000021814539
Message-Id: <c09bf5fc-8fc6-dddd-0a18-bd7d5f2136b5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/19 11:02 PM, Tim Chen wrote:
> On 8/30/19 10:49 AM, subhra mazumdar wrote:
>> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
>> "latency-nice" which is shared by all the threads in that Cgroup.
> 
> 
> Subhra,
> 
> Thanks for posting the patchset.  Having a latency nice hint
> is useful beyond idle load balancing.  I can think of other
> application scenarios, like scheduling batch machine learning AVX 512
> processes with latency sensitive processes.  AVX512 limits the frequency
> of the CPU and it is best to avoid latency sensitive task on the
> same core with AVX512.  So latency nice hint allows the scheduler
> to have a criteria to determine the latency sensitivity of a task
> and arrange latency sensitive tasks away from AVX512 tasks.
> 


Hi Tim and Subhra,

This patchset seems to be interesting for my TurboSched patches as well
where I try to pack jitter tasks on fewer cores to get higher Turbo Frequencies.
Well, the problem I face is that we sometime end up putting multiple jitter tasks on a core
running some latency sensitive application which may see performance degradation.
So my plan was to classify such tasks to be latency sensitive thereby hinting the load
balancer to not put tasks on such cores.

TurboSched: https://lkml.org/lkml/2019/7/25/296

> You configure the latency hint on a cgroup basis.
> But I think not all tasks in a cgroup necessarily have the same
> latency sensitivity.
> 
> For example, I can see that cgroup can be applied on a per user basis,
> and the user could run different tasks that have different latency sensitivity.
> We may also need a way to configure latency sensitivity on a per task basis instead on
> a per cgroup basis.
> 

AFAIU, the problem defined above intersects with my patches as well where the interface
is required to classify the jitter tasks. I have already tried few methods like
syscall and cgroup to classify such tasks and maybe something like that can be adopted
with these patchset as well.


Thanks,
Parth

