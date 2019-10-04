Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2980C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E46222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TzOtoCbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbfJDVny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:43:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43432 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbfJDVnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so3712594plj.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toiNQ3uyPVKtH1FJVvzAY7ss6AyZ/5waNznuCuWvkdU=;
        b=TzOtoCbB3wTUkHkOU1u6rGd1iSwJ194lmn85uiHDs5T6xQcYgo0t2ul3hzsyMwQbuQ
         qOUvdW/x75fWC4KMphZXmPtc1D8u3aUqxs5hEDAqeLqHnEbaaqBpOiRQiZ9CwWsrMPrq
         rX8Bd21LyyjGMOnQbTB74gj9QRCEJ8EIL5xVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=toiNQ3uyPVKtH1FJVvzAY7ss6AyZ/5waNznuCuWvkdU=;
        b=bf/mow8WpuZyL+4UPuis9jWUkiMKTLWUB50YuGmBokL9+xlY8RuaHC2TTmH2Q7tdbB
         SBJNpY3GOAnvIryB9i/SvEoICe7i7dh1ir50AbHhULz/UK668b774gBGWWWi1VFOJj3W
         LX+b9b3N7aVrVdt99JxY022f1vWydQU3bAQG7+KyZc4/76Zk7VoScTXdvFLL6gIcNu89
         Ek6V+bsAmzsUqDdDSjP5q0xtFY3qti/jRxi0VycaPuZGGiR97/sSj4iTYRIehKiSyVMM
         XDkvIscl605XnUO+a/tKq/XyJA+KMnGMh2+GRvOryinYuqV/6naIN9Nrm/WeTIaBT3hN
         8akA==
X-Gm-Message-State: APjAAAX77jPJkQ97RDTC57R323PhjpiHm40lbgCVweLbE0OpscLH2aed
        6bvQHYzyxXl5u5DUs/MkeFpCpey+FhQ=
X-Google-Smtp-Source: APXvYqwrzdAE/OJpg7isYO1jPn6XxjlNXM//y5fRAtvkqmGiU4FWBiyHveqOe25U22waXQPmK0b92g==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr18020276pla.55.1570225424939;
        Fri, 04 Oct 2019 14:43:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 09/10] hwmon: (lm70) Avoid undefined reference to match table
Date:   Fri,  4 Oct 2019 14:43:33 -0700
Message-Id: <20191004214334.149976-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to remove of_match_ptr() from the definition of
of_match_device() when CONFIG_OF=n. This way we can always be certain
that of_match_device() acts the same when CONFIG_OF is set and when it
isn't. Add of_match_ptr() here so that this doesn't break when that
change is made to the of_match_device() API.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-hwmon@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/hwmon/lm70.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 4122e59f0bb4..57480dada955 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -155,7 +155,7 @@ static int lm70_probe(struct spi_device *spi)
 	struct lm70 *p_lm70;
 	int chip;
 
-	match = of_match_device(lm70_of_ids, &spi->dev);
+	match = of_match_device(of_match_ptr(lm70_of_ids), &spi->dev);
 	if (match)
 		chip = (int)(uintptr_t)match->data;
 	else
-- 
Sent by a computer through tubes

