Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9140CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E48218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4cNJVCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKAVmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:42:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39148 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:42:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so7260367pgn.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qw73byJosffXkuqCyMjGKLHzCzbk8f/W13zIdru5UDs=;
        b=U4cNJVCbks5NLLHVvES6/rHnlmhJhpSMl4fcP8dWEYgRQCUF/LViLyJ+r3ZlycmBiq
         U61vGyoMRuhx302M6+QRUXjQcvBE4HNWxrXru+uO+01oARndC8BJr50YVp1WG45/cQiU
         IJvSFPRE4mNvWR1Z9i7BOkTOp0rFTtS1gsvkL74U24eAVrwEgphnDYbo0igPqVCeSdSh
         MvMeuNuGNFrUEYPMyMwzTYe+YmDFC2bTBhMqVytVriYjs6Axrx7ciK3b+DeQEkIWZvZr
         64yYVOQqb68IRFRymdr40JyPViSmEmFS9TVzhXIL1EZcwONBU4aTh3HjJwlyrC6I31s3
         4Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qw73byJosffXkuqCyMjGKLHzCzbk8f/W13zIdru5UDs=;
        b=ZDoDK/Wh1ulSbsAt8ZOiJ7yVEAmt8zWkogwLMJz8oLSNKH6UW4jy8g5lm1AER1Dxoa
         ySUkDTzv53Qh7E4u7Tag4PmNWOvgOZckUlpuAr2XNUe7HK0yK6NllejelXpV9VdGzUvV
         jGanZA21eTT09vAs3dNvkicXpBBoRWA+K/ZOe+UInWQ1Cy/pqnnMYpwhtrghPAwAMrKh
         UcoqTnN2HizvyiYdEy9jQZLSPjvzjRpNSjL1RMk6XqL7C9psbRs0tc0zMneSqGfVA2H2
         Pk+AZMO80DVvpnmfD/JOYheH1lF79n567BPoUbRiPtVRM0xfvmirhxPx44QgBlNnzB3M
         GX4g==
X-Gm-Message-State: APjAAAUNHUmbN0uX09FXpUQsmn7I7r5sTeykYMu1T3id8IKjVoaVGaZD
        fX2w2MLOduqgAgF85cuhPPFR2uBwUFA=
X-Google-Smtp-Source: APXvYqwPZQOJ824hOIpx+OQwUm86AFEzCF124ezoCY0dfNb/xkltqGVcYD5Tca7S+Udll9ZOgpadQQ==
X-Received: by 2002:a63:6581:: with SMTP id z123mr15822936pgb.367.1572644561515;
        Fri, 01 Nov 2019 14:42:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id u36sm8299058pgn.29.2019.11.01.14.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:42:41 -0700 (PDT)
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
Subject: [PATCH v14 0/5] DMA-BUF Heaps (destaging ION)
Date:   Fri,  1 Nov 2019 21:42:33 +0000
Message-Id: <20191101214238.78015-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This again? I know!

Apologies to all who hoped I'd stop bothering them with this
patch set, but I ran afoul of the DRM tree rules by not
getting the userland patches properly reviewed prior to the
patches landing (I mistakenly was waiting for the patches to
land upstream before pushing the userland patches). Thus,
these were correctly reverted from the drm-misc-next tree.

My attempts to quickly fix the userland review issue didn't get
very far, as the revert brought additional eyes to the patchset,
and further interface changes were requested (comically, which
is the exact reason I was waiting to push the userland changes
:)

So like groundhog day, here we are again, with v14:

This patchset implements per-heap devices which can be opened
directly and then an ioctl is used to allocate a dmabuf from the
heap.

The interface is similar, but much simpler then IONs, only
providing an ALLOC ioctl (and a GET_FEATURES interface to help
with any future changes to the interface).

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

New in v14:
* Reworked ioctl handler to zero fill any difference in
  structure size, similar to what the DRM core does, as
  suggested by Dave Airlie
* Removed now unnecessary reserved bits in allocate_data
* Added get_features ioctl as suggested by Dave Airlie
* Removed pr_warn_once messages as requested by Dave
  Airlie
* Fix missing argment to WARN() in dma_heap_buffer_destroy()
  found and fixed by Dan Carpenter <dan.carpenter@oracle.com>
* Add check in fault hanlder that pgoff isn't larger then
  pagecount, reported by Dan Carpenter
* Fix "redundant assignment to variable ret" issue reported
  by Colin King and fixed by Andrew Davis
* Fix a missing return value in kselftest
* Add calls to test the GET_FEATURES ioctl in ksefltest
* Build fix reported by kernel test robot <lkp@intel.com>
  and fixed by Xiao Yang <ice_yangxiao@163.com> for kselftest
* Minor kselftest Makefile cleanups

Many thanks again to the folks above who found and submitted
fixes to small issues while the patches were in -next! I've
folded them in to the patch set here.

The ioctl rework to avoid reserved fields, was mostly duplicated
from the DRM core, but it does add some complexity to the ioctl
handler so I'd appreciate extra review.

It felt substantial enough that I've removed the previous reviewed
by and acked-by tags, but please let me know if you'd like me to
re-add yours back.

Apologies again for my flub and the extra noise here!
I really appreciate everyone's patience with with me.

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
 drivers/dma-buf/dma-heap.c                    | 313 ++++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 178 ++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 271 +++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 +++
 drivers/dma-buf/heaps/system_heap.c           | 124 +++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  77 +++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 255 ++++++++++++++
 14 files changed, 1387 insertions(+)
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

