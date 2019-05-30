Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0260C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB2825DDC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfE3Qyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:54:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39758 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfE3Qyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:54:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 062FA341;
        Thu, 30 May 2019 09:54:39 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCB683F5AF;
        Thu, 30 May 2019 09:54:37 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 0/4] coresight: Do not call smp_processor_id from preemptible contexts
Date:   Thu, 30 May 2019 17:54:23 +0100
Message-Id: <1559235267-25232-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a few places where we call smp_processor_id() from preemptible
contexts during the perf buffer handling. We do this to figure out the
numa node for the allocation in case the event is not CPU bound. Use
numa_node_id() instead in such cases to avoid a splat.

Changes since V2:
 - Use NUMA_NO_NODE instead of numa_node_id() for event->cpu == -1. (Robin Murphy)

Suzuki K Poulose (4):
  coresight: tmc-etr: Do not call smp_processor_id() from preemptible
  coresight: tmc-etr: alloc_perf_buf: Do not call smp_processor_id from
    preemptible
  coresight: tmc-etf: Do not call smp_processor_id from preemptible
  coresight: etb10: Do not call smp_processor_id from preemptible

 drivers/hwtracing/coresight/coresight-etb10.c   |  6 ++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  6 ++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 13 ++++---------
 3 files changed, 8 insertions(+), 17 deletions(-)

-- 
2.7.4

