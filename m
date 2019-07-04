Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3CCC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1102D205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ftzysFAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfGDXiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 19:38:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41873 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfGDXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:38:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id g7so5915320oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ve/CczmjDTp62IiyOlOME0RVKS5HfvyxwnJvsVLm4Vs=;
        b=ftzysFAgpNAb+BruhLNH0hJPG1+DZJH5fW47QFP2ZCCrJsWY0QiqCN33vLIdmP+YKX
         oYjFGqBNFdAiE67/Scf00vlp73/xqc9pUOTQqv50+CArtatDE9N0E1fmMn6a6b4TXgvC
         b4ikeLch0hVf8zFQYSEq1w3vTKY09hc+kjsVZV/qqSlPyxPEUIxUQ7KsfqcwWe9BrcAA
         v/Qn7UXw1I9f8vsa2e7SuNV9MVKpvVtW0GhCb8C3HKqRROUiumhwmxjXK1mvWegh7J9t
         v+AIy6jg8Of0NKSl5vCY5SL/L+7uGHiv+8rWcdQo5jq8sjpRw09XucLUw0n59f/fPRH+
         PPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ve/CczmjDTp62IiyOlOME0RVKS5HfvyxwnJvsVLm4Vs=;
        b=a6ei/cpno/s8wnMV7RPP0TpXX2SYQtHDqMqQkqiFOstUxB9E69BriwOmR00btTSy8a
         X5813aPRPfKNCb+cth15649XRZWcIGYffxdXTxhJ0Hp7ww+lhFTYMPxv/xjw/V/ZieZ8
         jJJiQSDSUdv1caRIIIv1Ca0OhKaSekP06U/dYF4/jat8xj8u+fQr0COrOokgZS0lRSaY
         FSJNh2b7Kg4GKiyA45pxHDaYgmIcugo7U/dCnVZfOWNkKOtLaOzpWvV0OnaTL/JHLQu6
         3aeK0SDoetOa/Zxim2W87NmCcHykJKIzTXLx0FDr07xXNjkTAPOp+UazwGayGRpCsEQ6
         wInw==
X-Gm-Message-State: APjAAAWjIKRRap0WfCQ78WGZrfcpE4f6JNSGAKw4qJlXUtYPfvUc0+Za
        ZYbjQAlbDT6elc4O55iE0aWV35wWFTK3DvVIJYbdKQ==
X-Google-Smtp-Source: APXvYqxPvl0JaE/xctjYrnEPxDDTTNAKohKZCdbZNul+YnSwqo3/7CHb/acC/vbGgVjEA6Xdvr5WpUQKmbNeFnXQ/uE=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr441491oif.70.1562283482013;
 Thu, 04 Jul 2019 16:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558547956.git.robin.murphy@arm.com> <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com> <20190626153829.GA22138@infradead.org>
 <20190626154532.GA3088@mellanox.com> <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
 <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org> <20190704195934.GA23542@mellanox.com>
In-Reply-To: <20190704195934.GA23542@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Jul 2019 16:37:51 -0700
Message-ID: <CAPcyv4iSviwyAPBnw5zDu_Ks0Ty0sFZ6QbEtVVU0PRd=ReRZNg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 12:59 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jul 04, 2019 at 11:53:24AM -0700, Andrew Morton wrote:
> > On Wed, 26 Jun 2019 20:35:51 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > > > Let me know and I can help orchestate this.
> > >
> > > Well.  Whatever works.  In this situation I'd stage the patches after
> > > linux-next and would merge them up after the prereq patches have been
> > > merged into mainline.  Easy.
> >
> > All right, what the hell just happened?
>
> Christoph's patch series for the devmap & hmm rework finally made it
> into linux-next, sorry, it took quite a few iterations on the list to
> get all the reviews and tests, and figure out how to resolve some
> other conflicting things. So it just made it this week.
>
> Recall, this is the patch series I asked you about routing a few weeks
> ago, as it really exceeded the small area that hmm.git was supposed to
> cover. I think we are both caught off guard how big the conflict is!
>
> > A bunch of new material has just been introduced into linux-next.
> > I've partially unpicked the resulting mess, haven't dared trying to
> > compile it yet.  To get this far I'll need to drop two patch series
> > and one individual patch:
>
> > mm-clean-up-is_device__page-definitions.patch
> > mm-introduce-arch_has_pte_devmap.patch
> > arm64-mm-implement-pte_devmap-support.patch
> > arm64-mm-implement-pte_devmap-support-fix.patch
>
> This one we discussed, and I thought we agreed would go to your 'stage
> after linux-next' flow (see above). I think the conflict was minor
> here.
>
> > mm-sparsemem-introduce-struct-mem_section_usage.patch
> > mm-sparsemem-introduce-a-section_is_early-flag.patch
> > mm-sparsemem-add-helpers-track-active-portions-of-a-section-at-boot.patch
> > mm-hotplug-prepare-shrink_zone-pgdat_span-for-sub-section-removal.patch
> > mm-sparsemem-convert-kmalloc_section_memmap-to-populate_section_memmap.patch
> > mm-hotplug-kill-is_dev_zone-usage-in-__remove_pages.patch
> > mm-kill-is_dev_zone-helper.patch
> > mm-sparsemem-prepare-for-sub-section-ranges.patch
> > mm-sparsemem-support-sub-section-hotplug.patch
> > mm-document-zone_device-memory-model-implications.patch
> > mm-document-zone_device-memory-model-implications-fix.patch
> > mm-devm_memremap_pages-enable-sub-section-remap.patch
> > libnvdimm-pfn-fix-fsdax-mode-namespace-info-block-zero-fields.patch
> > libnvdimm-pfn-stop-padding-pmem-namespaces-to-section-alignment.patch
>
> Dan pointed to this while reviewing CH's series and said the conflicts
> would be manageable, but they are certainly larger than I expected!
>
> This series is the one that seems to be the really big trouble. I
> already checked all the other stuff that Stephen resolved, and it
> looks OK and managable. Just this one conflict with kernel/memremap.c
> is beyond me.
>
> What approach do you want to take to go forward? Here are some thoughts:
>
> CH has said he is away for the long weekend, so the path that involves
> the fewest people is if Dan respins the above on linux-next and it
> goes later with the arm patches above, assuming defering it for now
> has no other adverse effects on -mm.
>
> Pushing CH's series to -mm would need a respin on top of Dan's series
> above and would need to carry along the whole hmm.git (about 44
> patches). Signs are that this could be managed with the code currently
> in the GPU trees.
>
> If we give up on CH's series the hmm.git will not have conflicts,
> however we just kick the can to the next merge window where we will be
> back to having to co-ordinate amd/nouveau/rdma git trees and -mm's
> patch workflow - and I think we will be worse off as we will have
> totally given up on a git based work flow for this. :(

I think the problem would be resolved going forward post-v5.3 since we
won't have two tress managing kernel/memremap.c. This cycle however
there is a backlog of kernel/memremap.c changes in -mm.
