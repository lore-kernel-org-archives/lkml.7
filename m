Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD5206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521762;
	bh=AS7vz4AG6dDOpzOWr7bFy+qNqjjjnghZQo+IX8vYMJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJZ0U/Y69Pd0uzrxK03Fa8me0SF9Eekpe2W3QH8rdYu4vpWKEkETkWGMV2c859pVe
	 plsdj9m4sEj7Qis/z890OmTRq0DK/PzTiUomErexN2KX7HvvM6rPYXEJ9tBM3W+L7c
	 DM4ZWwB1U5KBNgeKnJYy11myhimwGRLUi5/EK9z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfLPSml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfLPSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDE3206EC;
        Mon, 16 Dec 2019 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519214;
        bh=AS7vz4AG6dDOpzOWr7bFy+qNqjjjnghZQo+IX8vYMJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYLSGOYoMibt5KOzjAgvkIZGtTCnaSpL9CGLRODoyUe2PbTkDZ9cj1HwITMUa1bO0
         aGY85Qgixdz3yXC/dWNCdV3GVWC+g9AyxjvaC1tb3N/qyGkyt0Vtz65UTg5UBduMO8
         S5E64ehCq7S/f1AP3sNiLk3anP8UH+4WWMK0V5OM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himanshu Madhani <hmadhani@marvell.com>,
        "Ewan D. Milne" <emilne@redhat.com>, Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 243/267] scsi: qla2xxx: Fix message indicating vectors used by driver
Date:   Mon, 16 Dec 2019 18:49:29 +0100
Message-Id: <20191216174915.865473186@linuxfoundation.org>
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

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit da48b82425b8bf999fb9f7c220e967c4d661b5f8 ]

This patch updates log message which indicates number of vectors used by
the driver instead of displaying failure to get maximum requested
vectors. Driver will always request maximum vectors during
initialization. In the event driver is not able to get maximum requested
vectors, it will adjust the allocated vectors. This is normal and does not
imply failure in driver.

Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Link: https://lore.kernel.org/r/20190830222402.23688-2-hmadhani@marvell.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 6a76d72175154..ebca1a470e9bc 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3369,10 +3369,8 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 		    ha->msix_count, ret);
 		goto msix_out;
 	} else if (ret < ha->msix_count) {
-		ql_log(ql_log_warn, vha, 0x00c6,
-		    "MSI-X: Failed to enable support "
-		     "with %d vectors, using %d vectors.\n",
-		    ha->msix_count, ret);
+		ql_log(ql_log_info, vha, 0x00c6,
+		    "MSI-X: Using %d vectors\n", ret);
 		ha->msix_count = ret;
 		/* Recalculate queue values */
 		if (ha->mqiobase && ql2xmqsupport) {
-- 
2.20.1



