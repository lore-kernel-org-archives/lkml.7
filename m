Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB8320665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flk5D1GQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfHMVXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:23:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfHMVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:23:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so109217361wru.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=WHUBb+H0Fi59TuSnrPphyzWvLSNTI5lBd4Ed7ZWbKac=;
        b=flk5D1GQPH6bz87YfESC50J2CIiPCWuM1ESgqDS/4CVkPN3FZ6KMdbBY7q10WQi4hf
         DX2kCmk/72jGOrGnEFKaZwZzrcXkjqklChRHJu67ZZCMIf7atO9XzBNs3C8HJTptTkaS
         xpdBn8bHPh15KFc4EQXh/zPuXXuzSkyB9VAzxY3f5TJdX7s9+Bdk96rl+vc6RoB+CCdY
         G2cWaO07eTpKKNa4Od2HyP6tfiJNm/aVekGeE5gfR4Ir5J5xyqI4niDBTlKr/LhXqcWH
         /rffdla4tc9HHN0vx4DG8TxAQqDrTk7tS+G0gjsivKZrdtV7PSOtTsBAuKM26+UIhmzC
         Pisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=WHUBb+H0Fi59TuSnrPphyzWvLSNTI5lBd4Ed7ZWbKac=;
        b=d52Z09SEoic2lHeiVn6BkX6mHlH05H+Pj57/eXCB045oUivDp+1hpE0PwqTpKuZf/S
         mEfatgK25oe14OAZPYdfRCgFuURfi6z5rjbOMd0SdY+TXUB2vhOofKiUhmx7kotWdReH
         XV+ODyYbu6KYG8DlnNqmrFPJndCMydpj0oe+jbLeS8KreEmj9dXtIPgypP1Xjq9MTH9K
         bDttOoWmbkdMs9SvEqRCibbzMML2Pd7hnXrtt3PngS3REBhEkokZX2gPyY+cScZTFBf4
         F2S1SVUzBTztGNT29BxCS7CCXAMnJIcAbaxPeVnB30xoRKKXnt4NDmm6lWyiTv37Kuse
         RKhA==
X-Gm-Message-State: APjAAAVFp5Jpg/4lXL/tzVk0BW9b7kaDx5b5nsGZBf5qyASA6z/CUV73
        ZkQ7jMkeaYkYqMDJYFOK6XpEf8iZ2vhfH0uk
X-Google-Smtp-Source: APXvYqxqDe0eC1jvfVvG5Yg3H7Sma318HlwxlATwTpE2EYroxmXRO+UeMNarOHV9lOjqRVfNUal2HQ==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr48505235wrq.52.1565731428327;
        Tue, 13 Aug 2019 14:23:48 -0700 (PDT)
Received: from Lappy.lan (cpc96340-rdng26-2-0-cust780.15-3.cable.virginm.net. [86.14.239.13])
        by smtp.gmail.com with ESMTPSA id o20sm273957797wrh.8.2019.08.13.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 14:23:47 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     afaerber@suse.de, Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] regmap: fix writes to non incrementing registers
Date:   Tue, 13 Aug 2019 22:22:51 +0100
Message-Id: <20190813212251.12316-1-ben.whitten@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking if a register is writable we must first check if the
register is a non incrementing writable register.
Non incrementing register are deep and do not move to the next
register when writing, for example a FIFO.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/base/regmap/regmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f1025452bb39..70645a28897c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1489,10 +1489,11 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	WARN_ON(!map->bus);
 
 	/* Check for unwritable registers before we start */
-	for (i = 0; i < val_len / map->format.val_bytes; i++)
-		if (!regmap_writeable(map,
-				     reg + regmap_get_offset(map, i)))
-			return -EINVAL;
+	if (!regmap_writeable_noinc(map, reg))
+		for (i = 0; i < val_len / map->format.val_bytes; i++)
+			if (!regmap_writeable(map,
+					     reg + regmap_get_offset(map, i)))
+				return -EINVAL;
 
 	if (!map->cache_bypass && map->format.parse_val) {
 		unsigned int ival;
-- 
2.17.1

