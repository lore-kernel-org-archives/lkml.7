Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC487C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8E221907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126837;
	bh=3tZMqAe4m2tyxH1Km1vnkr2W2uO+Aoqi8LQxBStiESA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iMQ7N3V5GYWEw6H3IDtLLc1+6EWhcO1tKMVtcljbQkS6NiSdXdIqwW3fE6LUQdb5K
	 M2dAOOaBo8uk62q+bjSAvArUsRMYFMWTM0M+kH7GiwUX6HLJf7YFOjPTJfD8kGBnIA
	 ya8a2dolKN4oCY0sVuMKJdM257qPIoYduZmjloqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389987AbfDXR1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390380AbfDXR1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB381205ED;
        Wed, 24 Apr 2019 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126832;
        bh=3tZMqAe4m2tyxH1Km1vnkr2W2uO+Aoqi8LQxBStiESA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smhf4vzSKCx+9U07ye/dqiJQGzmz3lb/FNES8rqKdFX4nOf0YcOBnpyLM8L+bv9cR
         AoJlYxBXmqPw+VyflTwmMSKNE2b/RyYfBmLUTkNT+uRfS5xUL8BcWmN60UK7XAb047
         zi/5g/x86PZ1CAHFTUcNmO3TOb45x+/QHNyREG2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaesoo Lee <jalee@purestorage.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 33/70] scsi: core: set result when the command cannot be dispatched
Date:   Wed, 24 Apr 2019 19:09:53 +0200
Message-Id: <20190424170911.461102399@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaesoo Lee <jalee@purestorage.com>

commit be549d49115422f846b6d96ee8fd7173a5f7ceb0 upstream.

When SCSI blk-mq is enabled, there is a bug in handling errors in
scsi_queue_rq.  Specifically, the bug is not setting result field of
scsi_request correctly when the dispatch of the command has been
failed. Since the upper layer code including the sg_io ioctl expects to
receive any error status from result field of scsi_request, the error is
silently ignored and this could cause data corruptions for some
applications.

Fixes: d285203cf647 ("scsi: add support for a blk-mq based I/O path.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_lib.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2050,8 +2050,12 @@ out:
 			blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
 		break;
 	default:
+		if (unlikely(!scsi_device_online(sdev)))
+			scsi_req(req)->result = DID_NO_CONNECT << 16;
+		else
+			scsi_req(req)->result = DID_ERROR << 16;
 		/*
-		 * Make sure to release all allocated ressources when
+		 * Make sure to release all allocated resources when
 		 * we hit an error, as we will never see this command
 		 * again.
 		 */


