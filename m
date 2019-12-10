Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088FC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42D0207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVRphTYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfLJSz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40556 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfLJSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so21311056wrn.7;
        Tue, 10 Dec 2019 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=buyLI45l4zB2SYDrnrkuR0XbVX9htttO2YBB5BmsEdg=;
        b=lVRphTYlkKXnztZvgIn6OhW2ANapDiarJXM+1NdrWmhdluIthENf58m2q+4BDl958E
         XVlz6rNhmXRpXxY6HFfeloYi9FFHi6dVGLOEw/5xPb5A9HyfXV9lggTLIYPHu+WHLrfz
         uf6QleJcHZCvSaI1AAr+CFDxDPChU1tfpFRuNo1AoX1mcQhffC4nvXxpnJJbqu91J7R0
         TrOiUnN5dhLwRIqxam0RHfld17iM/vMNK0ZO8joAYIXF8UhncSyASuQqLMT+4YxkybAs
         Lf7Rqd+yND2ThEaULn7JXZ02XJ5IhRqkyS+G44SXlW9OShR+LM5B0dh2lm3ZZ7/sCTxs
         Z+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=buyLI45l4zB2SYDrnrkuR0XbVX9htttO2YBB5BmsEdg=;
        b=oK/8RVFvCnj/lUmGthqUoySBm6fMubclEhwXLN6H38Kl3nWyN2j9WzYbOGYs3fhAeL
         OEov1DdCXXXrpyolv+KTpcTzRIKNuTPcZW46C7VcP22p7QvwHqvsPSbieo2c+79O1HtO
         X1evVQA254/EYST3OBZ2yj+9OunuJT9OEpGVkx4jpVlsegPX9lYtEHnwQhkUhxB6250r
         Q9LJO+h0CEifa9UqzAnbX0LcGgMG9MgHiN7yQp5y/WFbrXsCtSIa/gFMVddn9jxhbvez
         uoOjzOmKnhR/6XnoIFV1E0DeScXHPe+/sTVaYFKga1aR+dbDLtqcpVuXS3iFGzL36Ohq
         CIxQ==
X-Gm-Message-State: APjAAAWTArv21k6bEVjscREy8zM794RMNICIftseCSJkZrPlr9HVFsEZ
        iPNGL5qbEa8lF0HYPQ2S03O7jW18
X-Google-Smtp-Source: APXvYqzj5EReFxF160THPK7rEWBfVB4+rTGlzMJbnbHBDFvu8E8Gz7fADcgSauoJzarnONnYz2LNWw==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr4939176wrt.366.1576004122183;
        Tue, 10 Dec 2019 10:55:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:21 -0800 (PST)
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
Subject: [PATCH 4/8] ata: ahci_brcm: Add missing clock management during recovery
Date:   Tue, 10 Dec 2019 10:53:47 -0800
Message-Id: <20191210185351.14825-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream implementation of ahci_brcm.c did contain clock
management recovery, but until recently, did that outside of the
libahci_platform helpers and this was unintentionally stripped out while
forward porting the patch upstream.

Add the missing clock management during recovery and sleep for 10
milliseconds per the design team recommendations to ensure the SATA PHY
controller and AFE have been fully quiesced.

Fixes: eb73390ae241 ("ata: ahci_brcm: Recover from failures to identify devices")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 58f8fd7bb8b8..66a570d0da83 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -274,6 +274,13 @@ static unsigned int brcm_ahci_read_id(struct ata_device *dev,
 	/* Perform the SATA PHY reset sequence */
 	brcm_sata_phy_disable(priv, ap->port_no);
 
+	/* Reset the SATA clock */
+	ahci_platform_disable_clks(hpriv);
+	msleep(10);
+
+	ahci_platform_enable_clks(hpriv);
+	msleep(10);
+
 	/* Bring the PHY back on */
 	brcm_sata_phy_enable(priv, ap->port_no);
 
-- 
2.17.1

