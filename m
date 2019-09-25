Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D035C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1921D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dOzuI9mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393165AbfIYUbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:31:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42412 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbfIYUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:31:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so8411972wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcBsCzwhp5Ecgxfu1Yf/yNSTuRVO8fFdckSjieoTLBs=;
        b=dOzuI9mJG7MNkBkGgMGYhShhE5duhtiVQDyWLneLxX5wD/HCWf9T/PGCnLnPzC7wtc
         ysS3Th4+kQaByGMbqsOJTgU9iown1CZdT89pHVI0AwdYL8iFDKcrSGBjpJLG5UVdC/Z5
         eFEL4LYNjIxiH8xHZSo6ggGvIjxXX0eE8hVW8ghYYZYge090LkWEtqou4uIwMC+Q6C7K
         BmI6qzs0PsJPxUaEiJH3kQJ+Rut1XEYojN4XokuuEIzUqBoZdypscGa3T0t7AJulGOCi
         pQeAI/Uc1o44hsSpr1OWt2THVPdcK3Q0ilf9Qd1CykPt2J7mq2nyU7AkflhRneuODZeh
         d2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcBsCzwhp5Ecgxfu1Yf/yNSTuRVO8fFdckSjieoTLBs=;
        b=FBCvjUvXr/7c/ClUbKUgRQGtTzFNgzTUZaEkTwvbrcK0EcMnCwP6GVK6igjqXcfoBw
         SLSO5rkAWgJQgrn1YI7tibNPVPC6EALRoaFGU5pf0YzjUpvNhaCfTmWCLNP72reh0msU
         BWhfvgsU95bJ9Ccm0XrSiIC3C9Fi3Fc31z74fpCGf0Q9p122PozTDQj/rJh6KD93a/0N
         nq6LI/G722QPfowQaN9nXvfTc9CMhxNzVsHhKrPuMiKuU2F3gfYodVpQWQ6Iupxys0lC
         kyr+ZUiz8VX6YFmMYP2w2RX3QCZAARFx6evp8Cz/YH/p0XaGd58aKIOBNn4qECKTazki
         UFog==
X-Gm-Message-State: APjAAAU9t2xbw5eJgo7fQnQx1apzlI3QIlOEjj2rovundPMDfHyvfomq
        3ePMwYQvpLrvtdJcYppJuMzO1hK9B+U=
X-Google-Smtp-Source: APXvYqwzQxZ9IYuGZE7fRHX9HR9jZ3vCuFGihvzGzRLMzKQ9kPDNMFvtmH/a4e7Uuo1sLkQjk6Emtw==
X-Received: by 2002:adf:cc87:: with SMTP id p7mr142508wrj.43.1569443477086;
        Wed, 25 Sep 2019 13:31:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ecba:5540:2c05:40e4:899d:aef0])
        by smtp.gmail.com with ESMTPSA id j1sm301348wrg.24.2019.09.25.13.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:31:16 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, wsa@the-dreams.de, qii.wang@mediatek.com,
        drinkcat@chromium.org, hsinyi@chromium.org, tglx@linutronix.de,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH] i2c: i2c-mt65xx: fix NULL ptr dereference
Date:   Wed, 25 Sep 2019 22:31:13 +0200
Message-Id: <20190925203113.6972-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit abf4923e97c3 ("i2c: mediatek: disable zero-length transfers
for mt8183"), there is a NULL pointer dereference for all the SoCs
that don't have any quirk. mtk_i2c_functionality is not checking that
the quirks pointer is not NULL before starting to use it.

This commit add a check on the quirk pointer before dereferencing it.

Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for mt8183")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 29eae1bf4f86..ec00fc6af9ae 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -875,7 +875,7 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 
 static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 {
-	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
+	if (adap->quirks && adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
 		return I2C_FUNC_I2C |
 			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 	else
-- 
2.23.0

