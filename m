Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD51C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F225222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDofDShd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgAFTTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43428 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgAFTTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id k197so27290527pga.10;
        Mon, 06 Jan 2020 11:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cc+8NW3oaqL7v7CJZlR+R8urn6RS/4vks+nXeck2ako=;
        b=BDofDShdgPFjSEz7ovXl1Q/E6JikGI9vQ+kXpBed7w52ce/5mCF/SjDbuRsKI7uAja
         QAsR2f3Ly4Nmasaq3vlaw25EhlnzyYYAXXx29fCGm0OH7ryj2FdtjE+hbl+CPP+nHMHP
         tIJS9IBgfUDUC1peoBn5cYHb1mXv10c96rN/hIYCpgjCDKvSqrEE9gyNg/fF43ece8pC
         ey1mqrbD6YbqyxuCB2Ia4REqmBhXHnUfcvrOtdXTj12Kg/2EifQKhoiHAuEcd22f5exn
         cDtRRYyFADRovM1nw3rFwPic5yzoOrwKeQndnZmdETNN07o04PVKf2B4jvsUZTrzrX+F
         cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cc+8NW3oaqL7v7CJZlR+R8urn6RS/4vks+nXeck2ako=;
        b=qqZ8kGWhS1RyDXaQBDk7mtqvUG3vVKHDzkmCGDHOtvcVG0Kd8PCIC/WbCuRGJPhoNB
         uJdBk5in09n04BI5WYLxLpoRb3LMYv0jufrtRoyl+zIbzxqFR3z85CZbD3a0VAUrxSkt
         jKkoRQlx5yQ01eZOtsf+w37/sT5Ch6zYTDmTqBw1K+NnoPlv6WRIgO9ndfJDYf4aycW/
         7BpafrzK9vjIZ8FeE6Zpo82960XzNbQOeJQZwAeaMsOHyjNImnjmn/AWdxnB5WwG1CG8
         dXDazyQZNKhKHLJPgvTTtpgPNjpoAHUm96Rhu+5z5khaEl5POvbxR0Sjcf7B8VI60nY6
         SEug==
X-Gm-Message-State: APjAAAVWt+11UQBldDH0FvJoQo7aj1sjlWfVBfjcjrubb1eH6hipPROj
        dLZ1Lqn/pkVZnZfHtKgnlJDtydc4
X-Google-Smtp-Source: APXvYqxq/x2IRI/9YHrxAyymDX9EY9Q5xfpzh0M6wGgr+jbFrxm2VaKcmYRNZpvhJVW4ZGpQN+rQkw==
X-Received: by 2002:a62:5214:: with SMTP id g20mr107833749pfb.101.1578338351804;
        Mon, 06 Jan 2020 11:19:11 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g10sm72795594pgh.35.2020.01.06.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:11 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v2 2/2] ata: ahci_brcm: BCM7216 reset is self de-asserting
Date:   Mon,  6 Jan 2020 11:19:06 -0800
Message-Id: <20200106191906.18266-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191906.18266-1-f.fainelli@gmail.com>
References: <20200106191906.18266-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM7216 reset controller line is self-deasserting, unlike other
platforms, so make use of reset_control_reset() instead of
reset_control_deassert().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 70e3e386d52e..75931cfb70bc 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -363,8 +363,12 @@ static int brcm_ahci_resume(struct device *dev)
 	struct brcm_ahci_priv *priv = hpriv->plat_data;
 	int ret = 0;
 
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		ret = reset_control_deassert(priv->rcdev);
+	if (!IS_ERR_OR_NULL(priv->rcdev)) {
+		if (priv->version == BRCM_SATA_BCM7216)
+			ret = reset_control_reset(priv->rcdev);
+		else
+			ret = reset_control_deassert(priv->rcdev);
+	}
 	if (ret)
 		return ret;
 
@@ -473,8 +477,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	}
 
 	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_deassert(priv->rcdev);
+	if (!IS_ERR_OR_NULL(priv->rcdev)) {
+		if (priv->version == BRCM_SATA_BCM7216)
+			reset_control_reset(priv->rcdev);
+		else
+			reset_control_deassert(priv->rcdev);
+	}
 
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
-- 
2.17.1

