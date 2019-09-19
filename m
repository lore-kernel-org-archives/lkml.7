Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B01E21929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLzZY8uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391844AbfISQwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:52:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40710 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfISQwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:52:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so3701983ota.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s+MeooT8MC1ceHz/F61nLHOvnsbLpM4gTCQiQySmE2s=;
        b=gLzZY8uF/boSl4oCwqXWngNHkJYjnx2DZj3yk0PMVbpEQv2Szs/+z23ktTW1L94B0r
         y7P9Y90beRh+HnCCKbL3kEKL8La7/Swkv9sT64oKmZSqgnrZVQayv3FZixuHhYdrGnHK
         iMLP3X4SlWR/tX8CI26TZLErcz2rR3uYmvb6anWxBKe7kSLfgAw3T6yRMTlHSfdpyXXg
         nHwwb8Aiuhm+1lDpoQGGKeIIqr6hRMgOGNo/l6w21Qp5o6HlKxmi8WOAjmKsE26kdTfW
         0lZ/RyuoYim+VJQLm82IZdJ3edFiMfKXrkKrze+BlQsswKLZmqGtA0RsUoCTHY5WGDks
         OhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s+MeooT8MC1ceHz/F61nLHOvnsbLpM4gTCQiQySmE2s=;
        b=jfSSTCkohKVmPuIFhYEoMWpDO5YmwIMt+06klH3orh313M89y3wd6OY7koFKJ1kCWK
         c2A5P+PCX9OXkgHjCG9rHgJkkZ7Rj9g0tlu865TY5BDmX3JeLkfKNI4R/Vn3M4V/izY5
         G8nJM24yBU8szSDWGAJpc+2kD7qZIGxXW8ccge/k3xuIpw1S2UZ2ey4wdieTq/2WJlQk
         /EbvbA3dsPRR1CWcoWK9rSQUsRRl5ByDaAm0JZsURL3Q3yK0d30aoB5sR/4J//blGDCN
         7tDV1O/dYxV1jehXA9wum6OQkPwgDV/WNNrM0gvlGl5xkSkeNpP2B+DCBk/QTrbBQ8ZU
         gWfg==
X-Gm-Message-State: APjAAAXN4HnrAwkfURP9u1+t+iaYx/p5nfOVo0b3M/2OhZgxosU2lWA2
        vVmz1sMbZhj/F0YkfKloJGjMxugTnwLWV3hdKMVWzQ==
X-Google-Smtp-Source: APXvYqxWNNLwTF6d9EkBEFxDnbTHq4BFS1Wxnvctc73jt6RsO5DmUbNtJ6DJsEqAyMBdF94LXniU63aV8IlOkzyl0n4=
X-Received: by 2002:a05:6830:1e72:: with SMTP id m18mr1337213otr.371.1568911924352;
 Thu, 19 Sep 2019 09:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190906184712.91980-1-john.stultz@linaro.org>
In-Reply-To: <20190906184712.91980-1-john.stultz@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 19 Sep 2019 22:21:52 +0530
Message-ID: <CAO_48GFHx4uK6cWwJ4oGdJ8HNZNZYDzdD=yR3VK0EXQ86ya9-g@mail.gmail.com>
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
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
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph, everyone,

On Sat, 7 Sep 2019 at 00:17, John Stultz <john.stultz@linaro.org> wrote:
>
> Here is yet another pass at the dma-buf heaps patchset Andrew
> and I have been working on which tries to destage a fair chunk
> of ION functionality.
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
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=3Ddev/=
dma-buf-heap
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
> I've also removed the stats accounting, since any such accounting
> should be implemented by dma-buf core or the heaps themselves.
>
> Most of the changes in this revision are adddressing the more
> concrete feedback from Christoph (many thanks!). Though I'm not
> sure if some of the less specific feedback was completely resolved
> in discussion last time around. Please let me know!

It looks like most of the feedback has been taken care of. If there's
no more objection to this series, I'd like to merge it in soon.

If there are any more review comments, may I request you to please provide =
them?

>
> New in v8:
> * Make struct dma_heap_ops consts (Suggested by Christoph)
> * Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
>   (suggested by Christoph)
> * Condense dma_heap_buffer and heap_helper_buffer (suggested by
>   Christoph)
> * Get rid of needless struct system_heap (suggested by Christoph)
> * Fix indentation by using shorter argument names (suggested by
>   Christoph)
> * Remove unused private_flags value
> * Add forgotten include file to fix build issue on x86
> * Checkpatch whitespace fixups
>
> Thoughts and feedback would be greatly appreciated!
>
> thanks
> -john
Best,
Sumit.
>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: dri-devel@lists.freedesktop.org
>
>
> Andrew F. Davis (1):
>   dma-buf: Add dma-buf heaps framework
>
> John Stultz (4):
>   dma-buf: heaps: Add heap helpers
>   dma-buf: heaps: Add system heap to dmabuf heaps
>   dma-buf: heaps: Add CMA heap to dmabuf heaps
>   kselftests: Add dma-heap test
>
>  MAINTAINERS                                   |  18 ++
>  drivers/dma-buf/Kconfig                       |  11 +
>  drivers/dma-buf/Makefile                      |   2 +
>  drivers/dma-buf/dma-heap.c                    | 250 ++++++++++++++++
>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>  drivers/dma-buf/heaps/Makefile                |   4 +
>  drivers/dma-buf/heaps/cma_heap.c              | 164 +++++++++++
>  drivers/dma-buf/heaps/heap-helpers.c          | 269 ++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
>  drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
>  include/linux/dma-heap.h                      |  59 ++++
>  include/uapi/linux/dma-heap.h                 |  55 ++++
>  tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 230 +++++++++++++++
>  14 files changed, 1262 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>
> --
> 2.17.1
>


--=20
Thanks and regards,

Sumit Semwal
Linaro Consumer Group - Kernel Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
