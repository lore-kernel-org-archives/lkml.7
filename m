Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F75FC31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F92184D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="EjLlQE4P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="G2dVBLpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFNWYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 18:24:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46750 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfFNWYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 18:24:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1EB3C8EE147;
        Fri, 14 Jun 2019 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560551045;
        bh=7IkzCl5xuesXjn4kt8C9Xue+PKpF+HaeTeLvv0akPX8=;
        h=Subject:From:To:Cc:Date:From;
        b=EjLlQE4PEOVec8zihsgV/qNJN+U/EnAa5yHCF5eFMIBCRKJVd5EB1zihEzzRJI96f
         BzsnzZDRD0PFZ8uuVTSIFBPrM7Vm/cGh1gzWH2Z9XzQHSMsBufklenIKdHu3JJNV/f
         D/tOnaSXeAnY8w5gGuE7k7HISKzVI9bGBAMKBSaE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eqTXls4_4FLu; Fri, 14 Jun 2019 15:24:05 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A758F8EE134;
        Fri, 14 Jun 2019 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1560551044;
        bh=7IkzCl5xuesXjn4kt8C9Xue+PKpF+HaeTeLvv0akPX8=;
        h=Subject:From:To:Cc:Date:From;
        b=G2dVBLpwI9+wqT2dxWGEKnfaTTJvlvzw+zdy4AmVn9G7pNiATWg+ypGsh1OnZvaqp
         DIyAhPA18XF9Nt0D380NIb6EQaor4rKFsYUzhcFIJbUrv5GgtIHn63jpSr1gz/6Ubt
         cK2Xf/prhNWiiU7xu/P4xx1Lxl8pdXddnI7biPRY=
Message-ID: <1560551043.27102.99.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.2-rc4
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jun 2019 15:24:03 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single bug fix for hpsa.  The user visible consequences aren't clear,
but the ioaccel2 raid acceleration may misfire on the malformed request
assuming the payload is big enough to require chaining (more than 31 sg
entries).

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Don Brace (1):
      scsi: hpsa: correct ioaccel2 chaining

And the diffstat:

 drivers/scsi/hpsa.c     | 7 ++++++-
 drivers/scsi/hpsa_cmd.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 1bef1da273c2..8068520cf89e 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -4940,7 +4940,7 @@ static int hpsa_scsi_ioaccel2_queue_command(struct ctlr_info *h,
 			curr_sg->reserved[0] = 0;
 			curr_sg->reserved[1] = 0;
 			curr_sg->reserved[2] = 0;
-			curr_sg->chain_indicator = 0x80;
+			curr_sg->chain_indicator = IOACCEL2_CHAIN;
 
 			curr_sg = h->ioaccel2_cmd_sg_list[c->cmdindex];
 		}
@@ -4957,6 +4957,11 @@ static int hpsa_scsi_ioaccel2_queue_command(struct ctlr_info *h,
 			curr_sg++;
 		}
 
+		/*
+		 * Set the last s/g element bit
+		 */
+		(curr_sg - 1)->chain_indicator = IOACCEL2_LAST_SG;
+
 		switch (cmd->sc_data_direction) {
 		case DMA_TO_DEVICE:
 			cp->direction &= ~IOACCEL2_DIRECTION_MASK;
diff --git a/drivers/scsi/hpsa_cmd.h b/drivers/scsi/hpsa_cmd.h
index 21a726e2eec6..f6afca4b2319 100644
--- a/drivers/scsi/hpsa_cmd.h
+++ b/drivers/scsi/hpsa_cmd.h
@@ -517,6 +517,7 @@ struct ioaccel2_sg_element {
 	u8 reserved[3];
 	u8 chain_indicator;
 #define IOACCEL2_CHAIN 0x80
+#define IOACCEL2_LAST_SG 0x40
 };
 
 /*
