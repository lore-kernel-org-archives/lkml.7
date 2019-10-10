Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B188FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823AB2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHg3iNHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfJJSpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:45:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44840 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJSpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:45:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id e10so226609pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qbQX2dFwOfupPyJT9xEfaHjD6bXklURnHUzRGrs4Lug=;
        b=eHg3iNHXmqfnVM+He75Y8RB7/IsLd3kVdOOhrA9Q80FLoCz0AacbxAF4CY6opcJjH8
         UWtscgsn6eQzoUtyo5f6B0gLn5j5rMR3pVpfUjSxr4Fpbp289/I4jA6Vg3RgSVExDzOm
         CSnY0OvkAmLgKeZ1VybGZkh2DRVPACJkpZsQVbohH0rLZg9mmBKGvaw054HgIJ1IdvBn
         GEcK5q5kWht+wPH87A6f60F+1YMsffH6u+e+QRdhKFQLvRM4qea4ifJHAXVvI3Lfhi9T
         EC2hjiGzrJFE1O2eeS1XalPpqH2Kh1PDw6qtZgO7ZHiQTEdUlm+lO7IWw1ukBHuUtpIZ
         kXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qbQX2dFwOfupPyJT9xEfaHjD6bXklURnHUzRGrs4Lug=;
        b=sMVkQLroo4/Y58/Rq4oB9gn+bIhUH7vYFJ8bwjz6NEYrVNkN5n03xlPHIRYaVkYbkG
         N7ADsfCGIseB/YN/AqA73jvjxkiREkQ0Fl2RSyMnAGd8AG6lruIjNVhUWMUlIzy1n8rx
         +a44eOj6UXdaxTR5J+xt9rr5LL7OzCNFsP6/FgZklHEdNdvZe+KxNn+12s6IT00niAry
         VMD/pqx6AUluTNCrPVVnmT6fC1MFutJGmQXjq8I4GrQMSywOnYyHWtofGDj3a+1mB8hP
         XQH1u8F8bF32E1gzN6+fNXmrmcXnt2NOccA2VoIfz3JwVpE0pqOhJ8BSqS8MnrvSflVr
         ivlg==
X-Gm-Message-State: APjAAAV6IHAGJLO2ZMTYiqZZqaNYyTDE9HJK5xjDwI+S82Lp3qLejN6x
        ZG3t6AEuFLbctmKxl9wpoCwDN8gg9+g=
X-Google-Smtp-Source: APXvYqyhabqDAR0UfhpPjZvuKWuv1fZeka4LY4M3Q+jfYCJYJwULI3n4inYm70uMM9R2ZdqS0DYXmQ==
X-Received: by 2002:a63:e750:: with SMTP id j16mr13048201pgk.30.1570733104434;
        Thu, 10 Oct 2019 11:45:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w65sm7541732pfb.106.2019.10.10.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:45:03 -0700 (PDT)
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
Subject: [PATCH v11 0/5] DMA-BUF Heaps (destaging ION)
Date:   Thu, 10 Oct 2019 18:44:53 +0000
Message-Id: <20191010184458.51039-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feeling a bit repetitive, but here is yet another pass at the
dma-buf heaps patchset Andrew and I have been working on which
tries to destage a fair chunk of ION functionality.

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

New in v11:
* Kconfig text improvements suggested by Randy Dunlap

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

