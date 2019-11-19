Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681A5C33C9D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39746206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143143;
	bh=hmx5Rpbn7yfuwK7i95I3Vro9XyTui2okvZWKHzrJrQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jhZnOW95xG/0vhquWud9dO6xlz4Zeh3tcVWX49QSfKX8nPRU8trf69QG1LiYCMTZe
	 c0Qfx+MT/jX+bDloMTCOyOklYfJC9z46Ct470E2s7Ys91K6wgm+6aV5Y43H6o1BS9X
	 8PtzOBy+b8fyZc/6ziUPZRJOSxwZ2r261xyAZJtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfKSFsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730809AbfKSFsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:48:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78052075E;
        Tue, 19 Nov 2019 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142505;
        bh=hmx5Rpbn7yfuwK7i95I3Vro9XyTui2okvZWKHzrJrQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXSWj9Juywn5LtPsZAxCflpIwWd5K0R1BW9O2AdCFCoW3Dqh5H+Eg5+uU5yhSB3JZ
         rErcg9kKCNJ8QLT3ER6AEFs5jg3QndsbWz3qmfKlg4LCDjWAflzMklSfhybXchtwnH
         78CCFcs0iIS/0xa1Ik2ayrBpabzoTXZoUWhF+lxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 104/239] Drivers: hv: vmbus: Fix synic per-cpu context initialization
Date:   Tue, 19 Nov 2019 06:18:24 +0100
Message-Id: <20191119051325.796790982@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit f25a7ece08bdb1f2b3c4bbeae942682fc3a99dde ]

If hv_synic_alloc() errors out, the state of the per-cpu context
for some CPUs is unknown since the zero'ing is done as each
CPU is iterated over.  In such case, hv_synic_cleanup() may try to
free memory based on uninitialized values.  Fix this by zero'ing
the per-cpu context for all CPUs before doing any memory
allocations that might fail.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/hv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe041f22521da..23f312b4c6aa2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -148,6 +148,17 @@ static void hv_init_clockevent_device(struct clock_event_device *dev, int cpu)
 int hv_synic_alloc(void)
 {
 	int cpu;
+	struct hv_per_cpu_context *hv_cpu;
+
+	/*
+	 * First, zero all per-cpu memory areas so hv_synic_free() can
+	 * detect what memory has been allocated and cleanup properly
+	 * after any failures.
+	 */
+	for_each_present_cpu(cpu) {
+		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
+		memset(hv_cpu, 0, sizeof(*hv_cpu));
+	}
 
 	hv_context.hv_numa_map = kzalloc(sizeof(struct cpumask) * nr_node_ids,
 					 GFP_ATOMIC);
@@ -157,10 +168,8 @@ int hv_synic_alloc(void)
 	}
 
 	for_each_present_cpu(cpu) {
-		struct hv_per_cpu_context *hv_cpu
-			= per_cpu_ptr(hv_context.cpu_context, cpu);
+		hv_cpu = per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		memset(hv_cpu, 0, sizeof(*hv_cpu));
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-- 
2.20.1



