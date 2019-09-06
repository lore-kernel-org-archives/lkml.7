Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A035C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2349420838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5tjzjee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406147AbfIFSrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:47:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405083AbfIFSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:47:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so5081852pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jm07RF4qOusTFQQs40dCbcyWy1wVMhan2978N/Kfrcc=;
        b=v5tjzjee9XCrwsAWLSx2DbjrGRiM8X6w/A7Nr6rwn9E7619shZjoGo0+eh1YtG0wy5
         NOydPAc1//zWmgNhxQ0RD9/jUVukWm8Qy/er4VKYJoUVC0oGtfWOcMfyWoW7amQocGuY
         crNauJ/YBM4g5Hv/nJg9z4FWroXttlb2U3r3GlQH93WyJOB1skX8ZxtZKHYl9+QPfhVl
         Rv5FCoNuchZlGjgMncrswQpBH59EGVCjKWGdr1WCw7zzNKX7hu4B27+QIdVeBU0mMRrH
         26VZXFhJXzpwYsVOW91h/mnIzY8pvbzGfPEtC+08tAxioiNn7m+0SgHuPhZID9UkryRg
         NWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jm07RF4qOusTFQQs40dCbcyWy1wVMhan2978N/Kfrcc=;
        b=bV11sE8hAA37wa0pgJIKDkF9NO4vQWZprl0Vm/BrxsGtBjKBSaL8o3OnVaqof3jOH8
         HrJc1+zNIjeMRuYOIZIcb+QsH/vnd4/60sdMIlhzDRHk/JOWC0uSCt1EEFyPahnzReI1
         eheK4No5kQlHomw+BKQ+IIbmiCzg+OtHJFsw45oKDdaAo4p4u12W/AxRZynnbauyhEUv
         GYUPOkSMaFjGsu/mIPjdt/ybpQ6MxCL++OiNjbXpJ8EFBWVbyQXamSpRlFYMvzt4ZM7I
         u3SYVE+itG+V9/3IhO4hvHpNZ7Q/dW7PUHhzdenuU845lFzewl5AkfWqpDPz+GSSHuBh
         jXiw==
X-Gm-Message-State: APjAAAVIUHGn62WHcXn6sKikWROujJfMTiX09mqpmdOB00JdoSXjhtqC
        1oTNtzPBBrj31jaDxglZL6msXyAJcjo=
X-Google-Smtp-Source: APXvYqzwiHW5Dl9BkLPwxd4zUluXR77pWbZha7lV+2J4rKMNHOTMqoQ7Z+jsIz8DW0FLEYRjo59cLA==
X-Received: by 2002:a62:87c8:: with SMTP id i191mr12487069pfe.133.1567795638125;
        Fri, 06 Sep 2019 11:47:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o35sm4889462pgm.29.2019.09.06.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 11:47:17 -0700 (PDT)
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
Subject: [RESEND][PATCH v8 0/5] DMA-BUF Heaps (destaging ION)
Date:   Fri,  6 Sep 2019 18:47:07 +0000
Message-Id: <20190906184712.91980-1-john.stultz@linaro.org>
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

