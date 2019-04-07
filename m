Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3830C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF15D20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 22:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VF6J7VpL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDGWLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 18:11:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45348 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfDGWLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 18:11:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id y84so8928424oia.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2XZYc73eRD7vceltyVRxYxMZptJ0KGjDTZjSsKaM94=;
        b=VF6J7VpLiFG+tX7uSQBIb+AwaLMM5daXTCJr5O14/07I+crMC/7CyhhDhw/rkhgzqV
         QAJpzGmLF77WW5GGQgOi7zXJLDOUf9PWcJXZpAaDnR8G2Z/o32w5PyVXb2/17NUKOENd
         ILp3C+qJyDufmz/H2FvScxkpoEoX8y3/OKQkd3xj2xNV8GjV5iFpzzmF+UKZJX1J+Nbv
         +s8qytEbKUXRw946ci+uDxo4I/DMq3otb4OcjI6kzqUlEJ+XYDKXR8Rkk3WUGRzttS9r
         3gvfgcy6yRVczoPA5o6/ZvBoApQtsCN3QuyBLTFSXyHZBeidoj1Uji54NX/l7khGIYFi
         58RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2XZYc73eRD7vceltyVRxYxMZptJ0KGjDTZjSsKaM94=;
        b=pLzpMUb/DKMNiHW5fkZw5ZID+iMyWRr7LaO0K3gY/+cWvv2s6kDoJNe8D0J8nMYXk8
         5b54+Aq6Wjm/V7LN4LpuODkvO+ODA+TOwQA58nN1BawJPy6S9QOaZYkyxUyzI6aZ7it6
         TiWusJ/s+EApFcgZs8Kh1ICGdYJo9hj45a4eBjh3a6O1QoXraK+q2HDSCsKA1zdNbbfa
         uBzEO1stHlMFLMSuMRDP8Q57fEwVMfJan1iM/rhVKuuwCM4GBIAZwCBComdhnAzdmOHA
         WTLOqaE9TRXy6u6AXwkR8X6kO5eOm9awLMgFMTATMiRb1Kki14w5JChRkiqtZWzrotoj
         ayvA==
X-Gm-Message-State: APjAAAXNajwAyhicF4qbTwIhL1lcZQiLfNdgnFWi3VS6RqiTs8Rh00g7
        tpeLBKp8MHAeuhAE8zY1O3Wp1K8/9T5xHNQMB/+3Hw==
X-Google-Smtp-Source: APXvYqzY6+cyTHrSoY4urPHyhyziXZg+NKTZb0BCBZ46NSBkQJtTlIpQKITlrqnG9yYnwNxu42BStWrEHG+Tle46O5A=
X-Received: by 2002:aca:f581:: with SMTP id t123mr14992918oih.0.1554675072260;
 Sun, 07 Apr 2019 15:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-7-git-send-email-anshuman.khandual@arm.com>
 <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com> <0d72db39-e20d-1cbd-368e-74dda9b6c936@arm.com>
 <CAPcyv4h5YskvjR306FsHnVHpPjnT4s2JPJXgk6CxiMz8bjhqkg@mail.gmail.com> <a16a9867-7019-10ab-1901-c114bcd8712b@arm.com>
In-Reply-To: <a16a9867-7019-10ab-1901-c114bcd8712b@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 7 Apr 2019 15:11:00 -0700
Message-ID: <CAPcyv4j0Z2ASeJGgS18Bpgr_2F8XdZdCq4T9W5fgkG1oWKtNHg@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64/mm: Enable ZONE_DEVICE
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>, james.morse@arm.com,
        Mark Rutland <mark.rutland@arm.com>, cpandya@codeaurora.org,
        arunks@codeaurora.org, osalvador@suse.de,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>, cai@lca.pw,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 2:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 04/04/2019 06:04, Dan Williams wrote:
> > On Wed, Apr 3, 2019 at 9:42 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >>
> >> On 04/03/2019 07:28 PM, Robin Murphy wrote:
> >>> [ +Dan, Jerome ]
> >>>
> >>> On 03/04/2019 05:30, Anshuman Khandual wrote:
> >>>> Arch implementation for functions which create or destroy vmemmap mapping
> >>>> (vmemmap_populate, vmemmap_free) can comprehend and allocate from inside
> >>>> device memory range through driver provided vmem_altmap structure which
> >>>> fulfils all requirements to enable ZONE_DEVICE on the platform. Hence just
> >>>
> >>> ZONE_DEVICE is about more than just altmap support, no?
> >>
> >> Hot plugging the memory into a dev->numa_node's ZONE_DEVICE and initializing the
> >> struct pages for it has stand alone and self contained use case. The driver could
> >> just want to manage the memory itself but with struct pages either in the RAM or
> >> in the device memory range through struct vmem_altmap. The driver may not choose
> >> to opt for HMM, FS DAX, P2PDMA (use cases of ZONE_DEVICE) where it may have to
> >> map these pages into any user pagetable which would necessitate support for
> >> pte|pmd|pud_devmap.
> >
> > What's left for ZONE_DEVICE if none of the above cases are used?
> >
> >> Though I am still working towards getting HMM, FS DAX, P2PDMA enabled on arm64,
> >> IMHO ZONE_DEVICE is self contained and can be evaluated in itself.
> >
> > I'm not convinced. What's the specific use case.
>
> The fundamental "roadmap" reason we've been doing this is to enable
> further NVDIMM/pmem development (libpmem/Qemu/etc.) on arm64. The fact
> that ZONE_DEVICE immediately opens the door to the various other stuff
> that the CCIX folks have interest in is a definite bonus, so it would
> certainly be preferable to get arm64 on par with the current state of
> things rather than try to subdivide the scope further.
>
> I started working on this from the ZONE_DEVICE end, but got bogged down
> in trying to replace my copied-from-s390 dummy hot-remove implementation
> with something proper. Anshuman has stepped in to help with hot-remove
> (since we also have cloud folks wanting that for its own sake), so is
> effectively coming at the problem from the opposite direction, and I'll
> be the first to admit that we've not managed the greatest job of meeting
> in the middle and coordinating our upstream story; sorry about that :)
>
> Let me freshen up my devmap patches and post them properly, since that
> discussion doesn't have to happen in the context of hot-remove; they're
> effectively just parallel dependencies for ZONE_DEVICE.

Sounds good. It's also worth noting that Ira's recent patches for
supporting get_user_pages_fast() for "longterm" pins relies on
PTE_DEVMAP to determine when fast-GUP is safe to proceed, or whether
it needs to fall back to slow-GUP. So it really is the case that
"devmap" support is an assumption for ZONE_DEVICE.
