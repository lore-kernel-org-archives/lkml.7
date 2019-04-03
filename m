Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0269A20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjSKI9RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfDCHsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:48:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39228 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:48:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id b65so7606852plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wIrhdib+AH7V7mv416SXk4Mr89Zd0kNoPOL6hTxLt3Q=;
        b=EjSKI9RYimvWRM16YkSc6LGvSzO22UKOs2T9S4A67k5/WXdFA988jWsej87Rpeo4fe
         zaLe/fyZhJpsLtgOyaodeYRv2/HWkv4YPZznsr4jWbmPIM0SigTBmgSUvcQg4GiEWZnL
         pV0SRXQ8JieuOYuhuAEIfuRaAv17e1Hqv9GFwejXKcub1xEqG/G5BSLZahWZ6enZ1iMB
         Ms36nG+zTIHIZQ1ApmyboAju1hEiZjq2zoI9U1bYd21A7qTbOAqtd/y1OJpllkF0cVXs
         GitkKqvIgH2KiV5S1Df0qV6UYKgoTIarAQExoENf48mnLBS+B2iacWm/lHeyQCTdzj2j
         NOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wIrhdib+AH7V7mv416SXk4Mr89Zd0kNoPOL6hTxLt3Q=;
        b=V95rLlY2USAwgiEYWOf98K8ODgOb7ntZTmWxnYKC1Z2sShmx+mnx91rGFssVw0BD1c
         PRLpz9dxmdyfbPgKEULI7twtx0KSx7uNd2aMKhOE4uHtXQw+5GKaM7mhs0MDrB1inH8U
         PcPFDGfQVtFBYRPVW6jp1x6yfWbja5Df+KAwsnnn73QTpDt+q7XPVRqXLsw6P18rGtQL
         Hmb6mMLD7uwOOROfJ+0fNAanGPj9mB58ttU9YEk/3Fq+Y5afWac2kG5H6Dwc7scP+Ghy
         msNIOuKHfv4b2d3VQ+Q8io9zkk5snO6tsHaH8Cw9iVAG/a4DCJti61cfaO0+KLHEML8J
         /zhw==
X-Gm-Message-State: APjAAAXpJbb/n/ojfT9/9Ly3aJgmucjKXvNUjqNH2gQ3mteTTQ4W84n8
        nLNGYwUthgZ8BpEbBq18kudWGYy0Q4dNkQ==
X-Google-Smtp-Source: APXvYqx1F7XIOAypUIEBSjcZX7EXGcVjvkPedEXEoSRCRbrNm5ChVaDD1g9KO6GN3FNPX/L7MSulKw==
X-Received: by 2002:a17:902:e20e:: with SMTP id ce14mr62067330plb.193.1554277714315;
        Wed, 03 Apr 2019 00:48:34 -0700 (PDT)
Received: from ubuntu.localdomain ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id i31sm30500995pgi.36.2019.04.03.00.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 00:48:33 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        dan.carpenter@oracle.com
Subject: [PATCH] ASoC: sprd: Fix the smatch warning
Date:   Wed,  3 Apr 2019 00:47:55 -0700
Message-Id: <811e491489b62624942dabd56f277b08784ef0f9.1554276741.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary validation of the 'cstream' variable to fix
below smatch warning:

sprd_platform_compr_drain_notify() warn: variable dereferenced
before check 'cstream' (see line 105)

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/soc/sprd/sprd-pcm-compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index dc84257..424e983 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -107,8 +107,7 @@ static void sprd_platform_compr_drain_notify(void *arg)
 
 	memset(stream->info_area, 0, sizeof(struct sprd_compr_playinfo));
 
-	if (cstream)
-		snd_compr_drain_notify(cstream);
+	snd_compr_drain_notify(cstream);
 }
 
 static void sprd_platform_compr_dma_complete(void *data)
-- 
1.9.1

