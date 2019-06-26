Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F820C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27918208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="TjN/sMb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfFZHg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:36:59 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:40471 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfFZHg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:36:59 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZbt0RPDz8tZk;
        Wed, 26 Jun 2019 09:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561534618; bh=JoSWxQI8TrFLVkUAqTNzLN0P0y/aMOvhLol7DAFb8RY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=TjN/sMb1CN6B3ECARo0tOBC8ZpHXUGNI+o0NPlHAcz+xQRbHjXSMRsgrwe5gupBLo
         6PCv2ep68tjnQSYLY+UTzFciTrAO7fhh7tqsbp/kLhpwpyEtxpiXCKXnSEhmavRUEA
         n2ktSqFOUHrRMSO1EVMs0Arj6mx9xWWVP/6yCIC52U2GmeSNqYX6s7wVADkodOLSFh
         uLzm5raZrEqf5ZvPJNUF2mM3nAm5r3k8OCALXozEgjTUn+6UsgFhVWPv8RIzoV2/nq
         VESSkZYfUYEWVv9/5y638I0toLuceyF6ZsSbcYRublHbFs64lQ2RAOyKJXUMP9Su2z
         mKghtIgjDWSDw==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45YZbp6HYdz8t3Y;
        Wed, 26 Jun 2019 09:36:54 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 26 Jun 2019
 09:36:23 +0200
Received: from TroubleWorld.fritz.box (95.90.221.207) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Wed, 26 Jun 2019 09:36:22 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        <linux-kernel@i4.cs.fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] staging: kpc2000: introduce 'unsigned int'
Date:   Wed, 26 Jun 2019 09:35:24 +0200
Message-ID: <20190626073531.8946-7-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626073531.8946-1-fabian.krueger@fau.de>
References: <20190625115251.GA28859@kadam>
 <20190626073531.8946-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.90.221.207]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced 'unsigned' with it's equivalent 'unsigned int' to reduce
confusion while reading the code.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index d5b4bd7b2ea7..eeb36d78402e 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -308,7 +308,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 	list_for_each_entry(transfer, &m->transfers, transfer_list) {
 		const void *tx_buf = transfer->tx_buf;
 		void       *rx_buf = transfer->rx_buf;
-		unsigned    len = transfer->len;
+		unsigned int len = transfer->len;
 
 		if (transfer->speed_hz > KP_SPI_CLK ||
 		    (len && !(rx_buf || tx_buf))) {
@@ -354,7 +354,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
 		/* transfer */
 		if (transfer->len) {
 			unsigned int word_len = spidev->bits_per_word;
-			unsigned count;
+			unsigned int count;
 
 			/* set up the transfer... */
 			sc.reg = kp_spi_read_reg(cs, KP_SPI_REG_CONFIG);
-- 
2.17.1

