Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D182C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F3D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355279;
	bh=NVvtnQW6+4IY5A1Rbha4/7epwBJhAGchxQSymarG8d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h76gA/TxamzlQAIBqjC7Dy6pLghObzqvBi9y3NJLaC0OjteXYxqEacbA1ZUpYX9mn
	 hs/Rjg25gvUzBDTi+wpDUDMYM3qNonGl3+wd++M+qZSDnn3AdONk+eKSJGwOBkEVmq
	 /PNqpwqHxuMY9HFZ2tLSYausgFkx8ZYC4ox0Jezw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfDOTH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730322AbfDOTHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACBAB218FE;
        Mon, 15 Apr 2019 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355271;
        bh=NVvtnQW6+4IY5A1Rbha4/7epwBJhAGchxQSymarG8d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=051yNZl65NIrBlHCYCqoO1KddgvaIe/q9BXnnLOY7AmU1Quo/sZI/FfNZcwiSuIJM
         fX8LDnH+V09GlHzT8/2tvOAgFZOFfzAJPZEhmQYm6kI96VtwviuADXvY48mOjkzidR
         54qP0UeALISF6PAMQGmVGCxuxPTQPwC23y43biac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4.19 074/101] genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=n
Date:   Mon, 15 Apr 2019 20:59:12 +0200
Message-Id: <20190415183744.374157389@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -554,6 +554,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
+		mutex_init(&desc[i].request_mutex);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();


