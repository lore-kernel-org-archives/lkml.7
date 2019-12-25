Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BCBC2D0C3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF92053B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 02:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLYCvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:51:06 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:59083 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbfLYCvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:51:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TlrxobV_1577242263;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0TlrxobV_1577242263)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 10:51:03 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, gerry@linux.alibaba.com,
        zhabin@linux.alibaba.com, jing2.liu@intel.com,
        chao.p.peng@intel.com
Subject: [PATCH v1 0/2] support virtio mmio specification Version 3
Date:   Wed, 25 Dec 2019 10:50:21 +0800
Message-Id: <cover.1577240905.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cloud native environment, we need a lightweight and secure system. It
should benefit from the speed of containers and the security of VM, which
is classified as secure containers. The traditional solution of cloud VM
is Qemu. In fact we don't need to pay for the legacy devices. Currently,
more userspace VMMs, e.g. Qemu, Firecracker, Cloud Hypervisor and Alibaba
Cloud VMM which is called Dragonball, began to pay attention to a
lightweight solution.

The lightweight VMM is suitable to cloud native infrastructure which is
designed for creating secure sandbox to address the requirements of
multi-tenant. Meanwhile, with faster startup time and lower memory
overhead, it makes possible to launch thousands of microVMs on the same
machine. This VMM minimizes the emulation devices and uses virtio-mmio to
get a more lightweight transport layer. The virtio-mmio devices have less
code than virtio-pci, which can decrease boot time and increase deploy
density by customizing kernel such as setting pci=off. From another point
of view, the minimal device can reduce the attack surface.

We have compared the number of files and the lines of code between
virtio-mmio and virio-pci.

				Virtio-PCI	    Virtio-MMIO	
	number of files(Linux)	    161			1
	lines of code(Linux)	    78237		538
	number of files(Qemu)	    24			1
	lines of code(Qemu)	    8952		421

But the current standard virtio-mmio spec has some limitations which is
only support legacy interrupt and will cause performance penalties.

To address such limitation, we proposed to update virtio-mmio spec to
version 3 to add the MSI interrupt and doorbell notify features[1], which
can achieve the same performance as virtio-pci devices with only around 400
lines of code.

Here are the performance gain of MSI interrupt in virtio-mmio. Each case is
repeated three times.

        netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024

                Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
        trans/s     9536        6939            9500
        trans/s     9734        7029            9749
        trans/s     9894        7095            9318

With the virtio spec proposal[1], other VMMs (e.g. Qemu) can also make use
of the new features to get a enhancing performance.

[1] https://lkml.org/lkml/2019/12/20/113

Liu Jiang (2):
  x86/msi: Enhance x86 to support platform_msi
  virtio-mmio: add features for virtio-mmio specification version 3

 arch/x86/Kconfig                 |   6 ++
 arch/x86/include/asm/hw_irq.h    |   5 +
 arch/x86/include/asm/irqdomain.h |   9 ++
 arch/x86/kernel/apic/msi.c       |  74 +++++++++++++
 drivers/base/platform-msi.c      |   4 +-
 drivers/virtio/virtio_mmio.c     | 226 ++++++++++++++++++++++++++++++++++++---
 include/linux/msi.h              |   1 +
 include/uapi/linux/virtio_mmio.h |  28 +++++
 8 files changed, 337 insertions(+), 16 deletions(-)

-- 
1.8.3.1

