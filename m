Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0583B2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498548;
	bh=wj+xJcMJnR3JBZmFiYZ/HEjkXpciWEdzBQ/fzR8JVIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdU68U/lWsxpklC0VHpWi0Pm43KTeIQlt5aG/Ro1N4lFGq9gmtirU52CAAQdLC8rv
	 wXqVUFGI1d3VFmXUoyrq9xQpPERfU9ifKXAmC6kDiRItMKoDlIV7NUapmON4ckL1Ye
	 A2dhl+iwRrwlnW74GEY7F3rp7ZoJ5aUmW06Ox4qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfKKSzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729608AbfKKSzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:55:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260692184C;
        Mon, 11 Nov 2019 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498540;
        bh=wj+xJcMJnR3JBZmFiYZ/HEjkXpciWEdzBQ/fzR8JVIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lWUC5EWEOcSGxsMP4qrBHPJqTElHlFdAn0P9SSU6DEK5aK5ULnWIVnLEj6h1xx/sh
         +2rbHTaG2vw5u5EyRdietEOWnclmsud6Se+ngM3JpsaW6OJdbhs6On/AqdVvo3fwcg
         mGlp6+SuZBGI9/1HnoloGTYHv5Iufia1lc69hEb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuliy Izrailov <yuliy.izrailov@wdc.com>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 112/193] scsi: ufs-bsg: Wake the device before sending raw upiu commands
Date:   Mon, 11 Nov 2019 19:28:14 +0100
Message-Id: <20191111181509.379427636@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avri Altman <avri.altman@wdc.com>

[ Upstream commit 74e5e468b664d3739b2872d54764af97ac38e795 ]

The scsi async probe process is calling blk_pm_runtime_init for each lun,
and then those request queues are monitored by the block layer pm
engine (blk-pm.c).  This is however, not the case for scsi-passthrough
queues, created by bsg_setup_queue().

So the ufs-bsg driver might send various commands, disregarding the pm
status of the device. This is wrong, regardless if its request queue is
pm-aware or not.

Fixes: df032bf27a41 (scsi: ufs: Add a bsg endpoint that supports UPIUs)
Link: https://lore.kernel.org/r/1570696267-8487-1-git-send-email-avri.altman@wdc.com
Reported-by: Yuliy Izrailov <yuliy.izrailov@wdc.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufs_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index a9344eb4e047f..dc2f6d2b46edc 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -98,6 +98,8 @@ static int ufs_bsg_request(struct bsg_job *job)
 
 	bsg_reply->reply_payload_rcv_len = 0;
 
+	pm_runtime_get_sync(hba->dev);
+
 	msgcode = bsg_request->msgcode;
 	switch (msgcode) {
 	case UPIU_TRANSACTION_QUERY_REQ:
@@ -135,6 +137,8 @@ static int ufs_bsg_request(struct bsg_job *job)
 		break;
 	}
 
+	pm_runtime_put_sync(hba->dev);
+
 	if (!desc_buff)
 		goto out;
 
-- 
2.20.1



