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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD009C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F595207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzVb/3I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgAFS7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:59:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgAFS7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:59:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so27272922pgm.5;
        Mon, 06 Jan 2020 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4kYkD+SUb7SbLPsbfnAVbKbyKDhqQnUCO7FuiijcfY4=;
        b=tzVb/3I8/4CKtN89hxjhvBviIKQciFr5Nbvt5jKget7U88m5ALpXQHLzLHamwK0Fiv
         MCMcKa21Txo5421c004jHlNdEZEZyZpSVxuw1BcFLUW9QlIrcxaB1qyQXz+Tg12qVhYP
         1m7IT2WPLTgFQiXvLIf3jLseKVcDwIxBGjRIvkRIabXko3ulMYWo12QjtE3/xGC/2XnP
         89uus8pEKfPIOk6A2K5iA7sf2iCJjJhP3vRMxfAbAh/bvl4Q9POCPEboqHWj0G+6V5m6
         7j6UWzqRrYo8NtaJfb5awREZZ1f9p4+eSyd26zeIsMWL9irp5cH7IH6uMHUikA+Im0sY
         i3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4kYkD+SUb7SbLPsbfnAVbKbyKDhqQnUCO7FuiijcfY4=;
        b=OjKluz/Gb57uRAnBfWciatpfc0U2XKnM2HKjCnR0NN4sSi85FASa3oIgkekrORaowX
         CysMgwxwIaX6fV8ybsVrX4B3Bbd4QjuJvzrRtshN7Bwwc1LstgU14rp1x1CfWOvWdjVK
         pKqmIfLXMJJO2tvIPs6tZ+bk5jiqyuEjCeCNqsuXNdqySCg88j0l4hGlsQ3TqvJU0mu+
         lQimIQVFpYjy7ToFh1JmcuPAGKhcY2xPpQe18FKRxXOOZ16feHXdBS+7nTx8LzRWu0IL
         vwAv8G0wh2G5tvhPfT+n2o+YOh69pQ6d++xK7ku5ZTZmYJhunIEztdvuGqNE7khrx+Jn
         1zXg==
X-Gm-Message-State: APjAAAVFKSxHN923KfUoekZQ8ogOHl2flQ47/WWxz/hebAxd07ChniR8
        7vUGaYsjPcTdkX+rBCdTP7zN3mZo
X-Google-Smtp-Source: APXvYqxPIhl0ekNXmxt/C80Lcr2AjjH07VjcWRE3VsTBU6VK2yv2D8+qucCRMZqokgfSQS17GW4coQ==
X-Received: by 2002:a62:cece:: with SMTP id y197mr113645300pfg.9.1578337146668;
        Mon, 06 Jan 2020 10:59:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 18sm71758718pfj.3.2020.01.06.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 10:59:06 -0800 (PST)
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
Subject: [PATCH 2/2] ata: ahci_brcm: BCM7216 reset is self de-asserting
Date:   Mon,  6 Jan 2020 10:58:57 -0800
Message-Id: <20200106185857.11128-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106185857.11128-1-f.fainelli@gmail.com>
References: <20200106185857.11128-1-f.fainelli@gmail.com>
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
index c3137ec9fb1c..5c9fcdb8df96 100644
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
 
@@ -475,8 +479,12 @@ static int brcm_ahci_probe(struct platform_device *pdev)
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

