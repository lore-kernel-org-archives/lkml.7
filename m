Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF24F2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGV3PPD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbfJJJvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:51:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32884 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbfJJJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:51:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so6725397wme.0;
        Thu, 10 Oct 2019 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OG3k/fhvlc/AA6RizL9Af/sd7AzPm1RXL7y5lP2bZ+0=;
        b=DGV3PPD26+aekcSvDrMT3Fz0/AWM4PpSVhkB/quLmEzuMMtaIV6rLxMZpYKqNLb1O6
         U2dueoibYIC40p7TCNh9BaNh2xphJ912o1kQpuv7VBKMiighybq+1wNpeAsJVWJdvPRl
         dv7IuP/GMp7DxgAvVc8qc6jopRMh1lo25HDr2LIc6HBgUnoas76cW0URS83DbUYKHN43
         HkAaguQaMYgAkgyxlrFBUS0bhj9q651BE5pUhEq5Z73gD9gP3rhCE0d6yQNWwT38jac0
         SGQxl+2Q8IL06DflDFFSvgqNOLX1Meh2yyQbW1SXN+9+LtQb/lhtnKngwGqIE46n2mXt
         Up3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OG3k/fhvlc/AA6RizL9Af/sd7AzPm1RXL7y5lP2bZ+0=;
        b=bxx6BIE/opADxy0VbXCfPJOQdmmJ3ySR2K3Hi+JHejcdoqlfYbJPHQQz28Sh4vnPhy
         fOsc3GrznjgZ3EZkMVdgP6WOr3sKuhOlmCg8pcpNYN6L4SS6mANLCzFKv10pdI8hhmNk
         pO9dvJaHfO1r2QJk4h6To9ZVEeK+bOJDSA2Zm+ydVGE0BKayYc8QoTldDCGzJHTa2TjV
         CbElAfSSvbnaPA0/WTOLi7S60oWupuNXeHLMRZ18ayTkZ12Bq0hTZ4NyM7oDDo+WSB9i
         ROsU8Hb4CQwBUJyWN9zZxPyqEgSJ23GPQbaABX54bnKIcmUZZgTAfKRuCvCEXi+kMr6q
         NN9g==
X-Gm-Message-State: APjAAAW+qd0xZFlEkQ07YqTLYk+Y9aWH/PpSIhNWGBQuy7nsiQNZ4BSD
        gilhsyI/DMm/MPVbgB1MBrE=
X-Google-Smtp-Source: APXvYqz7bia0tQGw1TblRvVjnoCr7hexrV8AeSR3ExiEHcejj7w9uyF3pc9zAOTdXVY/+T8yR/12ZA==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr3655489wmc.121.1570701096444;
        Thu, 10 Oct 2019 02:51:36 -0700 (PDT)
Received: from localhost.localdomain ([46.114.37.24])
        by smtp.googlemail.com with ESMTPSA id o4sm11678251wre.91.2019.10.10.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 02:51:35 -0700 (PDT)
From:   Gon Solo <gonsolo@gmail.com>
To:     mchehab+samsung@kernel.org
Cc:     linux-media@vger.kernel.org, mchehab@infradead.org, jp@jpvw.nl,
        crope@iki.fi, sean@mess.org, linux-kernel@vger.kernel.org,
        Gon Solo <gonsolo@gmail.com>
Subject: [PATCH 3/4] af9035: Make speed computation clear.
Date:   Thu, 10 Oct 2019 11:51:02 +0200
Message-Id: <20191010095103.3803-4-gonsolo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010091848.GA2898@Limone>
References: <20191010091848.GA2898@Limone>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gon Solo <gonsolo@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 3afd18733614..51e607ea3add 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -1197,6 +1197,15 @@ static int af9035_frontend_attach(struct dvb_usb_adapter *adap)
 	return ret;
 }
 
+/*
+ * The I2C speed register is calculated with:
+ *	I2C speed register = (1000000000 / (24.4 * 16 * I2C_speed))
+ *
+ * The default speed register for it930x is 7, with means a
+ * speed of ~366 kbps
+ */
+#define I2C_SPEED_366K 7
+
 static int it930x_frontend_attach(struct dvb_usb_adapter *adap)
 {
 	struct state *state = adap_to_priv(adap);
@@ -1208,13 +1217,13 @@ static int it930x_frontend_attach(struct dvb_usb_adapter *adap)
 
 	dev_dbg(&intf->dev, "adap->id=%d\n", adap->id);
 
-	/* I2C master bus 2 clock speed 300k */
-	ret = af9035_wr_reg(d, 0x00f6a7, 0x07);
+	/* I2C master bus 2 clock speed 366k */
+	ret = af9035_wr_reg(d, 0x00f6a7, I2C_SPEED_366K);
 	if (ret < 0)
 		goto err;
 
-	/* I2C master bus 1,3 clock speed 300k */
-	ret = af9035_wr_reg(d, 0x00f103, 0x07);
+	/* I2C master bus 1,3 clock speed 366k */
+	ret = af9035_wr_reg(d, 0x00f103, I2C_SPEED_366K);
 	if (ret < 0)
 		goto err;
 
-- 
2.20.1

