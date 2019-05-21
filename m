Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2594C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A724421873
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6m0bG+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfEUOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:44:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33797 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbfEUOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:44:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so8575023plz.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YjYseCZQLoFuFy6wB+/po9n3RrWPo0OCVJ23Hjgjzo=;
        b=N6m0bG+uzJyuf+DqjNJb+TpKxpL8saEuXMtNVMAixVRdWPgVWnBoBFB7DwGf9okZiV
         WRgwu0rORwzAJV2dJpMizvWiHbdB41xYe/NhwVp9xt2c8g99kmJn200iR1u0cFu20XxB
         GcwSlvogROTc7LhP5sKxeE2aSz2Mm3hVynpdoo6GKB0sl2Y5Ydtdo+3pcWh8qwiFzOQe
         mjqp+Nxj/BS3fy90oYbWqkX+wBLUsmLLutQSjodabbSB/SyQotvIJsi64hz8AWByWo/q
         9ZahZpO9zY/2dd4dkgGHoJvI1tbjbIYBxQ/LiylAu96Zy9W+6Ke8oib2Q390RvuXCjbR
         2LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YjYseCZQLoFuFy6wB+/po9n3RrWPo0OCVJ23Hjgjzo=;
        b=Tfkht7nCSsAw3yvAkMLgNXt2DNw5OgLiAGuD6/k0aoYI+Wt3tKb4dhl+yZsi7UA3D1
         F0WpHKkCS4yBcr+awwm5TRcdil3m1FgDI+HdW0MaV+QlzWWaint1X7hwkilcl7w8QU8n
         W4lxdkYtse+fgKXyWjNAcBWB3arI2i49umtLrR7dEdZbsb3GTje40EqzU0aANIK/OlAo
         P/O6cpOTVbqa+y3tmV7fczbezlY8uKbc6VMuj2n0X5KA5VZjLMjQ9BUmQVs7JEbxVx/7
         SrRSStjW65paY3hs/LRHCtu7Va0DfGCEJiadPEd1DI3Qo0/KRe2sqC5/Czk0f83JHXmg
         9+6A==
X-Gm-Message-State: APjAAAW6WPLhWts4x/x/rgWWrErHIWNHOAfCHLiOc/gFKFngKhLFmW4J
        6oQXjV/bzTDUmfKO4JVoMUw=
X-Google-Smtp-Source: APXvYqwfIL0O2kND4Rj47U/np0ygx/4AxrznFqfRoEJlDQJHOBU7SmyycyslnSilj8K1SoQPunggKQ==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr7998295plb.329.1558449888952;
        Tue, 21 May 2019 07:44:48 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g17sm13227945pfb.56.2019.05.21.07.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 07:44:48 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v3 2/2] mtd: nand: raw: brcmnand: fallback to detected ecc-strength, ecc-step-size
Date:   Tue, 21 May 2019 10:44:22 -0400
Message-Id: <1558449865-36852-2-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1558449865-36852-1-git-send-email-kdasu.kdev@gmail.com>
References: <1558449865-36852-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change supports nand-ecc-step-size and nand-ecc-strength fields in
brcmnand DT node to be optional.
see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt

If both nand-ecc-strength and nand-ecc-step-size are not specified in
device tree node for NAND, raw NAND layer does detect ECC information by
reading ONFI extended parameter page for parts using ONFI >= 2.1.
In case of non-ONFI NAND parts there could be a nand_id table entry with
ECC information. If there is valid device tree entry for nand-ecc-strength
and nand-ecc-step-size fields it still shall override the detected values.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ce0b8ff..1bdd490 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2144,6 +2144,17 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 		return -EINVAL;
 	}
 
+	if (chip->ecc.mode != NAND_ECC_NONE &&
+	    (!chip->ecc.size || !chip->ecc.strength)) {
+		if (chip->base.eccreq.step_size && chip->base.eccreq.strength) {
+			/* use detected ECC parameters */
+			chip->ecc.size = chip->base.eccreq.step_size;
+			chip->ecc.strength = chip->base.eccreq.strength;
+			dev_info(ctrl->dev, "Using ECC step-size %d, strength %d\n",
+				chip->ecc.size, chip->ecc.strength);
+		}
+	}
+
 	switch (chip->ecc.size) {
 	case 512:
 		if (chip->ecc.algo == NAND_ECC_HAMMING)
-- 
1.9.0.138.g2de3478

