Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F71DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43F32080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432291;
	bh=cnqALwMuRfyo5+y1ZAdyD4v7PD7Zz5NZ8hggQcZxekQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RwKxo0BIhNSvOcV1Ki2o32XV4deGkxQg9BsTCBaUvj+GmPisaCjG6VBhb5geNigFG
	 a8E9gux8J6xrNslFUEXcJ7Ox0wKWNCZQe3pjnSurkRXbZaQ6yR3ZgOlS8lo5z5kUwN
	 dRiKzreejSwwK206JMeY5n3dqI4EQRFoux/riT4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgAGVYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbgAGVAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:00:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B3824677;
        Tue,  7 Jan 2020 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430817;
        bh=cnqALwMuRfyo5+y1ZAdyD4v7PD7Zz5NZ8hggQcZxekQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgjFxgaf9n5dskL4GUg3vQFB5EEEKOidOe4XpsQCX8KTs2Q3YCntGa0E0SUXfrqKI
         siX5o8WCK37tEnNTAYgnv69Z16jrWg+sBejUt75Wk8UoLxFP3gMf5+WuPP0kO63LHP
         8vpBfR58IJGnzYA0k6cob+sUVnQTSdTxgPgP75Pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 108/191] ata: ahci_brcm: BCM7425 AHCI requires AHCI_HFLAG_DELAY_ENGINE
Date:   Tue,  7 Jan 2020 21:53:48 +0100
Message-Id: <20200107205338.767411951@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 1a3d78cb6e20779a19388315bd8efefbd8d4a656 upstream.

Set AHCI_HFLAG_DELAY_ENGINE for the BCM7425 AHCI controller thus making
it conforming to the 'strict' AHCI implementation which this controller
is based on.

This solves long link establishment with specific hard drives (e.g.:
Seagate ST1000VM002-9ZL1 SC12) that would otherwise have to complete the
error recovery handling before finally establishing a succesful SATA
link at the desired speed.

We re-order the hpriv->flags assignment to also remove the NONCQ quirk
since we can set the flag directly.

Fixes: 9586114cf1e9 ("ata: ahci_brcmstb: add support MIPS-based platforms")
Fixes: 423be77daabe ("ata: ahci_brcmstb: add quirk for broken ncq")
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci_brcm.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -76,8 +76,7 @@ enum brcm_ahci_version {
 };
 
 enum brcm_ahci_quirks {
-	BRCM_AHCI_QUIRK_NO_NCQ		= BIT(0),
-	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(1),
+	BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE	= BIT(0),
 };
 
 struct brcm_ahci_priv {
@@ -439,18 +438,27 @@ static int brcm_ahci_probe(struct platfo
 	if (!IS_ERR_OR_NULL(priv->rcdev))
 		reset_control_deassert(priv->rcdev);
 
-	if ((priv->version == BRCM_SATA_BCM7425) ||
-		(priv->version == BRCM_SATA_NSP)) {
-		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;
-		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
-	}
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv)) {
 		ret = PTR_ERR(hpriv);
 		goto out_reset;
 	}
 
+	hpriv->plat_data = priv;
+	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP | AHCI_HFLAG_NO_WRITE_TO_RO;
+
+	switch (priv->version) {
+	case BRCM_SATA_BCM7425:
+		hpriv->flags |= AHCI_HFLAG_DELAY_ENGINE;
+		/* fall through */
+	case BRCM_SATA_NSP:
+		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
+		priv->quirks |= BRCM_AHCI_QUIRK_SKIP_PHY_ENABLE;
+		break;
+	default:
+		break;
+	}
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
@@ -470,15 +478,8 @@ static int brcm_ahci_probe(struct platfo
 	/* Must be done before ahci_platform_enable_phys() */
 	brcm_sata_phys_enable(priv);
 
-	hpriv->plat_data = priv;
-	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP;
-
 	brcm_sata_alpm_init(hpriv);
 
-	if (priv->quirks & BRCM_AHCI_QUIRK_NO_NCQ)
-		hpriv->flags |= AHCI_HFLAG_NO_NCQ;
-	hpriv->flags |= AHCI_HFLAG_NO_WRITE_TO_RO;
-
 	ret = ahci_platform_enable_phys(hpriv);
 	if (ret)
 		goto out_disable_phys;


