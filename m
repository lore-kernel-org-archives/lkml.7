Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86088C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 06:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4137D2089E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 06:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MjpFofPR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MjpFofPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfFHGFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 02:05:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48882 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbfFHGFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 02:05:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 79BC98EE1D3;
        Fri,  7 Jun 2019 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1559973928;
        bh=nmFZNz2iwxicEerEssWBw2rYb/T5nbp1tsHl2DZlBdM=;
        h=Subject:From:To:Cc:Date:From;
        b=MjpFofPR70nAqkXjae/sueoarbReb64g/8UbVRMOKrTZ0BiHdr7YPkq4iY7yoF0Ma
         w0Rx8kSnYpXE3pqYCszlqH1VENHdvVsZDRnEW3sygf+Zbwf9KsImZszl72CKHNQVTy
         HZKkviwjSSzJKCuFSErgWPg+2jYmcNPrfztmG6Mg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IHYPgG0iQoQO; Fri,  7 Jun 2019 23:05:28 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D188E8EE0EF;
        Fri,  7 Jun 2019 23:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1559973928;
        bh=nmFZNz2iwxicEerEssWBw2rYb/T5nbp1tsHl2DZlBdM=;
        h=Subject:From:To:Cc:Date:From;
        b=MjpFofPR70nAqkXjae/sueoarbReb64g/8UbVRMOKrTZ0BiHdr7YPkq4iY7yoF0Ma
         w0Rx8kSnYpXE3pqYCszlqH1VENHdvVsZDRnEW3sygf+Zbwf9KsImZszl72CKHNQVTy
         HZKkviwjSSzJKCuFSErgWPg+2jYmcNPrfztmG6Mg=
Message-ID: <1559973926.2787.5.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.2-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 07 Jun 2019 23:05:26 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two bug fixes, both for fairly serious problems; the UFS one looks like
it could be used to exfiltrate data from the kernel, although probably
only a privileged user has access to the command management interface
and the missing unlock in smartpqi is long standing and probably a
little used error path.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Avri Altman (1):
      scsi: ufs: Check that space was properly alloced in copy_query_response

Dan Carpenter (1):
      scsi: smartpqi: unlock on error in pqi_submit_raid_request_synchronous()

And the diffstat:

 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++++--
 drivers/scsi/ufs/ufshcd.c             | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index d6be4e8f4a8f..8fd5ffc55792 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -4046,8 +4046,10 @@ static int pqi_submit_raid_request_synchronous(struct pqi_ctrl_info *ctrl_info,
 				return -ETIMEDOUT;
 			msecs_blocked =
 				jiffies_to_msecs(jiffies - start_jiffies);
-			if (msecs_blocked >= timeout_msecs)
-				return -ETIMEDOUT;
+			if (msecs_blocked >= timeout_msecs) {
+				rc = -ETIMEDOUT;
+				goto out;
+			}
 			timeout_msecs -= msecs_blocked;
 		}
 	}
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8c1c551f2b42..3fe3029617a8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1917,7 +1917,8 @@ int ufshcd_copy_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	memcpy(&query_res->upiu_res, &lrbp->ucd_rsp_ptr->qr, QUERY_OSF_SIZE);
 
 	/* Get the descriptor */
-	if (lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
+	if (hba->dev_cmd.query.descriptor &&
+	    lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
 		u8 *descp = (u8 *)lrbp->ucd_rsp_ptr +
 				GENERAL_UPIU_REQUEST_SIZE;
 		u16 resp_len;
