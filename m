Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC4C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A5B2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfFNQ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:26:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbfFNQ0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:26:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5EGHO9w101839
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:26:08 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t4c5f8a25-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:26:08 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 14 Jun 2019 17:26:07 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Jun 2019 17:26:04 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5EGQ3M135520844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jun 2019 16:26:04 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7196E04E;
        Fri, 14 Jun 2019 16:26:03 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F72F6E052;
        Fri, 14 Jun 2019 16:26:01 +0000 (GMT)
Received: from [9.199.60.77] (unknown [9.199.60.77])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jun 2019 16:26:01 +0000 (GMT)
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
 <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
 <20190614153535.GA9900@linux>
 <c3f2c05d-e42f-c942-1385-664f646ddd33@linux.ibm.com>
 <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Fri, 14 Jun 2019 21:56:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061416-0016-0000-0000-000009C27AEC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011261; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01217915; UDB=6.00640491; IPR=6.00999036;
 MB=3.00027312; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-14 16:26:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061416-0017-0000-0000-000043A6B53A
Message-Id: <24fcb721-5d50-2c34-f44b-69281c8dd760@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906140134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19 9:52 PM, Dan Williams wrote:
> On Fri, Jun 14, 2019 at 9:18 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 6/14/19 9:05 PM, Oscar Salvador wrote:
>>> On Fri, Jun 14, 2019 at 02:28:40PM +0530, Aneesh Kumar K.V wrote:
>>>> Can you check with this change on ppc64.  I haven't reviewed this series yet.
>>>> I did limited testing with change . Before merging this I need to go
>>>> through the full series again. The vmemmap poplulate on ppc64 needs to
>>>> handle two translation mode (hash and radix). With respect to vmemap
>>>> hash doesn't setup a translation in the linux page table. Hence we need
>>>> to make sure we don't try to setup a mapping for a range which is
>>>> arleady convered by an existing mapping.
>>>>
>>>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>>>> index a4e17a979e45..15c342f0a543 100644
>>>> --- a/arch/powerpc/mm/init_64.c
>>>> +++ b/arch/powerpc/mm/init_64.c
>>>> @@ -88,16 +88,23 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>>>>     * which overlaps this vmemmap page is initialised then this page is
>>>>     * initialised already.
>>>>     */
>>>> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
>>>> +static bool __meminit vmemmap_populated(unsigned long start, int page_size)
>>>>    {
>>>>       unsigned long end = start + page_size;
>>>>       start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>>>>
>>>> -    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
>>>> -            if (pfn_valid(page_to_pfn((struct page *)start)))
>>>> -                    return 1;
>>>> +    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page))) {
>>>>
>>>> -    return 0;
>>>> +            struct mem_section *ms;
>>>> +            unsigned long pfn = page_to_pfn((struct page *)start);
>>>> +
>>>> +            if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>>>> +                    return 0;
>>>
>>> I might be missing something, but is this right?
>>> Having a section_nr above NR_MEM_SECTIONS is invalid, but if we return 0 here,
>>> vmemmap_populate will go on and populate it.
>>
>> I should drop that completely. We should not hit that condition at all.
>> I will send a final patch once I go through the full patch series making
>> sure we are not breaking any ppc64 details.
>>
>> Wondering why we did the below
>>
>> #if defined(ARCH_SUBSECTION_SHIFT)
>> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>> #elif defined(PMD_SHIFT)
>> #define SUBSECTION_SHIFT (PMD_SHIFT)
>> #else
>> /*
>>    * Memory hotplug enabled platforms avoid this default because they
>>    * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
>>    * this is kept as a backstop to allow compilation on
>>    * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
>>    */
>> #define SUBSECTION_SHIFT 21
>> #endif
>>
>> why not
>>
>> #if defined(ARCH_SUBSECTION_SHIFT)
>> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>> #else
>> #define SUBSECTION_SHIFT  SECTION_SHIFT

That should be SECTION_SIZE_SHIFT

>> #endif
>>
>> ie, if SUBSECTION is not supported by arch we have one sub-section per
>> section?
> 
> A couple comments:
> 
> The only reason ARCH_SUBSECTION_SHIFT exists is because PMD_SHIFT on
> PowerPC was a non-constant value. However, I'm planning to remove the
> distinction in the next rev of the patches. Jeff rightly points out
> that having a variable subsection size per arch will lead to
> situations where persistent memory namespaces are not portable across
> archs. So I plan to just make SUBSECTION_SHIFT 21 everywhere.
> 


persistent memory namespaces are not portable across archs because they 
have PAGE_SIZE dependency. Then we have dependencies like the page size 
with which we map the vmemmap area. Why not let the arch
arch decide the SUBSECTION_SHIFT and default to one subsection per 
section if arch is not enabled to work with subsection.

-aneesh

