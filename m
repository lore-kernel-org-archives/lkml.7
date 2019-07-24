Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF249C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A6A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997041;
	bh=FbZbedkP++TyVHZEGVF8M9bwJy5eFHGnrq/eBQWUgCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=brUy79c6jBfhjGClnt+XmbTzB0oGzxZhAKthH5DSJC4NQ2hE+n7BwDxWZ97F+//A9
	 5mxPWtdXxgWjswNmLvxuDx+U+Fy5bNMxM//zoIO6A5kJZ2Acwci/qtrqwjpmZaZEZV
	 6HV231h2PscZ/uB8oImYra9Y2YBIxTSK2BtBE2W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbfGXThU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389433AbfGXThR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:37:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614C1214AF;
        Wed, 24 Jul 2019 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997036;
        bh=FbZbedkP++TyVHZEGVF8M9bwJy5eFHGnrq/eBQWUgCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyGPpQx0yLHcaSIozgV8bYCnHNcumsw29KPMztUKyEwcAPddXSL939PYAN2gMkv1C
         6VIr8ezy4plEhIt1Fp75ZmeLQ3hUtnOCOLWpNyJq40WouG+rka9d/88ToAWeSRc47Z
         bQn1bxuWJEia6gZSFFGSfJkLZBaJBCYTJ7DKD1ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.2 260/413] scsi: megaraid_sas: Fix calculation of target ID
Date:   Wed, 24 Jul 2019 21:19:11 +0200
Message-Id: <20190724191754.674264112@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

commit c8f96df5b8e633056b7ebf5d52a9d6fb1b156ce3 upstream.

In megasas_get_target_prop(), driver is incorrectly calculating the target
ID for devices with channel 1 and 3.  Due to this, firmware will either
fail the command (if there is no device with the target id sent from
driver) or could return the properties for a target which was not
intended.  Devices could end up with the wrong queue depth due to this.

Fix target id calculation for channel 1 and 3.

Fixes: 96188a89cc6d ("scsi: megaraid_sas: NVME interface target prop added")
Cc: stable@vger.kernel.org
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas_base.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6155,7 +6155,8 @@ megasas_get_target_prop(struct megasas_i
 	int ret;
 	struct megasas_cmd *cmd;
 	struct megasas_dcmd_frame *dcmd;
-	u16 targetId = (sdev->channel % 2) + sdev->id;
+	u16 targetId = ((sdev->channel % 2) * MEGASAS_MAX_DEV_PER_CHANNEL) +
+			sdev->id;
 
 	cmd = megasas_get_cmd(instance);
 


