Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78072C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F01D208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355286;
	bh=OVPd61lh52XnKI/5MBHrjcApo0Y+YUQqhVuZpSLUWyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ye8DJWNAdNVnJXT1ozgfwQvmes0pQ1rClkKfiWFlhOlVSmQ7yWt8XpuGoVdYdkB+1
	 vKvsGHDgFYsGKTjKWl1hfSKsGMLDW8f/mEBm7F7xKiuRtv7wK82c428K8LosyKqN0T
	 w2nE9dpgSiaFGhfB9+fuyPtrjBS+0VIDToKIRc2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfKJDIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbfKJCpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:45:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7222A215EA;
        Sun, 10 Nov 2019 02:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353908;
        bh=OVPd61lh52XnKI/5MBHrjcApo0Y+YUQqhVuZpSLUWyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwqK1pR0WZxD9NyaYHi4MAZlI3XIVshGDEOhSqTO57RQtPVfVCfgizkDIMid+qF2A
         Wteg5BO+N9X1ka8gxTl2Pcnp24+eXWt5YIJYKqER2cNEPVvUGbRI+0ZxuIf58S4mTS
         LlFfhyHhGnXNWzjaX6mqhABYwJc/3LXFwiuh1MJk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 172/191] scsi: NCR5380: Check for invalid reselection target
Date:   Sat,  9 Nov 2019 21:39:54 -0500
Message-Id: <20191110024013.29782-172-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 7ef55f6744c45e3d7c85a3f74ada39b67ac741dd ]

The X3T9.2 specification (draft) says, under "6.1.4.1 RESELECTION", that "the
initiator shall not respond to a RESELECTION phase if other than two SCSI ID
bits are on the DATA BUS." This issue (too many bits set) has been observed in
the wild, so add a check.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/NCR5380.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 90136942f4882..c67f476447372 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -2008,6 +2008,11 @@ static void NCR5380_reselect(struct Scsi_Host *instance)
 	NCR5380_write(MODE_REG, MR_BASE);
 
 	target_mask = NCR5380_read(CURRENT_SCSI_DATA_REG) & ~(hostdata->id_mask);
+	if (!target_mask || target_mask & (target_mask - 1)) {
+		shost_printk(KERN_WARNING, instance,
+			     "reselect: bad target_mask 0x%02x\n", target_mask);
+		return;
+	}
 
 	dsprintk(NDEBUG_RESELECTION, instance, "reselect\n");
 
-- 
2.20.1

