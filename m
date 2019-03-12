Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF08EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BA42173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412311;
	bh=lh68bcRPKdHZQeuyuU7jczphxAuBmrEAqJBGAAIyetE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/BepeFzzEzbVf23aCkQ2nw+68uRvluiV+JbCroLImoe5Iy5tW+ASEDIhU679/P48
	 VMoPiGcVDXOgHGU+s0WIe6OadehNCUDARRPBN5maacsrnjcJcbpJ+3EJnhuhYb5O76
	 DefxlYGVFJFh9J2QAPGyf7Wn3Guz85vpHHO+z2+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfCLRia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbfCLRQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:32 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA10F21873;
        Tue, 12 Mar 2019 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410992;
        bh=lh68bcRPKdHZQeuyuU7jczphxAuBmrEAqJBGAAIyetE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEyK8WKrNvSEkOg2c48JOKHdJk4BmmXfsLUsiQ1npA0HhLryFo+E3N/0xwYhNg1m4
         iV8FUF+VR/tXjPhohXDRILSNT7FTL1Kge9m0QEXVVdd635dyhaZqspcfR8iHIKaRhT
         OhIz7hzMY1siDy/uCf+WTz+VONM3W5xMDwo2sef4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lu <ming.lu@citrix.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 072/135] scsi: libfc: free skb when receiving invalid flogi resp
Date:   Tue, 12 Mar 2019 10:08:39 -0700
Message-Id: <20190312170347.893928069@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 2fd0ec651170..ca7967e390f1 100644
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



