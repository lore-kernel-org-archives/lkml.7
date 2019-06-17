Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73519C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EE421874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfFQIim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:38:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfFQIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:38:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5H8bwF3108312
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:38:41 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t670s1c06-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 04:38:41 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 17 Jun 2019 09:38:39 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 09:38:35 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5H8cY5M49283138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 08:38:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEA8611C05C;
        Mon, 17 Jun 2019 08:38:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B95611C04C;
        Mon, 17 Jun 2019 08:38:33 +0000 (GMT)
Received: from [9.124.31.76] (unknown [9.124.31.76])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 08:38:33 +0000 (GMT)
Subject: Re: [PATCH v2] perf ioctl: Add check for the sample_period value
To:     mpe@ellerman.id.au, peterz@infradead.org
Cc:     jolsa@redhat.com, maddy@linux.vnet.ibm.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <87h89eq55e.fsf@concordia.ellerman.id.au>
 <20190604042953.914-1-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 17 Jun 2019 14:08:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604042953.914-1-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061708-0008-0000-0000-000002F463F1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061708-0009-0000-0000-000022617484
Message-Id: <e1d0fcf5-d7f8-44a0-a3b8-339f2b79fb2c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter / mpe,

Is the v2 looks good? If so, can anyone of you please pick this up.

On 6/4/19 9:59 AM, Ravi Bangoria wrote:
> perf_event_open() limits the sample_period to 63 bits. See
> commit 0819b2e30ccb ("perf: Limit perf_event_attr::sample_period
> to 63 bits"). Make ioctl() consistent with it.
> 
> Also on powerpc, negative sample_period could cause a recursive
> PMIs leading to a hang (reported when running perf-fuzzer).
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  kernel/events/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3b96c2..e44c90378940 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
>  	if (perf_event_check_period(event, value))
>  		return -EINVAL;
>  
> +	if (!event->attr.freq && (value & (1ULL << 63)))
> +		return -EINVAL;
> +
>  	event_function_call(event, __perf_event_period, &value);
>  
>  	return 0;
> 

