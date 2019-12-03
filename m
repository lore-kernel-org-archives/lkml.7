Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EE32073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kccTZ+9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfLCR0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 12:26:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35351 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCR0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 12:26:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so1962597plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ocQPUWmBDA1ShS30D9CjTE8lnIkFhXXMmEypYP4B6rw=;
        b=kccTZ+9Uc4KNGSKUxGhO+iaAN6wsFLsJrzJpvClvxh6T1hom4ViXkofIEeffvYb0eY
         3uweP6vw8BTxO6bKV2yhHNeWLZbE719Lki0BZaKRvzrwJKyQQSpHMKplJSvnp4Heqalr
         +pP8ghsniOFqwIPO1ft4c7khgElThpULVOkZkMHmexB8xYCso+U7/nMSt6BlWtrW+5Qf
         kSVaSOFB8fj+PEsYKVXc4ihEDtpMMGtih6gDjH5TLA/Wtv618d5dw9Qky98TLt6IBdgY
         d2bLK3UJ4ka6Z3Wep2oSiro1LqsruRGcqMEE9DOsrSAJg8bhsNSN39wub3g3I+ohFuAH
         XZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ocQPUWmBDA1ShS30D9CjTE8lnIkFhXXMmEypYP4B6rw=;
        b=FN6dXZZ9UD5hp+tfTCjAB2zhI3yyNtjRQgyEJNErP809WcxloA1VpK9bECoys8GEhX
         NmB5V1lEeNSLHX9D3V2ZQh02KZ6+SoqxeJ/uMDjsu1QkX+NmoFS3/nCM/iO281greNb6
         TN2FkneGUMR4Jaeff+FuCYNvzyd+ityHE5YLpVsowYZ3pTdOJOVCQ2JJLHvpypgNmDhe
         5lZ/Pk+7lwTVgJ79zNj3kX0xdfheZF7Ne/WisUoJgbwRI1cerelN8QpkWINC7ohs65Ob
         GmjqQsgS0IyRBJ/VSwB2EcgRR2w4AqZ3Lorl188Xhxcxxmm6Oz0UfEW7Rc0sOZ7uIwHo
         OAww==
X-Gm-Message-State: APjAAAUXFhBbFnjp7i6Uoat+bsFngO23Y2QCQkVi5/Tz6LYIofGNbZj0
        aUeQACuMxlWA7RbVXsTLfr+geatZuNk=
X-Google-Smtp-Source: APXvYqwy55wKG7PVnuQtP6CuY6wXN1tqggyfL0l53RKgpOyBd7xYIc/NDwo+Im4OU+AAfTYlCvPpuA==
X-Received: by 2002:a17:902:59d8:: with SMTP id d24mr5711015plj.318.1575394004633;
        Tue, 03 Dec 2019 09:26:44 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l9sm4066177pgh.34.2019.12.03.09.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 09:26:43 -0800 (PST)
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
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [RESEND][PATCH v16 0/5] DMA-BUF Heaps (destaging ION)
Date:   Tue,  3 Dec 2019 17:26:36 +0000
Message-Id: <20191203172641.66642-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to resend v16.

This patchset implements per-heap devices which can be opened
directly and then an ioctl is used to allocate a dmabuf from the
heap.

The interface is similar, but much simpler then IONs, only
providing an ALLOC ioctl.

Also, I've provided relatively simple system and cma heaps.

I've booted and tested these patches with AOSP on the HiKey960
using the kernel tree here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap

And the reviewed (+2'ed) userspace changes here:
  https://android-review.googlesource.com/c/device/linaro/hikey/+/909436

Compared to ION, this patchset is missing the system-contig,
carveout and chunk heaps, as I don't have a device that uses
those, so I'm unable to do much useful validation there.
Additionally we have no upstream users of chunk or carveout,
and the system-contig has been deprecated in the common/andoid-*
kernels, so this should be ok.

I've also removed the stats accounting, since any such
accounting should be implemented by dma-buf core or the heaps
themselves.

New in v16:
* Typo fix suggested by Hridya Valsaraju <hridya@google.com>
* Add extra error and ioctl compatibility testing suggested by
  Daniel Vetter to the kselftest test

Thanks again for all the reviews and feedback!
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
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org

Andrew F. Davis (1):
  dma-buf: Add dma-buf heaps framework

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heaps
  kselftests: Add dma-heap test

 MAINTAINERS                                   |  18 +
 drivers/dma-buf/Kconfig                       |  11 +
 drivers/dma-buf/Makefile                      |   2 +
 drivers/dma-buf/dma-heap.c                    | 297 +++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 177 ++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 271 ++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  53 +++
 drivers/dma-buf/heaps/system_heap.c           | 123 ++++++
 include/linux/dma-heap.h                      |  59 +++
 include/uapi/linux/dma-heap.h                 |  53 +++
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 396 ++++++++++++++++++
 14 files changed, 1484 insertions(+)
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

