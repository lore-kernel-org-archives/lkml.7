Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6548CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B83238C5
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfH3IlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:41:14 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36151 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfH3IlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:41:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Taqk6kb_1567154466;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Taqk6kb_1567154466)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Aug 2019 16:41:09 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
Subject: [PATCH v5 0/3] genirq/vfio: Introduce irq_update_devid() and optimize VFIO irq ops
Date:   Fri, 30 Aug 2019 16:41:02 +0800
Message-Id: <cover.1567151182.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO takes a free-then-request-irq way to do interrupt
affinity setting and masking/unmasking for a VM (with device passthru
via VFIO). Sometimes it only changes the cookie data of irqaction or even
changes nothing. The free-then-request-irq not only adds more latency,
but also increases the risk of losing interrupt, which may lead to a
VM hung forever in waiting for IO completion

This patchset solved the issue by:
Patch 2 introduces irq_update_devid() to only update dev_id of irqaction
Patch 3 make use of this function and optimize irq operations in VFIO

changes from v4:
 - Patch 3: follow the previous behavior to disable interrupt on error path
 - Patch 3: do irqbypass registration before update or free the interrupt
 - Patch 3: add more comments

changes from v3:
 - Patch 2: rename the new function to irq_update_devid()
 - Patch 2: use disbale_irq() to avoid a twist for threaded interrupt
 - ALL: amend commit messages and code comments

changes from v2:
 - reformat to avoid quoted string split across lines and etc.

changes from v1:
 - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
 - enhance error recovery code and debugging info in irq_update_devid
 - use __must_check in external referencing of this function
 - use EXPORT_SYMBOL_GPL for irq_update_devid
 - reformat code of patch 3 for better readability

Ben Luo (3):
  genirq: enhance error recovery code in free irq
  genirq: introduce irq_update_devid()
  vfio/pci: make use of irq_update_devid and optimize irq ops

 drivers/vfio/pci/vfio_pci_intrs.c | 124 ++++++++++++++++++++++++++------------
 include/linux/interrupt.h         |   3 +
 kernel/irq/manage.c               | 105 ++++++++++++++++++++++++++++----
 3 files changed, 183 insertions(+), 49 deletions(-)

-- 
1.8.3.1

