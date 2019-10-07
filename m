Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD23ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F8D20867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcE47NBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfJGVSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:18:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:18:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id b128so9481343pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VbBm6b8WwaHoBx4mFTOrc4Z9KlFyur8to2u/o2RBPeM=;
        b=GcE47NBP9I7BB7+gClNGLixzNmqWME4k2afteOmwTWznkSGQO0GqiehqhqFiY9Lknu
         Fccp1WxLaC3E80fCPCGvJND9UcK5g1e2tpRI9QJP/7Yd1LYLY7oG9z8Ba1cvpG7n/KOt
         YW3tXHPrjGMKfd8zxSeEjhm0lnorpoxKR59GDpZ5NDud5QAmVdEHC85kNT9mMclerUot
         fywbpJmQa6SkU3EdQn1jSApp8aEZDBq44EyBAEDDGF3yaFz4+zU1fC9+1vsLeyOpD0h1
         LeXcZKHOOx+sPJT+DfVBlYm/4o4v8aPJ0i61cm9ggUCK90qRFDRdstiEbrwfz9cEGZlI
         Opmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VbBm6b8WwaHoBx4mFTOrc4Z9KlFyur8to2u/o2RBPeM=;
        b=svRS9Vpfn2fEeSNoDxD/GKXhEWXyk6xak+GLAaAHmD9vPKVkdjPJ4cVvhcuRZ0J/Zv
         kR6T20LKo66vDekrAJ/OuTe+NJTiisJHRaPv2hJhVCqOj2HyosrqgoGiIfh4XbQinQYy
         YLfi/shCuSOuSnmMDIaTfa7x6rvffQQu1pkIvtdlssX0LU32hdLy4W7uDZvs9ukx03B9
         nJTkRGt4fJA4KWgaBvHNa/OlU39GYlXs0w8i8lwkGrgT9d5lnHLvHh5KgbUmOUQ4XNqQ
         AOtIWwwLiTmDqimjzZ7hrwHM88+MUkcfsCLleYdDyE5OGSxierqecZ+ugPZzveXe+M88
         /uKw==
X-Gm-Message-State: APjAAAWFdFvKJmKZWstbutglEwNJ+DXeYsI4h28P6cnPa6h8Bh7jdaN8
        fHkjB+sBWMqxlRKVWBqDPS3eJspMdxs=
X-Google-Smtp-Source: APXvYqzWtRA48S5+8dtm1saMMpkG0nG8yJMzSy8QmRFTTFL8Wy3mDXxu4fLDVKrbBhQKSLhFDwcxJA==
X-Received: by 2002:aa7:90c7:: with SMTP id k7mr375558pfk.39.1570483113892;
        Mon, 07 Oct 2019 14:18:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id t3sm353100pje.7.2019.10.07.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 14:18:33 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
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
        Hillf Danton <hdanton@sina.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v10 0/5] DMA-BUF Heaps (destaging ION)
Date:   Mon,  7 Oct 2019 21:18:25 +0000
Message-Id: <20191007211830.42838-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is yet another pass at the dma-buf heaps patchset Andrew
and I have been working on which tries to destage a fair chunk
of ION functionality.

The patchset implements per-heap devices which can be opened
directly and then an ioctl is used to allocate a dmabuf from the
heap.

The interface is similar, but much simpler then IONs, only
providing an ALLOC ioctl.

Also, I've provided relatively simple system and cma heaps.

I've booted and tested these patches with AOSP on the HiKey960
using the kernel tree here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap

And the userspace changes here:
  https://android-review.googlesource.com/c/device/linaro/hikey/+/909436

Compared to ION, this patchset is missing the system-contig,
carveout and chunk heaps, as I don't have a device that uses
those, so I'm unable to do much useful validation there.
Additionally we have no upstream users of chunk or carveout,
and the system-contig has been deprecated in the common/andoid-*
kernels, so this should be ok.

I've also removed the stats accounting, since any such accounting
should be implemented by dma-buf core or the heaps themselves.

New in v10:
* Fixed missing vmalloc.h include that was causing trouble on
  mips and sh (Reported-by: kbuild test robot <lkp@intel.com>)

thanks
-john

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc: Sudipto Paul <Sudipto.Paul@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: dri-devel@lists.freedesktop.org

Andrew F. Davis (1):
  dma-buf: Add dma-buf heaps framework

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heaps
  kselftests: Add dma-heap test

 MAINTAINERS                                   |  18 ++
 drivers/dma-buf/Kconfig                       |  11 +
 drivers/dma-buf/Makefile                      |   2 +
 drivers/dma-buf/dma-heap.c                    | 250 ++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 169 +++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 267 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++++
 14 files changed, 1273 insertions(+)
 create mode 100644 drivers/dma-buf/dma-heap.c
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
 create mode 100644 drivers/dma-buf/heaps/system_heap.c
 create mode 100644 include/linux/dma-heap.h
 create mode 100644 include/uapi/linux/dma-heap.h
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

-- 
2.17.1

