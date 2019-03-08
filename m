Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F345C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252BA206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+8O2BzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCHTsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:48:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35565 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfCHTsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:48:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so11886585qki.2;
        Fri, 08 Mar 2019 11:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8JbYhBkREjKi9HdILjG0gKF6tKhRCypgsFQponE9l8=;
        b=B+8O2BzAqk0hBkXUnzUXqQ53gf9+a2gRiTVy2oQ+Bp+kEhjqEGhrxI8HYWrD/ghZMu
         CgQPUM6WPv3u4Zw9Gn/DNMn37eDETlFx5XMWd7/Cmb+dcf9eS+0S8mibk2beyaI724la
         6zCuFK6x5A7qbFUoAUsxB2P541BhfrfAjtB6A7maH7/HAMQvT5edgOk2ODj9CwvQLRvx
         B49KBLthWqCZUOvCgDNxpKX1AmE147nr0Xe2TKQNmE/dUecYJCN3ojxjiKuZi9NtOuqB
         PGA8yLoNN+DLrtVDwNXBhQSXgvlqykL9Q+ZbyQD2RYS4yVrboo1Hmc1tWctkxA139LCh
         blvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8JbYhBkREjKi9HdILjG0gKF6tKhRCypgsFQponE9l8=;
        b=qdMh9Fo39ye6LSQQG+kEvwcqW+64PKROcxsoe1Z2wCccDy2gYfc2vD2q+iPsX13yb5
         HDFIUs55ig6wSl/5C+k1/O+TdSZoRo5jCEEmDH7x0Smyk63xd06WLZHALSwRG5zp8z9N
         HXucthNh6IXpDW6MWk7BiTSDHu6k1e9NTnOaoHDK/mHdRPnwoKOEbgKpqUSnZ+5eMY4n
         khrjVkw19TTNi9acLmFOWXnjcZSr1eEg255ZE59rWtwt2P/92Fa62cPUyEOmWMz6+2of
         j7MCP3AJeijJg7lKUNISbBp/kRjNWn1aXcJiBdzkwOqmdEL0WRnYAH4rmBbSQcCBXs9l
         Hyrg==
X-Gm-Message-State: APjAAAUPjPRlKAX0MiLiQCTWqaljLr3q5tI28XWoCL09JhZbmgYL1m/y
        tNIOMsY2VuRfbd1PIiiP0gE=
X-Google-Smtp-Source: APXvYqzWZqkNZGP7vjDwLBBxZZzQaOdHtuZX3zfIZKaDB8RgVqw6yh5tV73IyiMXWmvL606KM9/V3w==
X-Received: by 2002:a37:a10d:: with SMTP id k13mr6739803qke.203.1552074479453;
        Fri, 08 Mar 2019 11:47:59 -0800 (PST)
Received: from crypto.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n27sm2393038qtf.11.2019.03.08.11.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:47:58 -0800 (PST)
From:   Anderson Reis <andersonreisrosa@gmail.com>
X-Google-Original-From: Anderson Reis <anderson.reis.rosa@usp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Anderson Reis <andersonreisrosa@gmail.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 4/4] iio:potentiostat:lmp91000: change dev_err message
Date:   Fri,  8 Mar 2019 16:46:55 -0300
Message-Id: <20190308194655.5983-5-anderson.reis.rosa@usp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dev_err message on line 215 in order to inform that
tia-gain-ohm is not defined and an external resistor is not
specified.

Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 1de17924e154..5ed9752008a5 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
 	if (ret) {
 		if (!of_property_read_bool(np, "ti,external-tia-resistor"))
-			dev_err(dev, "no ti,tia-gain-ohm defined");
+			dev_err(dev, "no ti,tia-gain-ohm defined and external resistor not specified\n");
 			return ret;
 		}
 		val = 0;
-- 
2.20.1

