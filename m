Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48454C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF10214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aABm2nu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfHALS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:18:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbfHALSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MDmpY5EHj8U+zmmNaXw1ntCBz285jVsAmek2qVWzj1E=; b=aABm2nu9jDgmlCzsbre1rsw4Ak
        OGgghGKpUWPzgmQERlBHr4p1a9E55RLrbmCl7sygRMRlKxdRGkxRuG/q6cLXG+g/IqQjwBq9Ec2gw
        VN/Z19p6+0z6ig0KDmmc5kMMTBY+yRwPMkiUAFJyFCxd1ME0rj9DoTSfzREE5MbhDkG3SwnxNa1hy
        Y4MAgAJPBcN9iwYB0sSlJzC+r2OjVPtGOpKnncEc+tz7lUmsXe8JV5TYqL1NGljvl9n3rVnkMhj3d
        QSL4IwHmehgXKVUJ1Z2ueCzl5ouqmiEvAp964LlAwICOMUx8QNsPb6zQYRfd8Hq/MegTAJ3cCSZ1J
        s5vYR+Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ht968-0005fc-GW; Thu, 01 Aug 2019 11:18:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 89CC7202975E3; Thu,  1 Aug 2019 13:18:12 +0200 (CEST)
Message-Id: <20190801111541.858088180@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 01 Aug 2019 13:13:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4/5] media/ivtv: Reduce default FIFO priority
References: <20190801111348.530242235@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ivtv driver creates a FIFO-99 thread by default, reduce this to
FIFO-1.

FIFO-99 is the very highest priority available to SCHED_FIFO and
it not a suitable default; it would indicate the ivtv work is the
most important work on the machine.

FIFO-1 gets it above all OTHER tasks, which seems high enough lacking
better justification.

Cc: Andy Walls <awalls@md.metrocast.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/media/pci/ivtv/ivtv-driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/pci/ivtv/ivtv-driver.c
+++ b/drivers/media/pci/ivtv/ivtv-driver.c
@@ -738,7 +738,7 @@ static void ivtv_process_options(struct
  */
 static int ivtv_init_struct1(struct ivtv *itv)
 {
-	struct sched_param param = { .sched_priority = 99 };
+	struct sched_param param = { .sched_priority = 1 };
 
 	itv->base_addr = pci_resource_start(itv->pdev, 0);
 	itv->enc_mbox.max_mbox = 2; /* the encoder has 3 mailboxes (0-2) */


