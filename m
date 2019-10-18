Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DF9CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4AA222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gamFheCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438069AbfJRFX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:23:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39661 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407641AbfJRFX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:23:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so2689173pgn.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DXKps7/0UTC6N/waL44YFVSLkuti5RrXPqcBWv8KQbQ=;
        b=gamFheCDtldh8w0DIQwjkJQvPpQ8fVyjLzcl2Bnce55vZageN2p4ZFmfA77Hrfg3vi
         IIuX81DfKF1sY9uChHRvpH+LqRDY4esOj4H4NmjK1xqGdgAvDKplrYujdUncFZabA2W7
         CV1YHJWuWyoVtELxZ+dxIj4b75l46weQlcnVMPvJNBT1EqPmylnAAz7N4pHj5+/DR+eV
         US8Ysm9QoAyka+OTUptCBv9qihjrUN/x/S2a+Rv0ri00g9uAUwkhQF4mXumMLqQysELt
         sHbZk+4eFpXIimqCgWN0A5mLvPcTbg6LSUuyWtJHJwvTQ2CHEklWcly6eFL1SaJ9Vqsw
         MCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DXKps7/0UTC6N/waL44YFVSLkuti5RrXPqcBWv8KQbQ=;
        b=L5qKJzWsJqXkprxxieh+2sgU9gpxaRFx86RGjvSnlYXSXuaqbEawT+DQAPyrD8gYdK
         6VFOfUC+zuGb+3U1Bnfvb9gUmvqfde54mz6oFqHeUUmUKOyRNfvFkW+P80BbWLyVIEz/
         fTR2HuasoUGIy5mJWfhnR8QhLAqOIdTmVZr8kRZrdoLA2yRFqIDFZ0vJ7oChHdnwXdtg
         iX4NjZ3XRCwdC5awovYlQ8FEePhS6yBh6yAraW/I9QXxwCvXEqw5G1ecy9PYZA6/i9MZ
         jENUbJ7ZSYaOOvTA2Yo6wGFd2JpgabUJts/tHuXarhLY8QABYGC+/nwdcNjSOZg7vSp/
         bXHg==
X-Gm-Message-State: APjAAAWwPjHZIfEXnnzUHXvJog+k6tSFYIytpbGwgbBR3iQfy8ux2ry3
        O1ghhKkofXKrRl0ARmnW0K4iH51fmr0=
X-Google-Smtp-Source: APXvYqyqi7P3EgkAazgQczeDmVqJ1d/iYzFd3A4qEMOl6Sl00Jl2WrFk363AGlQfVaxWSAIHUHH7pA==
X-Received: by 2002:a65:564b:: with SMTP id m11mr3970970pgs.133.1571376207362;
        Thu, 17 Oct 2019 22:23:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id g202sm4729336pfb.155.2019.10.17.22.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:23:26 -0700 (PDT)
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
Subject: [PATCH v12 0/5] DMA-BUF Heaps (destaging ION)
Date:   Fri, 18 Oct 2019 05:23:18 +0000
Message-Id: <20191018052323.21659-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew brought up a reasonable concern with the CMA heap
enumeration in the previous patch set, and I had a few other
minor cleanups to add, so here is yet another pass at the
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

I've also removed the stats accounting, since any such
accounting should be implemented by dma-buf core or the heaps
themselves.

New in v12:
* To address Andrew's concern about adding all CMA areas, the
  CMA heap only adds the default CMA region for now.
* Minor cleanups and prep for loading heaps from modules
* I have patches to add other specified CMA regions, as well as
  loading heaps from modules in my WIP tree, which I will submit
  once this set is queued, here:
    https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/dma-buf-heap-WIP

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
 drivers/dma-buf/dma-heap.c                    | 271 ++++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 178 ++++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 270 +++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 124 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 +++++++++++++++
 14 files changed, 1308 insertions(+)
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

