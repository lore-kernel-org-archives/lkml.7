Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B6CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B100220665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfFZQ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:28:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfFZQ2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:28:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 423AD8CC4CB42EDAAF54;
        Thu, 27 Jun 2019 00:28:31 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 00:28:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/6] Fixes for HiSilicon LPC driver and logical PIO code
Date:   Thu, 27 Jun 2019 00:26:52 +0800
Message-ID: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in [1], the hisi-lpc driver has certain issues in handling
logical PIO regions, specifically unregistering regions.

This series add a method to unregister a logical PIO region, and fixes up
the driver to use them.

RCU usage in logical PIO code looks to always have been broken, so that
is fixed also. This is not a major fix as the list which RCU protects
would be rarely modified.

There is another patch to simplify logical PIO registration, made possible
by the fixes.

At this point, there are still separate ongoing discussions about how to
stop the logical PIO and PCI host bridge code leaking ranges, as in [2].

Hopefully this series can go through the arm soc tree and the maintainers
have no issue with that. I'm talking specifically about the logical PIO
code, which went through PCI tree on only previous upstreaming.

Since we so late in the cycle, it may be best to target v5.3, and I can
backport the fixes to stable myself.

[1] https://lore.kernel.org/lkml/1560770148-57960-1-git-send-email-john.garry@huawei.com/
[2] https://lore.kernel.org/lkml/4b24fd36-e716-7c5e-31cc-13da727802e7@huawei.com/

Change since v2:
- Add hisi_lpc_acpi_remove() stub to fix build for !CONFIG_ACPI

Changes since v1:
- Add more reasoning in RCU fix patch
- Create separate patch to change LOGIC_PIO_CPU_MMIO registration to
  accomodate unregistration

John Garry (6):
  lib: logic_pio: Fix RCU usage
  lib: logic_pio: Avoid possible overlap for unregistering regions
  lib: logic_pio: Add logic_pio_unregister_range()
  bus: hisi_lpc: Unregister logical PIO range to avoid potential
    use-after-free
  bus: hisi_lpc: Add .remove method to avoid driver unbind crash
  lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at
    registration

 drivers/bus/hisi_lpc.c    | 47 ++++++++++++++++++---
 include/linux/logic_pio.h |  1 +
 lib/logic_pio.c           | 86 +++++++++++++++++++++++++++------------
 3 files changed, 103 insertions(+), 31 deletions(-)

-- 
2.17.1

