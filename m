Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A113AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700F5218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116978;
	bh=uu1Z6gb8Sk2Ss0S34o/PKDQPR6fLUZgWr65Mf3s/6H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvAKastiFZU6jPgh8j83sLp+3+yrqg3dRjOfuOnL/tzGJBqNkSXLGm6dcMYdkEmqs
	 MZIzDCLCtphJdE59qTdyZoHQeG7qFg/n2KAkxLcgaCZM1wW/ohamLiF53B7Plc7vBR
	 F6ThQHnuhkRTRFrzySAjiJH/eUfjHlXTwQjzGGsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfDXOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbfDXOk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F17821903;
        Wed, 24 Apr 2019 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116828;
        bh=uu1Z6gb8Sk2Ss0S34o/PKDQPR6fLUZgWr65Mf3s/6H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iktYfwQZbogP3h/rpzKTiLuj3Bi7rDf9845bUHBYtM49UmJv2/Jin6PQsnz84EVyE
         vJywAm67aSmCmrl5hcJVOZCJ5hwTPUSTY1udNzKNhhWviC/YtjiQtu/+jDJ2yCNUZ9
         T1NiVRlqYungACq/KIxlferrFBFVnteUUljTMKeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Martin Wilck <mwilck@suse.com>, Hannes Reinecke <hare@suse.de>,
        NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
        Christophe Varoqui <christophe.varoqui@opensvc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        DM ML <dm-devel@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 33/52] scsi: core: add new RDAC LENOVO/DE_Series device
Date:   Wed, 24 Apr 2019 10:38:51 -0400
Message-Id: <20190424143911.28890-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xose Vazquez Perez <xose.vazquez@gmail.com>

[ Upstream commit 1cb1d2c64e812928fe0a40b8f7e74523d0283dbe ]

Blacklist "Universal Xport" LUN. It's used for in-band storage array
management.  Also add model to the rdac dh family.

Cc: Martin Wilck <mwilck@suse.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Cc: DM ML <dm-devel@redhat.com>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Reviewed-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_devinfo.c | 1 +
 drivers/scsi/scsi_dh.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index c4cbfd07b916..a08ff3bd6310 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -238,6 +238,7 @@ static struct {
 	{"NETAPP", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"LSI", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"ENGENIO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
+	{"LENOVO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"SMSC", "USB 2 HS-CF", NULL, BLIST_SPARSELUN | BLIST_INQUIRY_36},
 	{"SONY", "CD-ROM CDU-8001", NULL, BLIST_BORKEN},
 	{"SONY", "TSL", NULL, BLIST_FORCELUN},		/* DDS3 & DDS4 autoloaders */
diff --git a/drivers/scsi/scsi_dh.c b/drivers/scsi/scsi_dh.c
index 5a58cbf3a75d..c14006ac98f9 100644
--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -75,6 +75,7 @@ static const struct scsi_dh_blist scsi_dh_blist[] = {
 	{"NETAPP", "INF-01-00",		"rdac", },
 	{"LSI", "INF-01-00",		"rdac", },
 	{"ENGENIO", "INF-01-00",	"rdac", },
+	{"LENOVO", "DE_Series",		"rdac", },
 	{NULL, NULL,			NULL },
 };
 
-- 
2.19.1

