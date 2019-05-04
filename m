Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01017C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2AB205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 16:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfEDQkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 12:40:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39367 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfEDQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 12:40:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hMxhq-0005VN-WA; Sat, 04 May 2019 16:40:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mptsas:  fix undefined behaviour of a shift of an int by more than 31 places
Date:   Sat,  4 May 2019 17:40:10 +0100
Message-Id: <20190504164010.24937-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the shift of int value 1 by more than 31 places can result
in undefined behaviour. Fix this by making the 1 a ULL value before the
shift operation.

Addresses-Coverity: ("Bad shift operation")
Fixes: 547f9a218436 ("[SCSI] mptsas: wide port support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/message/fusion/mptsas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 6a79cd0ebe2b..51dcbbcf2518 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -854,7 +854,7 @@ mptsas_setup_wide_ports(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info)
 		    "%s: [%p]: deleting phy = %d\n",
 		    ioc->name, __func__, port_details, i));
 		port_details->num_phys--;
-		port_details->phy_bitmask &= ~ (1 << phy_info->phy_id);
+		port_details->phy_bitmask &= ~(1ULL << phy_info->phy_id);
 		memset(&phy_info->attached, 0, sizeof(struct mptsas_devinfo));
 		if (phy_info->phy) {
 			devtprintk(ioc, dev_printk(KERN_DEBUG,
@@ -889,7 +889,7 @@ mptsas_setup_wide_ports(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info)
 			port_details->port_info = port_info;
 			if (phy_info->phy_id < 64 )
 				port_details->phy_bitmask |=
-				    (1 << phy_info->phy_id);
+				    (1ULL << phy_info->phy_id);
 			phy_info->sas_port_add_phy=1;
 			dsaswideprintk(ioc, printk(MYIOC_s_DEBUG_FMT "\t\tForming port\n\t\t"
 			    "phy_id=%d sas_address=0x%018llX\n",
@@ -931,7 +931,7 @@ mptsas_setup_wide_ports(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info)
 			phy_info_cmp->port_details = port_details;
 			if (phy_info_cmp->phy_id < 64 )
 				port_details->phy_bitmask |=
-				(1 << phy_info_cmp->phy_id);
+				(1ULL << phy_info_cmp->phy_id);
 			port_details->num_phys++;
 		}
 	}
-- 
2.20.1

