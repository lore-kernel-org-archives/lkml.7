Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE6C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DC321783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfJATIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJATIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:08:39 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEBCAE2523
        for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2019 19:08:38 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id x77so15616248qka.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 12:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyDOxDob+igviijoSMOJYC51FLEyIymiVWHSujSRqsg=;
        b=Ae6krNmrgnprByIn8rIlH7+tl/PoLQ0qg5I6boxkYuGhkDKs7kt6lhbAlrsdKHcDzA
         0okbKs55mmC/pQFUN1N3pa+BSqgmVQKijDzyIH4NqQql0ki2B5PQOLaxrEchDQlNTNCo
         b9vlskNNcjqCZg/r8KAmGzTu9Eo+XFzFbcu1C1HZdi7uKcHcr5HtOsILkdIKXC9Pb01z
         NoimrpLB7MmX280vRjrl8iv+xNKEdGW48m+n1AOOVC4CykU48V+haVgl9G2u/OBnuxVl
         0aRhxT20JN68LeLg9eOUgNhOD8tnr/dEy6Rf0nx3FkZQAvxivkn5mDNlUMI8Q5zlth1L
         hzmA==
X-Gm-Message-State: APjAAAWAmk2VtboIjvsMwnQ7cScAY6dPmDrsPZwUmRP0sgTVxJOVVh2U
        hHUvjVW6IjFnA1Bb4LZlcocXDl3Y1AUnATDo5oPiwmATJ/HtYTjyfTjpbePSuMKOA2xRHUw3nw/
        xoU38GhfHhjA0kBKTaV52dSBA
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr7940566qkb.410.1569956918112;
        Tue, 01 Oct 2019 12:08:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqlzM9Ty0JvR982/ZKv1347lkHYUf56yBEMeBfEE56A9YdRL50Yn8F7mKtdi+zcUYu2r/EBA==
X-Received: by 2002:a05:620a:7ca:: with SMTP id 10mr7940534qkb.410.1569956917887;
        Tue, 01 Oct 2019 12:08:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id n42sm10811959qta.31.2019.10.01.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 12:08:36 -0700 (PDT)
Date:   Tue, 1 Oct 2019 15:08:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, osalvador@suse.de, yang.zhang.wz@gmail.com,
        pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com,
        riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com,
        aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
Subject: Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
Message-ID: <20191001144331-mutt-send-email-mst@kernel.org>
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 09:21:46AM -0700, Alexander Duyck wrote:
> I thought what Michal was asking for was what was the benefit of using the
> boundary pointer. I added a bit up above and to the description for patch
> 3 as on a 32G VM it adds up to about a 18% difference without factoring in
> the page faulting and zeroing logic that occurs when we actually do the
> madvise.

Something maybe worth adding to the log:

one disadvantage of the tight integration with the mm core is
that only a single reporting device is supported.
It's not obvious that more than one is useful though.

-- 
MST
