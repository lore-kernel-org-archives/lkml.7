Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7222C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6F720707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 11:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfLELm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 06:42:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728735AbfLELm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 06:42:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5Bg3Z0029052
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 06:42:26 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wpupb5hw8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:42:26 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 5 Dec 2019 11:42:24 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 11:42:19 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5BfcpB49676716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 11:41:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E25CFAE059;
        Thu,  5 Dec 2019 11:42:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DFB3AE051;
        Thu,  5 Dec 2019 11:42:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.37])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 11:42:16 +0000 (GMT)
Subject: Re: [RFC 1/3] Introduce latency-tolerance as an per-task attribute
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-2-parth@linux.ibm.com>
 <20191203083654.3ctttimdiujdt7tl@e107158-lin.cambridge.arm.com>
 <59044b60-a7d8-9508-4975-06afdcfd33cd@linux.ibm.com>
 <d6a1d7ae-fe5e-7f52-60b5-4daac9a70107@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 5 Dec 2019 17:12:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d6a1d7ae-fe5e-7f52-60b5-4daac9a70107@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120511-0020-0000-0000-000003944997
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120511-0021-0000-0000-000021EB7681
Message-Id: <f2df49f4-0396-0b90-d491-719a76bd6a1e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=915 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/19 2:54 PM, Dietmar Eggemann wrote:
> On 03/12/2019 16:47, Parth Shah wrote:
>>
>> On 12/3/19 2:06 PM, Qais Yousef wrote:
>>> On 11/25/19 15:16, Parth Shah wrote:
>>>> Latency-tolerance indicates the latency requirements of a task with respect
>>>> to the other tasks in the system. The value of the attribute can be within
>>>> the range of [-20, 19] both inclusive to be in-line with the values just
>>>> like task nice values.
>>>>
>>>> latency_tolerance = -20 indicates the task to have the least latency as
>>>> compared to the tasks having latency_tolerance = +19.
>>>>
>>>> The latency_tolerance may affect only the CFS SCHED_CLASS by getting
>>>> latency requirements from the userspace.
> 
> [...]
> 
>>>> diff --git a/include/linux/sched/latency_tolerance.h b/include/linux/sched/latency_tolerance.h
> 
> Do we really need an extra header file for this? I know there is
> linux/sched/prio.h but couldn't this go into kernel/sched/sched.h?

We can include this in kernel/sched/sched.h itself unless we have any plans
to use it outside the scheduler subsystem. I will then add it as specified
in next revision.

> 
> [...]
> 

