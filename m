Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED00C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB29D205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370334;
	bh=Yz79+7sAzSjLRMrf7ysgedIqRniCgvKmbIzFtZu3ulo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dvt+gwafU0R6rz+NL1EjgN04hx0LCMEN3rAfbB7QbUQydRos1PHpqdONt4Jabvm/C
	 fP3hSZee/yiHTSZ8PGpDG/TjVn1xwUTn0usTAuLOuA2M4eG5BqYKIVJSKgIDN643/G
	 siY8oKRZ0EkquVjj1w9hc8i6P7e3Sef0YpRFRhSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfFXJ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbfFXJ6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:58:51 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB32205ED;
        Mon, 24 Jun 2019 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370331;
        bh=Yz79+7sAzSjLRMrf7ysgedIqRniCgvKmbIzFtZu3ulo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDUo5E1ThCv7zcbjoUi62BGWF6o9yBorTr3wsdseCdYdblHbDcrvPIFv2EjQtRY6l
         UM/xVKQMDNR/7+k59Y4i4znseloz0ZP/AIIrQad9A1HQoKCq66cz2GQbVPKX5z6ZRQ
         EQDnh4lxGFTKh/XjzEIg5979z9ZoxSzCy7mDzbd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bean Huo <beanhuo@micron.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 32/51] scsi: ufs: Check that space was properly alloced in copy_query_response
Date:   Mon, 24 Jun 2019 17:56:50 +0800
Message-Id: <20190624092310.033425650@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1c90836f70f9a8ef7b7ad9e1fdd8961903e6ced6 ]

struct ufs_dev_cmd is the main container that supports device management
commands. In the case of a read descriptor request, we assume that the
proper space was allocated in dev_cmd to hold the returning descriptor.

This is no longer true, as there are flows that doesn't use dev_cmd for
device management requests, and was wrong in the first place.

Fixes: d44a5f98bb49 (ufs: query descriptor API)
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d8f0a1ccd9b1..60c9184bad3b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1788,7 +1788,8 @@ int ufshcd_copy_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	memcpy(&query_res->upiu_res, &lrbp->ucd_rsp_ptr->qr, QUERY_OSF_SIZE);
 
 	/* Get the descriptor */
-	if (lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
+	if (hba->dev_cmd.query.descriptor &&
+	    lrbp->ucd_rsp_ptr->qr.opcode == UPIU_QUERY_OPCODE_READ_DESC) {
 		u8 *descp = (u8 *)lrbp->ucd_rsp_ptr +
 				GENERAL_UPIU_REQUEST_SIZE;
 		u16 resp_len;
-- 
2.20.1



