Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B751C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431922DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ft6JmqWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfHTOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:12:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34672 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfHTOLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:11:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so12590101wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RwUl0tIvIWQJjsPo9IUx0TKimtG4MbaxDyHxqkSvC5A=;
        b=ft6JmqWgSOSM4d24X1q0N2J56uYy/FU4k08SXAeJ6pgdaXJ5cYbZX2WQ70C3sFnKQV
         4iXZe7h92gIl9tNrovxEYNUXt04plhsbh4BJqzGndjegbiJfrB7N8xhJCG7ZvR1SACp2
         2/VVKPaWXVbDNH6tijKiFQui4GLWVWScAtnfxqMAHfmJrd4GRQlK/NOJn59hI/ng/kYf
         fOlUF2vWVCwdU9uOBqJSgHdWj5Qe8GwEov/sD7ufWQpV2T2WdzrCQXAy44eL123/Vasu
         1hPW9gsS/nzyJbhHGtH25EisfEton7FtFTT1lySEcdQk8smMI55NJB2JUdY5gRJKv5Kz
         G5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=RwUl0tIvIWQJjsPo9IUx0TKimtG4MbaxDyHxqkSvC5A=;
        b=O85+hoOFACrTTGofQHpD8GbVZJpo6MzwP+oUOUhuYdijMaNddxHgqZDk+aZMuZekTE
         Bhamr+yDQPrNKXP6Miv4TWcbCpGIoN3GtxkhPtn89+MG+tiAKzB1AQPvP/srTaUxeTAE
         tuwO+vyquJfXaZW3JSgyebwFNYExe72IkXlroZefMceJzL1Eo0so8LA+Z8ivOKEOLdwn
         d3mSEjbT0Hss8F3/b5w22rsRhk1h0okYFAgW7B3YGiWK93decaVGu2zYWNaAkJLiEAX1
         C8mM6yFflg8c7fb4qphn5SCMBXO28TGy0IKMLlRvEauP2JAUESTBPE1MCYgc00S6qytB
         nnoQ==
X-Gm-Message-State: APjAAAX+uuTXWQiWtcSrtySAcVwIKN7jOu41Gy+grriuutUEG/ZwuONJ
        TqJOZufGD5tnW/Fc00GZy+3pfDj92I0Ftw==
X-Google-Smtp-Source: APXvYqzEIh6wkeygw1xRCd3/+HZRcK6Zad12CN+JWvrC+aemT0aFfIfzYCUHEgz9nu5K7xswVg1Ejw==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr35140281wre.114.1566310313897;
        Tue, 20 Aug 2019 07:11:53 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 2sm84660wmz.16.2019.08.20.07.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 07:11:53 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, linux@roeck-us.net
Cc:     Colin Ian King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH 4/4] iio: adc: ina2xx: Use label proper for device identification
Date:   Tue, 20 Aug 2019 16:11:41 +0200
Message-Id: <0542b562a813c5c22c42484ac24bbb626ac3c022.1566310292.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1566310292.git.michal.simek@xilinx.com>
References: <cover.1566310292.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using label property for easier device identification via
iio framework.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 7c7c63677bf4..077c54915f70 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1033,7 +1033,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	snprintf(chip->name, sizeof(chip->name), "%s-%s",
 		 client->name, dev_name(&client->dev));
 
-	indio_dev->name = chip->name;
+	indio_dev->name = of_get_property(np, "label", NULL) ? : chip->name;
 	indio_dev->setup_ops = &ina2xx_setup_ops;
 
 	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
-- 
2.17.1

