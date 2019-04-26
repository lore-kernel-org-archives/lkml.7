Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50579C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2190B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy1VTQH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDZPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:06:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35789 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDZPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:06:51 -0400
Received: by mail-lf1-f65.google.com with SMTP id j20so2764477lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uK1bPzXfoKqtAuaxFD9Fq0QPMIelpERA39QXbQVkvIg=;
        b=Uy1VTQH1+NF1sh+lwHjoPc4Ep9K2d8TefI4IG/PIxokwnNKQ/L2A14hJhvPbRVcoFy
         RpTUAzE5j3sywdjGfCe/nBkE57lXS2tSBxovsAjCbB9pekvm0J4z7f1HjeCE+noUOOh5
         qeFybjLsuVap6L6JCZzbG3xEqymrOvMgtK7sP005PaD/WsrJeKfCB0p3rKfZ5hIc8pYC
         Nr9yeZu9lkGw6P7k+dOMPz79Hykzc3pNiMDkHQDNXA+KrpuCBRPa7gDmFt+ItDECJdsy
         MbtL5Ia6hPxfIxt034pQLeVWG6ykR46S1dp3FMPIWLco1jih118lgV6HbtO5jElM9HjF
         yqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uK1bPzXfoKqtAuaxFD9Fq0QPMIelpERA39QXbQVkvIg=;
        b=GGEEAP9XnrhTc6oc2Dx0QXK+uhkoaTHyuZH7DxrVOpgA22pIGHr4AUsn6id3qFV5Fb
         jNMni7DU1fM27qhRNptXHlGYoUsS9ew3LEgph5gGewmBTqTID51r76Llg0KdrxNLMcbe
         c/9IdEpIytPk0lm3uy8eh5QH9sPgc5xWyHVOiGe2e2cuMmDaLg5BdaiUmcNAiPXfXWFx
         D3/fd8pbBOmuIutqod8cPUxlfGRrcdzh8A0Mavr62RGc7vHIj10v/FghjB/P+xeCSLqo
         R9kntlcW2hjEIyn6FQ3flCWXO8LEM8KAzAt2N3AZ9z2+qPsIjG1Gp6hkHKj0nBxuHkp/
         gXqA==
X-Gm-Message-State: APjAAAUUjCV+PNO4DHeoYj2vEtwh2FawjDbimQlgwGVN906VlqZJSDHS
        T987VrLuR6OQazwz+76wy3s=
X-Google-Smtp-Source: APXvYqzBuRAqCPFkR5+/YMDV+V9w4WpXskZfYfptKWo+v6n34mGJw53MRtyvwLFksaSbZdZwCmtfmA==
X-Received: by 2002:a19:48c9:: with SMTP id v192mr24276282lfa.136.1556291208973;
        Fri, 26 Apr 2019 08:06:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id o3sm5636622lfn.41.2019.04.26.08.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:06:48 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH] mtd: onenand: Add support for 8Gb datasize onenand
Date:   Fri, 26 Apr 2019 17:06:34 +0200
Message-Id: <20190426150634.5643-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Used in several S5PV210-based Galaxy S devices, among them SGH-T959V,
SGH-T959P, SGH-T839, and SPH-D700.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/mtd/nand/onenand/onenand_base.c | 2 ++
 include/linux/mtd/onenand_regs.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 4ca4b194e7d7..abdef0bd1367 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3260,6 +3260,8 @@ static void onenand_check_features(struct mtd_info *mtd)
 
 	/* Lock scheme */
 	switch (density) {
+	case ONENAND_DEVICE_DENSITY_8Gb:
+		this->options |= ONENAND_HAS_NOP_1;
 	case ONENAND_DEVICE_DENSITY_4Gb:
 		if (ONENAND_IS_DDP(this))
 			this->options |= ONENAND_HAS_2PLANE;
diff --git a/include/linux/mtd/onenand_regs.h b/include/linux/mtd/onenand_regs.h
index d60130f88eed..9640d707cbf8 100644
--- a/include/linux/mtd/onenand_regs.h
+++ b/include/linux/mtd/onenand_regs.h
@@ -80,6 +80,7 @@
 #define ONENAND_DEVICE_DENSITY_1Gb	(0x003)
 #define ONENAND_DEVICE_DENSITY_2Gb	(0x004)
 #define ONENAND_DEVICE_DENSITY_4Gb	(0x005)
+#define ONENAND_DEVICE_DENSITY_8Gb	(0x006)
 
 /*
  * Version ID Register F002h (R)
-- 
2.20.1

