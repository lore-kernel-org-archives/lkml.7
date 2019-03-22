Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF7F2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255508;
	bh=R757zrOngD58ypHyvCyMUJ1Hu6/kVQQkmkOUvCUeBUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NwwtoAER4jaeH5SMjxalT1ot3RNJ1tdEyCEdKqqWeTL8MrHzAn9Okv1LhrGR7+8G9
	 ki9Qtpqw9wlpEoZQqVravrfAEz1LbUDkxaApgGXLmrCwzQDgEn9ndJWew+mqBPFZmX
	 cwI+nv4T+PyZ3suPdDEN3lCdv08/EVhe2YpAtDWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfCVLvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbfCVLvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:51:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980C120693;
        Fri, 22 Mar 2019 11:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255505;
        bh=R757zrOngD58ypHyvCyMUJ1Hu6/kVQQkmkOUvCUeBUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0iRsxjgmlQyuC8VGdQ9MfuM+PgT1nm9ZC6VAKUtLzq3GgQQZf/GUDyzMraCLHEfv3
         2/i5MIUZkUYEV+F/Iaj9qJbC/T+hz/5B8lU23USIAqcSxilLpRkY5FyGDmeyUJmj7J
         wySIzoepO5nZwFKNnmuT4bAL4SxRXSqccUnh9178=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sagar Biradar <Sagar.Biradar@microchip.com>,
        Dave Carroll <david.carroll@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 096/183] scsi: aacraid: Fix performance issue on logical drives
Date:   Fri, 22 Mar 2019 12:15:24 +0100
Message-Id: <20190322111248.661783278@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

From: Sagar Biradar <sagar.biradar@microchip.com>

commit 0015437cc046e5ec2b57b00ff8312b8d432eac7c upstream.

Fix performance issue where the queue depth for SmartIOC logical volumes is
set to 1, and allow the usual logical volume code to be executed

Fixes: a052865fe287 (aacraid: Set correct Queue Depth for HBA1000 RAW disks)
Cc: stable@vger.kernel.org
Signed-off-by: Sagar Biradar <Sagar.Biradar@microchip.com>
Reviewed-by: Dave Carroll <david.carroll@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/aacraid/linit.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -413,13 +413,16 @@ static int aac_slave_configure(struct sc
 	if (chn < AAC_MAX_BUSES && tid < AAC_MAX_TARGETS && aac->sa_firmware) {
 		devtype = aac->hba_map[chn][tid].devtype;
 
-		if (devtype == AAC_DEVTYPE_NATIVE_RAW)
+		if (devtype == AAC_DEVTYPE_NATIVE_RAW) {
 			depth = aac->hba_map[chn][tid].qd_limit;
-		else if (devtype == AAC_DEVTYPE_ARC_RAW)
+			set_timeout = 1;
+			goto common_config;
+		}
+		if (devtype == AAC_DEVTYPE_ARC_RAW) {
 			set_qd_dev_type = true;
-
-		set_timeout = 1;
-		goto common_config;
+			set_timeout = 1;
+			goto common_config;
+		}
 	}
 
 	if (aac->jbod && (sdev->type == TYPE_DISK))


