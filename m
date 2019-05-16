Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E5FC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A6620833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtQtTKEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfEPQmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:42:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46496 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfEPQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:42:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id f37so6095099edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7hWW7F3Jq1teN//UiYRY0ce3mS1OHS7jeYFYW15JQuE=;
        b=OtQtTKENS/kDTkzdvta14eqqXLVyFWovn3fbD4Aqk3xTmHOj1RabBgYJ5NfI47wMoZ
         zICB7jy34Amf3NZv2XpTFIOfdsvC2Sbe8lIMZx8e7DkTUFDcpI4J8raTtFoiHiK4P57F
         U3flbJ4xdno3lno40OQQZGqVSGb529186F2GIAzC+x/RBmsc0BGWudxRaAmp5TgtJME7
         4st677zv7t7NT+eo7l7ifjejIUC8zvoYOa3Hk2wGXh6dPMNu4GwCNBeg/MNwH8w6K97f
         TAGNOXLUqL8sK32OoYQN/WMKsoD/nchOyBu2Jgk/PwRoHzhGUwC4sKZGEncwEN/8mDNo
         koEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7hWW7F3Jq1teN//UiYRY0ce3mS1OHS7jeYFYW15JQuE=;
        b=ZILVuihvihmhoaKIBdNzF5gGxjWcoE7kF1ubsN3ac5zhPXPcZf5CQftHBhlFHDelIS
         cSMhf4eb8dYpYjXTaI1PDgIhlKBaijg1nrnM0uulWCV9/FL+97xB4ufz3aefWiBugt3D
         EepsNUaLoryDP3FmPrm/ywOpISrBS1CEAtntm+XphdyGH1rONTVqBVGvz85RP4NfSn/q
         SVlOBaQM3UhIMrG3XzGf0Np3w5fEtfGS8tQGh4X0DvF0JVNZBT6Oqcc+scyTLDwmUzhc
         DjrJBwmvk1Dcl0FkDo192TF4iYwgRTbRtXrXzytyD0BkQChHsBF3LcKiBtLY9pwAirQg
         zMOw==
X-Gm-Message-State: APjAAAUYCZVhiTZ0+Gl5IfZquCSDP0UKkqoZ/MZtGKTHqYLG0xOmIism
        /hWJd/5sBFeCNBkPjwcT7ac=
X-Google-Smtp-Source: APXvYqxE5gnOG1GBDEQ/vXEgfSrP1xENIVStPlB1dls6VlS0+mMGiXF1Q9bgkjMyE3ebKtCimXoKMQ==
X-Received: by 2002:a50:8eb6:: with SMTP id w51mr50988410edw.34.1558024923930;
        Thu, 16 May 2019 09:42:03 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i45sm2013709eda.67.2019.05.16.09.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:42:03 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 1/2] mtd: Add flag to indicate panic_write
Date:   Thu, 16 May 2019 12:41:46 -0400
Message-Id: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a flag to indicate a panic_write so that low level drivers can
use it to take required action where applicable, to ensure oops data
gets written to assigned mtd device.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/mtdcore.c   | 3 +++
 include/linux/mtd/mtd.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 76b4264..a83decd 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1138,6 +1138,9 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		return -EROFS;
 	if (!len)
 		return 0;
+	if (!mtd->oops_panic_write)
+		mtd->oops_panic_write = true;
+
 	return mtd->_panic_write(mtd, to, len, retlen, buf);
 }
 EXPORT_SYMBOL_GPL(mtd_panic_write);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 677768b..791c34d 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -330,6 +330,12 @@ struct mtd_info {
 	int (*_get_device) (struct mtd_info *mtd);
 	void (*_put_device) (struct mtd_info *mtd);
 
+	/*
+	 * flag indicates a panic write, low level drivers can take appropriate
+	 * action if required to ensure writes go through
+	 */
+	bool oops_panic_write;
+
 	struct notifier_block reboot_notifier;  /* default mode before reboot */
 
 	/* ECC status information */
-- 
1.9.0.138.g2de3478

