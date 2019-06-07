Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C00EC28EBD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4712F207E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDoMzWqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFGDH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 23:07:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33659 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFGDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 23:07:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so375294pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OP/5HcXPO39lZBmwz/TKmqEHSGCcXshK7QEl3YE6azg=;
        b=nDoMzWqA+SQGNUjkHYCmMeluLcQ/NdfdL82xSfqhUQBkPAb1HTdTBXQtkYFkBxNe8b
         s/MTvZMK73j5tpNcHdbl9x/cuttENCnK+Exl49xh7MLnS3Nr11QufOjiICba0tLOfKbv
         vBvA0fLNHZdfU+jX/WJ+Lm1ymU5MYD+GY00BhTdFDvRvyu2ZfFGqH40ujcEPQdbfNmAw
         ENnwkGITftRCLihI1PKxhul0T7vvrjwFVeMmBch4K8J6nX4f3hKamfLWQU0shfml8tlw
         6vj5jycWek+VMelH+RXPF82v2d5frMbz9Y9otJC/WAMP6EyJWfr0zMdimuYoZcHcsDG6
         lSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OP/5HcXPO39lZBmwz/TKmqEHSGCcXshK7QEl3YE6azg=;
        b=iWF+ev6McbR7qabrcwudo8GUO9I5fGe4zMVTtQkOwVekpbjTt2enoucWLN/X8+xOyL
         Tpr0Mc2L//RWRbuwm5D8z/k0eeHihCPCCbchIcLgiiBm3U+W+fqtpsFcgDi/Dse8UU7d
         wXLjeT3hohOv+CTSgyrV6cHfVqTQrx++9J3xCwno/pQo+iivj8Vy0ZelDxWfffr2l7Si
         PPj9wQlGcZevIgq2f0B5MNLrBl4dctS42TKtJxaMeUqlEnKO37unY5+g0+xanFRTDK5T
         lCDSyGqcSrn+o0SA0qlHbLZSWurvsHwCA0hQ16CM4LYDa98MCSk2LqXm9IAbh0glaoCU
         fDaA==
X-Gm-Message-State: APjAAAWhBBmVw6j55aGganPIgYemCki5TkSayyJ8vyv3Db8X8jDFHQU/
        m4c08CBXuYtD7oX6+SP8xlIEoZ/YKaU=
X-Google-Smtp-Source: APXvYqzyxMip+mubvZBo4tVOQ7mIWLXt8jDq45eJiNt4huoSsdACR223z8H4ZXIqy6N8p0sqwhe0LQ==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr902777pgv.58.1559876844279;
        Thu, 06 Jun 2019 20:07:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id f4sm506575pfn.118.2019.06.06.20.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 20:07:22 -0700 (PDT)
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
Subject: [PATCH v5 0/5] DMA-BUF Heaps (destaging ION)
Date:   Fri,  7 Jun 2019 03:07:14 +0000
Message-Id: <20190607030719.77286-1-john.stultz@linaro.org>
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


New in v5:
* Actually not much that I'm submitting now. I've backed out the
  large order page allocation I added in v4 as using it with the
  pagelist structure in the helper buffers ended up leaking
  memory unless we split them, and then we didn't see any
  performance improvement.
* I have spent a fair amount of time looking at allocation
  performance compared to ION, and I do have a patch stack
  that performs equal or better then ION (utilizing large order
  allocations, sgtables, and a page pool). However, Andrew
  convinced me that the extra complexity of these optimizations
  would distract reviewers from the core functionality, and we
  can submit those changes afterwards without any interface
  impact. WIP patches can be found here:
    https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap-WIP
* Minor cleanups


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
 drivers/dma-buf/dma-heap.c                    | 237 ++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 169 ++++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 261 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 123 +++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  56 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |  11 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 232 ++++++++++++++++
 14 files changed, 1251 insertions(+)
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

