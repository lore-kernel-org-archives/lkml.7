Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433172087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155325;
	bh=ksd2GxFaR8I8MVeWhGJ40R65aUuMdI4nHDD1YSmkOkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YeYF9uWcW1KNRc3K1kpbfCzsOVL3MBzAP9myqhksi9BTdL6En92cWKg3vPBPTs5T1
	 FXol2GQoe7e7qnkd8hgilVTzX+zp7QwpLVGpZTFlomEH/ASY0dpMN+gugIQhZXMwwr
	 wdcCjKikvE4TbdGTPqHu03FOv13pcUZRla9GJZFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfEFPIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfEFOgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEFC20C01;
        Mon,  6 May 2019 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153370;
        bh=ksd2GxFaR8I8MVeWhGJ40R65aUuMdI4nHDD1YSmkOkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZHriexZkGAqFUifdd+l5V/JS+vNrEDC9F6Ik0Qw/4iU80ue0ZXPvZVXGaAuBeLMZ
         qm1l9HQoOukQ2BSk7nPQz1Ksbyr2FEVpwPsOSAJbBUsyhJAEZKN+Gw5PPITaOm8NSf
         U7RX5/dM6z7q9M6RGI5v56O5w2wyEd4WDCKOUZeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>,
        Christophe Varoqui <christophe.varoqui@opensvc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        DM ML <dm-devel@redhat.com>,
        Xose Vazquez Perez <xose.vazquez@gmail.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 063/122] scsi: core: add new RDAC LENOVO/DE_Series device
Date:   Mon,  6 May 2019 16:32:01 +0200
Message-Id: <20190506143100.615679234@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
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
2.20.1



