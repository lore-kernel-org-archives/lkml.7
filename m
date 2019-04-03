Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E534FC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32EB2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZdnyAbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDCUpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:45:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36045 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:45:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so702512qtn.3;
        Wed, 03 Apr 2019 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4plFhU/Zqm1lqkeMfe6JXmo9VfvB6FCCzNZE6pU1PLM=;
        b=RZdnyAbZAe72wW1u3aA0oNToW7AA59ns5xNeWjpmsonQqA8bwlPOEfRplx50mdhXGn
         GJTAsah4ir8S2SkVEOazY2/kNgUd3jHTALG+PkkZX8O4ivExlYbtS1lidbPnH5I3XsPL
         LMZuH43xs5zN5w6Jy4lzcMhG2WSe8SGezsJYj2zczs2NGAev1YtZ7OBicuioJHo+xDjo
         CoAQY21DzuemKNLQCTL0wEQGljkBItO3QGMkejrOcjvKSRdfSI3WnZJf/x+KoN8cePul
         NSkABzOODdZaFjo/Mm+YbN6vSQqckr6Lc8HkjK3GZbiXS4egsGwWAX/BDuAOqA+1bu5+
         qTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4plFhU/Zqm1lqkeMfe6JXmo9VfvB6FCCzNZE6pU1PLM=;
        b=WV7BNhKQ7l9HtMzLxgvnG2YXuybHaXyO8oU+ace9/8l4h5M1W89M8N6vO2KfouiOVw
         nCTjBw1wdt/Na1hrYwPeDMllrtDfMNeK2bO3PQAds0QwW2RU54W93hV4Tglv6kySb0+Z
         4byY8N0v/sNSWNDnv2y4Rr9QrmoVNUSBVId8Q/vSQz1FOGQ3PDscMi6vEygcxIcHlEP5
         zKw74Em971MVL4mOsPyHQoD722HwuOHi/cIms6Q/N5la7j0cJEhmYqp9jSp23q1Yode+
         uUs0V8a7cMXWovVFTcV+aTT/LpctM2wUSGjQ/+HZhHXbuKlEk2QMPN+YlrKzzhX1PQtj
         Uu9Q==
X-Gm-Message-State: APjAAAVjiYepVvNfpBqR6bN/b+oUEszajcX9sTouZ3hIdx3tuKt0qXl0
        qmmpNk6E25fwfaVc3ORSUv4=
X-Google-Smtp-Source: APXvYqxi7qwM1qJhpgRBCPF8OaODWX32KhU6/r0sNZS1PbNMhJySFh43tMrPBxpaAAaUYNDWiV7tag==
X-Received: by 2002:aed:356e:: with SMTP id b43mr2012818qte.161.1554324315856;
        Wed, 03 Apr 2019 13:45:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:a2b6::2])
        by smtp.gmail.com with ESMTPSA id d21sm11673184qtc.91.2019.04.03.13.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:45:15 -0700 (PDT)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: cdc: ad7746: Replace bitshift by BIT
Date:   Wed,  3 Apr 2019 17:45:02 -0300
Message-Id: <20190403204502.28917-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace bitshifts on lines 54, 56 and 78 of ad7746.c.

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 0eb28fea876e..ea48b14cee72 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -51,9 +51,9 @@
 #define AD7746_CAPSETUP_CACHOP		BIT(0)
 
 /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
-#define AD7746_VTSETUP_VTEN		(1 << 7)
+#define AD7746_VTSETUP_VTEN		BIT(7)
 #define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
+#define AD7746_VTSETUP_VTMD_EXT_TEMP	BIT(5)
 #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
 #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
 #define AD7746_VTSETUP_EXTREF		BIT(4)
@@ -75,7 +75,7 @@
 #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
 #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
 #define AD7746_CONF_MODE_IDLE		(0 << 0)
-#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7746_CONF_MODE_CONT_CONV	BIT(0)
 #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
 #define AD7746_CONF_MODE_PWRDN		(3 << 0)
 #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
-- 
2.21.0

