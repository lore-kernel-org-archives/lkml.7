Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C97C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E792339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567619837;
	bh=kU7T7boB3lu4ouiTS0fzoSs8WN5eNdV+uh7JZCbDeIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMZ7Uk20MbaaZEme0k40nK7LXfm59iGuNDcPLeGy5f3iPa33p04lg7dhaKbZXn3j8
	 8ImBElPMGXaleBQCxP2+3EQcCPDrzKxpwKMhHifeNs82TohlPS+5+DUi/YXDvjCbZ+
	 xN36ll4ZoRYRgtBuToumZNpHEPvc+Iy+hHQ/b0bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfIDR5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732466AbfIDR5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:57:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA03A2339E;
        Wed,  4 Sep 2019 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567619833;
        bh=kU7T7boB3lu4ouiTS0fzoSs8WN5eNdV+uh7JZCbDeIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y8LoiPnTF7tW3GvXkN95JZr4bEmyrGmf+36KXJvb6zGDciyfXD78rncEZBYtM74bD
         PM9lDHm0Yos2cb3HnlT1HAmqQu2zf/qL58RV7cZ+1fyXbtP+YT2hFlq/+FiNcJ0mgE
         GBrnMMg9jhLTNuMQbMy7+iw2qmmbwpnuXuwiOTj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 50/77] scsi: ufs: Fix NULL pointer dereference in ufshcd_config_vreg_hpm()
Date:   Wed,  4 Sep 2019 19:53:37 +0200
Message-Id: <20190904175308.160671194@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175303.317468926@linuxfoundation.org>
References: <20190904175303.317468926@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7c7cfdcf7f1777c7376fc9a239980de04b6b5ea1 ]

Fix the following BUG:

  [ 187.065689] BUG: kernel NULL pointer dereference, address: 000000000000001c
  [ 187.065790] RIP: 0010:ufshcd_vreg_set_hpm+0x3c/0x110 [ufshcd_core]
  [ 187.065938] Call Trace:
  [ 187.065959] ufshcd_resume+0x72/0x290 [ufshcd_core]
  [ 187.065980] ufshcd_system_resume+0x54/0x140 [ufshcd_core]
  [ 187.065993] ? pci_pm_restore+0xb0/0xb0
  [ 187.066005] ufshcd_pci_resume+0x15/0x20 [ufshcd_pci]
  [ 187.066017] pci_pm_thaw+0x4c/0x90
  [ 187.066030] dpm_run_callback+0x5b/0x150
  [ 187.066043] device_resume+0x11b/0x220

Voltage regulators are optional, so functions must check they exist
before dereferencing.

Note this issue is hidden if CONFIG_REGULATORS is not set, because the
offending code is optimised away.

Notes for stable:

The issue first appears in commit 57d104c153d3 ("ufs: add UFS power
management support") but is inadvertently fixed in commit 60f0187031c0
("scsi: ufs: disable vccq if it's not needed by UFS device") which in
turn was reverted by commit 730679817d83 ("Revert "scsi: ufs: disable vccq
if it's not needed by UFS device""). So fix applies v3.18 to v4.5 and
v5.1+

Fixes: 57d104c153d3 ("ufs: add UFS power management support")
Fixes: 730679817d83 ("Revert "scsi: ufs: disable vccq if it's not needed by UFS device"")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b140e81c4f7da..fd8bbd2b5d0eb 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4418,6 +4418,9 @@ static inline int ufshcd_config_vreg_lpm(struct ufs_hba *hba,
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg)
 {
+	if (!vreg)
+		return 0;
+
 	return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
 }
 
-- 
2.20.1



