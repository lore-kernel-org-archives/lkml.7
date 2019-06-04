Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76543C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571AE255DE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFDCZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:25:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35009 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbfFDCZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:25:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07855518|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0986686-0.0125057-0.888826;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Eh6dKEu_1559615105;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Eh6dKEu_1559615105)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 04 Jun 2019 10:25:05 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, linux-csky@vger.kernel.org,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH V4 0/6] csky: Add pmu hardware sampling support
Date:   Tue,  4 Jun 2019 10:23:54 +0800
Message-Id: <cover.1559614824.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add hardware sampling support for csky-pmu, and
also add some properties to pmu node definition. perf can record
on hardware event with this patch applied.

Cc: Guo Ren <guoren@kernel.org>

Changes since v3:
  - change reg-io-width to count-width
  - use macro sign_extend64
  - update commit log

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
  csky: Add count-width property for csky pmu
  csky: Add pmu interrupt support
  dt-bindings: csky: Add csky PMU bindings
  csky: Fix perf record in kernel/user space

 Documentation/devicetree/bindings/csky/pmu.txt |  38 +++
 arch/csky/kernel/perf_event.c                  | 424 +++++++++++++++++++++++--
 2 files changed, 441 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

-- 
2.7.4

