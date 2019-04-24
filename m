Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D28C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A90621905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127518;
	bh=/SCuVEvZ1AypaB4eQaAKoJcaWjN8N/OkT0gc+K1JcAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O5ywUXULanYxPqa4KF0I5Cxo1+UFCOrTP1Mi72VUrwgzHpkGuYB3vtfUbaGocbP3L
	 GeFwxaF2VfAIIAD9pTZ3epUlO9MD+6Zz0OrwQ3C1LiPz4FqTtFh1oKfdLy8n+z4Zwg
	 hNfbu8l8c7SanZglNRPWK4EJCHq15JnnLOQT9iVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392448AbfDXRih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392434AbfDXRie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:38:34 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21004218B0;
        Wed, 24 Apr 2019 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127513;
        bh=/SCuVEvZ1AypaB4eQaAKoJcaWjN8N/OkT0gc+K1JcAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3/q1qBCk3lXTUdMut0NSlA48Ma0TJakY1IGbb62H4U8Fdi6V7agysKO8EpOK10fs
         9tpS7N6ftcEy9/i4v04Zdxp0TNK8GF6Vk/PQ+XwCNp6yoH71VpgXFNH9DXYDKkV+LX
         YrPa0oJwG4QvG6opPoO8yzql29nVgpxeY4lAzUyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaesoo Lee <jalee@purestorage.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 076/115] scsi: core: set result when the command cannot be dispatched
Date:   Wed, 24 Apr 2019 19:10:12 +0200
Message-Id: <20190424170929.464119180@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
@@ -1763,8 +1763,12 @@ out_put_budget:
 			ret = BLK_STS_DEV_RESOURCE;
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


