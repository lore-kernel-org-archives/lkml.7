Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F50ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4CE2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6LeMHRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfKDSo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:44:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39138 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDSo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:44:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so15057626oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIHHPzEIZlxZwO4uYb9AqkuWkKRYCxaoO1dAlVnypSo=;
        b=y6LeMHRh2X/z21iqd/OGrTPukcGzBWE5r4FxdYdWoVA8CFVwZOIxhdvmEZSURcMzmx
         uc+M4VSP8ZS0sELWbzJA6eNK4donfuHDPCvgAA78pstFLaYRmvvjyzGW9J2MW5IThNXo
         bxjVViJM2JQT5/fW8dITPwhn3i0NmulLhCQM6/gIO52gi+35pkZZHIlYUwJTDkgxV7a7
         1YImDoOZXyRtPbgD0w5dTr9rdG4O3zVVfXBy5mzD0fmN28prQtOHIqx3tjus+0INvDao
         Lr020YlGcq7+M8B5ABg1Ob3hmMVVbItFKeFMhA/R6RaXqaucReeme2bYh34FtPUgiDE/
         WI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIHHPzEIZlxZwO4uYb9AqkuWkKRYCxaoO1dAlVnypSo=;
        b=tP1tMsKuMwSdYfeAy//UjUlYPYjZSgw0YdIVPta3bGG1xU3NqwK4/O9EQYoZR5mUj2
         it7Xdz5Kaokg/G6lv58P9+HBmCk+Q3NF1dJSSZR673GQ+q8b8isLFKtc/aGQ6M9rSA7y
         xsg4w1DtRRChb3BUmdlkQGL+3BLF718IHEtBzcjrBH2yPETfSrUJVgoe/s10B2YxOTsE
         gmfOt3NRb1XBlvhtxYL0703/67fqx9JUsFf8TNrnOgUAd49vitlIWOJOtPNXs2Cg5QE7
         AIKF5YITiKwzrQEt3gIfcesmdhwq3j30hQ5KjASWW3keoZaH3HQ6M1SAR+8p/Aj9QOk6
         eOZA==
X-Gm-Message-State: APjAAAUTyBzTZP3Wcb/ZebOWGrqerFOrjXuDnT6C+cQuKj4BrLz5D49h
        A6IjCghgUaZ8PQ+Mosa68Sh/ksBdXFUWA+OBMnEI8A==
X-Google-Smtp-Source: APXvYqwudkIT7BfyYubS2+BnLFVqC9kiJ2G6htJbTxypq0RyTqfsZr+adntbCigCob0HtC2BcOgG9Tp04w3kdvzLYpI=
X-Received: by 2002:aca:c64c:: with SMTP id w73mr398080oif.161.1572893066616;
 Mon, 04 Nov 2019 10:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org> <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191104102410.66wlyoln5ahlgkem@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 10:44:15 -0800
Message-ID: <CALAqxLV7sB+gN1FNhhaiE9FXmaFv1TNsmKxD1Xctab6fTERA4w@mail.gmail.com>
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
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
        Dave Airlie <airlied@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 2:24 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> On Fri, Nov 01, 2019 at 09:42:34PM +0000, John Stultz wrote:
> > From: "Andrew F. Davis" <afd@ti.com>
> >
> > Additionally should the interface grow in the future, we have a
> > DMA_HEAP_IOC_GET_FEATURES ioctl which can return future feature
> > flags.
>
> The userspace patch doesn't use this - and there's no indication of
> what it's intended to allow in the future. I missed the discussion
> about it, do you have a link?

Yea. Sorry, It was feedback I got via IRC. If your curious the irc log
can be found here:
  https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2019-10-30&show_html=true

> The new zeroing stuff all looks good to me - so wrt. that you can add
> back my r-b; would still like to get some clarification on the
> get_features, though.

From Daniel's feedback it sounds like I'll drop the empty get_features
ioctl then.

> Couple of typos below.

Apologies for my bad spelling! Thanks for the continued attention and review!
-john
