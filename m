Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71941C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A3223400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494665;
	bh=JL+SNRjKrSzVY2bQH0EbSdf5BZ9LDIz2h6lVziuKeSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4CXXYA1nPI9i1WfOpHpiklrPb2GB+adbfUkzf360fY0PDxlJ4IWBVw0P7aWvPc8j
	 5RAjbcJcRfWi62zs+qE3JPPuOz0B8e7+8vEVepSFDaIjuxikblQ9GpBaDVZoL71HSi
	 njwBAkCpBNXkN9OAySXZzfyNtC0f5DA47nr0m6ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfHVRYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391778AbfHVRYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:24:00 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8FE23402;
        Thu, 22 Aug 2019 17:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494639;
        bh=JL+SNRjKrSzVY2bQH0EbSdf5BZ9LDIz2h6lVziuKeSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Il1uN3WgqlnC1jk1fn5cS7TVrKuzkxY3PqL7hDYjIjV9QfiKjGPAYLMqPLYABdW43
         dR6MubmUkCdDfZOa4RwrOXl9xRYdiPhZwFUOHoYJ5Tqi0jemvn+2CuwgK9k1JFkzo8
         5DKRTRcmvn7SW04ccQHIuBJSZUaJfgcIcHbFV2oU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bader Ali - Saleh <bader.alisaleh@microsemi.com>,
        Scott Teel <scott.teel@microsemi.com>,
        Scott Benesh <scott.benesh@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 073/103] scsi: hpsa: correct scsi command status issue after reset
Date:   Thu, 22 Aug 2019 10:19:01 -0700
Message-Id: <20190822171731.867363725@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit eeebce1862970653cdf5c01e98bc669edd8f529a ]

Reviewed-by: Bader Ali - Saleh <bader.alisaleh@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hpsa.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 9f98c7211ec24..b82df8cdf9626 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -2236,6 +2236,8 @@ static int handle_ioaccel_mode2_error(struct ctlr_info *h,
 	case IOACCEL2_SERV_RESPONSE_COMPLETE:
 		switch (c2->error_data.status) {
 		case IOACCEL2_STATUS_SR_TASK_COMP_GOOD:
+			if (cmd)
+				cmd->result = 0;
 			break;
 		case IOACCEL2_STATUS_SR_TASK_COMP_CHK_COND:
 			cmd->result |= SAM_STAT_CHECK_CONDITION;
@@ -2423,8 +2425,10 @@ static void process_ioaccel2_completion(struct ctlr_info *h,
 
 	/* check for good status */
 	if (likely(c2->error_data.serv_response == 0 &&
-			c2->error_data.status == 0))
+			c2->error_data.status == 0)) {
+		cmd->result = 0;
 		return hpsa_cmd_free_and_done(h, c, cmd);
+	}
 
 	/*
 	 * Any RAID offload error results in retry which will use
@@ -5511,6 +5515,12 @@ static int hpsa_scsi_queue_command(struct Scsi_Host *sh, struct scsi_cmnd *cmd)
 	}
 	c = cmd_tagged_alloc(h, cmd);
 
+	/*
+	 * This is necessary because the SML doesn't zero out this field during
+	 * error recovery.
+	 */
+	cmd->result = 0;
+
 	/*
 	 * Call alternate submit routine for I/O accelerated commands.
 	 * Retries always go down the normal I/O path.
-- 
2.20.1



