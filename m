Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0039C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D8B20866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFPDuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 23:50:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbfFPDuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 23:50:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5G3lLMS125015
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 23:50:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t5dwx8ecc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 23:50:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Sun, 16 Jun 2019 04:50:15 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 16 Jun 2019 04:50:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5G3oBUR49348710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Jun 2019 03:50:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51C71AE057;
        Sun, 16 Jun 2019 03:50:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8981FAE04D;
        Sun, 16 Jun 2019 03:50:09 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.86.48])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 16 Jun 2019 03:50:09 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
In-Reply-To: <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com> <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com> <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com> <20190614153535.GA9900@linux> <c3f2c05d-e42f-c942-1385-664f646ddd33@linux.ibm.com> <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com>
Date:   Sun, 16 Jun 2019 09:19:42 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19061603-0016-0000-0000-000002897078
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061603-0017-0000-0000-000032E6B591
Message-Id: <87imt6i3zd.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906160035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Jun 14, 2019 at 9:18 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 6/14/19 9:05 PM, Oscar Salvador wrote:
>> > On Fri, Jun 14, 2019 at 02:28:40PM +0530, Aneesh Kumar K.V wrote:
>> >> Can you check with this change on ppc64.  I haven't reviewed this series yet.
>> >> I did limited testing with change . Before merging this I need to go
>> >> through the full series again. The vmemmap poplulate on ppc64 needs to
>> >> handle two translation mode (hash and radix). With respect to vmemap
>> >> hash doesn't setup a translation in the linux page table. Hence we need
>> >> to make sure we don't try to setup a mapping for a range which is
>> >> arleady convered by an existing mapping.
>> >>
>> >> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> >> index a4e17a979e45..15c342f0a543 100644
>> >> --- a/arch/powerpc/mm/init_64.c
>> >> +++ b/arch/powerpc/mm/init_64.c
>> >> @@ -88,16 +88,23 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
>> >>    * which overlaps this vmemmap page is initialised then this page is
>> >>    * initialised already.
>> >>    */
>> >> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
>> >> +static bool __meminit vmemmap_populated(unsigned long start, int page_size)
>> >>   {
>> >>      unsigned long end = start + page_size;
>> >>      start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
>> >>
>> >> -    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
>> >> -            if (pfn_valid(page_to_pfn((struct page *)start)))
>> >> -                    return 1;
>> >> +    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page))) {
>> >>
>> >> -    return 0;
>> >> +            struct mem_section *ms;
>> >> +            unsigned long pfn = page_to_pfn((struct page *)start);
>> >> +
>> >> +            if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
>> >> +                    return 0;
>> >
>> > I might be missing something, but is this right?
>> > Having a section_nr above NR_MEM_SECTIONS is invalid, but if we return 0 here,
>> > vmemmap_populate will go on and populate it.
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
>>   * Memory hotplug enabled platforms avoid this default because they
>>   * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
>>   * this is kept as a backstop to allow compilation on
>>   * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
>>   */
>> #define SUBSECTION_SHIFT 21
>> #endif
>>
>> why not
>>
>> #if defined(ARCH_SUBSECTION_SHIFT)
>> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
>> #else
>> #define SUBSECTION_SHIFT  SECTION_SHIFT
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

What is the dependency between subsection and pageblock_order? Shouldn't
subsection size >= pageblock size?

We do have pageblock size drived from HugeTLB size.

-aneesh

