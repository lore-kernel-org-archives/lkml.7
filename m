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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B8C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376D72072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDHnqbc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgAFS7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:59:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgAFS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:59:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so27253539pgb.13;
        Mon, 06 Jan 2020 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c8Jxobv5zatOIK6RH9Q9DDayA/oj2/+bYYzkppsnODM=;
        b=KDHnqbc9wQWU6Csdsh5BogGVWvazFYvnFEOD7aW9e2yeRGTuD25iZljw8KbpovbSJe
         3RiD97ic6doJ7HqoRJ3bepI+fCXqu+Q1D3KM2yWGlHmBLWl6+4iEwCvWfJic3rZE5wG8
         ScIqBQ64yIo9Hb8PdKUUT0L0EG8lf55FAfXZZjXh6eDC4WOKsESA8fBr9WKYmDITwzbE
         XdrncB1wsnUK73WAG/itShmAnBNN+HLWvVJrPoOwCcjA67YgRSmSJaRkIDq4w218xiq+
         bW8ZzJ2x52yIS5+G2EautNXDbm/W4B6R4jP6o2LzAIQI7qP6mWmNEVMKTcq7udMnFULk
         xY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c8Jxobv5zatOIK6RH9Q9DDayA/oj2/+bYYzkppsnODM=;
        b=UKk+j394jKwCiutwLYU34aRtVcyI3mgebNnPWpELuwcJ7fe8jF0Z1C1Ajl8pQI4v8A
         DjebmHybJQbgJL8sam4QA4YgioB8U/aPBG3kmQZu2CilTpTpMq4/LePBwDzzkciskAPh
         TUWWXJd7XYej+kB0+H4SaR42kPCdAuCr6XsMfENUjPAVE1NNKlQWlDCnF2F+FSYgL/AC
         YsKjN7f6tXq35qWTjTCiogDs1ol9hWwNag8d2zJlMBrOnsecGtJxtFC+7XzC7yOb2TAH
         9avDnQP1tuX8WYuNOVzOebhsdTIi11MU8tm8KJGzHhHE0eZCWUlPoCaalhSwXDVX1JpM
         pTWw==
X-Gm-Message-State: APjAAAVuGgfk+hULf7kOKphlM+dKJyxDOW+9WFS7o0lJYzj69o+AuOYD
        7bzcmuJG4vM5/zqOSm9Bkb7CUpW0
X-Google-Smtp-Source: APXvYqwJnKD1goRVnR0ADorKl9qoLrxd4X2m2EHJDSEgBCoJKh9a3QcclUoL1Mx5gylTHEIdelj9dQ==
X-Received: by 2002:a63:d40d:: with SMTP id a13mr99912990pgh.9.1578337145422;
        Mon, 06 Jan 2020 10:59:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 18sm71758718pfj.3.2020.01.06.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:59:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 1/2] ata: ahci_brcm: Perform reset after obtaining resources
Date:   Mon,  6 Jan 2020 10:58:56 -0800
Message-Id: <20200106185857.11128-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106185857.11128-1-f.fainelli@gmail.com>
References: <20200106185857.11128-1-f.fainelli@gmail.com>
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
 drivers/ata/ahci_brcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 13ceca687104..c3137ec9fb1c 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -453,10 +453,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	else
 		reset_name = "ahci";
 
-	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
-	if (!IS_ERR_OR_NULL(priv->rcdev))
-		reset_control_deassert(priv->rcdev);
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv)) {
 		ret = PTR_ERR(hpriv);
@@ -478,6 +474,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
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

