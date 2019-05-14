Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56847C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1911D20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFhGTh1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfENIuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:50:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41036 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:50:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id y22so14603922qtn.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vIaBEmouK0Dv5evBsOjDzjbMpOHy/p2WnePkbeo1Mc=;
        b=WFhGTh1Y4S1ju6lWu9MI4XMGSOMatltxrIA8pCJeGTceHDjhs6aBEBkWDrW+57C3Tt
         upNyvNiwFOskYrXXhZS2uAo+WPGR9JmiIX8okelcNO3uWULdQUugHNwrqOGF8Lp2mF3f
         MVVz8jooeeEv02QrzRZJNkx2fen8JIxLNiKFMok1N+Fp44KeewV9jWCkF6gzjIEyepKn
         1E5bfXCiJrfjGklIPIdeTEz9fJnJ93VHP3ymuy6cPuugt6z5vx3VFdvFwGb8qBqi0wX3
         my7ALjeKsSVJVbY/9gwpY4BwuZeEit6qXRv5mqsZtkp2QUzX2zv2lDUq0PjjlNe75Fru
         ruEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vIaBEmouK0Dv5evBsOjDzjbMpOHy/p2WnePkbeo1Mc=;
        b=KLzvz/XYViT9gXypenDD1FgVaff6e4SkMB8mGdfTfkSOrHXLn8YYRJp90LOMsUgf/w
         zGYtmRP/S0AMzte43cJU6ovcCAKd34cibB6ufL2oRL+wR1pbmGGQDKQoYtFvGPpZR7R3
         fCm2XolGn7J4Sgl+fX/LS+LQJTE60xYGSKzOi4FDfhMjwnqD7zOIjUNVL6Gi4cq/cfZW
         NvWBa4QFQwhl7UQVh/thhiwTHOjxEfFnRc/S54aObou4UdJ6pGGxSUjv/ISOwESzHjkb
         ZtK3WFljMmOuAMP5vayy+7tLgmL8e2yd7CPqM9pyeUnJQtWWgI5ppneUKjQ/t9QVuqVI
         fMvw==
X-Gm-Message-State: APjAAAWBbZfyevN6wfhbeJUJFcoa8rj6rLq0fpc23S3WgGdWF+vAO1YK
        huOZJQ9VpKYAeDf+uqn0IadzptnCTkrxKpobi7LsHQ==
X-Google-Smtp-Source: APXvYqxvMSCljX8FfiPMh8cHjmlwuPr7mVsPz3gRrPtZdM6wiiz+d/7LOxL99REnMQQ5G7ITq1TGFB2Hu34abh/W9cw=
X-Received: by 2002:a0c:b50d:: with SMTP id d13mr26556703qve.222.1557823799015;
 Tue, 14 May 2019 01:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190513183727.15755-1-john.stultz@linaro.org>
In-Reply-To: <20190513183727.15755-1-john.stultz@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 14 May 2019 10:49:48 +0200
Message-ID: <CA+M3ks7DZOab2Tdfnhwvzy_1YgSmspWvm-A2nOgDHwrx_T_J0g@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5 v4] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 13 mai 2019 =C3=A0 20:37, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
>
> Here is another RFC of the dma-buf heaps patchset Andrew and I
> have been working on which tries to destage a fair chunk of ION
> functionality.
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
> I've also removed the stats accounting for now, since any such
> accounting  should be implemented by dma-buf core or the heaps
> themselves.
>
>
> New in v4:
> * Add fd_flags per Benjamin's request to specify the creation
>   flags for the dmabuf fd.
> * Added some optimization in the system heap to allocate
>   contiguous pages where possible.
> * Reworked the kselftest code to use vgem rather then
>   introducing a dummy importer
> * Other cleanups suggested by Benjamin and Andrew.
>
>
> Outstanding concerns:
> * Need to better understand various secure heap implementations.
>   Some concern that heap private flags will be needed, but its
>   also possible that dma-buf heaps can't solve everyone's needs,
>   in which case, a vendor's secure buffer driver can implement
>   their own dma-buf exporter.
> * Making sure the performance issues from potentially
>   unnecessary cache-management operations can be resolved
>   properly for system and cma heaps(outstanding issue from ION).
>
>
> That said, the main user-interface is shaping up and I wanted
> to get some input on the device model (particularly from GreKH)
> and any other API/ABI specific input.
>

For the whole series:
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Thanks,
Benjamin

> thanks
> -john
>
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
> Cc: Xu YiPing <xuyiping@hisilicon.com>
> Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
> Cc: butao <butao@hisilicon.com>
> Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
> Cc: Yudongbin <yudongbin@hisilicon.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
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
>  drivers/dma-buf/Kconfig                       |  10 +
>  drivers/dma-buf/Makefile                      |   2 +
>  drivers/dma-buf/dma-heap.c                    | 241 ++++++++++++++++
>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>  drivers/dma-buf/heaps/Makefile                |   4 +
>  drivers/dma-buf/heaps/cma_heap.c              | 169 ++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.c          | 261 ++++++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
>  drivers/dma-buf/heaps/system_heap.c           | 162 +++++++++++
>  include/linux/dma-heap.h                      |  59 ++++
>  include/uapi/linux/dma-heap.h                 |  56 ++++
>  tools/testing/selftests/dmabuf-heaps/Makefile |  11 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 232 ++++++++++++++++
>  14 files changed, 1294 insertions(+)
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
