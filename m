Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FFCC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A7E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7Kqtsfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfI3NkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:40:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34492 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731062AbfI3NkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569850809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MA63hBmJsYzQss5DMknC+P7/1009LduBC7f7Jopycp4=;
        b=P7Kqtsfg+k+mp9Gjj91EQdh7cuObHG9nWUJ7EPYjvP9xD1fWhp2fsxBazwwzAcYeh0mIeA
        KP6dosf5Ka9jual+CAafLN/JEj6W7Xe02jn6o+tpm7lt2R502gG1gcAN8WuhZE/W+UZnT4
        H/CRSqYku85xa58oUZjYtZTyTKZK4V4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-HAXdRCSuPbGeRaAjVhzoBQ-1; Mon, 30 Sep 2019 09:40:07 -0400
Received: by mail-qt1-f200.google.com with SMTP id i10so13876663qtq.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9rR8tz1aiQ04YMjGa9rh3iMKIseE9DL6jnPV9zEToow=;
        b=rrUhuee9Glw0coRlbnsN6Hy3C3opjQMBkbtVha49rLPbGhrAXWqvfpzgvgISSK5Qid
         CeKW8v4h50h14AnJ6FWuFlQP6XzEqoZBudMu78NsJgZZTP+TGzsxRSTksE0usAa3C1dh
         Z0bkwPlmMIjyhGQiNx9jzNCOf4X+P9ZPHo1iZqQo0wOO43tL4CI+fHAX7IPDnUF393Co
         f6ORFcUPz3VDsDEJJtgbE8fr0oSgY/LZlVBKv55RsqxwjUCFAhVySJiMUSU45GaMke5Y
         JIgvhL6xejIVyo+t1wZ370dpZcrEEmcnALQOAUkmWhENfR7m2CvpJkFMdmG3aYcyBEdb
         bdnQ==
X-Gm-Message-State: APjAAAWhZ8z2TI3ZVKTsH42uZm84F5k2VMMy6ByFQIPHsyWxsI+/gHyi
        W4VAlRDb2bj+z9dUCKJL7zmMGwcxf4KInuQ2XZhjTvbbVk6OmPbC9Q7ToITNzraBkEVMwDabOM9
        K4AABoABdNBvR3Et0u5EnVsLc
X-Received: by 2002:aed:3168:: with SMTP id 95mr25049142qtg.262.1569850805493;
        Mon, 30 Sep 2019 06:40:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWTUfTCpm3XDLDndTdu5XFiG42Cb/X1AKodPj29qVz+Sx6vY4nBPTUxX8Y2gnZpbVsV3ZqPg==
X-Received: by 2002:aed:3168:: with SMTP id 95mr25049095qtg.262.1569850805134;
        Mon, 30 Sep 2019 06:40:05 -0700 (PDT)
Received: from ?IPv6:2601:342:8200:6edc::b073? ([2601:342:8200:6edc::b073])
        by smtp.gmail.com with ESMTPSA id f10sm6611230qtj.3.2019.09.30.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 06:40:04 -0700 (PDT)
Subject: Re: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
        dri-devel@lists.freedesktop.org
References: <20190906184712.91980-1-john.stultz@linaro.org>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <f8db6c29-ede2-e8ca-9433-139e01ae5982@redhat.com>
Date:   Mon, 30 Sep 2019 09:40:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190906184712.91980-1-john.stultz@linaro.org>
Content-Language: en-US
X-MC-Unique: HAXdRCSuPbGeRaAjVhzoBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/19 2:47 PM, John Stultz wrote:
> Here is yet another pass at the dma-buf heaps patchset Andrew
> and I have been working on which tries to destage a fair chunk
> of ION functionality.
>=20
> The patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
>=20
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl.
>=20
> Also, I've provided relatively simple system and cma heaps.
>=20
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>    https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=3Ddev=
/dma-buf-heap
>=20
> And the userspace changes here:
>    https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>=20
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
>=20
> I've also removed the stats accounting, since any such accounting
> should be implemented by dma-buf core or the heaps themselves.
>=20
> Most of the changes in this revision are adddressing the more
> concrete feedback from Christoph (many thanks!). Though I'm not
> sure if some of the less specific feedback was completely resolved
> in discussion last time around. Please let me know!
>=20
> New in v8:
> * Make struct dma_heap_ops consts (Suggested by Christoph)
> * Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
>    (suggested by Christoph)
> * Condense dma_heap_buffer and heap_helper_buffer (suggested by
>    Christoph)
> * Get rid of needless struct system_heap (suggested by Christoph)
> * Fix indentation by using shorter argument names (suggested by
>    Christoph)
> * Remove unused private_flags value
> * Add forgotten include file to fix build issue on x86
> * Checkpatch whitespace fixups
>=20
> Thoughts and feedback would be greatly appreciated!
>=20
> thanks
> -john
>=20
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
>=20
>=20
> Andrew F. Davis (1):
>    dma-buf: Add dma-buf heaps framework
>=20
> John Stultz (4):
>    dma-buf: heaps: Add heap helpers
>    dma-buf: heaps: Add system heap to dmabuf heaps
>    dma-buf: heaps: Add CMA heap to dmabuf heaps
>    kselftests: Add dma-heap test
>=20
>   MAINTAINERS                                   |  18 ++
>   drivers/dma-buf/Kconfig                       |  11 +
>   drivers/dma-buf/Makefile                      |   2 +
>   drivers/dma-buf/dma-heap.c                    | 250 ++++++++++++++++
>   drivers/dma-buf/heaps/Kconfig                 |  14 +
>   drivers/dma-buf/heaps/Makefile                |   4 +
>   drivers/dma-buf/heaps/cma_heap.c              | 164 +++++++++++
>   drivers/dma-buf/heaps/heap-helpers.c          | 269 ++++++++++++++++++
>   drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
>   drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
>   include/linux/dma-heap.h                      |  59 ++++
>   include/uapi/linux/dma-heap.h                 |  55 ++++
>   tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
>   .../selftests/dmabuf-heaps/dmabuf-heap.c      | 230 +++++++++++++++
>   14 files changed, 1262 insertions(+)
>   create mode 100644 drivers/dma-buf/dma-heap.c
>   create mode 100644 drivers/dma-buf/heaps/Kconfig
>   create mode 100644 drivers/dma-buf/heaps/Makefile
>   create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>   create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>   create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>   create mode 100644 drivers/dma-buf/heaps/system_heap.c
>   create mode 100644 include/linux/dma-heap.h
>   create mode 100644 include/uapi/linux/dma-heap.h
>   create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>   create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>=20

I've seen a couple of details that need to be fixed and can be
fixed fairly easily but as far as the overall design goes it looks
good. Once those are fixed up, you can add

Acked-by: Laura Abbott <labbott@redhat.com>

