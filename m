Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57750C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8FA20652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfDLMGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:06:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbfDLMGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:06:35 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1E638CD7C9B354257391;
        Fri, 12 Apr 2019 20:06:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 20:06:19 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <wangxiongfeng2@huawei.com>, <huawei.libin@huawei.com>,
        <james.morse@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/3] Enable kprobe to monitor sdei event handler
Date:   Fri, 12 Apr 2019 20:04:56 +0800
Message-ID: <1555070699-3685-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I use kprobe to monitor a sdei event handler, the CPU will hang. It's
because when I probe the event handler, the instruction will be replaced with 
brk instruction and brk exception is unmaskable. But 'vbar_el1' contains 
'tramp_vectors' in '_sdei_handler' when SDEI events interrupt userspace, so
we will go to the wrong place if brk exception happens.

I notice that 'ghes_sdei_normal_callback' call several funtions that are not
marked as 'nokprobe'. So I was wondering if we can enable kprobe in '_sdei_handler'.


Xiongfeng Wang (3):
  Revert "arm64: debug: remove unused local_dbg_{enable, disable}
    macros"
  sdei: enable dbg in '_sdei_handler'
  stop_machine: mask sdei before running the callback

 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/include/asm/irqflags.h       |  4 +++
 arch/arm64/kernel/debug-monitors.c      |  8 ++++++
 arch/arm64/kernel/sdei.c                | 43 ++++++++++++++++++++++++++-------
 kernel/stop_machine.c                   |  9 +++++++
 5 files changed, 56 insertions(+), 9 deletions(-)

-- 
1.7.12.4

