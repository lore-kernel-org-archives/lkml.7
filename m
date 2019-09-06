Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85803C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55529206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="B5lMPpGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395222AbfIFRdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:33:55 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33443 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388372AbfIFRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:33:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id e12so5339384oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qpDnR/GYJ/XrBLmzSIYUWPDpRlqXVwU8hq/PPEapHXQ=;
        b=B5lMPpGHxIofgZL10Pn92uDG8MnE3nHQtXDzubuDNUxCRt56k31Zr5/4pBbkv4ywfp
         k2B9yLhvs+CQZolGYvrtvi/f3xzxDtXhUuaaFUh5Dvv21CfjE/LNyLRZb+x7i5PmiS1D
         ZIUPTbM+K/3hH0G5jF0Ehvp/Yz/ZSAz34z7I9miMnRsfe9zcMJiYCJBadW8maOBNVufF
         LcFtXZOm1s1HhJLXNF5PKER+f1vQe8CZv1SdFAlPsTrPBHjyL4m5sSnEEtuWzr+dME/d
         yPglC9Vp78a/MAqamkHBU5HxSM1bZk6G1BF35zRlxhELkYuQGhMHkWrK/kqOJOKhXYXT
         WCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpDnR/GYJ/XrBLmzSIYUWPDpRlqXVwU8hq/PPEapHXQ=;
        b=GCKO8/JAgSdU9hxd3bFQmpfGz1FcwJhV1no0ZAm/t5LMrokkpl/ZQt8LKUG/aAgzD6
         X7c544BCqUWUD1DRRVbMX2oJCgZV//ELoZemsryFJkkS7gMGvCy1IntH9vSNAgM3D1bV
         xuWcyk8rY6EGabqedBGprePFntLHJstAmjuhl5NIjS5lGabPdVw+hTh6R+hUaZU9Hiwt
         BbyIfUkL0ySH4CwaggaESjR2iU1K2QhYF05yWrGYKWffHhJKQHsP1iHe87MsafXyZXCL
         Yl+KqogKMNeEXR4v06cKzCq39YRDSqpQz457ZzvazHo3C5dtdCiICORMkXeJ1LV9vZyk
         SSEA==
X-Gm-Message-State: APjAAAVUWLeC0Q3raJH8IHZyO47bhG+D3o9jqbLcGMXfumIljFhGfeAv
        gF/d58yP7ne96oRL+tJy3mcYrOFYBJvj5+wv2Hmenw==
X-Google-Smtp-Source: APXvYqxs26WaI4nMH81FCrmErnLZVB0v+f8/lt+3MTncxWG87yVQW0BSOxASyAFc+69JKSrfI3WlFVqe6CUueDct1rs=
X-Received: by 2002:aca:5dc3:: with SMTP id r186mr7672240oib.73.1567791233988;
 Fri, 06 Sep 2019 10:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190906145213.32552.30160.stgit@localhost.localdomain> <20190906145327.32552.39455.stgit@localhost.localdomain>
In-Reply-To: <20190906145327.32552.39455.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Sep 2019 10:33:42 -0700
Message-ID: <CAPcyv4i_LPrYvenhzcM_Ji6nviZWHqTDWQDDusv5pCXv0Bi7QA@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] mm: Add per-cpu logic to page shuffling
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

On Fri, Sep 6, 2019 at 7:53 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Change the logic used to generate randomness in the suffle path so that we
> can avoid cache line bouncing. The previous logic was sharing the offset
> and entropy word between all CPUs. As such this can result in cache line
> bouncing and will ultimately hurt performance when enabled.
>
> To resolve this I have moved to a per-cpu logic for maintaining a unsigned
> long containing some amount of bits, and an offset value for which bit we
> can use for entropy with each call.
>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
