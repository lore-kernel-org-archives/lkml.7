Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2127C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88164206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbTn8BUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfCHTrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:47:47 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40606 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfCHTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:47:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id h28so11868778qkk.7;
        Fri, 08 Mar 2019 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCmgnf+DSePwylqGHbW4EX8PQba6O1Evd59WRGue5aM=;
        b=jbTn8BUf9D4Hq3835SC0r4+906XV2OJt9ZHAECl/2hx9e/16jENlWcbhh8vhnrPTEt
         UgE0LspmAuFH+A/DDj5LNLoC1qBmCaMkzIUEfmjQupWa13Ufxe4JHKrnMEABIpxv17uf
         6Ul9BNThi83zpMwzfK6MsEFJW10ZPOBtbUs30kyNUDYrA7AdQrvrwHvqvAxLwQ4B8bB3
         x36o+Gx+d6v+XLebvGXe825MCePQJfLkhEj35ihaqXAYUeqmyBHpE90leZizxyVBLoCj
         wBN7H3NzxSI3MLN9RrMiVu+ZdO3JNY2B7CpVXi6Zt1oYPwDfnHIsYAQk+2i9Sh1SiOqX
         fbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCmgnf+DSePwylqGHbW4EX8PQba6O1Evd59WRGue5aM=;
        b=bdHzWk2osGUtOgBqufVodLuETeQOMzOnIPQfAcnREVz2msmZzqYkAIWhrSn0EdyG9b
         jGdKNHF2GyGsEEshDNlpFsOEkooNkeWuVBCoC8B4Sd8nCPT+DGi8l1TbzlWwLRpJ+inH
         w8zQ2R45TYUD0r15+Oxqd9Achv1MIOYKo/MddrzMMtxI+F2vjBGJ/hJ8b2/yfQNjpO+2
         CGmWRISRc4qPyiTJw2j7hHLAYII+QXAk7BGnx1yNeWM/t+M13nsT8svsyTJ/2Z3KgOol
         6+oJAmqZ/a4PF2KyfLnaTPCf2TJO7a9zKkJ265fwMuLgC56UTKdbjokAGDt9PEFTuauz
         oIKA==
X-Gm-Message-State: APjAAAWImbxmi6lXYsm+Z99DQxK1TpI209YpGpBzq+MALVcd0+jmiHOI
        2TsRSgA6moyueVJFRtvzILI=
X-Google-Smtp-Source: APXvYqwVVKo5PrEmmRlLWdBO1b/hrn/JB5tEBL9+KIlMira8qsKmHodyMhtCHGjltLo0uMHlTl3IWg==
X-Received: by 2002:a37:6042:: with SMTP id u63mr14587176qkb.289.1552074465571;
        Fri, 08 Mar 2019 11:47:45 -0800 (PST)
Received: from crypto.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n27sm2393038qtf.11.2019.03.08.11.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 11:47:44 -0800 (PST)
From:   Anderson Reis <andersonreisrosa@gmail.com>
X-Google-Original-From: Anderson Reis <anderson.reis.rosa@usp.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, matt.ranostay@konsulko.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH v2 2/4] iio:potentiostat:lmp91000: reduce line width and remove blank line
Date:   Fri,  8 Mar 2019 16:46:53 -0300
Message-Id: <20190308194655.5983-3-anderson.reis.rosa@usp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break the line 258 in order fit the line width on 80 characters. Remove
the blank line 279, as the line before is also a blank line. Solve these
checkpath.el WARNING and CHECK:

- lmp91000.c:258: WARNING: line over 80 characters
- lmp91000.c:279: CHECK: Please don't use multiple blank lines

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 03d277621861..c45cfb632649 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -255,8 +255,8 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
 	regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
-	regmap_write(data->regmap, LMP91000_REG_REFCN, LMP91000_REG_REFCN_EXT_REF
-					| LMP91000_REG_REFCN_50_ZERO);
+	regmap_write(data->regmap, LMP91000_REG_REFCN,
+		     LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
 	regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
 
 	return 0;
@@ -276,7 +276,6 @@ static int lmp91000_buffer_cb(const void *val, void *private)
 static const struct iio_trigger_ops lmp91000_trigger_ops = {
 };
 
-
 static int lmp91000_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct lmp91000_data *data = iio_priv(indio_dev);
-- 
2.20.1

