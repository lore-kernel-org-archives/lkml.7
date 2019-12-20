Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68133C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEF02146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLTMvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:51:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727335AbfLTMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKCofFP020816
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 07:50:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x0kspxu36-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 07:50:59 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 20 Dec 2019 12:50:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 20 Dec 2019 12:50:54 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBKCorCq30867544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 12:50:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC4A1A4059;
        Fri, 20 Dec 2019 12:50:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AE4FA4053;
        Fri, 20 Dec 2019 12:50:49 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.102.1.51])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 20 Dec 2019 12:50:48 +0000 (GMT)
Subject: Re: [RFC] cpuidle : Add debugfs support for cpuidle core
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <20191217143834.19797-1-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0jmMwRGDY70EV3sqpw7uJ4R+VomoWtJ9rWzNTVuV3AUxQ@mail.gmail.com>
 <CAOSf1CF9F1iViKCCoJXOPmkbj+kLXnJJz5b5B7xLgrLpCZoB3w@mail.gmail.com>
 <CAJZ5v0iMutsf1UK+01dsZa1WDZAVK_fvOZJ-2FgiYXwWDqdnig@mail.gmail.com>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Fri, 20 Dec 2019 18:20:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iMutsf1UK+01dsZa1WDZAVK_fvOZJ-2FgiYXwWDqdnig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19122012-0028-0000-0000-000003CA9D8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122012-0029-0000-0000-0000248DF248
Message-Id: <33e38a86-a022-6c15-7c78-77903ec5abc5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_02:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,


On 12/19/2019 02:34 PM, Rafael J. Wysocki wrote:
> On Wed, Dec 18, 2019 at 3:26 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>> On Wed, Dec 18, 2019 at 3:51 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Tue, Dec 17, 2019 at 3:42 PM Abhishek Goel
>>> <huntbag@linux.vnet.ibm.com> wrote:
>>>> Up until now, we did not have a way to tune cpuidle attribute like
>>>> residency in kernel. This patch adds support for debugfs in cpuidle core.
>>>> Thereby providing support for tuning cpuidle attributes like residency in
>>>> kernel at runtime.
>>> This is not a good idea in my view, for a couple of reasons.
>>>
>>> First off, if the target residency of an idle state is changed, it
>>> effectively becomes a different one and all of the statistics
>>> regarding it become outdated at that point.  Synchronizing that would
>>> be a pain.
>>>
>>> Next, governors may get confused if idle state parameters are changed
>>> on the fly.  In particular, the statistics collected by the teo
>>> governor depend on the target residencies of idle states, so if one of
>>> them changes, the governor needs to be reloaded.
>>>
>>> Next, idle states are expected to be ordered by the target residency
>>> (and by the exit latency), so their parameters cannot be allowed to
>>> change freely anyway.
>>>
>>> Finally, the idle state parameters are expected to reflect the
>>> properties of the hardware, which wouldn't hold any more if they were
>>> allowed to change at any time.
>> Certainly does sound like a headache.
>>
>>>> For example: Tuning residency at runtime can be used to quantify governors
>>>> decision making as governor uses residency as one of the parameter to
>>>> take decision about the state that needs to be entered while idling.
>>> IMO it would be better to introduce a testing cpuidle driver with an
>>> artificial set of idle states (or even such that the set of idle
>>> states to be used by it can be defined by the user e.g. via module
>>> parameters) for this purpose.
>> The motivation for this patch isn't really a desire to test / tune the
>> governor. It's intended to allow working around a performance problem
>> caused by using high-latency idle states on some interrupt heavy GPU
>> workload. The interrupts occur around ~30ms apart which is long enough
>> for the governor to put the CPU into the deeper states and over the
>> course of long job the additional wakeup latency adds up. The initial
>> fix someone came up with was cooking the residency values so the
>> high-latency states had a residency of +50ms to prevent the govenor
>> from using them. However, that fix is supposed to go into a bit of
>> firmware I maintain and I'm not terribly happy with the idea. I'm
>> fairly sure that ~30ms value is workload dependent and personally I
>> don't think firmware should be making up numbers to trick specific
>> kernel versions into doing specific things.
>>
>> My impression is the right solution is to have the GPU driver set a PM
>> QoS constraint on the CPUs receiving interrupts while a job is
>> on-going.
> Yes, that would address the GPU problem.
>
>> However, interrupt latency sensitivity isn't something
>> that's unique to GPUs so I'm wondering it it makes sense to have the
>> governor factor in interrupt traffic when deciding what state to use.
>> Is that something that's been tried before?
> Yes, that is in the works.
>
> The existing governors should take interrupts into account too in the
> form of the expected idle duration corrections, but that may not be
> particularly precise.  If the governor currently in use (I guess menu)
> doesn't to that, you may try an alternative one (e.g. teo).

For this particular case, I tried TEO but it did not solve the issue.
> That said, work is in progress on taking the actual interrupt
> frequency into account in idle duration prediction.
>
> Thanks!

Could you please point out to the patch looking into device interrupt
frequency for cpuidle.

Thanks.

