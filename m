Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF00BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E4B21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeuL8ziv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfEQSdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:33:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34581 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfEQSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:33:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so11943199eda.1;
        Fri, 17 May 2019 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BjD/hLmyWdf0NxPtEyGr7A4l+oVrtiHdbaFge55fb3c=;
        b=qeuL8zivm3qB3CHSXskrouAD+Q4290zHeWoWT8S731bP1s/SL8tdtcwQcG8xEMwQSN
         pDY+BENukAGdKHCnMewMyV6H+OZdMB9ud/heH0xx2/OauY2R4PcYscUF/DmfyE8zxlnr
         24TdmIl+5CDLlR4x359IjFBFTWJ8Impp3IF7V+PMjearxZ6+Fo+NrOUvhZ8MbxrUZKzn
         uA3+cWRgT32L2ej/JzUhoE9k0AaHkqqiLxJRDkqA2DCuIBzd0G5LgTAC9O1j1e+VDcZQ
         v3USP7u2LA23o8Zf78nbFoZmK4y0UDjAOVwvwxxqLPS0vLwcepiWBgSH3XgkITvfl0pW
         +qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BjD/hLmyWdf0NxPtEyGr7A4l+oVrtiHdbaFge55fb3c=;
        b=VT1R5yvWqMwboslEXjHpVX/1sO04fZb6Jq/HyOTafyrErvpL8x4BHZbyxYEwBX1WFs
         pl/rGbUIRWdh5JTK9Cr7zKJnBM5yg/Nu3HagHjQZk0k2TROKUqpFQVPMPGx3uP0wEHvX
         as/bOXp4HLNdLE8ekhS2AAmPvQaeSOunEgBRvCRWIjltu79/iM2EJWa33hyLzZuzTdyC
         AOKwWzuIU8B9m0sSvyrDIW6vVjdX+uUhSwN+5jQS7ymoAII5j3gLw/3uDKQdyuI6gs3q
         QDUxeNLYUwXjXi2DFv/ubsEiwmU3Mj0PEnPzEJf7HY3PlEXzT0R48JuoRaZ6vEFqsdF/
         O48g==
X-Gm-Message-State: APjAAAWSBCdUQOIZJ4Obxs0f2Guc2O2sTNZnBn8qnWoWaWT9BZSTk9oQ
        h61uv4t/CM6AMxaNVmLUdp4=
X-Google-Smtp-Source: APXvYqyQrr/jjTQ38l6Sibivrh9zTM+AWzaIkJ3ftnBxf11BDjXBKeRfiQV0gg8ONoYodsh1qvdgvg==
X-Received: by 2002:a50:d2d4:: with SMTP id q20mr60123979edg.120.1558118031463;
        Fri, 17 May 2019 11:33:51 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q19sm1687127eja.59.2019.05.17.11.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:33:50 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nand-ecc-step-size optional
Date:   Fri, 17 May 2019 14:29:54 -0400
Message-Id: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nand-ecc-strength and nand-ecc-step-size can be made optional as
brcmanand driver can support using the nand_base driver detected
values.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index bcda1df..29feaba 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -101,10 +101,10 @@ Required properties:
                               number (e.g., 0, 1, 2, etc.)
 - #address-cells            : see partition.txt
 - #size-cells               : see partition.txt
-- nand-ecc-strength         : see nand.txt
-- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
 
 Optional properties:
+- nand-ecc-strength         : see nand.txt
+- nand-ecc-step-size        : must be 512 or 1024. See nand.txt
 - nand-on-flash-bbt         : boolean, to enable the on-flash BBT for this
                               chip-select. See nand.txt
 - brcm,nand-oob-sector-size : integer, to denote the spare area sector size
-- 
1.9.0.138.g2de3478

