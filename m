Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE1AC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63846217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MlHh1i6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfIBPNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 11:13:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39831 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbfIBPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 11:13:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so14397266wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4zyk9Cnbgp0Wbx2zYyh+YsI7opWYp3GPDBFEHm6Kzg=;
        b=MlHh1i6lQJGw+leUixbTWWEE0JEFy2OC2jIZts9L+vQ5vHyF79Ha9Wo63z67EKD02d
         UYCv5h+zCsKgFhhILSMxRQzC32zMZXaQjja745kSFXCbt+XQPSh1lvOdj0//N1lXn9eO
         prwsBAFF1eBKgk+KddJeJIoYTfw90k7P2TUhOUfDBoQHTdWrZZPJ9LCj/ykUtbZakdNo
         7rhDAb7dlKNFR9qoIvXyCVq/w0CwkpncqDV/nIVqBBF/3VE5K3ny915OvvzZNoiAW/0w
         2TAF1cy6dvKNakk94Ku1SfEPWeEfp+2O/32SXWYocUDn68JEY4RgD4qgDx6kXWM0Aoo/
         6X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4zyk9Cnbgp0Wbx2zYyh+YsI7opWYp3GPDBFEHm6Kzg=;
        b=tbQDyF85i37UBoGr9lREcHEtOWlQBMcmLyykQ1FKsCVvVGDDjGwevoxtkA0JzDjjdV
         j9P0oYL6DBEYCUExa7QjL0LJd2/hf/7uDj9y0T8npW+/uwHPibcsqolqU5vJKAL04Qq1
         udzZleGi24SirPwLxrf6VV0A1a/upy477c9HuWqrGkMqP0x/qgCZLaxDhbp2/hF73Cyn
         +esTn4V8Mz9BnIDySuFdd2T39oCIBnYuktgRONGu0O8l6VL+KW3RFVGeKCHhhbS0eKHa
         y2qGBxwuSFri3xsdGX8G2psIlDpoztFeSssPYFC+jkFwjPZRNXUczhktFi8iEahxOBaa
         7Gow==
X-Gm-Message-State: APjAAAVOAJyRFmTHCq56xS3XmeWXazOHL1kiAPWmcSCF/NrKS5ZTNAY9
        /DXbG4fDulqGmK1Ez1Agte9rsTX3Gy8=
X-Google-Smtp-Source: APXvYqwYZuCDbSNew+Wvcew0Osd8yHVfRwhE8L/8iKuf8HAsPliiu9/fmiX85RcoVEwTjAQU35YD9w==
X-Received: by 2002:adf:9043:: with SMTP id h61mr36470379wrh.247.1567437214852;
        Mon, 02 Sep 2019 08:13:34 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id l20sm12882014wrb.61.2019.09.02.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 08:13:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regulator: add missing 'static inline' to a helper's stub
Date:   Mon,  2 Sep 2019 17:13:32 +0200
Message-Id: <20190902151332.28058-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The build fails when CONFIG_REGULATOR is not selected because the stub
for regulator_bulk_set_supply_names() is missing the 'static inline'
attribute.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/regulator/consumer.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 6d2181a76987..337a46391527 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -586,9 +586,10 @@ static inline int regulator_list_voltage(struct regulator *regulator, unsigned s
 	return -EINVAL;
 }
 
-void regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
-				     const char *const *supply_names,
-				     unsigned int num_supplies)
+static inline void
+regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
+				const char *const *supply_names,
+				unsigned int num_supplies)
 {
 }
 
-- 
2.21.0

