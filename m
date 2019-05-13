Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C92BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2921520873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfEMKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:07:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728701AbfEMKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:07:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DA2dFK142090
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:07:13 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sf3dsynbj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:07:13 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 13 May 2019 11:07:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 11:07:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4DA76Kc48758894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 10:07:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 666B3A405B;
        Mon, 13 May 2019 10:07:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B01CA4053;
        Mon, 13 May 2019 10:07:05 +0000 (GMT)
Received: from [9.124.31.49] (unknown [9.124.31.49])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 10:07:04 +0000 (GMT)
Subject: Re: [PATCH 1/2] perf ioctl: Add check for the sample_period value
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jolsa@redhat.com, mpe@ellerman.id.au, maddy@linux.vnet.ibm.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190511024217.4013-1-ravi.bangoria@linux.ibm.com>
 <20190513074213.GH2623@hirez.programming.kicks-ass.net>
 <20190513085620.GN2650@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 13 May 2019 15:37:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513085620.GN2650@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051310-0012-0000-0000-0000031B1158
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051310-0013-0000-0000-00002153A35B
Message-Id: <d2d34084-999d-9be2-511e-82625b80aa40@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/19 2:26 PM, Peter Zijlstra wrote:
> On Mon, May 13, 2019 at 09:42:13AM +0200, Peter Zijlstra wrote:
>> On Sat, May 11, 2019 at 08:12:16AM +0530, Ravi Bangoria wrote:
>>> Add a check for sample_period value sent from userspace. Negative
>>> value does not make sense. And in powerpc arch code this could cause
>>> a recursive PMI leading to a hang (reported when running perf-fuzzer).
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>> ---
>>>  kernel/events/core.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index abbd4b3b96c2..e44c90378940 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>>>  	if (perf_event_check_period(event, value))
>>>  		return -EINVAL;
>>>  
>>> +	if (!event->attr.freq && (value & (1ULL << 63)))
>>> +		return -EINVAL;
>>
>> Well, perf_event_attr::sample_period is __u64. Would not be the site
>> using it as signed be the one in error?
> 
> You forgot to mention commit: 0819b2e30ccb9, so I guess this just makes
> it consistent and is fine.
> 

Yeah, I was about to reply :)

