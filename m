Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B93C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84869263A6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfFCGre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:47:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57202 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfFCGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:47:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08230136|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.104506-0.0122054-0.883288;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03292;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.EglZ6gu_1559544451;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EglZ6gu_1559544451)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 03 Jun 2019 14:47:31 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>
Subject: [PATCH V3 0/6] csky: Add pmu hardware sampling support
Date:   Mon,  3 Jun 2019 14:46:19 +0800
Message-Id: <cover.1559544301.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add hardware sampling support for csky-pmu, and
also add some properties to pmu node definition. perf can record
on hardware event with this patch applied.

Changes since v2:
  - update dt-binding(csky pmu use rising edge interrupt)
  - use cpuhp_setup_state to enable irq(fix irq enable on smp)

Changes since v1:
  - do not update hpcr when event type is invalid(fix option 
    --all-kernel/--all-user)


Guo Ren (1):
  csky: Fixup some error count in 810 & 860.

Mao Han (5):
  csky: Init pmu as a device
  csky: Add reg-io-width property for csky pmu
  csky: Add pmu interrupt support
  dt-bindings: csky: Add csky PMU bindings
  csky: Fix perf record in kernel/user space

 Documentation/devicetree/bindings/csky/pmu.txt |  38 +++
 arch/csky/kernel/perf_event.c                  | 427 +++++++++++++++++++++++--
 2 files changed, 444 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

-- 
2.7.4

