Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B1C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F2020818
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563420315;
	bh=EjQiwJFzN6vC59pTA0kUIUoNEPvkuQCYIO3Sbda2fAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tbXyk04rj6v27fXusmjRVPc0GA/fDCQkYcRk3yEusIhSm5duAt1FPwPRSGZb3Q39I
	 z5fUtouRUIzcKbK9FVhbsqpoy9QOTFRI9Krl7sD/TKSZyrQySqW6i/gmNrqdaWBHM6
	 68IRUQqT8GbhSlp6Bcg5RYa3E9/kZBzyw/Tu/dEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbfGRDZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390089AbfGRDFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:05:55 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8019D21848;
        Thu, 18 Jul 2019 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419154;
        bh=EjQiwJFzN6vC59pTA0kUIUoNEPvkuQCYIO3Sbda2fAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqFBIpmyZ/iU6BMTbUWbpQrhJGGfIwH2MJIsIB+gZgfuHNiyDaVpKKLgcuViFofEj
         fXF2hCuIfRop93oPOu/8Iv3NY2vDbdRz54z1B8AKyI1p/4mKcbai49Pcj9LXhQClvM
         rPJWMQnzSd5ncU+YloCeOVlYvzJ+jy9YghFkbDJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.1 50/54] s390/qdio: dont touch the dsci in tiqdio_add_input_queues()
Date:   Thu, 18 Jul 2019 12:01:45 +0900
Message-Id: <20190718030057.070484504@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
References: <20190718030053.287374640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

commit ac6639cd3db607d386616487902b4cc1850a7be5 upstream.

Current code sets the dsci to 0x00000080. Which doesn't make any sense,
as the indicator area is located in the _left-most_ byte.

Worse: if the dsci is the _shared_ indicator, this potentially clears
the indication of activity for a _different_ device.
tiqdio_thinint_handler() will then have no reason to call that device's
IRQ handler, and the device ends up stalling.

Fixes: d0c9d4a89fff ("[S390] qdio: set correct bit in dsci")
Cc: <stable@vger.kernel.org>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/qdio_thinint.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/s390/cio/qdio_thinint.c
+++ b/drivers/s390/cio/qdio_thinint.c
@@ -79,7 +79,6 @@ void tiqdio_add_input_queues(struct qdio
 	mutex_lock(&tiq_list_lock);
 	list_add_rcu(&irq_ptr->input_qs[0]->entry, &tiq_list);
 	mutex_unlock(&tiq_list_lock);
-	xchg(irq_ptr->dsci, 1 << 7);
 }
 
 void tiqdio_remove_input_queues(struct qdio_irq *irq_ptr)


