Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263CFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC47E208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YprNyBwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfFQRVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:21:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44921 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:21:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so7545019oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m6hj6kR6+t7FFgSRKaK1PbX93Vf69qhd80YwAUvJfY=;
        b=YprNyBwcuU7peH69ojyfcOHSG09vpn+WCDMlzGVZX7krGOxzA38q9jGCAuVJ3u8dUl
         ARp0m4eM7XcX/eR8V6wFea0PHqsk2ILlfA4J8C3DcOEQ3mE+O51E01kszOwKzLuws2fF
         6Igv5nh+vDV7XP9ueQ61ixTl17AHI6MdkwZpji/iK30Tn5OzQgi5Xx2TA38yrkdJrsR1
         odxVF85VzukYawtRFMrPqVrmXrKlQ6HrdV+m99XuDdcrRABsCDi421y5SB7YP4Kn0iqZ
         FZRt9w+dmb+eOjEHfy4knKFlViuuM33mdh1Zzdp5EHs3I45SN1TMzM8K80BnPc4E7ZZb
         kqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m6hj6kR6+t7FFgSRKaK1PbX93Vf69qhd80YwAUvJfY=;
        b=HAxTAoyvUZuK7FJ/jpktimYj7bsHl8m2w3Iwf3VVu/9feLWOpZT1iZnMd8Jfm2yAOT
         8t6VyMQuorzyfKetVEfLk7Nr8vfWsnn1+tV1rM/geYhL/xjVIJ4G5xlBHZ4iTxD3DH9k
         4dOhAUXb8LnzW0EpD6tuu3F4m+rp9129fZlIkf/QeqAcmNUyIU88DMrmaHMuFzxo7V65
         TBNYpkMDnh7QIHV81zM/UlGKxbYhEYV1yiDDBRZARl9X5nTdl8T/idy63BIpvOQzjx54
         kjXB02PDyorArtt5wGEevctFcns3T4wkqQu4uGGZwuKve7a3SQr1r+f2/P2jh2IlTjAr
         s8GQ==
X-Gm-Message-State: APjAAAXiuf+v2XaNMBhVJ5B8BiIjczsIjCYTp/0WBn++RHOr64D8tSgj
        qNNHCmOx/7Akfmd9k36vD73UlO23UHJ74149smSatw==
X-Google-Smtp-Source: APXvYqwVgRIrtHtXnTOpaGBVuVulNLYZy1sN1k1Po68BpCrKXTxlXWFQxhkbz94oC9uvIpMV9vHTUh/5w12QpAh0JY0=
X-Received: by 2002:aca:1304:: with SMTP id e4mr11244312oii.149.1560792112232;
 Mon, 17 Jun 2019 10:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
 <1560376072.5154.6.camel@lca.pw> <87lfy4ilvj.fsf@linux.ibm.com>
 <20190614153535.GA9900@linux> <c3f2c05d-e42f-c942-1385-664f646ddd33@linux.ibm.com>
 <CAPcyv4j_QQB8SrhTqL2mnEEHGYCg4H7kYanChiww35k0fwNv8Q@mail.gmail.com> <87imt6i3zd.fsf@linux.ibm.com>
In-Reply-To: <87imt6i3zd.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 10:21:40 -0700
Message-ID: <CAPcyv4gKPBuZ_1=YRGpQb0hzgf_-PFdkgTgh1nHS_iAxbJ-MCg@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 8:50 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > On Fri, Jun 14, 2019 at 9:18 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 6/14/19 9:05 PM, Oscar Salvador wrote:
> >> > On Fri, Jun 14, 2019 at 02:28:40PM +0530, Aneesh Kumar K.V wrote:
> >> >> Can you check with this change on ppc64.  I haven't reviewed this series yet.
> >> >> I did limited testing with change . Before merging this I need to go
> >> >> through the full series again. The vmemmap poplulate on ppc64 needs to
> >> >> handle two translation mode (hash and radix). With respect to vmemap
> >> >> hash doesn't setup a translation in the linux page table. Hence we need
> >> >> to make sure we don't try to setup a mapping for a range which is
> >> >> arleady convered by an existing mapping.
> >> >>
> >> >> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> >> >> index a4e17a979e45..15c342f0a543 100644
> >> >> --- a/arch/powerpc/mm/init_64.c
> >> >> +++ b/arch/powerpc/mm/init_64.c
> >> >> @@ -88,16 +88,23 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
> >> >>    * which overlaps this vmemmap page is initialised then this page is
> >> >>    * initialised already.
> >> >>    */
> >> >> -static int __meminit vmemmap_populated(unsigned long start, int page_size)
> >> >> +static bool __meminit vmemmap_populated(unsigned long start, int page_size)
> >> >>   {
> >> >>      unsigned long end = start + page_size;
> >> >>      start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
> >> >>
> >> >> -    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
> >> >> -            if (pfn_valid(page_to_pfn((struct page *)start)))
> >> >> -                    return 1;
> >> >> +    for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page))) {
> >> >>
> >> >> -    return 0;
> >> >> +            struct mem_section *ms;
> >> >> +            unsigned long pfn = page_to_pfn((struct page *)start);
> >> >> +
> >> >> +            if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> >> >> +                    return 0;
> >> >
> >> > I might be missing something, but is this right?
> >> > Having a section_nr above NR_MEM_SECTIONS is invalid, but if we return 0 here,
> >> > vmemmap_populate will go on and populate it.
> >>
> >> I should drop that completely. We should not hit that condition at all.
> >> I will send a final patch once I go through the full patch series making
> >> sure we are not breaking any ppc64 details.
> >>
> >> Wondering why we did the below
> >>
> >> #if defined(ARCH_SUBSECTION_SHIFT)
> >> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
> >> #elif defined(PMD_SHIFT)
> >> #define SUBSECTION_SHIFT (PMD_SHIFT)
> >> #else
> >> /*
> >>   * Memory hotplug enabled platforms avoid this default because they
> >>   * either define ARCH_SUBSECTION_SHIFT, or PMD_SHIFT is a constant, but
> >>   * this is kept as a backstop to allow compilation on
> >>   * !ARCH_ENABLE_MEMORY_HOTPLUG archs.
> >>   */
> >> #define SUBSECTION_SHIFT 21
> >> #endif
> >>
> >> why not
> >>
> >> #if defined(ARCH_SUBSECTION_SHIFT)
> >> #define SUBSECTION_SHIFT (ARCH_SUBSECTION_SHIFT)
> >> #else
> >> #define SUBSECTION_SHIFT  SECTION_SHIFT
> >> #endif
> >>
> >> ie, if SUBSECTION is not supported by arch we have one sub-section per
> >> section?
> >
> > A couple comments:
> >
> > The only reason ARCH_SUBSECTION_SHIFT exists is because PMD_SHIFT on
> > PowerPC was a non-constant value. However, I'm planning to remove the
> > distinction in the next rev of the patches. Jeff rightly points out
> > that having a variable subsection size per arch will lead to
> > situations where persistent memory namespaces are not portable across
> > archs. So I plan to just make SUBSECTION_SHIFT 21 everywhere.
>
> What is the dependency between subsection and pageblock_order? Shouldn't
> subsection size >= pageblock size?
>
> We do have pageblock size drived from HugeTLB size.

The pageblock size is independent of subsection-size. The pageblock
size is a page-allocator concern, subsections only exist for pages
that are never onlined to the page-allocator.
