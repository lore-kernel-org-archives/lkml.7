Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45016C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EB02166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519015;
	bh=b2iBoewNmDG6SQvtgQipZKZPGeAm3I9wJ4Bn3cK56kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YxpPq+eyl8Yw2zR6+PvIXWbndXk/LFeq22ouDxNiw5EV8wzIdBRWHpbbWHdT/D2xa
	 b8/qHQYuDD7oRPWGWGnL4JcozIklVbt5wW2KBIbcGovfsWt8w0mgtBZQi86m4H5dzQ
	 S8akz0eZfQeIJUtLVhHGlm3hbrpyXCI8dfvi5eFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfLPR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfLPR4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A70205ED;
        Mon, 16 Dec 2019 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519010;
        bh=b2iBoewNmDG6SQvtgQipZKZPGeAm3I9wJ4Bn3cK56kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulxb+K65Rrmy0v1sqkVhPJo/R6QRBEby70J9bMJ+y1SsYtCif2esi2qlnBSDrCKob
         uA2aqoc9dD+4iYkmowgYZvCRNKr+6cBZE9kWniLTDk5s8tlgjziD4TAZJzhrbKn8zl
         m4QwU5xLHsTghhf+zAO84WnxNqSnKhK4Or99oBp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 159/267] scsi: qla2xxx: Fix driver unload hang
Date:   Mon, 16 Dec 2019 18:48:05 +0100
Message-Id: <20191216174911.216875484@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

commit dd322b7f3efc8cda085bb60eadc4aee6324eadd8 upstream.

This patch fixes driver unload hang by removing msleep()

Fixes: d74595278f4ab ("scsi: qla2xxx: Add multiple queue pair functionality.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191105150657.8092-5-hmadhani@marvell.com
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8092,8 +8092,6 @@ int qla2xxx_delete_qpair(struct scsi_qla
 	struct qla_hw_data *ha = qpair->hw;
 
 	qpair->delete_in_progress = 1;
-	while (atomic_read(&qpair->ref_count))
-		msleep(500);
 
 	ret = qla25xx_delete_req_que(vha, qpair->req);
 	if (ret != QLA_SUCCESS)


