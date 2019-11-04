Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AD3CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AA82080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxVs+IVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfKDQ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:58:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfKDQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:58:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id y23so7532018ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGFVtZgIuY0pmc+VyfR5bHjFuWMXBLC+PFqq5aHuIEo=;
        b=MxVs+IVXrO3laQhAsQiIIR5WTvzPZ/rDSAwIl8d3hD2isSoElvZb1eeIAUvCWShIGj
         AL4ZMlA0W548j6VmQp2kjBSfhpSGjPyht0wnnlh12bsw9+yQuPVnVJu2RUMBwMhMVy5g
         hf3tnhDhBsDGNej/dktnaLY/GEIKkwZDDnSwbI07qNU8QmHXmzL0m9QWkz5rihTll3OO
         dWrkOIV4xzOE4za+k3VjKwpvasbbbT2u9vjClU1SCfeqC6mEFeaOSPTEGV+OY7x81Kmm
         GQax7S04EG6zifGn7gE9BzmG99WYZsN0ZGnuxGgM8WhpeBE1fPVStd0rgl+YM8Y7CZGE
         vjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGFVtZgIuY0pmc+VyfR5bHjFuWMXBLC+PFqq5aHuIEo=;
        b=HJiF8Z1aBTzEEtM2Uil/g/jGXhaU5S7HbwHP+UYLU9/TNx8kLwR81xo9C8UhtthFXc
         BmIIfb249YvcRExKdim7qDyOeQ6bsbEs9ku6FQ4gNpSVPf3QgAMrdQCt8FmsNL2VSwyR
         4gklBeLBfsgtSyPanAJyWKj5fDdgHNX0SRs9DRpA6PPAKsxcLUUka/Y2gxQmlwNhfiKi
         ELPm1qj82KCl44ltkBhfib2Ash3E0nWN4H/FTK8+ikdM33aokle/DOY0TA3JWZJmncoL
         lOhew5JJ0XKaxCgMQfEaN4Ph5J+X7vBV8x5XPRSF7DWnCWcNDtxLdqTlQofFGlOU0f0D
         442Q==
X-Gm-Message-State: APjAAAVlnCkAvwV42qhDRnIMXsaDXzMyrHJmley5K07FoigWGGnKelKT
        q5pBH4vq2npuSA52o3DiOSqlatMrL+mYBOuEkxw=
X-Google-Smtp-Source: APXvYqyBWwpRhXathfjT9hiPrrapwsHBwEDmHstXjiCXSgsgfip5FT8iGRYWufzdrTu4WxJtt0TXzz7d5co/N0t+/2w=
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr10417952ljc.130.1572886709180;
 Mon, 04 Nov 2019 08:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org> <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 5 Nov 2019 02:58:17 +1000
Message-ID: <CAPM=9tydXxV-6++HkkA+JX9GPWE1sN_8CGVCVn-Mwfgfzcn=hg@mail.gmail.com>
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2019 at 20:24, Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi John,
>
> On Fri, Nov 01, 2019 at 09:42:34PM +0000, John Stultz wrote:
> > From: "Andrew F. Davis" <afd@ti.com>
> >
> > This framework allows a unified userspace interface for dma-buf
> > exporters, allowing userland to allocate specific types of memory
> > for use in dma-buf sharing.
> >
> > Each heap is given its own device node, which a user can allocate
> > a dma-buf fd from using the DMA_HEAP_IOC_ALLOC.
> >
> > Additionally should the interface grow in the future, we have a
> > DMA_HEAP_IOC_GET_FEATURES ioctl which can return future feature
> > flags.
>
> The userspace patch doesn't use this - and there's no indication of
> what it's intended to allow in the future. I missed the discussion
> about it, do you have a link?
>
> I thought the preferred approach was to add the new ioctl only when we
> need it, and new userspace on old kernels will get "ENOSYS" to know
> that the kernel doesn't support it.

This works once, expand the interface 3 or 4 times with no features
ioctl, and you start being hostile to userspace, which feature does
ENOSYS mean isn't supported etc.

Next userspace starts to rely on kernel version, but then someone
backports a feature, down the rabbit hole we go.

Be nice to userspace give them a features ioctl they can use to figure
out in advance which of the 4 uapis the kernel supports.

Dave.
