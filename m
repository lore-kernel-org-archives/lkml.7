Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51661218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254313;
	bh=+d/9uXorA3LwCqChgcn5govOR6TUdCwEcQOU6QjJyDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AY6H9yRFuiNzEtY5UN2igiGJ7FqRZPnn+8oajlx7Mzeq2Q0Hpxe/jxMpS+5wA4Q/i
	 H1oTL6Lw9PB9LUlTYf9Ia9ws8u2L1iTuH4C5v2do9HI/ZVItUBC7e0LknJRvWLCgvh
	 KXO4FIe1Y5IsSr70XqRaPWwXI0+/XiULvHvhx/So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfCVLbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbfCVLbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:31:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D359218B0;
        Fri, 22 Mar 2019 11:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254307;
        bh=+d/9uXorA3LwCqChgcn5govOR6TUdCwEcQOU6QjJyDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhtugmKwvI6HAm5/nEErim4hK/C8BnbVEsbfdKmfOVDVxwFVBfrFt5snhh/dRE1Az
         tKoKB/4j7nnUcYjtpB2Td4dXPByIeZgYmqo7z4/yOdJTM2+CLMtXGSNr4lXePh7i9l
         Cnn2ftTrkEhkX6NcQg+jJHpcFhs90GHmr6jJKUgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lu <ming.lu@citrix.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 095/230] scsi: libfc: free skb when receiving invalid flogi resp
Date:   Fri, 22 Mar 2019 12:13:53 +0100
Message-Id: <20190322111243.278859214@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5d8fc4a9f0eec20b6c07895022a6bea3fb6dfb38 ]

The issue to be fixed in this commit is when libfc found it received a
invalid FLOGI response from FC switch, it would return without freeing the
fc frame, which is just the skb data. This would cause memory leak if FC
switch keeps sending invalid FLOGI responses.

This fix is just to make it execute `fc_frame_free(fp)` before returning
from function `fc_lport_flogi_resp`.

Signed-off-by: Ming Lu <ming.lu@citrix.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_lport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index e01a29863c38..867fc036d6ef 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -1739,14 +1739,14 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
 	    fc_frame_payload_op(fp) != ELS_LS_ACC) {
 		FC_LPORT_DBG(lport, "FLOGI not accepted or bad response\n");
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	flp = fc_frame_payload_get(fp, sizeof(*flp));
 	if (!flp) {
 		FC_LPORT_DBG(lport, "FLOGI bad response\n");
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	mfs = ntohs(flp->fl_csp.sp_bb_data) &
@@ -1756,7 +1756,7 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
 		FC_LPORT_DBG(lport, "FLOGI bad mfs:%hu response, "
 			     "lport->mfs:%hu\n", mfs, lport->mfs);
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	if (mfs <= lport->mfs) {
-- 
2.19.1



