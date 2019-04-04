Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFEBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B6D214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4IvF7c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfDDMqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:46:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35016 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDMqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:46:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so1986720ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6p5ff3qqoSe8pSqdEKP+bILByJNenTTyQGBfGW1rx8=;
        b=K4IvF7c4zOdpBK5DsDEgbqf+rFasAzpI5fqazNLSbXGIPfMmErUstPj6VFTBRhU4oB
         6Mjoi+1zg2/oh2sVq4ffyOeN/dcIbHqVKkN70MGPE7MD0fzHlMTbW6eKjf6U9E/qcpXH
         gFvNrMXZ7X8C/BiUCckz6ef3dkrF20ARaYgeokgGx+3vfhALs+xzv7jB8S/DP3IdNagG
         EYDPM0DrX1/2lwnEzQTEVjlQchiY/bRz6UZ/l2flHcZmX1Iaph7xrL2Y+BiyySWryTeW
         8I+Ihny9tuCYlWzrgtUY6zMYBXeiihYnWpdaxBXyPHNhfPvf5TuUndPp5LbtZRBnYNB7
         FniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6p5ff3qqoSe8pSqdEKP+bILByJNenTTyQGBfGW1rx8=;
        b=JNpsK5Gy0ObyJ2pPcPNrRhgqSICucRgdlV8Wet5VwxVCCDGxKuEouB+7oBeK3sH/Ab
         BE4DJsJLgBbY5TSgXtCjkpO8stFw0lLMrEunQ6q490rbZR2omKXy6fEVDCroFk9ZGlwC
         I4q8mB54al1FOW2mSenIRWTlSGn6tuHgwcuvdGGVIWuGR4vlBHNJS+aIZcLRe0zcT2Ib
         LVMwuyGdNzJdRzl4Lgv22SIe+uQOPrQOR4nLEpIC1NAxjTTLQcl/BMD50GGe/ayLYGQr
         hEaiUF9zeJU77vAQYjifD4dg9J6tjebow8ugH4mZpAypyDSezJlLxjf4X8vk0vHuHove
         74PA==
X-Gm-Message-State: APjAAAW9xuHHU+C+oveB+w2MsxxQcpA7pSRIJUgoWVGWEwoRNx6s+Zz0
        yxQZJ3fAF2nRJaMbMCRxnI4=
X-Google-Smtp-Source: APXvYqzCLpU22BCXD3xvDYK6QZ+LE6kQbgpjeebrikPAokLU648zLbB9OQzVqkWCq4r1eGUvdrObig==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr3284002lje.22.1554382002996;
        Thu, 04 Apr 2019 05:46:42 -0700 (PDT)
Received: from haukka.localdomain (dygkdv8b8f74---xmv90y-4.rev.dnainternet.fi. [2001:14bb:150:38f0:3c26:f1ff:fe6a:8f7c])
        by smtp.gmail.com with ESMTPSA id u1sm3654596lfm.4.2019.04.04.05.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 05:46:42 -0700 (PDT)
From:   =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@gmail.com>
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, sergio.paracuellos@gmail.com,
        benniciemanuel78@gmail.com, neil@brown.name,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Antti=20Ker=C3=A4nen?= <detegr@gmail.com>
Subject: [PATCH] staging: mt7621-pci-phy: prevent use of uninitialized variable
Date:   Thu,  4 Apr 2019 15:44:17 +0300
Message-Id: <20190404124414.22846-1-detegr@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use uninitialized variable 'port' when printing an error message

Signed-off-by: Antti Keränen <detegr@gmail.com>
---
 drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
index 118302c122ee..aa3ae7777632 100644
--- a/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
+++ b/drivers/staging/mt7621-pci-phy/pci-mt7621-phy.c
@@ -331,7 +331,7 @@ static int mt7621_pci_phy_probe(struct platform_device *pdev)
 
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
-		dev_err(dev, "failed to get address resource(id-%d)\n", port);
+		dev_err(dev, "failed to get address resource\n");
 		return ret;
 	}
 
-- 
2.21.0

