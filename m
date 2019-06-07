Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3897FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1353B208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg+RmyEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfFGSZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:25:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46891 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbfFGSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:25:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so1629107pfy.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dxBPpI3MVYsAOxpF8JiGIoXl4M0t+BGFY9DsJwBkErU=;
        b=Kg+RmyEZNMx30Kvg+YHlUO2MVSec/5luO1b0NM7cCj2Dl2SWeLDw8XeQqmeit9/582
         GbFInsFxisllWwsM2qZ/BwgVFVeHyGvqaQwhoc4t82+XLMvi0npmjLX+7Vwzav8hQI8k
         96GjP48TC+5BWoHfsdtV6srD1+njcaNx6+rVmLaj59EFryRtM8yYNhLJgm3hP+A+ICJG
         tY9Q8Epn40gpi1rF0aXXABPb/uptN12TQ6MINhHWiOpmVJpaIpby8hPqMlojbulQW11X
         gnjQtPZAnejkBDRiRQ5eSjC1l6BU3vKee1zUFTrN3Hp86J+gupcSY0pj/HOJWAhYbFVR
         kILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dxBPpI3MVYsAOxpF8JiGIoXl4M0t+BGFY9DsJwBkErU=;
        b=E8YpF5L2/BuN2ieVsrMMokWfADlwy78AETSninKOx2rtWdKKJ31qa/Z7QBKJcel86l
         H6Gf07ZP3un+WNkN7udFpD3u1lDcj8/TxTX4AjR47KbYx6WPRcYSNkovMredn4UE2SHj
         ziyiThw3q95+u3B/2E7j26h40MhFVBS4yB7no8054QWGW/GbFYzN39d3r+hE6bWSV8zy
         2jO57Jq0qcEXJOXgL/+4VhPSVkyATIxbnc//bmfU1V0UThCjvWbgQZSrndml7KAkSpOL
         7PmL9SMbwtvDRzHRShllWJ9xkj9uYTAvcMa0I/iOjpil+eYIHC36Y2DAYTLtL3zvkZzp
         E1IQ==
X-Gm-Message-State: APjAAAWnWdXVL0hjTCSKC9SfNbz7qo7aJVWMW2cMTGwv5Hpg6Da5SAkR
        xLY52S1m0OYcgygkW3MhJAo=
X-Google-Smtp-Source: APXvYqwjy68R2apR0dXEdMRF+izBl8FP1xMw8f+LXYbvK3UnQ2ZsKiFCaxnpSZjRv/c5GcdnGGeZWg==
X-Received: by 2002:a63:374d:: with SMTP id g13mr4343521pgn.413.1559931933695;
        Fri, 07 Jun 2019 11:25:33 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id w187sm4076997pfb.4.2019.06.07.11.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:25:33 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 5/5] random: remove some dead code of poolinfo
Date:   Fri,  7 Jun 2019 14:25:17 -0400
Message-Id: <20190607182517.28266-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190607182517.28266-1-tiny.windzz@gmail.com>
References: <20190607182517.28266-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it is not being used, so delete it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/char/random.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 885707ac8e3b..d83401e35f71 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -441,33 +441,6 @@ static const struct poolinfo {
 	/* was: x^32 + x^26 + x^20 + x^14 + x^7 + x + 1 */
 	/* x^32 + x^26 + x^19 + x^14 + x^7 + x + 1 */
 	{ S(32),	26,	19,	14,	7,	1 },
-#if 0
-	/* x^2048 + x^1638 + x^1231 + x^819 + x^411 + x + 1  -- 115 */
-	{ S(2048),	1638,	1231,	819,	411,	1 },
-
-	/* x^1024 + x^817 + x^615 + x^412 + x^204 + x + 1 -- 290 */
-	{ S(1024),	817,	615,	412,	204,	1 },
-
-	/* x^1024 + x^819 + x^616 + x^410 + x^207 + x^2 + 1 -- 115 */
-	{ S(1024),	819,	616,	410,	207,	2 },
-
-	/* x^512 + x^411 + x^308 + x^208 + x^104 + x + 1 -- 225 */
-	{ S(512),	411,	308,	208,	104,	1 },
-
-	/* x^512 + x^409 + x^307 + x^206 + x^102 + x^2 + 1 -- 95 */
-	{ S(512),	409,	307,	206,	102,	2 },
-	/* x^512 + x^409 + x^309 + x^205 + x^103 + x^2 + 1 -- 95 */
-	{ S(512),	409,	309,	205,	103,	2 },
-
-	/* x^256 + x^205 + x^155 + x^101 + x^52 + x + 1 -- 125 */
-	{ S(256),	205,	155,	101,	52,	1 },
-
-	/* x^128 + x^103 + x^78 + x^51 + x^27 + x^2 + 1 -- 70 */
-	{ S(128),	103,	78,	51,	27,	2 },
-
-	/* x^64 + x^52 + x^39 + x^26 + x^14 + x + 1 -- 15 */
-	{ S(64),	52,	39,	26,	14,	1 },
-#endif
 };
 
 /*
-- 
2.17.0

