Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8DC5B578
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2013A214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 02:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfF2Co5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 22:44:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbfF2Coy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 22:44:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2F130804E4552ACA6848;
        Sat, 29 Jun 2019 10:44:51 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 29 Jun 2019 10:44:41 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
Date:   Sat, 29 Jun 2019 10:42:32 +0800
Message-ID: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset mark all the GICC node in MADT as possible CPUs even though it
is disabled. But only those enabled GICC node are marked as present CPUs.
So that kernel will initialize some CPU related data structure in advance before
the CPU is actually hot added into the system. This patchset also implement 
'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
needed to enable CPU hotplug.

To support CPU hotplug, we need to add all the possible GICC node in MADT
including those CPUs that are not present but may be hot added later. Those
CPUs are marked as disabled in GICC nodes.

Changelog:

v1 -> v2:
	rebase the thrid patch to the lastest kernel

Xiongfeng Wang (3):
  ACPI / scan: evaluate _STA for processors declared via ASL Device
    statement
  arm64: mark all the GICC nodes in MADT as possible cpu
  arm64: Add CPU hotplug support

 arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
 arch/arm64/kernel/setup.c | 19 ++++++++++++++++++-
 arch/arm64/kernel/smp.c   | 11 +++++------
 drivers/acpi/scan.c       | 12 ++++++++++++
 4 files changed, 57 insertions(+), 7 deletions(-)

-- 
1.7.12.4

