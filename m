Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7331ECA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAEC2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 05:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c83H9Xm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393966AbfJYF45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 01:56:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39975 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393713AbfJYF45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:56:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id d8so1144192otc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zThSuPucnYB11UxQ84T8AiU13at0QlBZrNas229mVK4=;
        b=c83H9Xm7uwJMYI/yUjZRfhl0JIbApRXJSslgxBFnsu3+JNMmAMx7Vvqg79Mi6F5/T6
         YA1unfPBbMrOhFSPnFZD9anMpGXO7as8l8PS3IU6UuRSTKTtHQRTeIQ5cnevXgD2hoQR
         L0ZIv9KKe1hJr4+zMi9wkJlNvAqVxGIkipCP5TMv1G54C7Yvfa8pafyAv2nflkMDdISX
         B2QPxwy33Po1tlfhJM858lU65nHQxQ1WeBZuvXvDX0IWU/0EVCywYRpPVABbk3oam2AI
         lU8d5Q6W9avvustlUo+sDMgS/yqJ5T/Yq21JKWYu7JnDhMg35Fd522DIvy6agg0OXOi6
         IImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zThSuPucnYB11UxQ84T8AiU13at0QlBZrNas229mVK4=;
        b=tKYUYinp55f2TPTcyVl2mEQZUZCb2Q3TtVmlY8Jp1S6zpXmIwYcCRQ4G+B7nHayDg8
         8hRzKwMYFhXpq9KzZMByX7q0sxRfBkfwZHiXPAhtj3uOIbDisXe/JRPX8bjUWbuJ4wJP
         VicAAD7lVTa56rXTm/dej3sIcEAobXLtZbsmxLt+ofrUgmZZVJdtrxKLOPm25P9U69wi
         3pfOjhJiTPmiHXGbC9Ij3wuD9PXnv1bWHLe7pMJ1Qov4IzeSGxGWeZZNJuRf/aRGerb3
         mCuKHiDO3xOnqpr+FVWY2NBhza+QVjhh0p6oeq769MuHvZRk9lYpmjiDOegrBVjYtlp8
         NjLA==
X-Gm-Message-State: APjAAAV/hqVA5IyoaN4LopM3A5nECi/2fa62g1pWmtVVEAfEd4DbqlAY
        xA3Q6mEvM20hO8H0zP9Rq/8/w7cdTNKvU9smkgDLRA==
X-Google-Smtp-Source: APXvYqw/DUlrRogzHWRrsD06nz/kflR9lP8eB8Uz45TB1T3cs5AdM0YleXz3T7NJw93Ak+GBflKz0IBcBroUy3HWdSA=
X-Received: by 2002:a9d:2241:: with SMTP id o59mr1342045ota.224.1571983016328;
 Thu, 24 Oct 2019 22:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191021190310.85221-1-john.stultz@linaro.org>
In-Reply-To: <20191021190310.85221-1-john.stultz@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Fri, 25 Oct 2019 11:26:44 +0530
Message-ID: <CAO_48GHk8b=7Rs2CYZvnki2EMpeo_4FRy+_3F0Mv_nAK42MpgQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Tue, 22 Oct 2019 at 00:33, John Stultz <john.stultz@linaro.org> wrote:
>
> Lucky number 13! :)
>
> Last week in v12 I had re-added some symbol exports to support
> later patches I have pending to enable loading heaps from
> modules. He reminded me that back around v3 (its been awhile!) I
> had removed those exports due to concerns about the fact that we
> don't support module removal.
>
> So I'm respinning the patches, removing the exports again. I'll
> submit a patch to re-add them in a later series enabling moduels
> which can be reviewed indepently.

This looks good to me, and hasn't seen any more comments, so I am
going to merge it via drm-misc-next today.
>
> With that done, lets get on to the boilerplate!
>
> The patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
>
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
>
> Also, I've provided relatively simple system and cma heaps.
>
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap
>
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
>
> I've also removed the stats accounting, since any such
> accounting should be implemented by dma-buf core or the heaps
> themselves.
>
> New in v13:
> * Re-remove symbol exports, per discussion with Brian. I'll
>   resubmit these separately in a later patch so they can be
>   independently reviewed
>
> thanks
> -john

<snip>

Best,
Sumit.
