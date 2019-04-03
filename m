Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B09C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332DD206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9uq1pgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDDQNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:13:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40021 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:13:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so1600290pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYyeiQLL73tEM/u50L/tx+FHr1FUO0o/H2RVwcC12A0=;
        b=E9uq1pgMKWm6hxKKCzFDwA8icMbuzNd/D7sKhUDXQ/BDu79Odyz+1dWRAZ1rlcgrv7
         PwQXAx251zhxWx5dPpSjVvBF95ymHXS855YoOZ7B0KQEsxdbdMUebEqfDacC4NG6INtg
         P6Qons//YqdYx8sUjTo+SvlLlQapTqB8HYRT2qfIBxtaIf3cgy8CSzWr9je5+SMDGxPJ
         Pj7vTP7/ciw5k86VV7Z/BmVWg678iEJXm/+MQfBPrWTBKXorOn9hO1VBeEdLMGdbnqEo
         QcGv/1RTgY4XpVJN+ZjYs0uJq4v36/r1noldIGrK2TDDKhMt7FlksDJi0s7Ma18SuGcy
         x0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYyeiQLL73tEM/u50L/tx+FHr1FUO0o/H2RVwcC12A0=;
        b=a2/k1EUF5JIoSG2CJII7oP6g3rUw856KW4jU8+9BcfCWBtpTGaCwq3Ij+05addNgr6
         sR2MChemH7Ol1EWkRMfCurnACKCj3UnT/Z2O8oMD1DuyzM1acB7dUj8pxT/xp8AcJT+b
         VMJcEK2M2YD8T1ptB8LSVgeyd/2yvGCiYvwVI/cS31a9OOTb3oJm8wOfGH/EPnrvVLSH
         XgjiXatVPNHqVEoNlhehE+g+Wf6Vry7VNjr5pjbWIyyX24jKOztTm1xtMaO93gHOxddf
         /GBcZiKN+rPrcJA5Rjx4mKaQv6trvA3QlIaJgLs2vnl/ADHZXSNKkx41hB4tM+zBt7xI
         Wlqg==
X-Gm-Message-State: APjAAAWzm50PDecggPdaAd64f8MUW6ELCRJ7yWOr/ozqtkRs4JMBMlKR
        1hVe3xa3a0gbarpIEcqho/U=
X-Google-Smtp-Source: APXvYqymu8xV98295h044l/TmWIuGnlvH5wX/hIriNKRBYKHx3vda37Ev7l/oBw9UBFwZ1/woz3zDg==
X-Received: by 2002:a62:62c3:: with SMTP id w186mr6728151pfb.73.1554394390701;
        Thu, 04 Apr 2019 09:13:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:9681:c7ba:deef:ba65:b868:9005])
        by smtp.gmail.com with ESMTPSA id c17sm28507738pfd.76.2019.04.04.09.13.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 09:13:10 -0700 (PDT)
From:   Nilesh Hase <nilhase25@gmail.com>
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, neil@brown.name, sr@denx.de,
        sankalpnegi2310@gmail.com, gch981213@gmail.com,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nilesh Hase <nilhase25@gmail.com>
Subject: [PATCH] MT7621-SPI: spi-mt7621: Fix alignment and style problems     Fixed Coding function and style issues
Date:   Thu,  4 Apr 2019 01:01:07 +0530
Message-Id: <20190403193107.23873-1-nilhase25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nilesh Hase <nilhase25@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index b509f9fe3346..6fa9876f5a92 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
 	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
 
 	if ((spi->max_speed_hz == 0) ||
-		(spi->max_speed_hz > (rs->sys_freq / 2)))
+	    (spi->max_speed_hz > (rs->sys_freq / 2)))
 		spi->max_speed_hz = (rs->sys_freq / 2);
 
 	if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
-- 
2.20.1

