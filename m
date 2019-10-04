Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A602C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BE222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UFkwlLQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbfJDVnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:43:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36482 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730590AbfJDVnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23so4496612pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubsbJVfyaxxi8UEKJtUs1pHXgsPvFxblh2S9JiFfFEQ=;
        b=UFkwlLQnUNyI5WNntdW9sbZ+MOSMgf2+fOLF8RG0Idqq0BiDJ31IThtlWGL76sEsh8
         ZOXjRMMhS2+jDESxPJYaF23djnnmvObforQfo9Lci5kCDyLYBF8PRkwvnwVf8Yl/9q4/
         sLymgqNYk/o0RadXVPMTvlSeFll8zoJ8X+f5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubsbJVfyaxxi8UEKJtUs1pHXgsPvFxblh2S9JiFfFEQ=;
        b=HBkD4WFisjrJaVFxJpsFbJBECryJ9jseRX8tvQLZVsNLPaXdbwoT1Mes62snub54eG
         VlyCgclcBWuU5sgCDEaI8IIA7DKCIEkQ7g8HvKW0VmdIgRxd1qHu4As1Gp8XfvJaGeG4
         cJVi/CqwPeJO08RaOpirI4vOntr++8DNWyRi7RuB1/WHWfmnPlRpvjB2AkIGzgNtr4dJ
         3U+koBRf9TZf7PYycVf/pxTCM7s6nKF4y5kwXeX0N6Tk4knc9XjFvE8Pkny9vsYyiNsQ
         xtRKWWMREX8uhPjEE2Asx4b7XrBIzm5oQixgEZgQBC8mQ50xlGyWC5pe9Cl8OdW1Gwnf
         zJSw==
X-Gm-Message-State: APjAAAWAA5cEDD3uTTeUPaRm+jmQ93gyGilxlnMOMxNuTUZTnMcsw5K7
        bNOwvXoZP02QyfG5hPL4RTADzI6GP8M=
X-Google-Smtp-Source: APXvYqxWNvMZbZVIHoPzbXHXqx4rR45wvPydpGvMiAUC+AaI6mlLIv/J0XRSrindMPfHhhURSHgsxQ==
X-Received: by 2002:a17:90a:77c7:: with SMTP id e7mr19330232pjs.59.1570225418345;
        Fri, 04 Oct 2019 14:43:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:37 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 02/10] media: renesas-ceu: Use of_device_get_match_data()
Date:   Fri,  4 Oct 2019 14:43:26 -0700
Message-Id: <20191004214334.149976-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can use the replacement API instead of calling
of_match_device() and then dereferencing the pointer that is returned.
This nicely avoids referencing the match table when it is undefined with
configurations where CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-media@vger.kernel.org>
Cc: <linux-renesas-soc@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/media/platform/renesas-ceu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
index 197b3991330d..60518bbc2cd5 100644
--- a/drivers/media/platform/renesas-ceu.c
+++ b/drivers/media/platform/renesas-ceu.c
@@ -1679,7 +1679,7 @@ static int ceu_probe(struct platform_device *pdev)
 	v4l2_async_notifier_init(&ceudev->notifier);
 
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-		ceu_data = of_match_device(ceu_of_match, dev)->data;
+		ceu_data = of_device_get_match_data(dev);
 		num_subdevs = ceu_parse_dt(ceudev);
 	} else if (dev->platform_data) {
 		/* Assume SH4 if booting with platform data. */
-- 
Sent by a computer through tubes

