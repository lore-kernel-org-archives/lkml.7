Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CCC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9108720857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfDBPZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:25:16 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:39230 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbfDBPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:25:16 -0400
Received: by mail-qt1-f178.google.com with SMTP id t28so15678052qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 08:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mx9J4jw2GPScgHPcaXdWstBCWvWOeEoG4tjKtIlkD4g=;
        b=TJ6JtoTtLQhpuJ2w6+i7tpKVWba+nAkb9tWl/+4vTgnZXGDXsW/Mnry0GTRi5Jk1gi
         Y3OB0yDIWPBA+CRfx6sAsFxa972K5UGWLtkV0IG9SKEWgd5FjUm76O8tfHs3tiof9uM5
         x0dAOz62cTAZTOpwEbg9RoRjFWISLpP/Q8UxX+z31P87pI1u2euracY8MtjwV6Ot7DPq
         +Kd0/ktyPw71jJGLH/ZeCnonigsrL01K6RGerHILyfyF4rB+NOFR6M0CdoVOjv3Yq2mP
         535iyHu/Ib/jR2opxQ5OGLQcmpcsGn555NsDyt0KdfV2dggIQpLG3QcFNSuZ8PRl8Z2V
         /+6w==
X-Gm-Message-State: APjAAAWxP/ce0NCxQPcSiiM4K4crwtHXobMT2KO7iUw5zH4iMTReD5Tt
        jY4r43kjFP54dXcDaVKmZzns/g==
X-Google-Smtp-Source: APXvYqwU2x/6XRs2Azjaky+XbQ7todIFJAnFK2yBCuWt+46dnJIjuwQoRZKqLUKdiA2YPkTMxWJ6bg==
X-Received: by 2002:a0c:d07b:: with SMTP id d56mr58838282qvh.89.1554218715324;
        Tue, 02 Apr 2019 08:25:15 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id a8sm7988404qtc.19.2019.04.02.08.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:25:13 -0700 (PDT)
Date:   Tue, 2 Apr 2019 11:25:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190402112115-mutt-send-email-mst@kernel.org>
References: <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
 <20190329125034-mutt-send-email-mst@kernel.org>
 <fb23fd70-4f1b-26a8-5ecc-4c14014ef29d@redhat.com>
 <20190401073007-mutt-send-email-mst@kernel.org>
 <29e11829-c9ac-a21b-b2f1-ed833e4ca449@redhat.com>
 <dc14a711-a306-d00b-c4ce-c308598ee386@redhat.com>
 <20190401104608-mutt-send-email-mst@kernel.org>
 <CAKgT0UcJuD-t+MqeS9geiGE1zsUiYUgZzeRrOJOJbOzn2C-KOw@mail.gmail.com>
 <6a612adf-e9c3-6aff-3285-2e2d02c8b80d@redhat.com>
 <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ue_By3Z0=5ZEvscmYAF2P40Bdyo-AXhH8sZv5VxUGGLvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:04:00AM -0700, Alexander Duyck wrote:
> Basically what we would be doing is providing a means for
> incrementally transitioning the buddy memory into the idle/offline
> state to reduce guest memory overhead. It would require one function
> that would walk the free page lists and pluck out pages that don't
> have the "Offline" page type set,

I think we will need an interface that gets
an offline page and returns the next online free page.

If we restart the list walk each time we can't guarantee progress.

> a one-line change to the logic for
> allocating a page as we would need to clear that extra bit of state,
> and optionally some bits for how to handle the merge of two "Offline"
> pages in the buddy allocator (required for lower order support). It
> solves most of the guest side issues with the free page hinting in
> that trying to do it via the arch_free_page path is problematic at
> best since it was designed for a synchronous setup, not an
> asynchronous one.


-- 
MST
