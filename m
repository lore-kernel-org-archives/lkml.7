Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF9DC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC1C20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934919;
	bh=QmKnUG+IKIzYAACa0xAZB+0Oimp/n+KJPMPj8GJ7ajc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jCihRfAD6YcreSUrpm1c2G7OSIjgO0T3y57tRXYhDT0kAmL/85SLpr2nGoqxsDrZP
	 pZV3PTb8+pz0TqTK3pVDFE1daeEl5w6y7eDdMlSBxKWp5X/sek4X37XiAYBAlsHY/B
	 AXSEoDDyn7o9DCSvoLn9E0avovzGDtfRU3bMGGFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfGLMeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbfGLMeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:34:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AE320645;
        Fri, 12 Jul 2019 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934885;
        bh=QmKnUG+IKIzYAACa0xAZB+0Oimp/n+KJPMPj8GJ7ajc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTTxNfKt/X6aVAvdBfyzCVFa5JkmFBQS+Y720iqms4DhixSnh/sYmLh6EFvuRBfMu
         7gvd9i/qyHZn01HmSB/KnUqUJQI2rpnLKfPbmwSnGfg8O7IHCAOloLLCbVjglEXA+y
         TJsMcubCV7roMonkN/03Li021sQFQVv7E8bZJ4t0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 5.2 46/61] coresight: etb10: Do not call smp_processor_id from preemptible
Date:   Fri, 12 Jul 2019 14:19:59 +0200
Message-Id: <20190712121623.098342297@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 730766bae3280a25d40ea76a53dc6342e84e6513 upstream.

During a perf session we try to allocate buffers on the "node" associated
with the CPU the event is bound to. If it is not bound to a CPU, we
use the current CPU node, using smp_processor_id(). However this is unsafe
in a pre-emptible context and could generate the splats as below :

 BUG: using smp_processor_id() in preemptible [00000000] code: perf/2544

Use NUMA_NO_NODE hint instead of using the current node for events
not bound to CPUs.

Fixes: 2997aa4063d97fdb39 ("coresight: etb10: implementing AUX API")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: stable <stable@vger.kernel.org> # 4.6+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20190620221237.3536-5-mathieu.poirier@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/coresight/coresight-etb10.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -373,12 +373,10 @@ static void *etb_alloc_buffer(struct cor
 			      struct perf_event *event, void **pages,
 			      int nr_pages, bool overwrite)
 {
-	int node, cpu = event->cpu;
+	int node;
 	struct cs_buffers *buf;
 
-	if (cpu == -1)
-		cpu = smp_processor_id();
-	node = cpu_to_node(cpu);
+	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
 
 	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
 	if (!buf)


