Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0569ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F12086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOZYCqXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfJUTDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:03:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33457 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUTDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:03:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so9017648pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jJ5jwtEtZvz3RKTAhKxTqC3TqPRBane8BbT7Fv1RJW8=;
        b=hOZYCqXHqLC3n/MXyVtTmVRpZnPhQox7vXpqyfiWUOSxFNESfl7BJbI5z7n718hGfv
         +SqpxbTaH8IK/C8WlH1ldbzr0hXhYFj8W/DyfAj9XpFWFGTEjuvCVQH57EJuLW8Wae97
         CuSrqpRnahvLph3SP0hlhbQ0ui3dyhNCUKYZGd9m4XHvoX+luJo39SBp7goWzNtEDBNR
         aft7fRiF/YRgIBEEeEK5/7AVK9UHtMY2IotFkc1BJXono6yiwCRV84AgjaK/oAQzB1ax
         pKfUOm0u/ZZe7Rwddo+wNwfJtY+hWxgEwFV88yFj1xHlTy7fau8HHxXpl+pRHAi8ga4n
         9zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jJ5jwtEtZvz3RKTAhKxTqC3TqPRBane8BbT7Fv1RJW8=;
        b=bCSmYxZt1L19/wZvHhB5h1Sawt9UoerqofxK3VdHsD7CJg58ZQcCCCZdYtRAinb0U5
         +ktD1+DimqQkf48DNJ+DmMGb+Tmodl+AZYE94AFNoJEi4MVcRJ2S+G88af1TQSCk4Dfk
         Pd5IJafMsWwogADr5ibM4bxhJIA/n7vVs7FdaRyt6NJm3M9gLaMoD+hWfZP4UyQScVud
         tQ+qSh5hGdFkf/12luN309C7wYAp+koxkOhAEQRtn1KaLIC7rRqHHOx1FIuRNfzmVTih
         zV0CZkrq31d0qiiTHpCIj7vX6XyCKIbsRFdlRyxkqTKtnx5mt+cnaJ7V8tDentXQZ/qw
         Z97Q==
X-Gm-Message-State: APjAAAVI2Di6nNVewC4w7YoqNwMnb2pq1P/7l2xopbgj3MjSLjk9x7LM
        gEtQWPC5MuFAtSHzD9hxhOdkvaONulw=
X-Google-Smtp-Source: APXvYqyTxiGSUWeYPGBn1NS7PIVC/jrrrhYoJpYqEd42zW4SoPqkKsN9p0nK2EnaXEJfoULDWS5CuQ==
X-Received: by 2002:a62:6842:: with SMTP id d63mr24242194pfc.16.1571684592819;
        Mon, 21 Oct 2019 12:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 127sm16223673pfy.56.2019.10.21.12.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:03:12 -0700 (PDT)
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
Subject: [PATCH v13 0/5] DMA-BUF Heaps (destaging ION)
Date:   Mon, 21 Oct 2019 19:03:05 +0000
Message-Id: <20191021190310.85221-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lucky number 13! :)

Last week in v12 I had re-added some symbol exports to support
later patches I have pending to enable loading heaps from
modules. He reminded me that back around v3 (its been awhile!) I
had removed those exports due to concerns about the fact that we
don't support module removal.

So I'm respinning the patches, removing the exports again. I'll
submit a patch to re-add them in a later series enabling moduels
which can be reviewed indepently.

With that done, lets get on to the boilerplate!

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

New in v13:
* Re-remove symbol exports, per discussion with Brian. I'll
  resubmit these separately in a later patch so they can be
  independently reviewed

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
 drivers/dma-buf/dma-heap.c                    | 269 ++++++++++++++++++
 drivers/dma-buf/heaps/Kconfig                 |  14 +
 drivers/dma-buf/heaps/Makefile                |   4 +
 drivers/dma-buf/heaps/cma_heap.c              | 178 ++++++++++++
 drivers/dma-buf/heaps/heap-helpers.c          | 268 +++++++++++++++++
 drivers/dma-buf/heaps/heap-helpers.h          |  55 ++++
 drivers/dma-buf/heaps/system_heap.c           | 124 ++++++++
 include/linux/dma-heap.h                      |  59 ++++
 include/uapi/linux/dma-heap.h                 |  55 ++++
 tools/testing/selftests/dmabuf-heaps/Makefile |   9 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 238 ++++++++++++++++
 14 files changed, 1304 insertions(+)
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

