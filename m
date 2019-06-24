Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2FBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C0020663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmV7vfx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbfFXTtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:49:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38210 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbfFXTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:49:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so7463824plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dwFqV91KqH1mK3/9wT2wWG2wDV0aDU1ov+CsBgMWwUE=;
        b=AmV7vfx5CGF4aKpWDx8j1xkohSfbcl709wpiY009FPnbsIsKYfselAK2Etw4zf2ZLP
         i3bZ33PuHyn5iuOiL4oLrVl+1yDzI54MDbF5J6n6XTuDvmXysIQ1nd24fddXcouBdde4
         KIOG5tyXCbQp+R0cz3ZrXNlvNPvN9//QMkSklcRkdM381MC2u0kY+cWy3s1ctPXi+l0C
         tAMsyXqhc5ZVA6LnqBxRuJU0cTufCVghODPcBh8Z8yxVcWmFGwDuPlSk254qXP8ZVCM9
         +N+D2gVKYQ0jvRJBefC1fACRCunhwE5X0SAynWEibTGZikAl39h8a1xXbwTd3C1w4ICc
         9MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dwFqV91KqH1mK3/9wT2wWG2wDV0aDU1ov+CsBgMWwUE=;
        b=MiXfzccJ5XTdcIROwckRWdv/5U9ZCfbiDRJa8IMIdmaZJwA4ncuYYDCRnweDpx5YSo
         d/8VDRvNIqbDrqeo2ypGp5OoNTjpUFyDc1bZpMUfqofrVuR7ZP7APehVp+O6jKWcx0Xz
         rnZwW4E5ciDVaL7U2T9u3/u+dM6FYQQHkcwBHZyXtdGGVGcjgYpTuaAY51muEBmA0LFm
         UoRLD/NL6YvpsFUC2nE1Fzx++gY0nCz9vY8ySiq3HWC+5E/JQXwZGqKSNgHQfhS+NoaM
         HM+P3L0VBWrrpDg7ZZtZtIwGTMhf5Bf073npjda8fz2O2Q2sU4VKF1ChjMetD6InQnmA
         S8ww==
X-Gm-Message-State: APjAAAXH0JneRfX/a+F0AQTSEZC6nZQJyxo4XshuWY8qKdGnBosy+NQw
        q0Ga9RRF6rhFd6+YBsZzpSJsh/R4r4U=
X-Google-Smtp-Source: APXvYqzaURlUIDNW/F4nWEPzG6zzTznkqS21+reIy8WqS0zn3dfgfRnGgBpOQfK1xpINj35aHy63iw==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr135278814plb.60.1561405753588;
        Mon, 24 Jun 2019 12:49:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v3sm7957031pfm.188.2019.06.24.12.49.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 12:49:12 -0700 (PDT)
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
        dri-devel@lists.freedesktop.org
Subject: [PATCH v6 0/5] DMA-BUF Heaps (destaging ION)
Date:   Mon, 24 Jun 2019 19:49:03 +0000
Message-Id: <20190624194908.121273-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another pass at the dma-buf heaps patchset Andrew and I
have been working on which tries to destage a fair chunk of ION
functionality.

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

I've also removed the stats accounting for now, since any such
accounting should be implemented by dma-buf core or the heaps
themselves.


New in v6:
* Number of cleanups and error path fixes suggested by Brian Starkey,
  many thanks for his close review and suggestions!


Outstanding concerns:
* Need to better understand various secure heap implementations.
  Some concern that heap private flags will be needed, but its
  also possible that dma-buf heaps can't solve everyone's needs,
  in which case, a vendor's secure buffer driver can implement
  their own dma-buf exporter. So I'm not too worried here.

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
Cc: dri-devel@lists.freedesktop.org

Andrew F. Davis (1):
  dma-buf: Add dma-buf heaps framework

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heaps
  kselftests: Add dma-heap test

 MAINTAINERS                                   |  18 ++
 drivers/dma-buf/Kconfig                       |  10 +
 drivers/dma-buf/Makefile                      |   2 +
 drivers/dma-buf/dma-heap.c                    | 249 +++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 169 +++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 262 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  54 ++++
 drivers/dma-buf/heaps/system_heap.c           | 121 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 234 ++++++++++++++++
 14 files changed, 1260 insertions(+)
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

