Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202DC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164DC21726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cr/2pcTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfIDVK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:10:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42113 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfIDVK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:10:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id c10so10782449otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPMWwNSvV9eb5rCu0YMNtiK3/0cR200eFpdZP8tToms=;
        b=cr/2pcTab+KUWoDNVNzO2zJ+8zFyfJbc3u75JTwJU8kJ7gWl3gxzG5ENnPPSyVrSCq
         SuBqAQ8RzhaV2a/HxduSt7ppLV/eWGTtUx/a6wNjIODvqE88o+7S1ZWGc6I6GW/lWSco
         ugSco9IMYbUbbhVhb7LB51QAUisJGNylBc2XTRY+ofuMS4mtW7yB+nBDwcC8Eflg+DIh
         C47efgC6cD78+M5RvB3gTx+JoWSmjAvaaa2GqDhJjsgLFt59c15hiEh1Ur3QDfAToi1y
         ZJezHfiZrelD2BcNYDQu3jmZ72RSuDo/vns5bY+ZuJ10WxhXfVOcTURaAUZLAfLH4A1T
         NulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPMWwNSvV9eb5rCu0YMNtiK3/0cR200eFpdZP8tToms=;
        b=KF/vooN5G7sszytf/GpgSxbqWEKEQenr/0pHizS+zGxXPMoKjb5QLbWkuRv1CbrG4u
         1mFIXQMPibmOSyYcd1cOVPNXCMEZXcx7T2Vn+ulsP9GgiPfV0+x3Jb07ElBgOF9/qTIx
         /cNNaz7xR9VdhjBM1AuF6a/pI0wYUd97Je+6h43ROIIcukOwuK0Q8PXueJPl3peq12m3
         v0TdJg3uL8iARGgxWxGoblvU5qMVnrib3JF4xu5WEC22Jj8/MnoZrNUYNP8Cwwp+MlX/
         04RIuVPU/O3exNTv0NNpY0EYWdLDMKrEnEF27Jnceg7ZLOQOmQm/Dim5MvyB0YUuDntA
         pK5w==
X-Gm-Message-State: APjAAAVuBjICYnmXKRuy+Us7flmENZNQsTaZqtlLOZoBuGClE0QNGbHk
        1Q+mgLC8LtqO9buMEHIbMTh2W8Srx6MRculves0Cwg==
X-Google-Smtp-Source: APXvYqzFh8uueHK+qUmQpwTm/TlKG431AzcbA3p2O6x4cql8knUN37kiD/jGqwHTO7K8qxaIQLqXw5St076KjdfoMnU=
X-Received: by 2002:a9d:6d15:: with SMTP id o21mr9381251otp.363.1567631427871;
 Wed, 04 Sep 2019 14:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190904150920.13848.32271.stgit@localhost.localdomain> <20190904151030.13848.25822.stgit@localhost.localdomain>
In-Reply-To: <20190904151030.13848.25822.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Sep 2019 14:10:17 -0700
Message-ID: <CAPcyv4jZVoztoRA7hEq5xzbwg0QJ+UVASuk5XQmB5KHQrvAmfA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] mm: Adjust shuffle code to allow for future coalescing
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     nitesh@redhat.com, KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Oscar Salvador <osalvador@suse.de>, yang.zhang.wz@gmail.com,
        Pankaj Gupta <pagupta@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:10 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Move the head/tail adding logic out of the shuffle code and into the
> __free_one_page function since ultimately that is where it is really
> needed anyway. By doing this we should be able to reduce the overhead
> and can consolidate all of the list addition bits in one spot.
>
> While changing out the code I also opted to go for a bit more thread safe
> approach to getting the boolean value. This way we can avoid possible cache
> line bouncing of the batched entropy between CPUs.

The original version of this patch just did the movement, but now the
patch also does the percpu optimization. At this point it warrants
being split into a "move" patch and then "rework". Otherwise the bulk
of the patch is not really well described by the patch title. With the
split there's a commit id for each of the performance improvement
claims.

Other than that the percpu logic changes look good to me.
