Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC6AC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817D8208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmWmLgJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAFTTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:19:14 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34827 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgAFTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:19:11 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so8164619pjc.0;
        Mon, 06 Jan 2020 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0pqFH2VG0zjlTk6J0L9VrG9oIlBzQyAPjQqRvKgB/OU=;
        b=PmWmLgJYXeTiAFx5HcOGxSDU548cT4knHNoDDBX77RQwTQMim1A2rZNP0npr3CqUnc
         YozX6q7tmqbjC+mRtIri/oE9+8oCL0KnjqhHHDgqzbjtMEopXiSuyCJEoTaiMTly/6+2
         tBWHPao1/pAWbi5rEyPO3ARmyDI3aHvHz6zRLcCO1LK7cIGj2KS8ROD9bLV3+7fdqISp
         o+h2PGDQ95cZCRH1qEzw+xTI8vbAgztuliC8q7RjtfUQFUS10ztibKSvW5zMaHboJXbU
         pZWxu9OP4C6wQqcv20fO7pv7jRooz/zDl9IcfjaJj49dgz4PejEi69afU4wWOrvRjrKn
         Eguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0pqFH2VG0zjlTk6J0L9VrG9oIlBzQyAPjQqRvKgB/OU=;
        b=c8pxXb9h+Q4WyCe1ZH7d95eGSto5tpCyQha23RjnKSqpJuIvBUc4P44tln/A7YL/il
         3atzx0ahG9wYvaL2DDjsFo+lkmv+7uT9WDMgVXjLjyGRlDr+3q4eNy6ZtQ3Td/APIqgm
         bGA9aev29JxnNV4oH8Lg7Ago/9p0dM70diQ8lHMj9VXFsSEoKpkCbMxjwnb7jnXZpevO
         JNKrBnz/R/Uf2zwIm77jjHbU/kvZCGoYSaATVlz0e9y9P0t6DtT6Q8U+5jlY5YYNSMso
         OJjtEk7UUSgqwC+yNapPg24BzRAOMw0IeLGWvEdtfMxa0f/5jC596LvtPllegkTHv0jv
         GTTA==
X-Gm-Message-State: APjAAAVRMq+0p5ysOMZivOjqga12wuDy5KXTwJPQjyvuiqOPzEmEKSaw
        bLjZJrDpN+BYQQhUP8pwvfCQ5iNh
X-Google-Smtp-Source: APXvYqxeHkJ7AJqqUTbyySWm/D6t4iAfm5ngfRjsoqUAk+Khgh78swP9P1Ngoqhsayfd1LWpGw+OqQ==
X-Received: by 2002:a17:902:5a83:: with SMTP id r3mr109637942pli.145.1578338350527;
        Mon, 06 Jan 2020 11:19:10 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g10sm72795594pgh.35.2020.01.06.11.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:19:10 -0800 (PST)
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
Subject: [PATCH v2 1/2] ata: ahci_brcm: Perform reset after obtaining resources
Date:   Mon,  6 Jan 2020 11:19:05 -0800
Message-Id: <20200106191906.18266-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106191906.18266-1-f.fainelli@gmail.com>
References: <20200106191906.18266-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources such as clocks, PHYs, regulators are likely to get a probe
deferral return code, which could lead to the AHCI controller being
reset a few times until it gets successfully probed. Since this is
typically the most time consuming operation, move it after the resources
have been acquired.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 13ceca687104..70e3e386d52e 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -453,15 +453,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	else
 		reset_name = "ahci";
 
-	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_deassert(priv->rcdev);
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
-	if (IS_ERR(hpriv)) {
-		ret = PTR_ERR(hpriv);
-		goto out_reset;
-	}
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
 
 	hpriv->plat_data = priv;
 	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP | AHCI_HFLAG_NO_WRITE_TO_RO;
@@ -478,6 +472,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
+	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		reset_control_deassert(priv->rcdev);
+
 	ret = ahci_platform_enable_clks(hpriv);
 	if (ret)
 		goto out_reset;
-- 
2.17.1

