Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5EC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E871E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="cQ50t0e/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfGRCJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:09:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33164 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfGRCJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:09:16 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so27264961otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 19:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JBv93M51Cm27uWFOlZ79cXm5tHYDJ8Ehc/VJnl7Bsac=;
        b=cQ50t0e/TYXv0f06gbL54Fp3Yrwg7bN8IkwK1+AnRAadEqm80rjzsuoKYNznG+tFEV
         lGh+daxpY4K8TeweA5JwO46a9l7Is2O+mKX7Sq5XQrkIimbUHVCFTLOeTaXe7/eBPY4r
         TQTAlSAmPhrkOUmlj7HQikodai2rpveJejNlWXcExthtUBOjtttnqiMwcVX0y7uJY2Wp
         8qx/syN6qXlxVfgr9w2ICvgORYcJmpuioHefo7erPDhr43tNevUjv4rWpDd0jQILpcLY
         z2lgLhavqUCKfmhC+3CeRBgCK9HNkHZpe2fQC0tjO48F9nvvnXdBe8hnidI/TDKktU5+
         Y/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JBv93M51Cm27uWFOlZ79cXm5tHYDJ8Ehc/VJnl7Bsac=;
        b=m1RUNn6aCTxmtCL7bGq66v4FfByZgMC9TVjHK+zFhhTqQjSWox0RIoff5T9Z9UlWo/
         4SPC/580CFukP7hoWTdx0dGFyIM9goUjJUImj2cqV20NbP/cWeg/Tbkr/WI0IgueJsmr
         zFnXrnl+wzaFWoddmK9SSQCerxVugnaU2XI6vvbN1uiG5ZS9Hty1lXBrqZBharuIpcCf
         dmg74cHlNTFzVIwMYIRkG26coJGhyyAEl30QhBtjkQIGz6Wq61sxKfhbMOvDKQrVQVDe
         5ArsWyOeLsWlk4B2MpuVLsyY6OUFxQAIUiFCdDUYr0LHiyF6TLf1Cqoir8uMLZ8dkig6
         WEKQ==
X-Gm-Message-State: APjAAAVKyJRC7G2yVXPF5hIJqeQMiK4ZKr+rgUHfZp5n+NhUDc1W72ld
        U6hWnD5TFYXGWYn6cRU46LTxE1dSVmdKzA==
X-Google-Smtp-Source: APXvYqwkduwNJYTtmbkWXsTJ92I8TPBt+8gY4M4U0jN8M8NZ5AO00WG6WLuOSXVQScDR/ok61UQnvw==
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr30566080otq.104.1563415755427;
        Wed, 17 Jul 2019 19:09:15 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id v203sm10184523oie.5.2019.07.17.19.09.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:09:14 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
Subject: [PATCH] scsi: csiostor: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:43 -0500
Message-Id: <20190718020745.8867-8-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/scsi/csiostor/csio_wr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
index 03bd896cdbb9..0ca695110f54 100644
--- a/drivers/scsi/csiostor/csio_wr.c
+++ b/drivers/scsi/csiostor/csio_wr.c
@@ -1316,7 +1316,6 @@ csio_wr_fixup_host_params(struct csio_hw *hw)
 	u32 fl_align = clsz < 32 ? 32 : clsz;
 	u32 pack_align;
 	u32 ingpad, ingpack;
-	int pcie_cap;
 
 	csio_wr_reg32(hw, HOSTPAGESIZEPF0_V(s_hps) | HOSTPAGESIZEPF1_V(s_hps) |
 		      HOSTPAGESIZEPF2_V(s_hps) | HOSTPAGESIZEPF3_V(s_hps) |
@@ -1347,8 +1346,7 @@ csio_wr_fixup_host_params(struct csio_hw *hw)
 	 * multiple of the Maximum Payload Size.
 	 */
 	pack_align = fl_align;
-	pcie_cap = pci_find_capability(hw->pdev, PCI_CAP_ID_EXP);
-	if (pcie_cap) {
+	if (pci_is_pcie(hw->pdev)) {
 		u32 mps, mps_log;
 		u16 devctl;
 
@@ -1356,9 +1354,7 @@ csio_wr_fixup_host_params(struct csio_hw *hw)
 		 * [bits 7:5] encodes sizes as powers of 2 starting at
 		 * 128 bytes.
 		 */
-		pci_read_config_word(hw->pdev,
-				     pcie_cap + PCI_EXP_DEVCTL,
-				     &devctl);
+		pcie_capability_read_word(hw->pdev, PCI_EXP_DEVCTL, &devctl);
 		mps_log = ((devctl & PCI_EXP_DEVCTL_PAYLOAD) >> 5) + 7;
 		mps = 1 << mps_log;
 		if (mps > pack_align)
-- 
2.17.1

