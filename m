Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6FCA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C892190F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 15:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qHSgKbcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfJTPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 11:07:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfJTPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:07:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so6044882wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BowsyRCbYQm6XUN+12hCD9eDw6JsQcgoAbMrcPR5L+0=;
        b=qHSgKbcYIsUwGQpczmipayh6Me22RJUYnCPn0NUOp1ECAhFAv/uz0+S0d7hIubBjqP
         XrgG/Qhd5RbqWOTIg8sXou3fMs8B0wV7O3DAJL8dKwWz8QRrQzurKZZX0laNbLSHl0LK
         khiqitVZ7bRom/szIEdsCzlZk+K8NFLLcOY4+czwvN7GaxP6KtzgIMChkkZndBzTAV3Q
         ZJyzBXwNxOrpj06MRheCvKmTYqntfcRdVNpTP2xUeGdYWGJEgBML17uP3WjTpCx9ueW1
         HpXKeJOPANVTZG2jqbHX/zypnU/HCS41nWkdJrpMz346Zieb4AZRMLBwDSiOJw2iYUN7
         qHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BowsyRCbYQm6XUN+12hCD9eDw6JsQcgoAbMrcPR5L+0=;
        b=i4DcEBDXHzwOoVZsp7IDQiwlr3RxyRbwla9hFNZ+2e7kNqiw+C51BT6d3qI/cI5OI5
         RI8KgqPGsdciPEf8NowO5sK9ZMeBKLj+yk5jwXnVhQUCBFwcCG/tLT6cgJRXYa1ps1Yz
         n3I8F5o2FzzhixOFDKWA23FeR2o8D1X5tstybJPHXuvwXpgdK4NKmHpsTAAAo74OwdEs
         8tH2YlonNLR5tv2oAD6Ip8IC0Odaa596KKQtnZa+0IvInM059YhMVboT7A8exu47AqbX
         nsUREAkaKoFj2JCht/blJwyRMwF9SLV6qVS9DOpdXYqeUPn6pfDpOnM9W8/bEIyH27ew
         MF7g==
X-Gm-Message-State: APjAAAUDmAMve9ZhZY9kTfxj1UYm0TQqYYOHUPy8pr/+1DKrvgZM4fRA
        dSHC3293X5fwdYDU5eTYXUJdl9M1sKc=
X-Google-Smtp-Source: APXvYqz6Y7p6koFFckiqQrTxAUzz3YtZ1GZ6iTTThDt9rGqgjMrYpYqkn3WoQK6zMKRgAz3/YEeoig==
X-Received: by 2002:adf:f402:: with SMTP id g2mr16522778wro.64.1571584044432;
        Sun, 20 Oct 2019 08:07:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:32c:e530:1f62:944f:4c42:96a0])
        by smtp.gmail.com with ESMTPSA id u1sm19057633wru.90.2019.10.20.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 08:07:23 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     matthias.bgg@gmail.com, lee.jones@linaro.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH RESEND] mfd: mt6397: Use PLATFORM_DEVID_NONE macro instead of -1
Date:   Sun, 20 Oct 2019 17:07:20 +0200
Message-Id: <20191020150720.2752-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct macro when adding the MFD devices instead of using
directly '-1' value.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/mfd/mt6397-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 310dae26ddff..9b19dfeeb797 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -171,9 +171,9 @@ static int mt6397_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
-					   ARRAY_SIZE(mt6323_devs), NULL,
-					   0, pmic->irq_domain);
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+					   mt6323_devs, ARRAY_SIZE(mt6323_devs),
+					   NULL, 0, pmic->irq_domain);
 		break;
 
 	case MT6391_CHIP_ID:
@@ -186,9 +186,9 @@ static int mt6397_probe(struct platform_device *pdev)
 		if (ret)
 			return ret;
 
-		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
-					   ARRAY_SIZE(mt6397_devs), NULL,
-					   0, pmic->irq_domain);
+		ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+					   mt6397_devs, ARRAY_SIZE(mt6397_devs),
+					   NULL, 0, pmic->irq_domain);
 		break;
 
 	default:
-- 
2.23.0

