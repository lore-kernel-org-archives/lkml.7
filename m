Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF57C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D662A22CBA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Nrydxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfGXMXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:23:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45986 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfGXMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:23:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so21958584plr.12;
        Wed, 24 Jul 2019 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48E6HSc2L70hlQLRSBeIv+/Db8vjv1Bu/UW8jXrS+U4=;
        b=M2NrydxgGzbdA1NpgU+GmccIx2rtAZfaW5/PTnf6k4bFLoXu9E6I7yzi8mDNk7O2+L
         NmE/PlITHEZ/LHV02kSI3E5R8WLqFrgtxKH6q6R9/hyZREojXXk+aAn60WRGIqqFhI1j
         pwWNiCgWU3ht7GvK+rRF24/3xfoqrE1rW7GTjXblwVTgpGMAtkcqld/pPmuimVrHGIKa
         5QIIcE5/HvD/kaNTrVn5U5QjlmRC84llpXAu00Kdh52KQB63o5h7Mr06+KSNXYVIdG+T
         w6wf+rE0xqAOzfZT4ndWwXasR0xMDg987TxzhBaIBAl9QPLKhtqHgCY71HaWYC53glS4
         Xm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48E6HSc2L70hlQLRSBeIv+/Db8vjv1Bu/UW8jXrS+U4=;
        b=qDonSdslwfWiMfHqG4E6U3FdvMs97LinETLZh1TVHnwxoUeOMbrZemeHoq21lnK+s8
         jY84xeyNt3R10RT68f9MkJUZ4ojab7D0yBzqNEtJAcA5BjlCWtXJN/P55cW5Ev8+lW57
         d6ZgL8bd1KGqOu4k4p9nchKTqi5Hob3C7ihOkPM8xLvUqX1WOkmdXg9PLpjnsYBQMciF
         jdK9m98VZzEwG+wRmxOoG9kPgJgIoYkIdkp3Rkg9htXt5sJQGp4n+2htArABFpYy3wyR
         u91mefqesXBQp/y1eptZplDk1Dh3GQfVekVo3WziqblO7KNAQv7qb0PDb47CTNh4G63Y
         gCSQ==
X-Gm-Message-State: APjAAAUyKoByatY/WTDRv75o1CpFbUbcTF7sj+TII91l000j6e3HD0jz
        VTQ93+22l/0aR54/ZP8WhP4=
X-Google-Smtp-Source: APXvYqyV++dF7Y2xCtTuo3l0EnNtBGcrJdWUNyN9cvS5LLSYn0cSjpYTw/jbSWSTUYf/WN5oZxKypg==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr85693188plp.221.1563971015577;
        Wed, 24 Jul 2019 05:23:35 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x9sm55087298pfn.177.2019.07.24.05.23.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:23:35 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: dw-pci: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 20:23:31 +0800
Message-Id: <20190724122331.21856-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-dw-pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 9651679ee7f7..c1e2401cace0 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -98,16 +98,14 @@ static void spi_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int spi_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_suspend_host(dws);
 }
 
 static int spi_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_resume_host(dws);
 }
-- 
2.20.1

