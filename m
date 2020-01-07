Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EFAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37387214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431069;
	bh=uC+QLzBMiSo2zy/Qp/KYlZZxIGvBdlhLhbjUGsv0+uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zaWP2nxlg1gb+gPOWrJtknznks3Uzap33mJSmoZsI4Lrltmzed3nnqvQvfxcnTr9N
	 oN5WRfYM+xtD7ZxGuRIdfn1wgEObfwj+p7INl904b4fHNp+wCIp0lR16dJGpfSId4t
	 4/+TAJO4bA/zOFiJ3xXG4v9x0SqV0VJv2oyWaiGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgAGVE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbgAGVEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:04:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04AE820880;
        Tue,  7 Jan 2020 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431063;
        bh=uC+QLzBMiSo2zy/Qp/KYlZZxIGvBdlhLhbjUGsv0+uY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wn2zMSV0k8JXjqyUGB3yQYdZOspqo7NnFCOjhvi3YkZMXtXRIg+BTN0jT/wq62H5T
         DKkJ11Lf9YY80lMCsZL7NzM1gtYH8c/40LO6pSZwh1mcxiKZKy8G3JCbRmlbQiHMbt
         xDlJtI0oWYpVYaZKEo9bBIoRFWz5puZ75VcELeh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krishna Kant <krishna.kant@purestorage.com>,
        Alexei Potashnik <alexei@purestorage.com>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Hannes Reinecke <hare@suse.de>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/115] scsi: qla2xxx: Send Notify ACK after N2N PLOGI
Date:   Tue,  7 Jan 2020 21:53:49 +0100
Message-Id: <20200107205253.870588539@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Bolshakov <r.bolshakov@yadro.com>

[ Upstream commit 5e6b01d84b9d20bcd77fc7c4733a2a4149bf220a ]

qlt_handle_login schedules session for deletion even if a login is in
progress. That causes login bouncing, i.e. a few logins are made before it
settles down.

Complete the first login by sending Notify Acknowledge IOCB via
qlt_plogi_ack_unref if the session is pending login completion.

Fixes: 9cd883f07a54 ("scsi: qla2xxx: Fix session cleanup for N2N")
Cc: Krishna Kant <krishna.kant@purestorage.com>
Cc: Alexei Potashnik <alexei@purestorage.com>
Link: https://lore.kernel.org/r/20191125165702.1013-11-r.bolshakov@yadro.com
Acked-by: Quinn Tran <qutran@marvell.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_target.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 8eda55e917e0..e9545411ec5a 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4779,6 +4779,7 @@ static int qlt_handle_login(struct scsi_qla_host *vha,
 
 	switch (sess->disc_state) {
 	case DSC_DELETED:
+	case DSC_LOGIN_PEND:
 		qlt_plogi_ack_unref(vha, pla);
 		break;
 
-- 
2.20.1



