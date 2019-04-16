Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C30C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A9120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfDPPYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:24:31 -0400
Received: from foss.arm.com ([217.140.101.70]:57822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbfDPPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:24:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 401F780D;
        Tue, 16 Apr 2019 08:24:31 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6802F3F59C;
        Tue, 16 Apr 2019 08:24:29 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will.deacon@arm.com
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        suzuki.poulose@arm.com, bigeasy@linutronix.de,
        peterz@infradead.org, clabbe.montjoie@gmail.com,
        Meng.Li@windriver.com
Subject: [PATCH v3 0/2] Fix Arm system PMU hotplug issues
Date:   Tue, 16 Apr 2019 16:24:23 +0100
Message-Id: <cover.1555427430.git.robin.murphy@arm.com>
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

v3: Improve cleanup in failure paths [Suzuki]

Robin.


Robin Murphy (2):
  perf/arm-cci: Remove broken race mitigation
  perf/arm-ccn: Clean up CPU hotplug handling

 drivers/perf/arm-cci.c | 21 ++++++++++++---------
 drivers/perf/arm-ccn.c | 25 +++++++++++++------------
 2 files changed, 25 insertions(+), 21 deletions(-)

-- 
2.21.0.dirty

