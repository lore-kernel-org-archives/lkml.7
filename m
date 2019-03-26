Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CC20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582398;
	bh=KjP2SYEcLH8bZdAliLGOf8HxYrY/Euj2bi/etasqFQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SAzrAIKlIoHjxLgumxuHLcR/A8xMUns+9noaIarRh2vrGAwebQi42cKOIkL+oD2ec
	 dUV9Gat0lv8M2/N1nXeOPJvP55tRAslchmFU7tyX1NUaFkxGl8I+wcL9nv+9D5kqRG
	 Ooq/Itc/QwlcDqQfJoR/t7GmJPVzQHXPkrdZHBUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbfCZGj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732763AbfCZGjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:54 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BC820879;
        Tue, 26 Mar 2019 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582393;
        bh=KjP2SYEcLH8bZdAliLGOf8HxYrY/Euj2bi/etasqFQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUL2wBbl5i/LFUR1DDwgT4Fp7dC/fvpDxDUlNwB4If3Ao6da5+drhf3RpEEFeC+YV
         eWHDNvktnSKx7niofdYTOD2NoVbndllDJbYhffQ9e905Jn02DLnNhGj+5VTudTpb+L
         lWk5SwwGnj12c8cs/npe21P5h1EcYbhjLFiFPjS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 23/52] scsi: ibmvscsi: Fix empty event pool access during host removal
Date:   Tue, 26 Mar 2019 15:30:10 +0900
Message-Id: <20190326042702.076902917@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

commit 7f5203c13ba8a7b7f9f6ecfe5a4d5567188d7835 upstream.

The event pool used for queueing commands is destroyed fairly early in the
ibmvscsi_remove() code path. Since, this happens prior to the call so
scsi_remove_host() it is possible for further calls to queuecommand to be
processed which manifest as a panic due to a NULL pointer dereference as
seen here:

PANIC: "Unable to handle kernel paging request for data at address
0x00000000"

Context process backtrace:

DSISR: 0000000042000000 ????Syscall Result: 0000000000000000
4 [c000000002cb3820] memcpy_power7 at c000000000064204
[Link Register] [c000000002cb3820] ibmvscsi_send_srp_event at d000000003ed14a4
5 [c000000002cb3920] ibmvscsi_send_srp_event at d000000003ed14a4 [ibmvscsi] ?(unreliable)
6 [c000000002cb39c0] ibmvscsi_queuecommand at d000000003ed2388 [ibmvscsi]
7 [c000000002cb3a70] scsi_dispatch_cmd at d00000000395c2d8 [scsi_mod]
8 [c000000002cb3af0] scsi_request_fn at d00000000395ef88 [scsi_mod]
9 [c000000002cb3be0] __blk_run_queue at c000000000429860
10 [c000000002cb3c10] blk_delay_work at c00000000042a0ec
11 [c000000002cb3c40] process_one_work at c0000000000dac30
12 [c000000002cb3cd0] worker_thread at c0000000000db110
13 [c000000002cb3d80] kthread at c0000000000e3378
14 [c000000002cb3e30] ret_from_kernel_thread at c00000000000982c

The kernel buffer log is overfilled with this log:

[11261.952732] ibmvscsi: found no event struct in pool!

This patch reorders the operations during host teardown. Start by calling
the SRP transport and Scsi_Host remove functions to flush any outstanding
work and set the host offline. LLDD teardown follows including destruction
of the event pool, freeing the Command Response Queue (CRQ), and unmapping
any persistent buffers. The event pool destruction is protected by the
scsi_host lock, and the pool is purged prior of any requests for which we
never received a response. Finally, move the removal of the scsi host from
our global list to the end so that the host is easily locatable for
debugging purposes during teardown.

Cc: <stable@vger.kernel.org> # v2.6.12+
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ibmvscsi/ibmvscsi.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2295,17 +2295,27 @@ static int ibmvscsi_probe(struct vio_dev
 static int ibmvscsi_remove(struct vio_dev *vdev)
 {
 	struct ibmvscsi_host_data *hostdata = dev_get_drvdata(&vdev->dev);
-	spin_lock(&ibmvscsi_driver_lock);
-	list_del(&hostdata->host_list);
-	spin_unlock(&ibmvscsi_driver_lock);
-	unmap_persist_bufs(hostdata);
+	unsigned long flags;
+
+	srp_remove_host(hostdata->host);
+	scsi_remove_host(hostdata->host);
+
+	purge_requests(hostdata, DID_ERROR);
+
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	release_event_pool(&hostdata->pool, hostdata);
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+
 	ibmvscsi_release_crq_queue(&hostdata->queue, hostdata,
 					max_events);
 
 	kthread_stop(hostdata->work_thread);
-	srp_remove_host(hostdata->host);
-	scsi_remove_host(hostdata->host);
+	unmap_persist_bufs(hostdata);
+
+	spin_lock(&ibmvscsi_driver_lock);
+	list_del(&hostdata->host_list);
+	spin_unlock(&ibmvscsi_driver_lock);
+
 	scsi_host_put(hostdata->host);
 
 	return 0;


