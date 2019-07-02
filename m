Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EEC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D4421855
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGeac4df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfGBIGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:06:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45571 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfGBIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:06:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so26366404edv.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v+gVEdHeB1hIvDD6bk9LhL2aP9OzxGeZK+EU7eJOmKo=;
        b=ZGeac4dfLGFaSPbVkqUj7qpg5c9UtxWKJUYqasnnRpUrX+7x+WLbzKZ6d25IvbuF4n
         r4fsbVVgEfcZUFKEZbv/QUtpqFGsmZossPQYMkO2pPSbhjC05OIk8CGFLNSN/0tvVUCN
         /rRulAIK5UQ9dOnOQUMtP6WRA8k14RustF8TzodmMLE2AMCLe0YkbW8zo38jo/wHCDkr
         OU80XI1DVy8D+BtMwSG/2T9bvcl4XnjI7SVu16feowa4PGzvvtJ+H6D5WOmV3mandOkD
         Jl1TK7GKVp4KbFWUpqgOWfB0W8HlEg4ycJzBr8sf6Mzol4YXUZPeZNvOBq7ZEpD3iOhS
         AtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v+gVEdHeB1hIvDD6bk9LhL2aP9OzxGeZK+EU7eJOmKo=;
        b=Ny25TYMaeYgx8mmaQEvkDg1Q/OUylJgfy8C1EdxuEJS5CTaRt3tyaQ/gud+SgdvSk5
         Vsg+uJuFDMnRCq0vihhg+zE5C9vaHxQFJRRUKrV8DRID3tFc+tx4dH92gYyrOu8KwkeS
         agrant8TkYzpiE4EHq5dJdcnSVpfc65wwVGmqH1iv3plQDB92ZKAaPA8/hqGtZy2WCjv
         BTIpeBhuOdeaaGILRxmvmSbMNnqwOSQAHwNzI6+7Z0FJKcDVq4oJaNnWm434JoanJ3Zd
         WNYma/N+05b56yyrkcz4kjzNCMLuz64X5R9cN79syFsa1EiP+yGO6JFA0mLQJrTGL4/5
         Fsfg==
X-Gm-Message-State: APjAAAWdwq5VkFGJQFd/uE1TFQsWZ8zrAypRMjkCD1NQTDu4TdgzhhqB
        zZb5VoUo6c4S2tyzX/5/B70=
X-Google-Smtp-Source: APXvYqyLyz4+m/jyDx9YPAgYfTRLOmth2w+dVO3Zgrz2HFR3uLrDnFJxKzRTjP2pGmF6eJQRU/U7tA==
X-Received: by 2002:a17:906:19c3:: with SMTP id h3mr26984148ejd.49.1562054795887;
        Tue, 02 Jul 2019 01:06:35 -0700 (PDT)
Received: from puskevit.guest.wlan ([195.142.153.182])
        by smtp.gmail.com with ESMTPSA id m3sm4199465edi.33.2019.07.02.01.06.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 01:06:35 -0700 (PDT)
From:   fatihaltinpinar@gmail.com
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
Subject: [PATCH] Staging: mt7621-dma: mtk-hsdma: fix a coding style issue
Date:   Tue,  2 Jul 2019 11:06:32 +0300
Message-Id: <20190702080632.27470-1-fatihaltinpinar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>

Fixed a coding style issue. Removed curly brackets of an one
line if statement.

Signed-off-by: Fatih ALTINPINAR <fatihaltinpinar@gmail.com>
---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index 0fbb9932d6bb..a58725dd2611 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -664,9 +664,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	hsdma = devm_kzalloc(&pdev->dev, sizeof(*hsdma), GFP_KERNEL);
-	if (!hsdma) {
+	if (!hsdma)
 		return -EINVAL;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.17.1

