Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D09C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC02468A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781738;
	bh=qGRvROEzM3vlKI0jA+ExRsSkpch1HpLNnk6tlf+EM78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G+PCPGSOVxjxei4PciAo8EEuV0SXAcLIg1YgmZay4+BwjziFl/IkqjEI4ukUiqfRB
	 o/J/SfvT0SS0Qmp2dnUvbyycLHrFheGKCfEU5WL6hX3BkPvK1i8WcL+vAMCbCsOKee
	 Dcm71JrH0xvNuOrlLbdD2RI5qpTCtnXtTylj598E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfLSSzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbfLSSzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:55:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A2C24682;
        Thu, 19 Dec 2019 18:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781733;
        bh=qGRvROEzM3vlKI0jA+ExRsSkpch1HpLNnk6tlf+EM78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3ceup8xJLbybHkcTJ+Uw3jNVYBGKSUPXJ9c6Ar7GGlvULWyd/Ffdt4+PgVvq9ctJ
         XdfL1SBVeimtKfxU2unE9upLAuEppr5PATFeIS35XyEp6f2pB8DpF7mJ6ZhZa0CFlE
         fO3pPL02X1CT2wM2Buq3JorORTJTJmI9V8LwAonU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, sheebab <sheebab@cadence.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 58/80] scsi: ufs: Disable autohibern8 feature in Cadence UFS
Date:   Thu, 19 Dec 2019 19:34:50 +0100
Message-Id: <20191219183131.230267215@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183031.278083125@linuxfoundation.org>
References: <20191219183031.278083125@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sheebab <sheebab@cadence.com>

commit d168001d14eccfda229b4a41a2c31a21e3c379da upstream.

This patch disables autohibern8 feature in Cadence UFS.  The autohibern8
feature has issues due to which unexpected interrupt trigger is happening.
After the interrupt issue is sorted out, autohibern8 feature will be
re-enabled

Link: https://lore.kernel.org/r/1575367635-22662-1-git-send-email-sheebab@cadence.com
Cc: <stable@vger.kernel.org>
Signed-off-by: sheebab <sheebab@cadence.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/cdns-pltfrm.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -99,6 +99,12 @@ static int cdns_ufs_link_startup_notify(
 	 */
 	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_LOCAL_TX_LCC_ENABLE), 0);
 
+	/*
+	 * Disabling Autohibern8 feature in cadence UFS
+	 * to mask unexpected interrupt trigger.
+	 */
+	hba->ahit = 0;
+
 	return 0;
 }
 


