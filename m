Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB5C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEC520830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfDCRJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:09:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45206 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDCRJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:09:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C0D680D;
        Wed,  3 Apr 2019 10:09:05 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6FAF3F68F;
        Wed,  3 Apr 2019 10:09:03 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        suzuki.poulose@arm.com, bigeasy@linutronix.de,
        peterz@infradead.org, clabbe.montjoie@gmail.com,
        Meng.Li@windriver.com
Subject: [PATCH v2 0/2] Fix Arm system PMU hotplug issues
Date:   Wed,  3 Apr 2019 18:08:58 +0100
Message-Id: <cover.1554310292.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After a converstaion with Thomas a while back, it felt like the best way
forward here is just to resolve the pressing preemption violation, and
not make things more complicated by trying to manage theoretical races
within perf core from a distance.

Thus v2 simply nukes the offending logic and brings those drivers in
line with the status quo. Due to the abrupt change in tactic I've not
kept the review tags given for v1.

Robin.


Robin Murphy (2):
  perf/arm-cci: Remove broken race mitigation
  perf/arm-ccn: Remove broken race mitigation

 drivers/perf/arm-cci.c | 16 +++++++---------
 drivers/perf/arm-ccn.c | 23 +++++++++++------------
 2 files changed, 18 insertions(+), 21 deletions(-)

-- 
2.21.0.dirty

