Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF04FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271AD20656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240854;
	bh=9FLjLiH7v5XHJHv+NXNnLPQ7INHN9b6L2M7gM2XWXIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WT5FjtUlWHcMbME8dGqWZ0OvIYfHf3LwZ9W7wErNw0YH9jUOWrIZj7c46ZfGEH6x8
	 bGn0NEcARrx5xHcdHMQrK2oO4fo6233IfR9gRaC4S0rV2lcPTsqqlqyWaSsbWbl45R
	 qiS26KC4rIvwGHhsyXimOvN+tbnW9jZExWA3Df9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbfKHTUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389367AbfKHTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64F3222CE;
        Fri,  8 Nov 2019 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239470;
        bh=9FLjLiH7v5XHJHv+NXNnLPQ7INHN9b6L2M7gM2XWXIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0C76ROC0Gc5LwPww+1vM1ezykap3b1SfVFXiZLl30/OVFZDM+D1J7Pvp7Alew8kQ
         9GFappxg5+No7jC/Nz7Zigh6AZl4YXOLjrf3t/ZJTndokKNJ3twYqGE9MuJoz0JyAY
         BXgWFCGQxgdOwa+K59FRpA8uPkNhqK7ohjLnt4WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bodo Stroesser <bstroesser@ts.fujitsu.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/62] scsi: target: core: Do not overwrite CDB byte 1
Date:   Fri,  8 Nov 2019 19:50:04 +0100
Message-Id: <20191108174733.613259615@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@ts.fujitsu.com>

[ Upstream commit 27e84243cb63601a10e366afe3e2d05bb03c1cb5 ]

passthrough_parse_cdb() - used by TCMU and PSCSI - attepts to reset the LUN
field of SCSI-2 CDBs (bits 5,6,7 of byte 1).  The current code is wrong as
for newer commands not having the LUN field it overwrites relevant command
bits (e.g. for SECURITY PROTOCOL IN / OUT). We think this code was
unnecessary from the beginning or at least it is no longer useful. So we
remove it entirely.

Link: https://lore.kernel.org/r/12498eab-76fd-eaad-1316-c2827badb76a@ts.fujitsu.com
Signed-off-by: Bodo Stroesser <bstroesser@ts.fujitsu.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 84742125f7730..92b52d2314b53 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -1151,27 +1151,6 @@ passthrough_parse_cdb(struct se_cmd *cmd,
 	struct se_device *dev = cmd->se_dev;
 	unsigned int size;
 
-	/*
-	 * Clear a lun set in the cdb if the initiator talking to use spoke
-	 * and old standards version, as we can't assume the underlying device
-	 * won't choke up on it.
-	 */
-	switch (cdb[0]) {
-	case READ_10: /* SBC - RDProtect */
-	case READ_12: /* SBC - RDProtect */
-	case READ_16: /* SBC - RDProtect */
-	case SEND_DIAGNOSTIC: /* SPC - SELF-TEST Code */
-	case VERIFY: /* SBC - VRProtect */
-	case VERIFY_16: /* SBC - VRProtect */
-	case WRITE_VERIFY: /* SBC - VRProtect */
-	case WRITE_VERIFY_12: /* SBC - VRProtect */
-	case MAINTENANCE_IN: /* SPC - Parameter Data Format for SA RTPG */
-		break;
-	default:
-		cdb[1] &= 0x1f; /* clear logical unit number */
-		break;
-	}
-
 	/*
 	 * For REPORT LUNS we always need to emulate the response, for everything
 	 * else, pass it up.
-- 
2.20.1



