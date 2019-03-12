Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADCFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58992087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413189;
	bh=KERUesxjIRFQNfRMcRgWGAskze/m4Cdvo8aRheYXcMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pNyp8Fewr+oALxdDwRN/kn4VTMzB71J0aOX7ZclF3KMcmKpBW+Lua24OtXQKsJf1H
	 GQQwv8PCk9nid1D6WMevlmolZHYa47LHEEYF9aPxPKxY8210mWLmhY0sVbR1Qwgezd
	 C2Pv9RqtHlwLHGmjL7Hz7xwO7AkV2YO6c6GfNJh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfCLRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfCLROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:22 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDA4A2173C;
        Tue, 12 Mar 2019 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410861;
        bh=KERUesxjIRFQNfRMcRgWGAskze/m4Cdvo8aRheYXcMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMTFk8q+7qLrOBBHhoyqBInhKCL1SXRu/NYXbV1jAnGRs+fDWsNnbXL2aUMPtGLNf
         aGsD17dbzRWH8OytuLytGV1RtoRoHNKTc0tTJNybkKBYwJYO/GgfdcN8UZ62o8Jogf
         o5h4HWlPEgWrFwuwlDf3JodFbHmiylzGJgZmtbE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lu <ming.lu@citrix.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/149] scsi: libfc: free skb when receiving invalid flogi resp
Date:   Tue, 12 Mar 2019 10:07:38 -0700
Message-Id: <20190312170353.097794983@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index be83590ed955..ff943f477d6f 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -1726,14 +1726,14 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
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
@@ -1743,7 +1743,7 @@ void fc_lport_flogi_resp(struct fc_seq *sp, struct fc_frame *fp,
 		FC_LPORT_DBG(lport, "FLOGI bad mfs:%hu response, "
 			     "lport->mfs:%hu\n", mfs, lport->mfs);
 		fc_lport_error(lport, fp);
-		goto err;
+		goto out;
 	}
 
 	if (mfs <= lport->mfs) {
-- 
2.19.1



