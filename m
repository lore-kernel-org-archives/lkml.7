Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1572CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBDC2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ty7bVJ0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfKFEXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:23:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43951 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfKFEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:23:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so16223528pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 20:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d1as87Sr0+uZOQFdm8joum2TejhuthHY4TqHQCXSeyE=;
        b=ty7bVJ0uKNUqnK+FvWEpAZZDVfk/ahCaVANdTvRblHQZ/xokbZaDnPyuK1QrD2N6lG
         w7YdpCcu0gS4v0qpcvs/3T6yD9/6xDHSLvib2RqQdK/3XkKYYEsF2fSLJx0DaoZFiROl
         +N+tzsrViXqYhXFeqD6mK3mIQegYaqX5KyUnYenfMaYdr5VHpFqZk1Nv518zGhhqIBJ+
         5yAfzkugnQjSSEB/aR3L+WMozre/06/cVjZ7uh30foPLdV1VJ+0Gd3XYEr0a+FTPkvT6
         YYIlRd7C0iaDovh1K6RI0mZb4VoCMU+dXSFQ99pPYztDOPH9Q92ADBYf4pyDrT72bery
         4h8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d1as87Sr0+uZOQFdm8joum2TejhuthHY4TqHQCXSeyE=;
        b=QEn0y0IL6TS32plrJUPmurnHZVyX8TmkigPuXeZ5mMR8WgK9EePXjQ2gyjXHSbgD3v
         C5RxNa/VAZA3TsRMbh00vD+z9dsOFSOkiMaihdk991GQ/mxnXj6tjSP6CGkaYsaLGLH/
         S2djdCvidHdBbBdgXLt/fat0B+8NXmN5pNjazfBPMgjqTCNG7YbTbxcL4yDqqUz5NSgO
         /nvgPldXwxUc+9OuKsC6cagzfUBPNSmr7A4AKx211/Q3EP7gIq7Gek46CZCFtK33v+Wc
         B5Zqvnk8wu2VvHHatVOywAJtFRYy+ePir2b+SAHpaCQJZQnRoX5W/g8G/f4BIjed6wuW
         YkOg==
X-Gm-Message-State: APjAAAXyl3wumwno2I9T68IHsIjy4EAX118hdf0pdDCKE9d5+/XRcNHj
        smbg8U6Yp4awar/UG2nbjGlIU5TeJUo=
X-Google-Smtp-Source: APXvYqxJ/eLZ1O/wEyv7aU5R5VcDbE/at06GP86l+CYFMwaGx7gOj+syCPEx8H9xQKXR9ODv74A56A==
X-Received: by 2002:a65:664e:: with SMTP id z14mr477142pgv.201.1573014180775;
        Tue, 05 Nov 2019 20:23:00 -0800 (PST)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id n15sm23730289pfq.146.2019.11.05.20.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:23:00 -0800 (PST)
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
Subject: [PATCH v15 0/5] DMA-BUF Heaps (destaging ION)
Date:   Wed,  6 Nov 2019 04:22:47 +0000
Message-Id: <20191106042252.72452-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once again, here we are with v15:

This patchset implements per-heap devices which can be opened
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

I've also removed the stats accounting, since any such
accounting should be implemented by dma-buf core or the heaps
themselves.

New in v15:
* Dropped the get_features ioctl as suggested by Brian
  Starkey and Daniel Vetter
* Add listhead comment suggested by Sandeep Patil
* Dropped minor value in struct dma_heap as suggested by
  Sandeep Patil
* Drop unused flags field from heap_helper_buffer as suggested
  by Sandeep Patil
* Fix grammar typo from Brian Starkey
* Remove usage of dropped get_features ioctl in kselftest test


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

 MAINTAINERS                                   |  18 ++
 drivers/dma-buf/Kconfig                       |  11 +
 drivers/dma-buf/Makefile                      |   2 +
 drivers/dma-buf/dma-heap.c                    | 297 ++++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 177 +++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 271 ++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  53 ++++
 drivers/dma-buf/heaps/system_heap.c           | 123 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  53 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++
 14 files changed, 1326 insertions(+)
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

