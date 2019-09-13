Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE433C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8722C206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380510;
	bh=nGYHI6LlHQJXqXhAx49Lr4q1RWH0aq7nAU5YsjvZ58Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wa6HwlEQVQKy3qNE2c/DZT29TJjPhKya+z4OwDcpZ8xeHtcT1MR/OfhreFCyr7cgX
	 j0ZIaRy8VCI5zhL98DX3CFXxkUt0UZrAl4jwUhl8CrNaYiANtQm8gtkF5Y+Nav7r8L
	 yCCK/A2TAahFxnKakf777Yj6PRQRrnPEM/HO5Aa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389655AbfIMNPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389612AbfIMNPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:15:04 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1BA208C2;
        Fri, 13 Sep 2019 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380504;
        bh=nGYHI6LlHQJXqXhAx49Lr4q1RWH0aq7nAU5YsjvZ58Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWohwD+HO7TiGxweYrarb5WIzM0+mx09eUoISsqkNpBLygnKMZslJFyZBzJbn4UEd
         2WD6vDsBu+2FaJytHcIXllMbN4bA6ya1CbnnpmfgmN9v4iL94Lnk9jNq76UNbygO4c
         sTUk93X0u5Ma/CaB5xH5TVbydsc/04ak0Mus1U7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/190] scsi: megaraid_sas: Fix combined reply queue mode detection
Date:   Fri, 13 Sep 2019 14:05:24 +0100
Message-Id: <20190913130605.179406535@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e29c322133472628c6de85efb99ccd3b3df5571e ]

For Invader series, if FW supports more than 8 MSI-x vectors, driver needs
to enable combined reply queue mode. For Ventura series, driver enables
combined reply queue mode in case of more than 16 MSI-x vectors.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 806ceabcabc3f..b6fc7c6337610 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5325,12 +5325,29 @@ static int megasas_init_fw(struct megasas_instance *instance)
 				instance->msix_vectors = (scratch_pad_2
 					& MR_MAX_REPLY_QUEUES_OFFSET) + 1;
 				fw_msix_count = instance->msix_vectors;
-			} else { /* Invader series supports more than 8 MSI-x vectors*/
+			} else {
 				instance->msix_vectors = ((scratch_pad_2
 					& MR_MAX_REPLY_QUEUES_EXT_OFFSET)
 					>> MR_MAX_REPLY_QUEUES_EXT_OFFSET_SHIFT) + 1;
-				if (instance->msix_vectors > 16)
-					instance->msix_combined = true;
+
+				/*
+				 * For Invader series, > 8 MSI-x vectors
+				 * supported by FW/HW implies combined
+				 * reply queue mode is enabled.
+				 * For Ventura series, > 16 MSI-x vectors
+				 * supported by FW/HW implies combined
+				 * reply queue mode is enabled.
+				 */
+				switch (instance->adapter_type) {
+				case INVADER_SERIES:
+					if (instance->msix_vectors > 8)
+						instance->msix_combined = true;
+					break;
+				case VENTURA_SERIES:
+					if (instance->msix_vectors > 16)
+						instance->msix_combined = true;
+					break;
+				}
 
 				if (rdpq_enable)
 					instance->is_rdpq = (scratch_pad_2 & MR_RDPQ_MODE_OFFSET) ?
-- 
2.20.1



