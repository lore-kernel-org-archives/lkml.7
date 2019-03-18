Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B444DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8672A2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JpXTIgcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfCRThI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:37:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40851 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:37:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id k11so14056628oic.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R0CxR5bVCegbln6z7376+bO3M7CvxMN5kr55cG4eMTQ=;
        b=JpXTIgcAvV8LCsUvBBsftaCQmXvSVhY6EuRPkcwx70+Cx9YgQLS6i5F3fQHPMVpbEG
         w3iuA2JhsE4Vp7tLmG7w7L4DyeI6JbLFS6IBzLCTiDK43Yyas2wF+kQMdA6PRwybJKG6
         9SWodxq/sXld8k9Lf691R0peGnls10J1R6gf9k222HW3FLAJ6g0T73CUtFaXwBFR+vCb
         nYI/svNps8B4NQj1ze53YErOFVpFmkcp4xQS/CE3iWz9iOGgRzkS1C7qmDs4G+hco/sb
         7X0GS3gazoLLB4fu9Ui8xvaF6Ydhbvfd9uzDVq2VLVFTBPA7H5t1mrCFZohtFvw+3B51
         SZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R0CxR5bVCegbln6z7376+bO3M7CvxMN5kr55cG4eMTQ=;
        b=QKjvNGfmMGBbRzsehj/v/Fho9jAZYN3G9z8cgA0+jVDCIiBe9D3BNDm5hLkduBWc+B
         3rPejTbeeoxU5EZk2wD35DsLcqpA+WiYZcLH+7a4Ly3H/djLAW5RGdFKfV4/Ag1GHOBK
         ZyTrSDlQ86LS9SFwKg/ho10n3af1/0clHpS7/5TNXhNV7WGTqvd7Yp5ZgFxH9ZskWk2/
         gNAZQ4liQu5KALoEOxea9DCTcVEGhmnzFbSUBTLVObionj2L2bNJ/hZKaFxldSmbiIeA
         AauTM9nDQlo+ZkkpY2HmCeYL2HoMH8jyPS9LOT7CRgL6kBRuzRjEsV536mcY1x7Om5EV
         Xe7Q==
X-Gm-Message-State: APjAAAXUMm5BcrMB6ZV96fhhwqWL9NI7uinoSeiyNQuM12VL7cx94DSO
        AWMBXfXhZEA4GMD99X/+QmkguzLj1zmTs9Cr0F8mae5+
X-Google-Smtp-Source: APXvYqzqlvRNoPBAp8dvQXRPlsaqLot8U8X7UtNFbKuyWp/Q0PRYCRj8UZK17phWdiYuXR5fTuDf1cWkaimd+/HIiuk=
X-Received: by 2002:aca:aa57:: with SMTP id t84mr345663oie.149.1552937827180;
 Mon, 18 Mar 2019 12:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com> <CAPcyv4geu34vgZszALiDxJWR8itK+A3qSmpR+_jOq29whGngNg@mail.gmail.com>
 <20190318185437.GB6786@redhat.com> <CAPcyv4gLyKkboZ-ucHubiHgdpF4i9w+XKhPujjJ=dwU9Vox=Bg@mail.gmail.com>
 <20190318192858.GC6786@redhat.com>
In-Reply-To: <20190318192858.GC6786@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 12:36:56 -0700
Message-ID: <CAPcyv4gotYtvo7hupYCxYsYCmNHaf8yoYgfi53N3AhuvMmT1zA@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 12:29 PM Jerome Glisse <jglisse@redhat.com> wrote:
[..]
> > I went looking for the hmm_dma_map() patches on the list but could not
> > find them, so I was reacting to the "This new functions just do
> > dma_map", and wondered if that was the full extent of the
> > justification.
>
> They are here [1] patch 7 in this patch serie

Ah, I was missing the _range in my search. I'll take my comments over
to that patch. Thanks.

> [1] https://lkml.org/lkml/2019/1/29/1016
