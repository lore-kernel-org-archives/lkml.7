Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC492C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C4B20828
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AeLh70p2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1N2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:28:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42243 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfH1N2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:28:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id i30so1730550pfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HLjilt3rg+lyPd3792HT3u5sFVLvu7ZHcOUuot5vMxU=;
        b=AeLh70p2oFQ6VbhYkCFUDStORNri4RTp7C/JORMqO1c+g6fqqzmNpWUKhUwNDF+31K
         YZeKKzGMM2WPATadOlwZxxCDmQDu0b+zSidhq/Xmc1GNbpbbq8KcWtGeRoOACFLyNIVR
         LdpuIv20+9GLIsiaZAADHgFQlun1o2KJHLaM5fxFUE8XC+JTienfq2f6BgqU9xtt7C6k
         hgkHx1gXMKBakw3tp9CADgfdwufArZLvP5U4zIel+xP4FgMzYM/NyM3nYS+ofo60O/VI
         97j1CX/xKmsoX2IL/JZW1t0yhhqtv+XJmvJ7uU7jgBFlzOK+fJCVzOhg/H/nUQG/mFgb
         xO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HLjilt3rg+lyPd3792HT3u5sFVLvu7ZHcOUuot5vMxU=;
        b=AS1VvCyeY2tKhjIBGqU/wEROuPC8oYfPilkiGbMBaXaaxmcCMCzmjXgfRiZLAlF5qY
         XXneHvzDq+lF39/4tIN8W1NAhrZ8vTtvRl3qSt2KG75b1e6/N2Nl92ga6q94rx75926b
         T/xeLzZ4xmNcaltayBV5ltCTYpDxpiMXzXaoXrglEIdm+i283Jp0s4zsLMWJaiGo/cFx
         bMLhBC4wjnq7w3PZOCd5jE9/9Stb6xNciZ9/8hM3PwtKZ90Z+hQ0VrliAy0b4bPsBTFX
         3FHu2emLThAi24paHVyewG0+Lw+4onCoedNoJK2lISBypkAQY1yXEF6fz7kviBE9wEpg
         4w9Q==
X-Gm-Message-State: APjAAAUq3b7lrGvjQJJZ45zlYDHY7VdBF6bXTndAaLwmakPZChvDTza9
        auURNiCCY1PObJ5GJpqlh5xUTQ==
X-Google-Smtp-Source: APXvYqzDwjhZ+nQXlc2KZFLLmCfQJ6Gx0V/PWp3sT/2sifJljHcHLJ/vJQ6zz2LkVS8WjxiyFEA0Ng==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr4250825pje.96.1566998893349;
        Wed, 28 Aug 2019 06:28:13 -0700 (PDT)
Received: from localhost.localdomain (li1566-229.members.linode.com. [139.162.86.229])
        by smtp.gmail.com with ESMTPSA id h11sm2473034pgv.5.2019.08.28.06.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 06:28:12 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/2] Add uacce module for Accelerator
Date:   Wed, 28 Aug 2019 21:27:54 +0800
Message-Id: <1566998876-31770-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uacce (Unified/User-space-access-intended Accelerator Framework) targets to
provide Shared Virtual Addressing (SVA) between accelerators and processes.
So accelerator can access any data structure of the main cpu.
This differs from the data sharing between cpu and io device, which share
data content rather than address.
Since unified address, hardware and user space of process can share the
same virtual address in the communication.

Uacce is intended to be used with Jean Philippe Brucker's SVA
patchset[1], which enables IO side page fault and PASID support. 
We have keep verifying with Jean's sva/current [2]
We also keep verifying with Eric's SMMUv3 Nested Stage patch [3]

This series and related zip & qm driver
https://github.com/Linaro/linux-kernel-warpdrive/tree/5.3-rc1-warpdrive-v2

The library and user application:
https://github.com/Linaro/warpdrive/tree/5.3-rc1-v2

References:
[1] http://jpbrucker.net/sva/
[2] http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current
[3] https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9

Change History:
v2:
Address comments from Greg and Jonathan
Modify interface uacce_register
Drop noiommu mode first

v1:
1. Rebase to 5.3-rc1
2. Build on iommu interface
3. Verifying with Jean's sva and Eric's nested mode iommu.
4. User library has developed a lot: support zlib, openssl etc.
5. Move to misc first

RFC3:
https://lkml.org/lkml/2018/11/12/1951

RFC2:
https://lwn.net/Articles/763990/


Background of why Uacce:
Von Neumann processor is not good at general data manipulation.
It is designed for control-bound rather than data-bound application.
The latter need less control path facility and more/specific ALUs.
So there are more and more heterogeneous processors, such as
encryption/decryption accelerators, TPUs, or
EDGE (Explicated Data Graph Execution) processors, introduced to gain
better performance or power efficiency for particular applications
these days.

There are generally two ways to make use of these heterogeneous processors:

The first is to make them co-processors, just like FPU.
This is good for some application but it has its own cons:
It changes the ISA set permanently.
You must save all state elements when the process is switched out.
But most data-bound processors have a huge set of state elements.
It makes the kernel scheduler more complex.

The second is Accelerator.
It is taken as a IO device from the CPU's point of view
(but it need not to be physically). The process, running on CPU,
hold a context of the accelerator and send instructions to it as if
it calls a function or thread running with FPU.
The context is bound with the processor itself.
So the state elements remain in the hardware context until
the context is released.

We believe this is the core feature of an "Accelerator" vs. Co-processor
or other heterogeneous processors.

The intention of Uacce is to provide the basic facility to backup
this scenario. Its first step is to make sure the accelerator and process
can share the same address space. So the accelerator ISA can directly
address any data structure of the main CPU.
This differs from the data sharing between CPU and IO device,
which share data content rather than address.
So it is different comparing to the other DMA libraries.

In the future, we may add more facility to support linking accelerator
library to the main application, or managing the accelerator context as
special thread.
But no matter how, this can be a solid start point for new processor
to be used as an "accelerator" as this is the essential requirement.

Kenneth Lee (2):
  uacce: Add documents for uacce
  uacce: add uacce driver

 Documentation/ABI/testing/sysfs-driver-uacce |   47 ++
 Documentation/misc-devices/uacce.rst         |  335 ++++++++
 drivers/misc/Kconfig                         |    1 +
 drivers/misc/Makefile                        |    1 +
 drivers/misc/uacce/Kconfig                   |   13 +
 drivers/misc/uacce/Makefile                  |    2 +
 drivers/misc/uacce/uacce.c                   | 1086 ++++++++++++++++++++++++++
 include/linux/uacce.h                        |  172 ++++
 include/uapi/misc/uacce.h                    |   39 +
 9 files changed, 1696 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-uacce
 create mode 100644 Documentation/misc-devices/uacce.rst
 create mode 100644 drivers/misc/uacce/Kconfig
 create mode 100644 drivers/misc/uacce/Makefile
 create mode 100644 drivers/misc/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/misc/uacce.h

-- 
2.7.4

