Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ACAC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422CC20811
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ti6WT1kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfCRSa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:30:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46914 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRSa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:30:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id x188so1676007oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbsTYKGPUf22VNUHUiDumPSMR3YTxTtHfk3y04Q51PI=;
        b=Ti6WT1kEvz5706AzrASGb3DEtp+m8ZO+QEXN5wFB+65Dn64vkucYPUtl275qzWQcDL
         OkR0bul4zxaYW6XYbh4PIZpjS8+i0ejH1t92P0sHeChDtCDzOuJwwPbk3tbyqGkr1I1s
         /CRlBL/qG+BRneir31rdy3ywTvLqDjVal2nUrrGHjc5tnTc+oLaAJ6w17FESSUFhpTTz
         H6oRDlE3nXOpY32QB6p7bgx5T6ZDi3cQ8pYGtpdtYPnvfTmVg+492QO6Dtkv7FhmtV2l
         RHN/0nkQsymYJPOLXNo9xYLbxTdMNX/84V7RB/qzEBmNsVk3fEoiZOuBtFYjxosXSVAa
         No3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbsTYKGPUf22VNUHUiDumPSMR3YTxTtHfk3y04Q51PI=;
        b=GG7sGAqU7ljEiKNYTi4zf6U/cjCi0R4wF63UW1lCHWHhWywamRDqUIBkDTHbCxMqqg
         80hvvMKZ7GjJYWTydURSgOHYXVk3sRu6c3PxO5IUHKCzG02/4sCX2wJ/P3Xv9b/sTWQg
         R39YhZghCN2sQ7TdMQa6rR347AlnOJVPzgs1XBBZHPk8nbQ1LcZ7J1G/xB+03DIAgcX1
         p4ERfZmCcLco3mVxLZzHbr5/OH2I5Y8VglAWQUu0iGjhn2M7cSZHAkLLq0/H1ptNkqa4
         cPBXL0y1CQacCu2Fe0hjG3SLZ8gI2cTaCCLON3/rQUSKfJb60rEgWwsrvcDmybK8znFw
         U/Dg==
X-Gm-Message-State: APjAAAUO4BhhExSukqCicfVY9rsEtYFEd3InPwj7Anucokr2dabprC2V
        7U6fAIIMn4muiQLMQKdRAIJ9j/1m5eVyQqjF3fLKkg==
X-Google-Smtp-Source: APXvYqy38RzGaS6GmKEWk8AVCslWmyO1VRMUjt3IiqPFlac6gvhzxAIrS42qy+DE9houQ7j4yhnpSI2lrBv5oKHke9g=
X-Received: by 2002:aca:f581:: with SMTP id t123mr198768oih.0.1552933827507;
 Mon, 18 Mar 2019 11:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org> <20190318170404.GA6786@redhat.com>
In-Reply-To: <20190318170404.GA6786@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 11:30:15 -0700
Message-ID: <CAPcyv4geu34vgZszALiDxJWR8itK+A3qSmpR+_jOq29whGngNg@mail.gmail.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:04 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Mar 13, 2019 at 09:10:04AM -0700, Andrew Morton wrote:
> > On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > > Andrew you will not be pushing this patchset in 5.1 ?
> >
> > I'd like to.  It sounds like we're converging on a plan.
> >
> > It would be good to hear more from the driver developers who will be
> > consuming these new features - links to patchsets, review feedback,
> > etc.  Which individuals should we be asking?  Felix, Christian and
> > Jason, perhaps?
> >
>
> So i am guessing you will not send this to Linus ? Should i repost ?
> This patchset has 2 sides, first side is just reworking the HMM API
> to make something better in respect to process lifetime. AMD folks
> did find that helpful [1]. This rework is also necessary to ease up
> the convertion of ODP to HMM [2] and Jason already said that he is
> interested in seing that happening [3]. By missing 5.1 it means now
> that i can not push ODP to HMM in 5.2 and it will be postpone to 5.3
> which is also postoning other work ...
>
> The second side is it adds 2 new helper dma map and dma unmap both
> are gonna be use by ODP and latter by nouveau (after some other
> nouveau changes are done). This new functions just do dma_map ie:
>     hmm_dma_map() {
>         existing_hmm_api()
>         for_each_page() {
>             dma_map_page()
>         }
>     }
>
> Do you want to see anymore justification than that ?

Yes, why does hmm needs its own dma mapping apis? It seems to
perpetuate the perception that hmm is something bolted onto the side
of the core-mm rather than a native capability.
