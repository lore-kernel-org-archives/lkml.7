Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D4AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B9724684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781667;
	bh=NDHlV/5kiS7r+Hm2Cfj1Jf69PpoWZ1Y7BukYPq+qrKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MueHGLo+C6JetCxDF0NZz2S6mgHLKYYY6vhXli2NLR1SDkR2uNB9rP1DgUel6rlRg
	 z4k6wnqAAh07yr/ehM0TQ4PQ4KZooI0QuUsm4kqKJHehSePAcxXrmktTiuBubm42pi
	 Z1/lNbYzCEtXJ4aSV0g9TERvndlGC5T7pwSWtBkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfLSSy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbfLSSyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:54:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF89227BF;
        Thu, 19 Dec 2019 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781663;
        bh=NDHlV/5kiS7r+Hm2Cfj1Jf69PpoWZ1Y7BukYPq+qrKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTwbj+t/UDqO7k+ta/pAT1Ko8RLFSm3rV1Guu00beu/9pUR269hST4b62wT9f18lS
         4MeYE2XbuPXPCwZeZZZRtAif2LZdESavXthcPwKS/YgPE6Ht7nS5tRHQu+4KEALDEK
         OMYllSk7hEzgAznxk7avT+6sWke22QhvBaEe2j1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 29/80] cifs: smbd: Only queue work for error recovery on memory registration
Date:   Thu, 19 Dec 2019 19:34:21 +0100
Message-Id: <20191219183103.776965717@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

commit c21ce58eab1eda4c66507897207e20c82e62a5ac upstream.

It's not necessary to queue invalidated memory registration to work queue, as
all we need to do is to unmap the SG and make it usable again. This can save
CPU cycles in normal data paths as memory registration errors are rare and
normally only happens during reconnection.

Signed-off-by: Long Li <longli@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smbdirect.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2269,12 +2269,7 @@ static void smbd_mr_recovery_work(struct
 	int rc;
 
 	list_for_each_entry(smbdirect_mr, &info->mr_list, list) {
-		if (smbdirect_mr->state == MR_INVALIDATED)
-			ib_dma_unmap_sg(
-				info->id->device, smbdirect_mr->sgl,
-				smbdirect_mr->sgl_count,
-				smbdirect_mr->dir);
-		else if (smbdirect_mr->state == MR_ERROR) {
+		if (smbdirect_mr->state == MR_ERROR) {
 
 			/* recover this MR entry */
 			rc = ib_dereg_mr(smbdirect_mr->mr);
@@ -2602,11 +2597,20 @@ int smbd_deregister_mr(struct smbd_mr *s
 		 */
 		smbdirect_mr->state = MR_INVALIDATED;
 
-	/*
-	 * Schedule the work to do MR recovery for future I/Os
-	 * MR recovery is slow and we don't want it to block the current I/O
-	 */
-	queue_work(info->workqueue, &info->mr_recovery_work);
+	if (smbdirect_mr->state == MR_INVALIDATED) {
+		ib_dma_unmap_sg(
+			info->id->device, smbdirect_mr->sgl,
+			smbdirect_mr->sgl_count,
+			smbdirect_mr->dir);
+		smbdirect_mr->state = MR_READY;
+		if (atomic_inc_return(&info->mr_ready_count) == 1)
+			wake_up_interruptible(&info->wait_mr);
+	} else
+		/*
+		 * Schedule the work to do MR recovery for future I/Os MR
+		 * recovery is slow and don't want it to block current I/O
+		 */
+		queue_work(info->workqueue, &info->mr_recovery_work);
 
 done:
 	if (atomic_dec_and_test(&info->mr_used_count))


