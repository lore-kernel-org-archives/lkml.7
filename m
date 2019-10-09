Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2416CECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E523E20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jo0D7FVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbfJIPWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:22:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40906 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIPWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:22:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id d26so1621085pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T84zFmO42nbUzgLTJpkaQAq6A6ocHYBnhFxVngdSKr4=;
        b=jo0D7FVIHUBDCB+50tpx961qMwi+Ll3o+WbCw7LdPww5xwZMbl2+g+2aUpSrf7Zq98
         SPyQznWoVlO67wV2ixuEVX8zJiLdj2vqGQukc22prBfbxr0RUC2DBxT3DymmVA5p4Mt3
         CXYD5q42Cy82ToM4O3Rym9LjFGKfcx7ROqyHF8WBw3LU3tAGVR4eRM/ZK63cswUlH80T
         rq1tS3HwnnrfDjsVrXmyvJOIgs+ZmBMzdKiTP/NeX9wuOy/w1J/zYVEFH+fgi73pK8Xx
         i+2XOBLujnNz9mJ0FhyKjtjsZEa/7prtLzVyc36HO1U2ptjCShMkAKi0kZkQpV61nYry
         mHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T84zFmO42nbUzgLTJpkaQAq6A6ocHYBnhFxVngdSKr4=;
        b=Qic0m4ZVz+3lVBCoLRJHyPYwN5760dmZpXarIJa5rOu7OPWFEmHFD2NDvzd4ZZsezi
         B3h3uXoWjXtlrNFlDpNudkdwz4qa6XB0FdlJZDdiOqVIMlCytUxTRMld6F6zzDe8jxHr
         jtQ8ZfHCKbKCssxY7kNAHMpbIra2ITXgRNnQkZ9gO/ZISERj6ll+on4tU2apD7rOyyg0
         mVMB8gykoPmrDrJKcwyQDELK4riHrbqouWptXhB55p/T/FfBZQiu1Ut/WdK+GlY8AiKy
         3AazI+X2c1Yygzxf7OqNUX6Ojmui1EeCPM6HqwO+Fn6xWCLFUpfhfcCaPnjb/si4j8Ku
         iabg==
X-Gm-Message-State: APjAAAUFhkATBGo2OkYCY//ZQHfjq4Tia41PQS4s/OVQwmIv3G1RLZyq
        QeH9cMUKeSGCC1tG1uuJt+76xA==
X-Google-Smtp-Source: APXvYqwYdmt7LdffGfHn+xN9LhF6QT6xzfmGlCotOAqgwADoJX92Wh73x3TxJas5GxB69mtF9/7FyQ==
X-Received: by 2002:a17:90a:9416:: with SMTP id r22mr4896064pjo.20.1570634523256;
        Wed, 09 Oct 2019 08:22:03 -0700 (PDT)
Received: from localhost.localdomain ([85.203.47.40])
        by smtp.gmail.com with ESMTPSA id h68sm3279597pfb.149.2019.10.09.08.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 08:22:02 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, jonathan.cameron@huawei.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [RESEND PATCH v4 0/2] Add uacce module for Accelerator
Date:   Wed,  9 Oct 2019 23:21:40 +0800
Message-Id: <1570634502-20923-1-git-send-email-zhangfei.gao@linaro.org>
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
Because of unified address, hardware and user space of process can share
the same virtual address in the communication.

Uacce is intended to be used with Jean Philippe Brucker's SVA
patchset[1], which enables IO side page fault and PASID support. 
We have keep verifying with Jean's sva/current [2]
We also keep verifying with Eric's SMMUv3 Nested Stage patch [3]

This series and related zip & qm driver
https://github.com/Linaro/linux-kernel-warpdrive/tree/5.4-rc1-uacce-v4

The library and user application:
https://github.com/Linaro/warpdrive/tree/wdprd-v1-upstream

References:
[1] http://jpbrucker.net/sva/
[2] http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current
[3] https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9

Change History:
v4:
Based on 5.4-rc1
Considering other driver integrating uacce, 
if uacce not compiled, uacce_register return error and uacce_unregister is empty.
Simplify uacce flag: UACCE_DEV_SVA.
Address Greg's comments: 
Fix state machine, remove potential syslog triggered from user space etc.

v3:
Recommended by Greg, use sturct uacce_device instead of struct uacce,
and use struct *cdev in struct uacce_device, as a result, 
cdev can be released by itself when refcount decreased to 0.
So the two structures are decoupled and self-maintained by themsleves.
Also add dev.release for put_device.

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
 Documentation/misc-devices/uacce.rst         |  297 ++++++++
 drivers/misc/Kconfig                         |    1 +
 drivers/misc/Makefile                        |    1 +
 drivers/misc/uacce/Kconfig                   |   13 +
 drivers/misc/uacce/Makefile                  |    2 +
 drivers/misc/uacce/uacce.c                   | 1013 ++++++++++++++++++++++++++
 include/linux/uacce.h                        |  167 +++++
 include/uapi/misc/uacce.h                    |   36 +
 9 files changed, 1577 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-uacce
 create mode 100644 Documentation/misc-devices/uacce.rst
 create mode 100644 drivers/misc/uacce/Kconfig
 create mode 100644 drivers/misc/uacce/Makefile
 create mode 100644 drivers/misc/uacce/uacce.c
 create mode 100644 include/linux/uacce.h
 create mode 100644 include/uapi/misc/uacce.h

-- 
2.7.4

