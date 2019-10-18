Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C68CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D6E222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F7bCnS3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502505AbfJRRcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:32:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50310 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfJRRcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:32:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so7014758wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Sw0jFW5jGSGbXDR6kjw3sQ7x0eXAWOU04hu+4Lun0I=;
        b=F7bCnS3unseU4Pe5IzC5zUpmWlYMdj2YoPBCoyigGCpOa5U4q61E23KUKl7/OO8nS6
         WUdzxbAus6HqI12ynE+nZwyeZbScvBHaNZ/MS3f0KnUNnx/EplI1jIZL/5iH71+0mdDz
         dcRy9M6gwI3bMmfZsccnxZpqW7Rd51W1NywMy4/Mp4wT89DnDgdkLVO9fv5sh0RYkPyS
         Ehf0VdWN6+9r6al9EuDyaJi+pPQ0TMXNqxP6f179NCcs0/5FVY+iBLYjGQ5xJXBeU71O
         Q8mJc2Fg+yP3dNOPle+Zb1QIZzX2WsgUBZelWPvl8lmHh9R83fIiczy6BM3vNpewfQqr
         /wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Sw0jFW5jGSGbXDR6kjw3sQ7x0eXAWOU04hu+4Lun0I=;
        b=V09ZsId9HxipBuA/NlYMoB2+YloyaJBODZA2hhOS2N2gh+u2+jmi4U6jIsJ2U0ux5R
         jNg8f+XxA6w23/7hCwkcV3Cb0zZnvNiRCcidTK4pOa6lUf49Yx7T7t2rMTTMMSVYMN45
         PAl8s5df7CRcnMda37Z4G3aJJW2V6hLzfHfVCYyeQ81yQobXbUXwaTDguEZZw7KAG5g1
         0QgxPRdTPB88R8HRdnBXX0HhzDWyNQ2lHnoaW7sc+K0T33BVaPK13VoBgB8/qZKotUNf
         TVL3ErkUqnB90IXLA/dnHrvL+aDLly9XyAWEpyCNRiTMOPydU6sTqS83UNP7AEAlkqxc
         iJGw==
X-Gm-Message-State: APjAAAXGlYF/Pw/0idCjv7fq3Gjtnyp/CkoVD+m1CaIOzV/iFaoCM7Cb
        6am4rrWwfqEoAkHoJ6XW/MK3nJGQwfU=
X-Google-Smtp-Source: APXvYqwLL/J/QMgyordUs7NtcgM+iCDETbDA3BzJsTD+EyqWB7RmlJjXBDAvzNb7XcPW3p+O8v6QGw==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr8798906wml.169.1571419936945;
        Fri, 18 Oct 2019 10:32:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:32c:e530:1f62:944f:4c42:96a0])
        by smtp.gmail.com with ESMTPSA id z4sm5911967wrh.93.2019.10.18.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 10:32:16 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Cc:     tglx@linutronix.de, hsinyi@chromium.org, drinkcat@chromium.org,
        qii.wang@mediatek.com, wsa@the-dreams.de, matthias.bgg@gmail.com,
        Fabien Parent <fparent@baylibre.com>,
        Cengiz Can <cengiz@kernel.wtf>, Ulrich Hecht <uli@fpond.eu>
Subject: [PATCH RESEND v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date:   Fri, 18 Oct 2019 19:32:13 +0200
Message-Id: <20191018173213.13282-1-fparent@baylibre.com>
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

This commit add a call to i2c_check_quirks which will check whether
the quirks pointer is set, and if so will check if the IP has the
NO_ZERO_LEN quirk.

Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for mt8183")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Ulrich Hecht <uli@fpond.eu>

---

v2:
	* use i2c_check_quirks to check the quirks

---
 drivers/i2c/busses/i2c-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 29eae1bf4f86..2152ec5f535c 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -875,7 +875,7 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
 
 static u32 mtk_i2c_functionality(struct i2c_adapter *adap)
 {
-	if (adap->quirks->flags & I2C_AQ_NO_ZERO_LEN)
+	if (i2c_check_quirks(adap, I2C_AQ_NO_ZERO_LEN))
 		return I2C_FUNC_I2C |
 			(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 	else
-- 
2.23.0

