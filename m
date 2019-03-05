Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D446DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9347E208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9X9v0Yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfCEUyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:54:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35170 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfCEUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:54:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so6620794pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 12:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3sko/Dla6gJ2MlsTozQ22MExjkm/9TQZQ+rE91DCTvQ=;
        b=g9X9v0YjrXxg8xtTraPDMyNGWK4K5YqwNl4nc+GWpoh4J+EOOukCpaDJPXfDa4P+9B
         z3kEZSrN/jue+zq/5COC89lPVUTX87WPqkW8aBBAIYjhfvGB5u+3XS57gtl7PLZTTYCR
         PCHSKrngqe8Nq6uoVbmP1Ua17gnR3gP8N+G07pbVKJW1Xbq4ozn9wAG/WJTj3E0gg4HB
         MsKbQk7mw1X1X4wvpHfjQxE6klc5dDMlGDuZGklxzSBsAjhklLMWRFuuAy171GQfVA7+
         c5+qiUgfU7THq2pXBve8blYmFVy5s3MMfPg2U2AUgmphSzq1xhPW5UbsYEHg9/eIuVye
         nItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3sko/Dla6gJ2MlsTozQ22MExjkm/9TQZQ+rE91DCTvQ=;
        b=dgkCO7r8CA6j+Y5XlmtvvotshEodZvppDpUP7uJ5u9vnFtEjMDP+vdpKp+82KX7mbB
         dW+NcyHL965eUboEJMn37CB/oJkJBsfvYmeNRa3UFlf3zy89KKSEacTL4npQNXXzkOzV
         Jj5jd1EYV+X2lsooEJXWRkE83wJHRFfztQh+CHNzkOyRfs+O7Jt7heHEZ/Qs2YrtgBlw
         qeTIwExDopxKhWef3CV16gcDINxqf5QLpVjpXph882Mv/Aw9DQdHTifL6uEht2y4uEIv
         45vM2bXqxFntOIDPOwyB+MvYCUVFAi2f13pCMXGEB/OEUAgpyqGqM6Txv7hCg638515F
         262w==
X-Gm-Message-State: APjAAAWUmqfj+CTWQ3+ic6uMTas6RZ4V4VPWJ0oMM9afnn9+VHgWox/l
        lpw8a+lKLBE6c9Tq7gVdCEbcHE9aCmY=
X-Google-Smtp-Source: APXvYqyT2BI00CWfP3ElcpycqhAMpRkoU43GQklbQWoWjw4Ew+Pn0MYprAK7GpqwdVlnW3G+MzagUQ==
X-Received: by 2002:a17:902:728f:: with SMTP id d15mr3253789pll.156.1551819281363;
        Tue, 05 Mar 2019 12:54:41 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id i4sm13411788pfo.158.2019.03.05.12.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Mar 2019 12:54:39 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: [RFC][PATCH 0/5 v2] DMA-BUF Heaps (destaging ION)
Date:   Tue,  5 Mar 2019 12:54:28 -0800
Message-Id: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a initial RFC of the dma-buf heaps patchset Andrew and I
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

Eventual TODOS:
* Reimplement page-pool for system heap (working on this)
* Add stats accounting to system/cma heaps
* Make the kselftest actually useful
* Add other heaps folks see as useful (would love to get
  some help from actual carveout/chunk users)!

That said, the main user-interface is shaping up and I wanted
to get some input on the device model (particularly from GreKH)
and any other API/ABI specific input. 

thanks
-john

Cc: Laura Abbott <labbott@redhat.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Andrew F. Davis <afd@ti.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: dri-devel@lists.freedesktop.org

Andrew F. Davis (1):
  dma-buf: Add dma-buf heaps framework

John Stultz (4):
  dma-buf: heaps: Add heap helpers
  dma-buf: heaps: Add system heap to dmabuf heaps
  dma-buf: heaps: Add CMA heap to dmabuf heapss
  kselftests: Add dma-heap test

 MAINTAINERS                                        |  16 +
 drivers/dma-buf/Kconfig                            |  10 +
 drivers/dma-buf/Makefile                           |   2 +
 drivers/dma-buf/dma-heap.c                         | 191 ++++++++++++
 drivers/dma-buf/heaps/Kconfig                      |  14 +
 drivers/dma-buf/heaps/Makefile                     |   4 +
 drivers/dma-buf/heaps/cma_heap.c                   | 164 ++++++++++
 drivers/dma-buf/heaps/heap-helpers.c               | 335 +++++++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h               |  48 +++
 drivers/dma-buf/heaps/system_heap.c                | 132 ++++++++
 include/linux/dma-heap.h                           |  65 ++++
 include/uapi/linux/dma-heap.h                      |  52 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile      |  11 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c |  96 ++++++
 14 files changed, 1140 insertions(+)
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
2.7.4

