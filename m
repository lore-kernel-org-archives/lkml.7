Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE46FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58F21655
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPvGjT+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfHWXry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:47:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39085 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHWXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 19:47:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so6461602pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jm07RF4qOusTFQQs40dCbcyWy1wVMhan2978N/Kfrcc=;
        b=oPvGjT+wXZIm32bCnvYe7n+EdH+cZadBw4KcwlK7j7Uoun4/J395B863RX59hQb0GA
         Xzhumg44jkma63ncg85ZZx7OB1ppD2gqjq42nF1FchQAIGPBardEt9gBw4Lw7eLPH8/A
         lGcTS23lemjnWvjzZ3gPXvLs5hE4G7JlQYEeHHc8TMYa+MUOR2JBP5mTN/c6gJirBhwy
         FE2m+t8RE9w5O5iYgLTcLhcGUUMRw8B/GlVcPPltT/c/Un3Y3IwOmosN44t0UvFVUDub
         HLczlAOpNyU4DS0SJS7bp7WqCZxfuzTOmpVxvOL53wqZKjkOAf2OywhUuUY3o/GO9YBL
         BKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jm07RF4qOusTFQQs40dCbcyWy1wVMhan2978N/Kfrcc=;
        b=Md0umrWP5M5iNZGtI/+V6bl/Lx53/h9RoP3ZIoGjKswXIzw/e9aK4z8Agzn1W+VjR2
         T+td+LqmEKv8ePWvXQjf3Z6pY+lgIj2Z2IxFppfWqYs7EYgM53/YrAHv6Zu1esOMrTfY
         Qdkz+n28m5hdTSjP1d09RsMFOQSYsdEr0IFBo51CstRFlmXNdwUwfBkJRmAO53CdE/Re
         RVd1a73XgrGYGyRJindWI4GYw7FTLOuk0U1bLw3aHx5rR9yphmtcwep1crpyObuTyp79
         SmEB9eoko1ImgXtVg9xYq0N8hMmLGQV2w9N330NCMlZlU569NdScAzUkyYu4bFoRhD1W
         Ak9A==
X-Gm-Message-State: APjAAAUo9emKlKVr7sp9/ucZqtFlmOqDiQsezHH2UA00DZlexBGZm/Rw
        FLDMQPPEE3+HLByTFllZQNbiEIzuJ5Q=
X-Google-Smtp-Source: APXvYqwEL3meLDNfEXETd/ZHDzt1FmSXZAuyCYXbh5gXIyYuYtsrTjQ6pGGf/KZb4J75y0roYhiuFw==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33mr7511537plb.269.1566604072188;
        Fri, 23 Aug 2019 16:47:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a5sm3185097pjs.31.2019.08.23.16.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 16:47:51 -0700 (PDT)
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
        dri-devel@lists.freedesktop.org
Subject: [PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Date:   Fri, 23 Aug 2019 23:47:42 +0000
Message-Id: <20190823234747.106510-1-john.stultz@linaro.org>
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

Most of the changes in this revision are adddressing the more
concrete feedback from Christoph (many thanks!). Though I'm not
sure if some of the less specific feedback was completely resolved
in discussion last time around. Please let me know!

New in v8:
* Make struct dma_heap_ops consts (Suggested by Christoph)
* Add flush_kernel_vmap_range/invalidate_kernel_vmap_range calls
  (suggested by Christoph)
* Condense dma_heap_buffer and heap_helper_buffer (suggested by
  Christoph)
* Get rid of needless struct system_heap (suggested by Christoph)
* Fix indentation by using shorter argument names (suggested by
  Christoph)
* Remove unused private_flags value
* Add forgotten include file to fix build issue on x86
* Checkpatch whitespace fixups

Thoughts and feedback would be greatly appreciated!

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
 drivers/dma-buf/heaps/cma_heap.c              | 164 +++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 269 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 122 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 230 +++++++++++++++
 14 files changed, 1262 insertions(+)
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

