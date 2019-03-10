Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E15C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C733E20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltsMJJUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCJRp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:45:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33737 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:45:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id z39so2656475qtz.0;
        Sun, 10 Mar 2019 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Na8cn6ZpM3g5SgVUX/cLn0sa0oxjd9imZV6NYEIWFu0=;
        b=ltsMJJUFXpu1LYE7umoiwKJWeI6J9rIlGON924T0CFSl0DwyN3gW4OXJlsFa98mQW5
         RdlrNjYdOL1Rmkg4VO41Sr9VYKjOC1mwsIHzSreGiOJ8G6YM0R2035oc9ypz8fX3Sac6
         lXNihAQGREpzXJlIE8BxXtZ52oCg2k8Lvju7p9b1QlfN3AOv/93Wi6Ur8LEFqTw66o3R
         EPtUAXW+hh3jNRx50peBsWbOza/oGISjO38QzbikVBtDngbARLNDTW5sujkRGqzFqktk
         aZqnn1W+9tmH2KSxKj8kQSXpwrRNe9T8SgCmaOBLgfJOKc6a7npzZNW/mE/XHExLUQHM
         LflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Na8cn6ZpM3g5SgVUX/cLn0sa0oxjd9imZV6NYEIWFu0=;
        b=JDMjPrPhuQaW3u8Y/sr8KYiZtnl54hvEndt8q+16bjaz5KSGMJY/TtCSxyGt0nwJBP
         coJ42EOisz6zxcTxc0GtqqAuua03cBRhWm8u+af5PysjsYbT3wN6M2FQKk0L5UmLRQ1d
         kpUliPUZwUASPTHXbxj/j1DiF9z0dAw6R1F/cCrNR5lU5XbBMgqvN1L1cgh5t23g0d28
         DMeS6V/PtCou6tLyR2/T78sGnKL9Zn35YlQVIVosAQnJg6CffEqBRVUHUErMsu8TtglR
         PR9hDFKMzdVKT6fuF/SRlnEYxsaCFwe+HgOjax0KF2vK0v0OYaECYJcmEXBC+gxe9xch
         4j5w==
X-Gm-Message-State: APjAAAX83op71/IU4h/jKtLkiYw8ItMPiGFaIldBp9/DM+mGhOGVzevT
        3fteGXsr+EbNgFs2c28gCh8=
X-Google-Smtp-Source: APXvYqycfl2QcY/lYYXLU8ty2wDUocZd7DZ4hHhYAKTVaPye6QXc1NI2w+S5GN+2Ulc4tJ9C9Lr6DQ==
X-Received: by 2002:aed:3608:: with SMTP id e8mr22989488qtb.31.1552239928105;
        Sun, 10 Mar 2019 10:45:28 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q23sm1826222qkc.64.2019.03.10.10.45.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:45:27 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:45:24 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 2/7] staging: iio: ad5933: organize includes
Message-ID: <20190310174524.taz6riaojgjyody3@smtp.gmail.com>
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

