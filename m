Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A46C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6680F20657
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BUkFTqNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCIS4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:56:38 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:60872 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfCIS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:56:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 9DD27C67
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 18:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gDG-Td9-oOMS for <linux-kernel@vger.kernel.org>;
        Sat,  9 Mar 2019 12:56:35 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 72A7597E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 12:56:35 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id v3so828573iol.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FTcEVPag8nS+fa6JTG7rl1xdy0ppSBpdVtsHxaw8feE=;
        b=BUkFTqNQZJuuD13b+NL3oZt76U1bVC3FJ6iHIznPjkR/ZLDnNf4X4pImnLmwGSt57T
         rAm6Q2XZ6u6jLh3pc5uVxIdpWZfN9bFUGdlcksDahWAiA30ljxwrKEFOKgAI6TPyASOw
         1uOMbP2xUL5sNeE9sv3xkEb/IHS0DKaBXATokjUAX1E2M/4OQZspyoMUUv96jvDxFzYF
         M7SjxRl793B2zi8wNtRQNNvk9bh0MbrNQmZyLGC1rN28U2MaYPgxyKzEMMGi3ROyFUmD
         BIHyuh7q/fQVGhSHEm5BjiTZq1xjaR1SHjfm4uZUdZTATXX7P9YhswGUI1z2X0IIcAvl
         K3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FTcEVPag8nS+fa6JTG7rl1xdy0ppSBpdVtsHxaw8feE=;
        b=fEvpr6LDMIEDdwjsqGgyBX/r43w+Uoy5pvLox0oTH3IAaFR4zFnmDTqIr/5lpBFNwJ
         anuu2ckdQMemUQEIkEcHsgx10ENCjsAGCdMECNLR+6wLPheKImb7ZEp6Cj/7FRt5QXEn
         GcSaYVSuYPLsr3VyzMG6HuTPatdJaEn4KJF1OWbADpJU69W2vkPsvEycrl3VLNgCKQGw
         sGnkcrtCvojzIOjLUGFVQxuWgMfCvQyn/Lsnwi/aOx9fPOvuLXsIBj5iVz25LGF9yK7S
         Fdd2RmS0F73rkggTs34PUEmoW9us8fITYNDBxBK7KTCtq1xxpxU2lLdS+o2zxNRlrtjF
         cPyQ==
X-Gm-Message-State: APjAAAVVs9ko2BR/aRxCiZBMyV2CaqvlHawiUx2OdqPSmJyBkR0fscn9
        wV9p15kj1hmhHY8i9tcdVDfsU8c4OWkFpRZKlF1jos6y9HLo9TMqqujIFkbmx7IYFngVI4e8bP2
        399dKKDoK5PCGJMQ8oeLIunY7Qohk
X-Received: by 2002:a5d:8982:: with SMTP id m2mr14598897iol.164.1552157795522;
        Sat, 09 Mar 2019 10:56:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxWN5J1k1+sAjKICs6/Cr65QKkR2e03MHrjNLE1Hl3OiO2TUYCJl8V2m2gvIN9sW8sUkq8j5g==
X-Received: by 2002:a5d:8982:: with SMTP id m2mr14598876iol.164.1552157794922;
        Sat, 09 Mar 2019 10:56:34 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id o129sm6217630ito.0.2019.03.09.10.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:56:33 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: hmc5843_spi: fix a NULL pointer dereference
Date:   Sat,  9 Mar 2019 12:56:27 -0600
Message-Id: <20190309185628.21059-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case devm_regmap_init_spi fails and returns NULL, the fix
returns an error to avoid NULL pointer dereference

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/iio/magnetometer/hmc5843_spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 535f03a70d63..15e2f7cbb3b5 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -59,6 +59,12 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 {
 	int ret;
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *devm_regmap = devm_regmap_init_spi(spi,
+			&hmc5843_spi_regmap_config);
+
+	if (IS_ERR(devm_regmap))
+		return PTR_ERR(devm_regmap);
+
 
 	spi->mode = SPI_MODE_3;
 	spi->max_speed_hz = 8000000;
@@ -68,7 +74,7 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 		return ret;
 
 	return hmc5843_common_probe(&spi->dev,
-			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
+			devm_regmap,
 			id->driver_data, id->name);
 }
 
-- 
2.17.1

