Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAE6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7E5218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcZQkLp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCOUIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:08:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40452 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCOUIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:08:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id t5so10865401wri.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qLtdzUN+oogw64VyyyhknYdUWM49blhNmdnvz9q5iw=;
        b=fcZQkLp6Vf72cBvsviN6ZR3p5TcOlBhnUzUmuAhGAYhU1xu74LAKyJmLyvG7JNMYO7
         aX+u5tWoAHYY8+JlQT3oF3MtC2IB3GkUCJaNH5cGPta4yshX+3NNbLMkqG+U7r0eFcpF
         RgU88QOvVgQYVcWw8xxED2cSQ8Srlvd/n8IWXrstr6rzcxnvXmCMCxiODoZYSI0FT+dR
         geCcEVtFpRJ6/hZqGJoemO2ZOeMEd4s+jhMMc2+8b295ZaE9hQjVds0B8kJAj0dYwhXg
         urtDyMi2z2/LEe9n1/Vmqa+v9mMSG926Po/NV0+97e9oNLIDdXHdpKQwW3lJL3yD2ZAQ
         gQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qLtdzUN+oogw64VyyyhknYdUWM49blhNmdnvz9q5iw=;
        b=H2N6bg51D6/0VEWrPWkeLXf08fbgiiJhymBNy68+eSPsZE4F5GRJsKlRrhvdmdwmK4
         oasEmfYi1wRn9zOzedha98i/v0ie/vDT5ICb3StBlHH3Hkp5sir1fPMnRVv56Qey9T2w
         8d+ZQYqGuhb6iMrmPfUVXBuRaNYKgXgkEdZGUNAFJIRqq/BH2tW1UFOEEL2/GSN61kgd
         g9cVJbKdbySrn4degFDlqSoTSMJ5FZJqQnzZtMW3V+zhkImRTkVOB/rbvIkt6WZSZCjx
         o/iUVA2e79fxR/v6Lb/NhtsAqTWT2mXd4wDbt7l0wiBCusU92VoAhqdEOr9ngOU0KYkk
         fZnQ==
X-Gm-Message-State: APjAAAXKMhwbGbEkpHodRVnbEEDo/uhung/B4w3R0VMyjzg9bpP2iJ6f
        En4nUB8H1zvV7DBxffauUHf+wpqDyHrY6K2LibPURw==
X-Google-Smtp-Source: APXvYqzSLu/bLYSg+kjOhvit2pqLLPhp1hBvmazSrYk8DTEcPaWLTFvvGyg9JJZL3S6qYG3+QCoYlaRTAe2MiDa/R/o=
X-Received: by 2002:adf:fa51:: with SMTP id y17mr3824176wrr.233.1552680532567;
 Fri, 15 Mar 2019 13:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-5-git-send-email-john.stultz@linaro.org> <20190315090652.GE4470@infradead.org>
In-Reply-To: <20190315090652.GE4470@infradead.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 15 Mar 2019 13:08:38 -0700
Message-ID: <CALAqxLVc475=eFSpJmYUE_82LWyR+bt1vWr-_0aGN=GPicPKVA@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5 v2] dma-buf: heaps: Add CMA heap to dmabuf heapss
To:     Christoph Hellwig <hch@infradead.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 2:06 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 05, 2019 at 12:54:32PM -0800, John Stultz wrote:
> > This adds a CMA heap, which allows userspace to allocate
> > a dma-buf of contiguous memory out of a CMA region.
>
> With my previous suggestion of DMA API usage you'd get CMA support for
> free in the system one instead of all this duplicate code..

Hey Christoph! Thanks for the review here! I'm still digesting your
comments, so apologies if I misunderstand.

On the point here, unless you're referring to some earlier suggestion
on a previous discussion (and not the system heap feedback), part of
the reason there are separate heaps is to allow Android to be able to
optimize where the allocations are coming from to best match the use
case. So they only want to allocate CMA backed dmabufs when the use
case has devices that require it, or they may even want to have
separate a CMA region reserved for a specific use case (like camera
buffers). Similarly for any future heap for allocating secure
dma-bufs.  So while in the implementation we can consolidate the code
more, but we'd still probably want to have separate heaps.

Does that make sense? Am I misinterpreting your feedback?

thanks
-john
