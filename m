Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACD3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770E62064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612141;
	bh=u9F+ZwraOPBqvQe+S80ZWpk3lzz/sa5YqOEatmuPSvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=trEZ8Lt8NXSlS7Fb578aHFxV1+Vi6hb0KD96f2x71E+olbQsHXAAURa3u9nIZORIu
	 /iJ+69VEbkvtGxzQZAA/PjJ6NqVvq8Bwzn1VTbAKSik5yJZzMHsQ+tt6zyrSNEjURE
	 bIplDwrFHjv3jD3ls1O2pFWBQVJkxoecHqm/KSeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391019AbfDRS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390215AbfDRSC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:02:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253AF217FA;
        Thu, 18 Apr 2019 18:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610576;
        bh=u9F+ZwraOPBqvQe+S80ZWpk3lzz/sa5YqOEatmuPSvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xb86zWa/Qeb0Y6TDM9O/9Xl5h3GPIQvgzplg6WveDEykQnHtX0HUpE2nwRoeKtpYA
         CtoHFOPP4A9bqMKgK9pTheWUzMXIpBIbbhDA1CBOy1obPiZA2FYpJTx7yChPMSncPg
         hf2JQGlKwJBXmq0pN37/7gGsjZq85x2tehl+YZvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Przemek Socha <soprwa@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/110] scsi: core: Avoid that system resume triggers a kernel warning
Date:   Thu, 18 Apr 2019 19:57:18 +0200
Message-Id: <20190418160446.384248164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 388b4e6a00bb3097278ed1648ac5a1cb48c894e6 ]

scsi_device_quiesce() and scsi_device_resume() are called during
system-wide suspend and resume. scsi_device_quiesce() only succeeds for
SCSI devices that are in one of the RUNNING, OFFLINE or TRANSPORT_OFFLINE
states (see also scsi_set_device_state()).  This patch avoids that the
following warning is triggered when resuming a system for which quiescing a
SCSI device failed:

WARNING: CPU: 2 PID: 11303 at drivers/scsi/scsi_lib.c:2600 scsi_device_resume+0x4f/0x58
CPU: 2 PID: 11303 Comm: kworker/u8:70 Not tainted 5.0.0-rc1+ #50
Hardware name: LENOVO 80E3/Lancer 5B2, BIOS A2CN45WW(V2.13) 08/04/2016
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 scsi_dev_type_resume+0x2e/0x60
 async_run_entry_fn+0x32/0xd8
 process_one_work+0x1f4/0x420
 worker_thread+0x28/0x3c0
 kthread+0x118/0x130
 ret_from_fork+0x22/0x40

Cc: Przemek Socha <soprwa@gmail.com>
Reported-by: Przemek Socha <soprwa@gmail.com>
Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably") # v4.15
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 18e4289baf99..655790f30434 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3095,7 +3095,6 @@ void scsi_device_resume(struct scsi_device *sdev)
 	 * device deleted during suspend)
 	 */
 	mutex_lock(&sdev->state_mutex);
-	WARN_ON_ONCE(!sdev->quiesced_by);
 	sdev->quiesced_by = NULL;
 	blk_clear_preempt_only(sdev->request_queue);
 	if (sdev->sdev_state == SDEV_QUIESCE)
-- 
2.19.1



