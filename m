Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8A22597B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191219;
	bh=R18vmRkvyvPiwMmVicyJXTYdoTg+OwqAuU6dOmOc0yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XjdkDVW3AUXWSZiI2KkoKkSGNNldHxnDMdc+tnPTUrIW7jS3lOcD5UgHKrTMvDen7
	 yHBAJW36MpUQZjfhORS2aZnvCwqH6Y5thKAaaVBokVlGjCym+YdVSVobwMG8k1MS48
	 BiEqeXYiNMUm6lxIh6dc2tFbMfbvlm5VkaFsDTWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbfE3EkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbfE3DMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:34 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75F623C5A;
        Thu, 30 May 2019 03:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185954;
        bh=R18vmRkvyvPiwMmVicyJXTYdoTg+OwqAuU6dOmOc0yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoJZlfGDDyrZigDUZNyNHwLGpyFVM/88oV4W1VFGCz6YBTJYfVUKfWXGZjO43bv+L
         9dEU5L4zXoN32cEvP1RAIcWqAiOrtLwnqUKJkUQpP5ShT5m+6T8gKzYF7wVEOlaex6
         P1kVj8hTI6KwfJchUMxjnw8WxCPj7dnzHEHM2lKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 369/405] scsi: lpfc: Resolve irq-unsafe lockdep heirarchy warning in lpfc_io_free
Date:   Wed, 29 May 2019 20:06:07 -0700
Message-Id: <20190530030559.391747686@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 50e3f871fb20a9bb644743e2986e8f50f98a25bc ]

A patch in the 12.2.0.0 set caused a new lockdep warning:

  WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
  5.0.0-rc8-next-20190301-dbg+ #1 Not tainted

  Possible interrupt unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&(&qp->io_buf_list_put_lock)->rlock);
                               local_irq_disable();
                               lock(&(&phba->hbalock)->rlock);
                               lock(&(&qp->io_buf_list_put_lock)->rlock);
  <Interrupt>
    lock(&(&phba->hbalock)->rlock);

see: https://www.spinics.net/lists/linux-scsi/msg128389.html

In summary, the new patch added taking the io_buf_list_put_lock while under
an irq-disabled hbalock. This created a lock heirarchy dependent upon irq
being disabled, and there are paths that take the io_buf_list_put_lock
without disabling irq.

Looking at the lpfc_io_free routine, which is where the new heirarchy was
introduced, there is no reason to be taking out the hbalock and raising
irq, as the functionality is replaced by the io_buf_list_xxx locks.

Resolve by removing the hbalock/irq calls in lpfc_io_free.

Fixes: 5e5b511d8bfa ("scsi: lpfc: Partition XRI buffer list across Hardware Queues")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 89a0c2bdb6a15..46e155d1fa155 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3618,8 +3618,6 @@ lpfc_io_free(struct lpfc_hba *phba)
 	struct lpfc_sli4_hdw_queue *qp;
 	int idx;
 
-	spin_lock_irq(&phba->hbalock);
-
 	for (idx = 0; idx < phba->cfg_hdw_queue; idx++) {
 		qp = &phba->sli4_hba.hdwq[idx];
 		/* Release all the lpfc_nvme_bufs maintained by this host. */
@@ -3649,8 +3647,6 @@ lpfc_io_free(struct lpfc_hba *phba)
 		}
 		spin_unlock(&qp->io_buf_list_get_lock);
 	}
-
-	spin_unlock_irq(&phba->hbalock);
 }
 
 /**
-- 
2.20.1



