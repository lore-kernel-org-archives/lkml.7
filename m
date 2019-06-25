Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5659BC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F7020657
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 23:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfFYXdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 19:33:44 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36611 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYXdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 19:33:18 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45YMsl1Kqqz1rh8r;
        Wed, 26 Jun 2019 01:33:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45YMsl10Vpz20Rx6;
        Wed, 26 Jun 2019 01:33:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id RjtqJ4q3UDsS; Wed, 26 Jun 2019 01:33:14 +0200 (CEST)
X-Auth-Info: zBrVjxkKMbfWqKp2Cl795HfNVguRxOsqlOBmoluSHBg=
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz [86.49.110.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 26 Jun 2019 01:33:14 +0200 (CEST)
From:   Marek Vasut <marex@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [RFC][PATCH] regmap: Drop CONFIG_64BIT checks from core
Date:   Wed, 26 Jun 2019 01:31:16 +0200
Message-Id: <20190625233116.2889-1-marex@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the CONFIG_64BIT checks from core regmap code, as it is well
possible to access e.g. an SPI device with 64bit registers from a
32bit CPU. The CONFIG_64BIT checks are still left in place in the
regmap mmio code however.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c |  4 ----
 drivers/base/regmap/regmap.c   | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index a93cafd7be4f..e443d9de3f7e 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -577,14 +577,12 @@ bool regcache_set_val(struct regmap *map, void *base, unsigned int idx,
 		cache[idx] = val;
 		break;
 	}
-#ifdef CONFIG_64BIT
 	case 8: {
 		u64 *cache = base;
 
 		cache[idx] = val;
 		break;
 	}
-#endif
 	default:
 		BUG();
 	}
@@ -618,13 +616,11 @@ unsigned int regcache_get_val(struct regmap *map, const void *base,
 
 		return cache[idx];
 	}
-#ifdef CONFIG_64BIT
 	case 8: {
 		const u64 *cache = base;
 
 		return cache[idx];
 	}
-#endif
 	default:
 		BUG();
 	}
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 19f57ccfbe1d..7da9dbb98d8a 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -298,7 +298,6 @@ static void regmap_format_32_native(void *buf, unsigned int val,
 	*(u32 *)buf = val << shift;
 }
 
-#ifdef CONFIG_64BIT
 static void regmap_format_64_be(void *buf, unsigned int val, unsigned int shift)
 {
 	__be64 *b = buf;
@@ -318,7 +317,6 @@ static void regmap_format_64_native(void *buf, unsigned int val,
 {
 	*(u64 *)buf = (u64)val << shift;
 }
-#endif
 
 static void regmap_parse_inplace_noop(void *buf)
 {
@@ -407,7 +405,6 @@ static unsigned int regmap_parse_32_native(const void *buf)
 	return *(u32 *)buf;
 }
 
-#ifdef CONFIG_64BIT
 static unsigned int regmap_parse_64_be(const void *buf)
 {
 	const __be64 *b = buf;
@@ -440,7 +437,6 @@ static unsigned int regmap_parse_64_native(const void *buf)
 {
 	return *(u64 *)buf;
 }
-#endif
 
 static void regmap_lock_hwlock(void *__map)
 {
@@ -921,7 +917,6 @@ struct regmap *__regmap_init(struct device *dev,
 		}
 		break;
 
-#ifdef CONFIG_64BIT
 	case 64:
 		switch (reg_endian) {
 		case REGMAP_ENDIAN_BIG:
@@ -937,7 +932,6 @@ struct regmap *__regmap_init(struct device *dev,
 			goto err_hwlock;
 		}
 		break;
-#endif
 
 	default:
 		goto err_hwlock;
@@ -998,7 +992,6 @@ struct regmap *__regmap_init(struct device *dev,
 			goto err_hwlock;
 		}
 		break;
-#ifdef CONFIG_64BIT
 	case 64:
 		switch (val_endian) {
 		case REGMAP_ENDIAN_BIG:
@@ -1019,7 +1012,6 @@ struct regmap *__regmap_init(struct device *dev,
 			goto err_hwlock;
 		}
 		break;
-#endif
 	}
 
 	if (map->format.format_write) {
@@ -2081,11 +2073,9 @@ int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
 			case 4:
 				ival = *(u32 *)(val + (i * val_bytes));
 				break;
-#ifdef CONFIG_64BIT
 			case 8:
 				ival = *(u64 *)(val + (i * val_bytes));
 				break;
-#endif
 			default:
 				ret = -EINVAL;
 				goto out;
@@ -2809,9 +2799,7 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		for (i = 0; i < val_count * val_bytes; i += val_bytes)
 			map->format.parse_inplace(val + i);
 	} else {
-#ifdef CONFIG_64BIT
 		u64 *u64 = val;
-#endif
 		u32 *u32 = val;
 		u16 *u16 = val;
 		u8 *u8 = val;
@@ -2827,11 +2815,9 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 				goto out;
 
 			switch (map->format.val_bytes) {
-#ifdef CONFIG_64BIT
 			case 8:
 				u64[i] = ival;
 				break;
-#endif
 			case 4:
 				u32[i] = ival;
 				break;
-- 
2.20.1

