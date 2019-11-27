Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B8A21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888688;
	bh=O+KNYKwrYXlnpwO1GIlUFnzRl1BQrKkUD6M9YTg3B08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oARm3b9OgNZw4AYsy0Z/9XmEMAkUUigNcAtdlutFyf/fzskXJsDbRWUlw9scFUya6
	 VWQxSEmI1+crH+KgNfUsV990rf2lye5y1mGmaTD5JaFY+5qrmdodQ8pIgJki2RcXf1
	 cAvny96SG6sY+hFN7tfb8Kv7YlH5BX79b1qTwhQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfK0VEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbfK0VEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:04:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849C92086A;
        Wed, 27 Nov 2019 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888681;
        bh=O+KNYKwrYXlnpwO1GIlUFnzRl1BQrKkUD6M9YTg3B08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFwnjBI4duFcFXok4hMqj2oEWPzCGS0oEaAUlI0aV6it02BEx+/1M1ske2EE3T25l
         IW/2CdcAiTlQuP3dv7LXKL5dcXAKXR++8aGJCVQiw0Pmoq5xwr3KFt9RM/+5dSKYMI
         3MVhtcOgx0aS4oL5g7g5r/v1TiILPS2Wz+5wRrXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KY Srinivasan <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 191/306] irq/matrix: Fix memory overallocation
Date:   Wed, 27 Nov 2019 21:30:41 +0100
Message-Id: <20191127203129.186296434@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 57f01796f14fecf00d330fe39c8d2477ced9cd79 ]

IRQ_MATRIX_SIZE is the number of longs needed for a bitmap, multiplied by
the size of a long, yielding a byte count. But it is used to size an array
of longs, which is way more memory than is needed.

Change IRQ_MATRIX_SIZE so it is just the number of longs needed and the
arrays come out the correct size.

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: KY Srinivasan <kys@microsoft.com>
Link: https://lkml.kernel.org/r/1541032428-10392-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/matrix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 92337703ca9fd..30cc217b86318 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,7 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS) * sizeof(unsigned long))
+#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
 
 struct cpumap {
 	unsigned int		available;
-- 
2.20.1



