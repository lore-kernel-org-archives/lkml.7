Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA331C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB55B20850
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfDNUEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725797AbfDNUEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:04:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3EJwusK066727
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:04:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvbcardk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 16:04:38 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Sun, 14 Apr 2019 21:04:37 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 14 Apr 2019 21:04:35 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3EK4YR647513638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Apr 2019 20:04:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 510EBAE053;
        Sun, 14 Apr 2019 20:04:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE4B8AE045;
        Sun, 14 Apr 2019 20:04:30 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.85.73.3])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 14 Apr 2019 20:04:30 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
 <CAJZ5v0h+jyPQ=NofwV4ha6zBqk7E1gF1xE9CoBfKYfb3jBTbig@mail.gmail.com>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Mon, 15 Apr 2019 01:34:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h+jyPQ=NofwV4ha6zBqk7E1gF1xE9CoBfKYfb3jBTbig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19041420-0012-0000-0000-0000030EB42E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041420-0013-0000-0000-00002146E62F
Message-Id: <32cdf163-32b7-1011-16aa-8b40332832db@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904140152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Thanks for the Review. Few inline replies below.


On 04/09/2019 03:31 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 5, 2019 at 11:17 AM Abhishek Goel
> <huntbag@linux.vnet.ibm.com> wrote:
>> Currently, the cpuidle governors (menu /ladder) determine what idle state
> There are three governors in 5.1-rc.
>
>> an idling CPU should enter into based on heuristics that depend on the
>> idle history on that CPU. Given that no predictive heuristic is perfect,
>> there are cases where the governor predicts a shallow idle state, hoping
>> that the CPU will be busy soon. However, if no new workload is scheduled
>> on that CPU in the near future, the CPU will end up in the shallow state.
>>
>> In case of POWER, this is problematic, when the predicted state in the
>> aforementioned scenario is a lite stop state, as such lite states will
>> inhibit SMT folding, thereby depriving the other threads in the core from
>> using the core resources.
>>
>> To address this, such lite states need to be autopromoted.
> I don't quite agree with this statement and it doesn't even match what
> the patch does AFAICS.  "Autopromotion" would be going from the given
> state to a deeper one without running state selection in between, but
> that's not what's going on here.
Thinking to call it "timed-exit". Is that good?
>> The cpuidle-core can queue timer to correspond with the residency value of the next
>> available state. Thus leading to auto-promotion to a deeper idle state as
>> soon as possible.
> No, it doesn't automatically cause a deeper state to be used next
> time.  It simply kicks the CPU out of the idle state and one more
> iteration of the idle loop runs on it.  Whether or not a deeper state
> will be selected in that iteration depends on the governor
> computations carried out in it.
I did not mean that next state is chosen automatically. I should have been
more descriptive here instead of just using "as soon as possible"
> Now, this appears to be almost analogous to the "polling" state used
> on x86 which uses the next idle state's target residency as a timeout.
>
> While generally I'm not a big fan of setting up timers in the idle
> loop (it sort of feels like pulling your own hair in order to get
> yourself out of a swamp), if idle states like these are there in your
> platform, setting up a timer to get out of them in the driver's
> ->enter() routine might not be particularly objectionable.  Doing that
> in the core is a whole different story, though.
>
> Generally, this adds quite a bit of complexity (on the "ugly" side of
> things IMO) to the core to cover a corner case present in one
> platform, while IMO it can be covered in the driver for that platform
> directly.
As of now, since this code doesn't add any benefit to the other platform,
I will post a patch with this implementation covered in platform-specific
driver code.
You are right that all the information needed for this implementation 
are also
available there in platform driver code, so we should be good to go.

