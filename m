Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF5FC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E5824805
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559646344;
	bh=XJhuHE9sWpCcCAc50dBRC17o3tRa2Q/ayJCS7jIGqjQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=n7qeYz1SWXfg4qgTyr8Hnw1eBWLCN7E8efqjOUEmXbaFAOfrMvysOo8v9mWzBwr77
	 tGRfhfigfVAksNtD9HZUDTLqRuKPZYsnw+OXYpDaVJTi1q2oNcps+K/WtRwA1mBCcw
	 rSzr4PcQe7YqGXvh11zfiTMqSpnyaS7OJcjZbx3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfFDLFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfFDLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:05:43 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E16247B8;
        Tue,  4 Jun 2019 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559646342;
        bh=XJhuHE9sWpCcCAc50dBRC17o3tRa2Q/ayJCS7jIGqjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kC8WGpgkLDDawz5eFAy3YsqRM8xx64wuGoRXj5gEG/9hgz7CBjTpR/tWVIX4ViUS0
         j9N87YSqG0Cg7ISjyetqfxUfHQFuTShBQLIp1HtfzH8dasjnlUhc0hGdgeDraUrbH6
         nWIpAyLvXb1DGQ9gxIQhoa/lISYqvbVmENnkiM2A=
From:   guoren@kernel.org
To:     marc.zyngier@arm.com, mark.rutland@arm.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jason@lakedaemon.net,
        guoren@kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 0/4] irqchip/irq-csky-mpintc: Update some features
Date:   Tue,  4 Jun 2019 19:05:02 +0800
Message-Id: <1559646306-18860-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Here are some patches for irq-csky-mpintc. Any feedback is welcome.

Changes for V4:
 - Remove priority setting
 - Add remove loop in csky_mpintc_handler in a seperate patch
 - Add auto irq deliver fixup patch
 - Add include file for devicetree document's example
 - Add --cover-letter

Changes for V3:
 - Use IRQ_TYPE_LEVEL_HIGH as default instead of IRQ_TYPE_NONE
 - Remove unnecessary loop in csky_mpintc_handler
 - Update commit log msg

Changes for V2:
 - Fixup this_cpu_read() preempted problem
 - Optimize the coding style
 - Optimize #interrupt-cells to one style

Guo Ren (4):
  irqchip/irq-csky-mpintc: Add triger type
  dt-bindings: interrupt-controller: Update csky mpintc
  irqchip/irq-csky-mpintc: Support auto irq deliver to all cpus
  irqchip/irq-csky-mpintc: Remove unnecessary loop in interrupt handler

 .../bindings/interrupt-controller/csky,mpintc.txt  |  20 +++-
 drivers/irqchip/irq-csky-mpintc.c                  | 102 +++++++++++++++++++--
 2 files changed, 109 insertions(+), 13 deletions(-)

-- 
2.7.4

