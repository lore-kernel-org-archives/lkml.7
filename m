Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD029C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B5C20659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZ0/toRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfGAP2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:28:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43769 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGAP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:28:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so13612637ljv.10;
        Mon, 01 Jul 2019 08:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7R/PTq1FrTJQOZMaMuQLuy0eR9eOHzUISgHDr8CtHHY=;
        b=tZ0/toRXFe0dk6BKIOkw4bvQ1LSvJ7B8hrxoMtWWUxBO7OhB8qycIDVtiiQ6Ac38s8
         SKj0CJGNLQtgIwX0iDmAC53leMFn74+Nt1ZCLFy0ycxzai4aj6qnFdqBwU7J4sCJJ1oZ
         bN2Rr9XdxaS0eSghYjXyhnlOjy0NI+0FuRvz4xMbr3+gGh/bnDokgwX6funU9ZbNGZ1l
         OqXVWRLrJs5svOSsNpc0FkIeYj3nBUcMA1voWyx+tenGLupcCkW0upf/CMTKy58spt0u
         P6edl/y0c4pZ/MXyRTN+opSbRBLdbn0EtZvMONejEkjzWQ2JRaAltpkNKVJhlKUAOpJj
         0LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7R/PTq1FrTJQOZMaMuQLuy0eR9eOHzUISgHDr8CtHHY=;
        b=iZPDWrVQ8odizXrgxNq2HVBtjgxz+kU1y/aacyhKwdbjWVwxi95Jwu9iFMVxiUhvSK
         05kQqHsJ4gs6yatY6GSX3txym08wwlOieUE4Zz8HX8nHoksmOYYZkJqktXe+Q+2I3XEv
         dOUWSc5nAgQKPkmTb6ZlKpuqaXRiB0aH0jaS6sV8NwmBl2fYUu53OuVxJ4bcXfadeuzc
         KsbeeepqrLbw4YIHK7gG72fcrwOZbLSnGnqvPupACsoC0AR0JDJpU1qCLHzXeJLSAc2B
         wl0CgKHt5XEzg6PR/CSs1eALTGEMNbILJF+KPSiTH92fAkOigaqQkzvzlGTy6MWJmL1U
         6lJg==
X-Gm-Message-State: APjAAAU/VlYl+Bs0T8yb6pKQ9DNCvlv0h6ddxvaYXsZFvZHDYRpuTXrd
        +0j+XALcu7NA8khZcT26Yhw=
X-Google-Smtp-Source: APXvYqxydb3LQTTnZLV/Ae+tkX41rpe5+CuCF9HE+PL+JKMMs7BXPBSf+/nZXBvCXyqfkXEozJ92lw==
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr188073ljc.240.1561994931947;
        Mon, 01 Jul 2019 08:28:51 -0700 (PDT)
Received: from localhost.localdomain ([91.238.216.6])
        by smtp.gmail.com with ESMTPSA id e12sm2561626lfb.66.2019.07.01.08.28.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:28:51 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linus.walleij@linaro.org, paweldembicki@gmail.com,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] net: dsa: vsc73xx: Assert reset if iCPU is enabled
Date:   Mon,  1 Jul 2019 17:27:23 +0200
Message-Id: <20190701152723.624-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701152723.624-1-paweldembicki@gmail.com>
References: <20190701152723.624-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver allow to use devices with disabled iCPU only.

Some devices have pre-initialised iCPU by bootloader.
That state make switch unmanaged. This patch force reset
if device is in unmanaged state. In the result chip lost
internal firmware from RAM and it can be managed.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 36 ++++++++++++--------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 9975446cdc66..5cdf91849b5d 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -405,22 +405,8 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	}
 
 	if (val == 0xffffffff) {
-		dev_info(vsc->dev, "chip seems dead, assert reset\n");
-		gpiod_set_value_cansleep(vsc->reset, 1);
-		/* Reset pulse should be 20ns minimum, according to datasheet
-		 * table 245, so 10us should be fine
-		 */
-		usleep_range(10, 100);
-		gpiod_set_value_cansleep(vsc->reset, 0);
-		/* Wait 20ms according to datasheet table 245 */
-		msleep(20);
-
-		ret = vsc->ops->read(vsc, VSC73XX_BLOCK_SYSTEM, 0,
-				   VSC73XX_ICPU_MBOX_VAL, &val);
-		if (val == 0xffffffff) {
-			dev_err(vsc->dev, "seems not to help, giving up\n");
-			return -ENODEV;
-		}
+		dev_info(vsc->dev, "chip seems dead.\n");
+		return -EAGAIN;
 	}
 
 	ret = vsc->ops->read(vsc, VSC73XX_BLOCK_SYSTEM, 0,
@@ -471,9 +457,8 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	}
 	if (icpu_si_boot_en && !icpu_pi_en) {
 		dev_err(vsc->dev,
-			"iCPU enabled boots from SI, no external memory\n");
-		dev_err(vsc->dev, "no idea how to deal with this\n");
-		return -ENODEV;
+			"iCPU enabled boots from PI/SI, no external memory\n");
+		return -EAGAIN;
 	}
 	if (!icpu_si_boot_en && icpu_pi_en) {
 		dev_err(vsc->dev,
@@ -1147,6 +1132,19 @@ int vsc73xx_probe(struct vsc73xx *vsc)
 		msleep(20);
 
 	ret = vsc73xx_detect(vsc);
+	if (ret == -EAGAIN) {
+		dev_err(vsc->dev,
+			"Chip seams to be out of control. Assert reset and try again.\n");
+		gpiod_set_value_cansleep(vsc->reset, 1);
+		/* Reset pulse should be 20ns minimum, according to datasheet
+		 * table 245, so 10us should be fine
+		 */
+		usleep_range(10, 100);
+		gpiod_set_value_cansleep(vsc->reset, 0);
+		/* Wait 20ms according to datasheet table 245 */
+		msleep(20);
+		ret = vsc73xx_detect(vsc);
+	}
 	if (ret) {
 		dev_err(vsc->dev, "no chip found (%d)\n", ret);
 		return -ENODEV;
-- 
2.20.1

