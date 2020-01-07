Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A152DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711402072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431969;
	bh=MtdUgNPDa3aX5Kb/VGZT6RpldSDFV2vG1xDSF8jS+Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=px12rlW/hgBTPCn4ZBQNUZIKxR8dXQ4/pEIuhhm1N186vnVrN9oi2dqtmbUTqOrDm
	 59hB32uikI/E7neAhk99WYCIJNM0kxPNMo3tpXEUR7o9pIuGyZQMNmH44sUu4UMvSO
	 FP89/JZ0qdzqMA5Au+t2om9Xa7iuF3CF3CIv+HXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgAGVT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:49980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgAGVEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9942081E;
        Tue,  7 Jan 2020 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431090;
        bh=MtdUgNPDa3aX5Kb/VGZT6RpldSDFV2vG1xDSF8jS+Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5peypzfiXkytrVmYTjQw7y1ynUOPzaKAFyaKvfk2mguCv3Ek00bj1irf6Evb9Vv4
         yMOp7DmxiH0CDcMdkV4w27UgxHGON3+vgFsSk1jYbo8TfRe4/WQRCWsSuq/RfFifed
         gs+6PVhmJi3GNJtSCl8ceTaikkUqL3i0AJ9BeUbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/115] s390/cpum_sf: Avoid SBD overflow condition in irq handler
Date:   Tue,  7 Jan 2020 21:53:59 +0100
Message-Id: <20200107205301.057506360@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 0539ad0b22877225095d8adef0c376f52cc23834 ]

The s390 CPU Measurement sampling facility has an overflow condition
which fires when all entries in a SBD are used.
The measurement alert interrupt is triggered and reads out all samples
in this SDB. It then tests the successor SDB, if this SBD is not full,
the interrupt handler does not read any samples at all from this SDB
The design waits for the hardware to fill this SBD and then trigger
another meassurement alert interrupt.

This scheme works nicely until
an perf_event_overflow() function call discards the sample due to
a too high sampling rate.
The interrupt handler has logic to read out a partially filled SDB
when the perf event overflow condition in linux common code is met.
This causes the CPUM sampling measurement hardware and the PMU
device driver to operate on the same SBD's trailer entry.
This should not happen.

This can be seen here using this trace:
   cpumsf_pmu_add: tear:0xb5286000
   hw_perf_event_update: sdbt 0xb5286000 full 1 over 0 flush_all:0
   hw_perf_event_update: sdbt 0xb5286008 full 0 over 0 flush_all:0
        above shows 1. interrupt
   hw_perf_event_update: sdbt 0xb5286008 full 1 over 0 flush_all:0
   hw_perf_event_update: sdbt 0xb5286008 full 0 over 0 flush_all:0
        above shows 2. interrupt
	... this goes on fine until...
   hw_perf_event_update: sdbt 0xb5286068 full 1 over 0 flush_all:0
   perf_push_sample1: overflow
      one or more samples read from the IRQ handler are rejected by
      perf_event_overflow() and the IRQ handler advances to the next SDB
      and modifies the trailer entry of a partially filled SDB.
   hw_perf_event_update: sdbt 0xb5286070 full 0 over 0 flush_all:1
      timestamp: 14:32:52.519953

Next time the IRQ handler is called for this SDB the trailer entry shows
an overflow count of 19 missed entries.
   hw_perf_event_update: sdbt 0xb5286070 full 1 over 19 flush_all:1
      timestamp: 14:32:52.970058

Remove access to a follow on SDB when event overflow happened.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 0f4957ac81b6..5bfb1ce129f4 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1261,12 +1261,6 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		 */
 		if (flush_all && done)
 			break;
-
-		/* If an event overflow happened, discard samples by
-		 * processing any remaining sample-data-blocks.
-		 */
-		if (event_overflow)
-			flush_all = 1;
 	}
 
 	/* Account sample overflows in the event hardware structure */
-- 
2.20.1



