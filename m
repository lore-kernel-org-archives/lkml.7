Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A2CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDD1218FE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355609;
	bh=tQz8htdpHXY1/I4RO+5Hc67rupr0Ctu9d514Q73bDLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIj2bObg3pmsVGkCmNWAdKVq/vvk11/Up7BPYf0a0Kh2GAlkqbTYsRDycHAvV4vDu
	 9GotBBg80FkU8RxGkwoByHT08gmqEOgzOZyU3LWwQplAPmpcA6EL7gmpaAXaQvcIgM
	 BZPOFuR0lBYxjM+pbIL3yJVXRkt0anN/ixHHKi/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfDOTN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbfDOTNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9EC20880;
        Mon, 15 Apr 2019 19:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355599;
        bh=tQz8htdpHXY1/I4RO+5Hc67rupr0Ctu9d514Q73bDLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOCqnkQvZ3C2AyhwPwggaY7gZ2F/MKPMDbRhxdX7Wu6vopHbrw6cxLsxsVuo2BqOB
         Pv3c8Xaa1DAwkynIqzAv8+2XqDvgza1wlAcqEcRaBnTFGSqAxGeKp2dpWI+yoUzlbL
         lx4vr5QyftXbvZ0PYb5MnIuVBhoFCIDY+jv9px24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5.0 082/117] genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=n
Date:   Mon, 15 Apr 2019 21:00:52 +0200
Message-Id: <20190415183749.108569215@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

commit e8458e7afa855317b14915d7b86ab3caceea7eb6 upstream.

When CONFIG_SPARSE_IRQ is disable, the request_mutex in struct irq_desc
is not initialized which causes malfunction.

Fixes: 9114014cf4e6 ("genirq: Add mutex to irq desc to serialize request/free_irq()")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190404074512.145533-1-wangkefeng.wang@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/irqdesc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -558,6 +558,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
+		mutex_init(&desc[i].request_mutex);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();


