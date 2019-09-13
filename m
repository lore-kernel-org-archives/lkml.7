Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C6920717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbfIMJKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:10:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387937AbfIMJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:10:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8D97jLQ038174
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 05:10:42 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v05e260pm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 05:10:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.ibm.com>;
        Fri, 13 Sep 2019 10:10:39 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Sep 2019 10:10:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8D9AZWC58327128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 09:10:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C490A4060;
        Fri, 13 Sep 2019 09:10:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8282A405C;
        Fri, 13 Sep 2019 09:10:34 +0000 (GMT)
Received: from pomme.local (unknown [9.145.117.92])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Sep 2019 09:10:34 +0000 (GMT)
Subject: Re: [PATCH 2/3] powperc/mm: read TLB Block Invalidate Characteristics
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190830120712.22971-1-ldufour@linux.ibm.com>
 <20190830120712.22971-3-ldufour@linux.ibm.com> <87impxshfk.fsf@linux.ibm.com>
 <468a53a6-a970-5526-8035-eef59dcf48ed@linux.ibm.com>
 <97bafb53-6ae9-1d42-1816-ef81b845b80c@linux.ibm.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
Date:   Fri, 13 Sep 2019 11:10:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <97bafb53-6ae9-1d42-1816-ef81b845b80c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091309-0012-0000-0000-0000034ACACB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091309-0013-0000-0000-000021853A28
Message-Id: <76cd8c5e-0a7f-1aa0-0004-c7a874085ce1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909130088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/09/2019 à 04:00, Aneesh Kumar K.V a écrit :
> On 9/13/19 12:56 AM, Laurent Dufour wrote:
>> Le 12/09/2019 à 16:44, Aneesh Kumar K.V a écrit :
>>> Laurent Dufour <ldufour@linux.ibm.com> writes:
> 
>>>> +
>>>> +    idx = 2;
>>>> +    while (idx < len) {
>>>> +        unsigned int block_size = local_buffer[idx++];
>>>> +        unsigned int npsize;
>>>> +
>>>> +        if (!block_size)
>>>> +            break;
>>>> +
>>>> +        block_size = 1 << block_size;
>>>> +        if (block_size != 8)
>>>> +            /* We only support 8 bytes size TLB invalidate buffer */
>>>> +            pr_warn("Unsupported H_BLOCK_REMOVE block size : %d\n",
>>>> +                block_size);
>>>
>>> Should we skip setting block size if we find block_size != 8? Also can
>>> we avoid doing that pr_warn in loop and only warn if we don't find
>>> block_size 8 in the invalidate characteristics array?
>>
>> My idea here is to fully read and process the data returned by the hcall, 
>> and to put the limitation to 8 when checking before calling H_BLOCK_REMOVE.
>> The warning is there because I want it to be displayed once at boot.
>>
> 
> 
> Can we have two block size reported for the same base page size/actual page 
> size combination? If so we will overwrite the hblk[actual_psize] ?

In check_lp_set_hblk() I'm only keeping the bigger one.

> 
>>>
>>>> +
>>>> +        for (npsize = local_buffer[idx++];  npsize > 0; npsize--)
>>>> +            check_lp_set_hblk((unsigned int) local_buffer[idx++],
>>>> +                      block_size);
>>>> +    }
>>>> +
>>>> +    for (bpsize = 0; bpsize < MMU_PAGE_COUNT; bpsize++)
>>>> +        for (idx = 0; idx < MMU_PAGE_COUNT; idx++)
>>>> +            if (mmu_psize_defs[bpsize].hblk[idx])
>>>> +                pr_info("H_BLOCK_REMOVE supports base psize:%d 
>>>> psize:%d block size:%d",
>>>> +                    bpsize, idx,
>>>> +                    mmu_psize_defs[bpsize].hblk[idx]);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +machine_arch_initcall(pseries, read_tlbbi_characteristics);
>>>> +
>>>>   /*
>>>>    * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
>>>>    * lock.
> 
> -aneesh

