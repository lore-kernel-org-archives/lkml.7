Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91C5C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1AB21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003710;
	bh=M5uc/v81DuSZATN2cUl2Qdb7TKwsn7SAGqthCt4e2JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iU+NZXb672Hk19OkGmjXCAZPqZZnG4vRzVt2buZWdIkg/0Ix3suVczXAA/1DjxyDf
	 sM/30SrbAoRoXLe9bB2/EekAlk3vjmPOZ13FoptOsIBsvKlvzHXNTKpKlLHwi0tL7F
	 YnZOVJcWypYaYSVLtG/C9jhl/DwYzd+75YvIrXb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgABWVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgABWVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:21:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C4420863;
        Thu,  2 Jan 2020 22:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003701;
        bh=M5uc/v81DuSZATN2cUl2Qdb7TKwsn7SAGqthCt4e2JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdh/BiVgWZrJp9oMUOBjyp82EpkZ69qAzOQH2qdLBBzApRhH9o3NNgg5Wx5PjYdZ3
         Gi0MwJA+k2BYd7TGWhUbXmruO8KfcksbpKYnZSCFQjj1jBD61A0+NbTQSgD++XhUAh
         N1+NA1Bq73//lGlZo61ow+tCzvHqm0SaUtdQcizA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/114] scsi: NCR5380: Add disconnect_mask module parameter
Date:   Thu,  2 Jan 2020 23:07:07 +0100
Message-Id: <20200102220034.604993039@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220029.183913184@linuxfoundation.org>
References: <20200102220029.183913184@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 0b7a223552d455bcfba6fb9cfc5eef2b5fce1491 ]

Add a module parameter to inhibit disconnect/reselect for individual
targets. This gains compatibility with Aztec PowerMonster SCSI/SATA
adapters with buggy firmware. (No fix is available from the vendor.)

Apparently these adapters pass-through the product/vendor of the attached
SATA device. Since they can't be identified from the response to an INQUIRY
command, a device blacklist flag won't work.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Link: https://lore.kernel.org/r/993b17545990f31f9fa5a98202b51102a68e7594.1573875417.git.fthain@telegraphics.com.au
Reviewed-and-tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/NCR5380.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 8ec68dcc0cc4..95a3e3bf2b43 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -129,6 +129,9 @@
 #define NCR5380_release_dma_irq(x)
 #endif
 
+static unsigned int disconnect_mask = ~0;
+module_param(disconnect_mask, int, 0444);
+
 static int do_abort(struct Scsi_Host *);
 static void do_reset(struct Scsi_Host *);
 static void bus_reset_cleanup(struct Scsi_Host *);
@@ -946,7 +949,8 @@ static bool NCR5380_select(struct Scsi_Host *instance, struct scsi_cmnd *cmd)
 	int err;
 	bool ret = true;
 	bool can_disconnect = instance->irq != NO_IRQ &&
-			      cmd->cmnd[0] != REQUEST_SENSE;
+			      cmd->cmnd[0] != REQUEST_SENSE &&
+			      (disconnect_mask & BIT(scmd_id(cmd)));
 
 	NCR5380_dprint(NDEBUG_ARBITRATION, instance);
 	dsprintk(NDEBUG_ARBITRATION, instance, "starting arbitration, id = %d\n",
-- 
2.20.1



