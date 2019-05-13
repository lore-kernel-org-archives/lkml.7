Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395FBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29D4217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ql9zTXdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfEMShg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:37:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44744 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEMShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:37:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so7188381pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7ta6Dt81bGZU9BIZmXBk7KPXs3pWx/uQSwyX/aFs/cU=;
        b=Ql9zTXdTr2UHbU87mcJ0v0HAMUX6aGcYoVfeHA+cb9ZsIVTDmX1dlZ4jqVVw2ceRT7
         qgDIIaF9f3wgUMrkaIt6fNHaoO/iZ4BVxJECbgfR3cmJY2ell5O9XgB8fdDMP83Q+0er
         iN56XU3SVLoTsQvVzX8YpjTFImRP83CcLfAl632vtSlJci12w+OoZrYAEOR9vYBoAE6m
         u8UmfwhPqVmaOKa/17EOPA8GyBgP0gruqkgIDnf2bbuZSBySdjPatmcDlOqfGZyaievL
         XYyymbe5MsR3WIPSCwgnskQ2Y9FT0YhqDnQ1KkXHcbCEsdUkL71wrMUR37AesUlLExyP
         4y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ta6Dt81bGZU9BIZmXBk7KPXs3pWx/uQSwyX/aFs/cU=;
        b=pOe2c31EcOGz83ki0FYeUKjBvhhjB+8dIFwtDRbVe3j3Lw90mYCXfOtM/Zf+AXHRuA
         Dvjuz2oKbHaC3OvoRfPFvYLGdzgReRpI3Hg+iHeZnFw369WA1pxUbxOV+DpePi5b5f/J
         jYjC2JeTP4OwkQyO2ifkbQfDlB7sWJuXGlMy/gJp/IKbmJHw/BU1E28CXJByXUvERIfG
         UOTi5f+8UeuYZNYR7l66kE3w5xvMcnBtpYYEOZC8gGYCBbv9qaibVw6P6yoTmPGQQdyX
         ZvK5Dl6067kqTqPl/Y8KhFWVN6kuEIB7En7f88adq3h3/IxHl49g3g1KsaoF1vp4NsjZ
         Fnow==
X-Gm-Message-State: APjAAAVTMuDiTgbRqFLNRkFswg3uxE7RJ+yxIt0tX22QjtnLEoBERLIa
        ceLM96sptAYGXhrwQ72g2ZS88bUIlyU=
X-Google-Smtp-Source: APXvYqwfsOAP1xNjvu+u8ncG2XEwfMC9o240s60cZjr4QjdborLBIAOCCwf3Y8Dj8ev2ytQD3izV5w==
X-Received: by 2002:aa7:95bb:: with SMTP id a27mr23976186pfk.30.1557772651657;
        Mon, 13 May 2019 11:37:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u11sm17334881pfh.130.2019.05.13.11.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:37:30 -0700 (PDT)
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
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 0/5 v4] DMA-BUF Heaps (destaging ION)
Date:   Mon, 13 May 2019 11:37:22 -0700
Message-Id: <20190513183727.15755-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another RFC of the dma-buf heaps patchset Andrew and I
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
accounting  should be implemented by dma-buf core or the heaps
themselves.


New in v4:
* Add fd_flags per Benjamin's request to specify the creation
  flags for the dmabuf fd.
* Added some optimization in the system heap to allocate
  contiguous pages where possible.
* Reworked the kselftest code to use vgem rather then
  introducing a dummy importer
* Other cleanups suggested by Benjamin and Andrew.


Outstanding concerns:
* Need to better understand various secure heap implementations.
  Some concern that heap private flags will be needed, but its
  also possible that dma-buf heaps can't solve everyone's needs,
  in which case, a vendor's secure buffer driver can implement
  their own dma-buf exporter.
* Making sure the performance issues from potentially
  unnecessary cache-management operations can be resolved
  properly for system and cma heaps(outstanding issue from ION).


That said, the main user-interface is shaping up and I wanted
to get some input on the device model (particularly from GreKH)
and any other API/ABI specific input. 

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
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: "Chenfeng (puck)" <puck.chen@hisilicon.com>
Cc: butao <butao@hisilicon.com>
Cc: "Xiaqing (A)" <saberlily.xia@hisilicon.com>
Cc: Yudongbin <yudongbin@hisilicon.com>
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
 drivers/dma-buf/dma-heap.c                    | 241 ++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 169 ++++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 261 ++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 162 +++++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  56 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |  11 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 232 ++++++++++++++++
 14 files changed, 1294 insertions(+)
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

