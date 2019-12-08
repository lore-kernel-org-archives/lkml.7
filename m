Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156DAC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863D206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfLHF6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:58:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfLHF6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:58:14 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB85krXK019618
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 00:58:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr8kuy67e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 00:58:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 8 Dec 2019 05:58:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Dec 2019 05:58:04 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB85w4vN56295506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Dec 2019 05:58:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAA9B4C04A;
        Sun,  8 Dec 2019 05:58:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36C494C046;
        Sun,  8 Dec 2019 05:57:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.71.101])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Dec 2019 05:57:59 +0000 (GMT)
Subject: Re: [RFC 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, pavel@ucw.cz,
        dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
 <c26f7909-0e4e-a897-bf84-0aa9e5389a0d@arm.com>
 <838f233e-fa4c-d5a3-9b50-69e2e121edda@arm.com>
 <5c5b61fa-e8f7-5aa7-0fe0-91cb0d4736fb@linux.ibm.com>
 <1cc0a6a4-85e9-4b53-7139-261558682582@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Sun, 8 Dec 2019 11:27:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1cc0a6a4-85e9-4b53-7139-261558682582@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120805-0016-0000-0000-000002D2BAC1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120805-0017-0000-0000-00003334C8D7
Message-Id: <0936f3e7-8aa7-67f4-4262-48346367a522@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-07_08:2019-12-05,2019-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=788
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912080053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 6:01 PM, Dietmar Eggemann wrote:
> On 05.12.19 18:13, Parth Shah wrote:
>>
>>
>> On 12/5/19 7:33 PM, Dietmar Eggemann wrote:
>>> On 05/12/2019 11:49, Valentin Schneider wrote:
>>>>  
>>>> On 05/12/2019 09:24, Dietmar Eggemann wrote:
>>>>> On 25/11/2019 10:46, Parth Shah wrote:
> 
> [...]
> 
>>> OK, I went through this thread again. So Google or we have to provide
>>> the missing per-taskgroup API via cpu controller's attributes (like for
>>> uclamp) for the EAS usecase.
>>
>> I suppose many others (including myself) will also be interested in having
>> per-taskgroup attribute via CPU controller.
> 
> Ok, let us have a look since Android needs it.
> 
> [...]
> 
>> I kept choosing appropriate name and possible values for this new attribute
>> in the separate thread. https://lkml.org/lkml/2019/9/30/215
>> From which discussion, looking at Patrick's comment
>> https://lkml.org/lkml/2019/9/18/678 I thought of picking latency_tolerance
>> as the appropriate name.
>> Still will be happy to change as per the community needs.
> 
> Yeah, SCHED_FLAG_LATENCY_TOLERANCE seems to be pretty long.
> 

Hi, I'm thinking of sending v2 for the patch series and for the sake of
continuity, I will maintain the name as it is because I'm expecting further
response from other developers for the latency_nice. Will re-spin the
series with new name if people agrees upon.


Best,
Parth

