Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BE6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D432075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB+O0res"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfC2AQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:16:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35926 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfC2AQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:16:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id k2so137246plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zUD6J6xvycIjyNyLvpEuugsPd2gKGFqcuvSvKt5Ezpk=;
        b=fB+O0resKM3NMQsIy2cMyDKoPAozo2Dj4jfS7fml6mW72XIV5N9Cv4ireGBBjcwzZW
         N/AHI56YHyigeAMcRvi0aJ4tJpBak5GaMzVh0rNJ7k6TRlUZ1f+kgk9v9kpK81RdP3sw
         ykvzH87A2KzPg6EgXO4WJOEVGcrN6apaFPsfS1fBwNwWpWRDhkevJ3E0LmS+Luue0z+Q
         NWCkLtxp2ssv8rWq7HyUDNU3iRcMI/o9wEVNrTcJthGqJwkHFM654mnTLbO/KREUQMkE
         A3pOzjyBoiXf3ou/0HNtwGHk89ze0lfh2zzMJVojusRLwu7rHCQ6bdMG36ShNExyQj+O
         wjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zUD6J6xvycIjyNyLvpEuugsPd2gKGFqcuvSvKt5Ezpk=;
        b=sGVcRyV9Nvxx8wiuuUb54oPLWqdAS9YzSY1o0u9M9LAOxPZw2U8eVCKqEQXe6TzXLA
         r82TmKNX7IGbKvQpxnjrI17VgVjO1/tPAsjLsXJbRP3zhJc6ALLjUhD8EUeUCbM9Unig
         iI8S5BSuOB4UgGGF8wAS7i6jgDULK9maV3qeV7LqiG5MrStg7E0o5REU7/a0ZEzGVbtO
         Mbl1CfbnGGBViC8+nmMPjeXdBGRwxSK3DyrMrV/YlPXTGbzh6m/GErkr2x3HOY6Zvrmw
         srLgxlqH6Dg4KHKn43mg4XQrgHSIR4WAJDywsi5YqKTtIHRrRtG/dmyhzw6PVJNcX9Mk
         FHJw==
X-Gm-Message-State: APjAAAUI1CYDRBkr8Jt/g29DPOTgfpH6HkZ1QlKtOvRAPYasON2vAaYo
        NAdl0wiRfRfummnkkY8vzC0ckUiSmBE=
X-Google-Smtp-Source: APXvYqxYOvuMaNb07WtFoeQX0BD9F2k2Xa9veT1mthqUdGCwJpUOTtXshw98A7/cF2s7bOejLMTj2A==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr46647990plk.282.1553818566731;
        Thu, 28 Mar 2019 17:16:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id g5sm430137pfo.53.2019.03.28.17.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Mar 2019 17:16:05 -0700 (PDT)
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
Subject: [RFC][PATCH 0/6 v3] DMA-BUF Heaps (destaging ION)
Date:   Thu, 28 Mar 2019 17:15:56 -0700
Message-Id: <1553818562-2516-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
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

Also, I've provided simple system and cma heaps. The system
heap in particular is missing the page-pool optimizations ION
had, but works well enough to validate the interface.

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

I've also removed the stats accounting for now, since it should
be implemented by the heaps themselves.


New in v3:
* Proper /dev/heap/* names on both Android and classic Linux
  environments
* Major rework of the helper code from Andrew
* Dummy test device added to test importing
* *Lots* of cleanups suggested by many (thank you for all the
  input)!


Outstanding concerns:
* Potential need for private flags in interface for secure
  heaps. Need to better understand secure heap usage.
* Making sure the performance issues from potentially unnecessary
  cache-management operations can be resolved properly for system
  and cma heaps (outstanding issue from ION).


Eventual TODOS:
* Sanity filtering for heap names
* Reimplement performance optimizations for system heap
* Add stats accounting to system/cma heaps
* Make the kselftest more useful
* Add other heaps folks see as useful (would love to get
  some help from actual carveout/chunk users)!

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

Andrew F. Davis (2):
  dma-buf: Add dma-buf heaps framework
  dma-buf: Add Dummy Importer Test Device

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heapss
  kselftests: Add dma-heap test

 MAINTAINERS                                        |  18 ++
 drivers/dma-buf/Kconfig                            |  16 ++
 drivers/dma-buf/Makefile                           |   3 +
 drivers/dma-buf/dma-buf-testdev.c                  | 239 +++++++++++++++++++
 drivers/dma-buf/dma-heap.c                         | 234 ++++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                      |  14 ++
 drivers/dma-buf/heaps/Makefile                     |   4 +
 drivers/dma-buf/heaps/cma_heap.c                   | 170 ++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.c               | 261 +++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h               |  55 +++++
 drivers/dma-buf/heaps/system_heap.c                | 120 ++++++++++
 include/linux/dma-heap.h                           |  58 +++++
 include/uapi/linux/dma-buf-testdev.h               |  37 +++
 include/uapi/linux/dma-heap.h                      |  52 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile      |  11 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 169 +++++++++++++
 16 files changed, 1461 insertions(+)
 create mode 100644 drivers/dma-buf/dma-buf-testdev.c
 create mode 100644 drivers/dma-buf/dma-heap.c
 create mode 100644 drivers/dma-buf/heaps/Kconfig
 create mode 100644 drivers/dma-buf/heaps/Makefile
 create mode 100644 drivers/dma-buf/heaps/cma_heap.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
 create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
 create mode 100644 drivers/dma-buf/heaps/system_heap.c
 create mode 100644 include/linux/dma-heap.h
 create mode 100644 include/uapi/linux/dma-buf-testdev.h
 create mode 100644 include/uapi/linux/dma-heap.h
 create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
 create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

-- 
2.7.4

