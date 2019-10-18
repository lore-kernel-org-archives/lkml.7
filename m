Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE53FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25AA21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRl4/YMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409944AbfJRMEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:04:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46587 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392487AbfJRMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:04:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so8618761qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zgv+qsT50asyCBxx8dHLrc/7R2zuXJqrAElFwEmz+6o=;
        b=PRl4/YMK8PN+sw8qz9vbBuWmnDNxUIbUV/4by7yJ/ZaetJCfkYyfwrAGp4L4IH6LoP
         X90KnC+d9bCIKe0fkrb8KwvqpCKLZfxHCWiRVC5+Avh65mJjwzKqn/c7tQy4nIFc43w6
         fEhxkzcQyeFDnYdq9lc6NIglUPHlGjhxzCtISkWH0lr1mN/d5ArBGgrWkrdHp3Fe8Lyd
         mX6Uxi4EFn19ZqRvFKdtnYLqjyXoc84MmMj+814gfoww9pORycIuZnYnOy5whHI3n0U7
         fWrPnn2VRYK4wEAYgggIvmmEHwL+yRBrdIpc5fY7eSH2tabBEWdHELFqZ+S8jDFESWhz
         xVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zgv+qsT50asyCBxx8dHLrc/7R2zuXJqrAElFwEmz+6o=;
        b=kbCTKpLYurM8Xyli6l/Hd63KPj8PfcbiW48TcZLK3T03wHt6FdVnrHKr0wnSsjYnbg
         lLEPmnR+3Q2Yo0KGDt3yH6knAkaUXSY4gzZ4pwtboyJaqobuAG6SBFTFAdgRP2vHwVWG
         oL6Vvku2TXL9jmbHWdjEGMG1W+XjwMK7y2cKWmwwE79HQjfpDlXWtwtK+9ojcarm5o3G
         +FupVNeQSLCx/eVmkvheY6EuzapjfOZBtfL1d+sur4OyS62qwz04SYfEJYxcvBFCoGPX
         yFcJqYX+C5zhPMiCku7S1vfpfj01R5Lm4Lw7xFH6cAoWjZjJC+tMWCLU9G1Mdo8p7myc
         +l+A==
X-Gm-Message-State: APjAAAXHOyN7cwgnfKYBUlXYSgGx4a1D5Oe22mOdjKKybvrIYNMdq8t7
        iH7+eIABxNrOxXiRpI5ABPIT5Wzm31MPikuqBvBuQw==
X-Google-Smtp-Source: APXvYqxN/PMVQWc4kwuCABb8SVWIpRbyl131FT7CZcvatX5vcKooHrltGmgsSQcxbFgna4xwbUWch+DuxQg3HoR+XIE=
X-Received: by 2002:ac8:110d:: with SMTP id c13mr9331476qtj.209.1571400244300;
 Fri, 18 Oct 2019 05:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-5-john.stultz@linaro.org> <20191018112124.grjgqrn3ckuc7n4v@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191018112124.grjgqrn3ckuc7n4v@DESKTOP-E1NTVVP.localdomain>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 18 Oct 2019 14:03:53 +0200
Message-ID: <CA+M3ks6KqqXCfqA6VDKnQOsvFLQfaGrUnA+eesnyzMRniFB00A@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] dma-buf: heaps: Add CMA heap to dmabuf heaps
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 18 oct. 2019 =C3=A0 13:21, Brian Starkey <Brian.Starkey@arm.com> a =
=C3=A9crit :
>
> On Fri, Oct 18, 2019 at 05:23:22AM +0000, John Stultz wrote:
> > This adds a CMA heap, which allows userspace to allocate
> > a dma-buf of contiguous memory out of a CMA region.
> >
> > This code is an evolution of the Android ION implementation, so
> > thanks to its original author and maintainters:
> >   Benjamin Gaignard, Laura Abbott, and others!
> >
> > NOTE: This patch only adds the default CMA heap. We will enable
> > selectively adding other CMA memory regions to the dmabuf heaps
> > interface with a later patch (which requires a dt binding)

Maybe we can use "no-map" DT property to trigger that. If set do not expose=
 the
cma heap.

Benjamin
>
> That'll teach me for reading my email in FIFO order.
>
> This approach makes sense to me.
>
> -Brian
>
