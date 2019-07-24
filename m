Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A4AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAFC22387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 00:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIn0Lomb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfGXAhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:37:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfGXAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:37:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so11012891pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rr/xnJYIYPtES/KYVdfSYwWQuwOMrM9NXRwqhvYtOeI=;
        b=uIn0LombegkiJxXFKlEpOg9SFE+17v76HmQs6L6g4R5LtONn5LFHTTwmK8HE3jjb+h
         FNg90C9QhuT59GJxsWEDjfj/i6qZhYFPmdBzd7rkGdf0H0iQO6zUYKM/3m3gjrHZLC/g
         YAB3YPfExc3uuPllROXVrpqNc2aqt12IcVfpwQA4939X+paEv7phQ3j2hhZzdVrcFXyW
         D6RDYxceot2IaoBv84G3rhXck+04pUFRba/JML30v6vbaDAbrzgfECoTwO5cCZI6dbyM
         Xb7Qg/ab5WS6gvPGygsoxN7Ak3rsSIT+ZzpYKW37Q4XL+rhNzySTkBler5icKqG2xBEo
         oqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rr/xnJYIYPtES/KYVdfSYwWQuwOMrM9NXRwqhvYtOeI=;
        b=MGoGLnvkLd8Fa2ATVKvdv5qYYSYE6B+qkVfFt0tqjnJlO17dSfR1Y+xmwswtkqNESO
         YI7Aw1izWMeguvB94tHSA4kP4/M2zlBtLrowLr29sMxkMwlKfETxuCGCgGRBIs1MdmlH
         B7ORgwZxW1O2jJ2EoRGP3BaBUyXJbcwVPkdcJTuhLPYw4Rak40Fv374fCIxWiuEgBXKk
         OD6k+rk04cwGhFx/pbKXzq/fl0QoeBxMYV8ajQFuKn+PvPU6YuIbRRzEYtsm2SSqd9Qb
         GTTNgQy4YJWmBpSDEOs9b3svgnx8cAOJ6Zj3hIw49cfdNIicTLsP3Kb83mo9+m7HXwnR
         jHYQ==
X-Gm-Message-State: APjAAAUfnGcevsT7+YrXbgYF1bJ/N1phZis7ymIj+0pyOp5mzLYevH8b
        9b041eNESazTGEtcyPwymte/LrkSPBQ=
X-Google-Smtp-Source: APXvYqxY36haiuKUyV2u4Er3a+w5Yr+x7sqm5YRUUZ1UHHesU9T0RdjuJL4f73r/mpzhQwg3/64BgQ==
X-Received: by 2002:a17:90a:17a6:: with SMTP id q35mr85071276pja.118.1563928622570;
        Tue, 23 Jul 2019 17:37:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id x26sm58890022pfq.69.2019.07.23.17.36.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 17:37:01 -0700 (PDT)
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
Subject: [PATCH v7 0/5] DMA-BUF Heaps (destaging ION)
Date:   Wed, 24 Jul 2019 00:36:51 +0000
Message-Id: <20190724003656.59780-1-john.stultz@linaro.org>
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


New in v7:
* Longer Kconfig description to quiet checkpatch warnings
* Re-add compat_ioctl bits (Hridya noticed 32bit userland wasn't
  working)
* Make init_heap_helper_buffer lowercase, as suggested by Christoph
* Add dmabuf export helper to reduce boilerplate code
* Add system heap DOS avoidance suggested by Laura from ION code

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
 drivers/dma-buf/dma-heap.c                    | 252 ++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 164 +++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 276 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  58 ++++
 drivers/dma-buf/heaps/system_heap.c           | 123 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 235 +++++++++++++++
 14 files changed, 1280 insertions(+)
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

