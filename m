Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8657C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83DB20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGIVRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:17:38 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:12432 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbfGIVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:17:38 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69LGFNl024628;
        Tue, 9 Jul 2019 21:17:21 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2tmye9987t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 21:17:21 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id DE5AE58;
        Tue,  9 Jul 2019 21:17:20 +0000 (UTC)
Received: from [16.116.129.61] (unknown [16.116.129.61])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id C1B7248;
        Tue,  9 Jul 2019 21:17:18 +0000 (UTC)
Subject: Re: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
To:     Nadav Amit <namit@vmware.com>
Cc:     Russ Anderson <rja@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
References: <20190702235151.4377-1-namit@vmware.com>
 <20190702235151.4377-9-namit@vmware.com>
 <alpine.DEB.2.21.1907092146570.1758@nanos.tec.linutronix.de>
 <20190709200914.fjvi3cy3qfc6fmis@hpe.com>
 <373adfb0-0047-eae2-46a5-041caddfca97@hpe.com>
 <3AA5020A-111F-48F4-A0E9-B3C09E5EC43E@vmware.com>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <6a40267d-f646-5406-db14-155ecd05cf48@hpe.com>
Date:   Tue, 9 Jul 2019 14:17:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <3AA5020A-111F-48F4-A0E9-B3C09E5EC43E@vmware.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2019 2:09 PM, Nadav Amit wrote:
>> On Jul 9, 2019, at 1:29 PM, Mike Travis <mike.travis@hpe.com> wrote:
>>
>>
>>
>> On 7/9/2019 1:09 PM, Russ Anderson wrote:
>>> On Tue, Jul 09, 2019 at 09:50:27PM +0200, Thomas Gleixner wrote:
>>>> On Tue, 2 Jul 2019, Nadav Amit wrote:
>>>>
>>>>> SGI UV support is outdated and not maintained, and it is not clear how
>>>>> it performs relatively to non-UV. Remove the code to simplify the code.
>>>>
>>>> You should at least Cc the SGI/HP folks on that. They are still
>>>> around. Done so.
>>> Thanks Thomas.  The SGI UV is now HPE Superdome Flex and is
>>> very much still supported.
>>> Thanks.
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>>> ---
>>>>>   arch/x86/mm/tlb.c | 25 -------------------------
>>>>>   1 file changed, 25 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
>>>>> index b47a71820f35..64afe1215495 100644
>>>>> --- a/arch/x86/mm/tlb.c
>>>>> +++ b/arch/x86/mm/tlb.c
>>>>> @@ -689,31 +689,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
>>>>>   		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
>>>>>   				(info->end - info->start) >> PAGE_SHIFT);
>>>>>   -	if (is_uv_system()) {
>>>>> -		/*
>>>>> -		 * This whole special case is confused.  UV has a "Broadcast
>>>>> -		 * Assist Unit", which seems to be a fancy way to send IPIs.
>>>>> -		 * Back when x86 used an explicit TLB flush IPI, UV was
>>>>> -		 * optimized to use its own mechanism.  These days, x86 uses
>>>>> -		 * smp_call_function_many(), but UV still uses a manual IPI,
>>>>> -		 * and that IPI's action is out of date -- it does a manual
>>>>> -		 * flush instead of calling flush_tlb_func_remote().  This
>>>>> -		 * means that the percpu tlb_gen variables won't be updated
>>>>> -		 * and we'll do pointless flushes on future context switches.
>>>>> -		 *
>>>>> -		 * Rather than hooking native_flush_tlb_multi() here, I think
>>>>> -		 * that UV should be updated so that smp_call_function_many(),
>>>>> -		 * etc, are optimal on UV.
>>>>> -		 */
>>
>> I thought this change was already proposed a bit ago and we acked it
>> awhile back. Also the replacement functionality is being worked on but it
>> is more complex. The smp call many has to support all the reasons why it’s
>> called and not just the tlb shoot downs as is the current BAU case.
> 
> Sorry for not cc’ing you before. In the meanwhile, can you give an explicit
> acked-by? (I couldn’t find the previous patch you regarded.)

Sure:

Acked-by: Mike Travis <mike.travis@hpe.com>

> 
> Thanks,
> Nadav
> 
