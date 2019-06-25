Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10AC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CC720656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="VWqSyGvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfFYLfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:35:00 -0400
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:51201 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730434AbfFYLe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:34:59 -0400
Received: from mx-exchlnx-1.rrze.uni-erlangen.de (mx-exchlnx-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::37])
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3p32fVDz8vFy;
        Tue, 25 Jun 2019 13:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1561462139; bh=iFvqU5P2PzjR3zYgUujUJdCyVZ41SEOkT3DtA4ND8V4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=VWqSyGvr2hYgrmwCTdxv+paDci4LJNN7MtIOTYIKX/fCOVDhxy5J8t4cigCF/lWg+
         uJsqtZRAAjveHDN6Qm/PuOD9QIr3WfwqobGgcbz3y4MwFe6qFHT0/MRef0cgkPoGcr
         KbVAULdSERgI/E5CVAjchPOpUTaKB06PI8y7zfBE3uplmNzK5dLjtDEXeIdnhLwOCF
         DLoTTj+dmXckMn198wgjRSHYLuK4OTdaSJtRAeHIEFqB6cVWMNdrWSigAuTAdyPmjV
         ryJ5BHFE3+R4KHjqa+oiV8zqRF6zHITDHk9TkwpGeiKKhIr7lGipXBRvant6EJPmn6
         QRxoGpVKvgInA==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
Received: from hbt1.exch.fau.de (hbt1.exch.fau.de [10.15.8.13])
        by mx-exchlnx-1.rrze.uni-erlangen.de (Postfix) with ESMTP id 45Y3p11FYMz8vCX;
        Tue, 25 Jun 2019 13:28:57 +0200 (CEST)
Received: from MBX3.exch.uni-erlangen.de (10.15.8.45) by hbt1.exch.fau.de
 (10.15.8.13) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Jun 2019
 13:28:23 +0200
Received: from TroubleWorld.pool.uni-erlangen.de (10.21.22.37) by
 MBX3.exch.uni-erlangen.de (10.15.8.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 25 Jun 2019 13:28:21 +0200
From:   Fabian Krueger <fabian.krueger@fau.de>
CC:     <fabian.krueger@fau.de>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] staging: kpc2000: introduce __func__
Date:   Tue, 25 Jun 2019 13:27:18 +0200
Message-ID: <20190625112725.10154-8-fabian.krueger@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625112725.10154-1-fabian.krueger@fau.de>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.22.37]
X-ClientProxiedBy: MBX3.exch.uni-erlangen.de (10.15.8.45) To
 MBX3.exch.uni-erlangen.de (10.15.8.45)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the function name hard coded as string, using __func__
and the '%s'-placeholder will always give the current name of the
function. When renaming a function, the debugging-messages won't have to
be rewritten.

Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 732254e9b261..f258f369e065 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -457,13 +457,14 @@ kp_spi_probe(struct platform_device *pldev)
 
 	drvdata = pldev->dev.platform_data;
 	if (!drvdata) {
-		dev_err(&pldev->dev, "kp_spi_probe: platform_data is NULL!\n");
+		dev_err(&pldev->dev, "%s: platform_data is NULL\n", __func__);
 		return -ENODEV;
 	}
 
 	master = spi_alloc_master(&pldev->dev, sizeof(struct kp_spi));
 	if (master == NULL) {
-		dev_err(&pldev->dev, "kp_spi_probe: master allocation failed\n");
+		dev_err(&pldev->dev, "%s: master allocation failed\n",
+			__func__);
 		return -ENOMEM;
 	}
 
@@ -486,7 +487,8 @@ kp_spi_probe(struct platform_device *pldev)
 
 	r = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	if (r == NULL) {
-		dev_err(&pldev->dev, "kp_spi_probe: Unable to get platform resources\n");
+		dev_err(&pldev->dev, "%s: Unable to get platform resources\n",
+			__func__);
 		status = -ENODEV;
 		goto free_master;
 	}
-- 
2.17.1

