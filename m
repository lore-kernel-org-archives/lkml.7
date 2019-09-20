Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A720C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408680AbfITKpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:45:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732138AbfITKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:45:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8KAbPeV074196
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:45:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4t21701x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:45:48 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 20 Sep 2019 11:45:46 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Sep 2019 11:45:41 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8KAje1A40108050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 10:45:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 630275204E;
        Fri, 20 Sep 2019 10:45:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.163])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CAD065205A;
        Fri, 20 Sep 2019 10:45:37 +0000 (GMT)
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        mingo@redhat.com, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <20190919144259.vpuv7hvtqon4qgrv@e107158-lin.cambridge.arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 20 Sep 2019 16:15:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190919144259.vpuv7hvtqon4qgrv@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092010-0012-0000-0000-0000034E7F76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092010-0013-0000-0000-00002189049F
Message-Id: <b782b3c2-2db3-1dde-f996-9c274ba465ac@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=992 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909200101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/19 8:13 PM, Qais Yousef wrote:
> On 09/18/19 18:11, Parth Shah wrote:
>> Hello everyone,
>>
>> As per the discussion in LPC2019, new per-task property like latency-nice
>> can be useful in certain scenarios. The scheduler can take proper decision
>> by knowing latency requirement of a task from the end-user itself.
>>
>> There has already been an effort from Subhra for introducing Task
>> latency-nice [1] values and have seen several possibilities where this type of
>> interface can be used.
>>
>> From the best of my understanding of the discussion on the mail thread and
>> in the LPC2019, it seems that there are two dilemmas;
>>
>> 1. Name: What should be the name for such attr for all the possible usecases?
>> =============
>> Latency nice is the proposed name as of now where the lower value indicates
>> that the task doesn't care much for the latency and we can spend some more
>> time in the kernel to decide a better placement of a task (to save time,
>> energy, etc.)
>> But there seems to be a bit of confusion on whether we want biasing as well
>> (latency-biased) or something similar, in which case "latency-nice" may
>> confuse the end-user.
>>
>> 2. Value: What should be the range of possible values supported by this new
>> attr?
>> ==============
>> The possible values of such task attribute still need community attention.
>> Do we need a range of values or just binary/ternary values are sufficient?
>> Also signed or unsigned and so the length of the variable (u64, s32, etc)?
> 
> IMO the main question is who is the intended user of this new knob/API?
> 
> If it's intended for system admins to optimize certain workloads on a system
> then I like the latency-nice range.
> 
> If we want to support application writers to define the latency requirements of
> their tasks then I think latency-nice would be very confusing to use.
> Especially when one has to consider they lack a pre-knowledge about the system
> they will run on; and what else they are sharing the resources with.
> 

Yes, valid point.
But from my view, this will most certainly be for system admins who can
optimize certain workloads from the systemd, tuned or similar OS daemons.

>>
>>
>>
>> This mail is to initiate the discussion regarding the possible usecases of
>> such per task attribute and to come up with a specific name and value for
>> the same.
>>
>> Hopefully, interested one should plot out their usecase for which this new
>> attr can potentially help in solving or optimizing it.
>>
>>
>> Well, to start with, here is my usecase.
>>
>> -------------------
>> **Usecases**
>> -------------------
>>
>> $> TurboSched
>> ====================
>> TurboSched [2] tries to minimize the number of active cores in a socket by
>> packing an un-important and low-utilization (named jitter) task on an
>> already active core and thus refrains from waking up of a new core if
>> possible. This requires tagging of tasks from the userspace hinting which
>> tasks are un-important and thus waking-up a new core to minimize the
>> latency is un-necessary for such tasks.
>> As per the discussion on the posted RFC, it will be appropriate to use the
>> task latency property where a task with the highest latency-nice value can
>> be packed.
>> But for this specific use-cases, having just a binary value to know which
>> task is latency-sensitive and which not is sufficient enough, but having a
>> range is also a good way to go where above some threshold the task can be
>> packed.
> 
> 
> $> EAS
> ====================
> The new knob can help EAS path to switch to spreading behavior when
> latency-nice is set instead of packing tasks on the most energy efficient CPU.
> ie: pick the most energy efficient idle CPU.
> 

+1

Thanks,
Parth

> --
> Qais Yousef
> 

