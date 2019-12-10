Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF62214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtWNev19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfLJSzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:55:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfLJSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:55:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so21340173wrh.5;
        Tue, 10 Dec 2019 10:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MZGxKkjM3GfxdQHN3yZAl1Qk3NVNJ9qPzoQRTnTiiYA=;
        b=gtWNev19Ji+Mx5eOZKN76LtLVlVukccE+8NfVVWNY7TMR6Up4+gelQOx6TeJoQluv2
         Z+ii7LmFS89vctX69+GbL8JVqUKxY819ix/9F7aVSZ8bWtfC+zj4pE8ZpwW+waqulwUX
         MgFLr946UyG19AbNCtJdSYx9+BEUxtHDH3VN7QN8AD5GkmDVVVGDuoCiNfR/Hn+Ro4TR
         zhFVXHdYX7BTrfeSkfAkuwLlyoyzN3PKZhntDhgggHshANQTdGgNiEi3CvdVLaqXJAYd
         AIuftst4TCYEOER+seTqBb4CqORxEYSvs2yr8SkkeEU7cvmTwShbEGijJ3rFQvlsJPhj
         BHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MZGxKkjM3GfxdQHN3yZAl1Qk3NVNJ9qPzoQRTnTiiYA=;
        b=Zom+OQVAdngWEuEFkvLE4YEk/dUPlfKqlU5dKyBOOkBn01+1CBHEtR4h3DlPA3xvVA
         +sCrVjuFf1z3nFiPz6V2k0kmIBTv20tqnYYjPD7NDpBRv6zOEsq+xn84/6yiFb0L/vNk
         XwVPHfj5afIlwNyMn0HyqJVo4zyZHFxCCV67VthsyCZ4fjTsssK/Ec6Y1l8+A34pArU7
         Xy+EXtizDCqezY9+/EyYxUpJrUKwRvhSBocYgdAtwPGfFKhw6Uk++U/pT+9q75Fk6kx6
         kxCQ0nsHnzgCgiQNfMomwrJ0TutJWSuJUxabhnvl1GboJihffA0d2fZ07HV/hVIGIsN9
         McHQ==
X-Gm-Message-State: APjAAAUHHMFBuGadn72yHXEHxq4Wb/7d2JFeZtmAO4hQ8bnuiB8ERqFC
        cZt9/kQmJs0yo4Z+j+hgheWi1BlK
X-Google-Smtp-Source: APXvYqzr7vFBDEMA0EceUoUPW+KD+5q4iMsC32nx3Qq087NgA8IF8RVYtnX7ET8lpzOR69z2jA6h9Q==
X-Received: by 2002:adf:f052:: with SMTP id t18mr4868262wro.192.1576004131730;
        Tue, 10 Dec 2019 10:55:31 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e6sm4213536wru.44.2019.12.10.10.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 10:55:31 -0800 (PST)
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
Subject: [PATCH 7/8] dt-bindings: ata: Document BCM7216 AHCI controller compatible
Date:   Tue, 10 Dec 2019 10:53:50 -0800
Message-Id: <20191210185351.14825-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210185351.14825-1-f.fainelli@gmail.com>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM7216 AHCI controller makes use of a specific reset controller
line/name, document the compatible string and the optional reset
properties.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
index 7713a413c6a7..b9ae4ce4a0a0 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt
@@ -5,6 +5,7 @@ Each SATA controller should have its own node.
 
 Required properties:
 - compatible         : should be one or more of
+			"brcm,bcm7216-ahci"
 			"brcm,bcm7425-ahci"
 			"brcm,bcm7445-ahci"
 			"brcm,bcm-nsp-ahci"
@@ -14,6 +15,12 @@ Required properties:
 - reg-names          : "ahci" and "top-ctrl"
 - interrupts         : interrupt mapping for SATA IRQ
 
+Optional properties:
+
+- reset: for "brcm,bcm7216-ahci" must be a valid reset phandle
+  pointing to the RESCAL reset controller provider node.
+- reset-names: for "brcm,bcm7216-ahci", must be "rescal".
+
 Also see ahci-platform.txt.
 
 Example:
-- 
2.17.1

