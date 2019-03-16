Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8ADC4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D4218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWsM9vkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfCPPG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:06:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37731 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfCPPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:06:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so13395024qtn.4;
        Sat, 16 Mar 2019 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Na8cn6ZpM3g5SgVUX/cLn0sa0oxjd9imZV6NYEIWFu0=;
        b=rWsM9vkGbErKLWYlT9ac3rJiTrPhJEx+wjb8dPH7c/guY04HPLEzqxxm6C3yQbeN7B
         6ZskU0zUR5G50c+VUsDKsAvvNCo8n9AQZzWk184N96yvRyYVqLEp/sQLqmDYEFoS/00X
         h8PUMZ93f/gZblr6Q9wlA+znA6nrPEJeFo6bwqdE7Lg1HdEnWbhmmAsols45Eax2dkXY
         GeORVMDvnjUBx/wC0AprTAvJfewsAJmO+3JzFTjGYBpUA2Uq246bn4WlylRWbyv4JG4J
         T2WWZcQVrXKcXFExtLP+rW64fjPlIQwd0mxn1Vl+6aEL7Ea3E8BUTOaM71Cjmk5+gvP4
         Z8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Na8cn6ZpM3g5SgVUX/cLn0sa0oxjd9imZV6NYEIWFu0=;
        b=h8t5AF2Xx8pXT6g6/ztNcJaL4XqA7IdzkAneYrROT2vyu7RLx8q49GRbrxNywr2Aw7
         1Y+ypVDSV6wNhIfFtut0JEBUB/7kUOGPjs7w8O8g7Qevkd66IFQuxv6g7iODPiOBaitm
         QSV+ea3nVp3JSpgMn/p/ZhyZ2uo8dFRtMMf9WlfDlF7tBVmACMWXy8H7+PqJKf16Mnvj
         o2WzSP/U24sHFG+8P72YP5802V9PzdV40JTilakjJzzBhycg8+JLKtYDQ2eBwlWCuyw2
         saMAltMomx3JCTxn6Q6MErSfpNvYOz5lXNuKrrkV+BUr1LOR210aInF7N4a1DHioEfmR
         Umlw==
X-Gm-Message-State: APjAAAWPZ9MZaADnbwqyivpdoxjc4cWZfbNdNhrIhjszUDTgLR1DILCK
        i5RaWrcrtjQpohEOdfVBeJI=
X-Google-Smtp-Source: APXvYqydL90L10MqKKh/QNjvHnfXTJFjnbSza0Xvt264zJmh8wdaNa7T62Y/XnaiB4T4NA8rw90Juw==
X-Received: by 2002:a0c:afef:: with SMTP id t44mr6651774qvc.59.1552748815061;
        Sat, 16 Mar 2019 08:06:55 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id r17sm2739703qkm.17.2019.03.16.08.06.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:06:54 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:06:50 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 2/7] staging: iio: ad5933: organize includes
Message-ID: <20190316150650.jke4uqgnf5w6s3cv@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Organize includes to list them in lexicographic order.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 05e2185bfdae..c2a7a59e469c 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -6,22 +6,22 @@
  * Licensed under the GPL-2.
  */
 
-#include <linux/interrupt.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/sysfs.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/clk.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
 
 /* AD5933/AD5934 Registers */
 #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
-- 
2.20.1

