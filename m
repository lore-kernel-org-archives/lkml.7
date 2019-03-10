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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B2C10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F78C20657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn4IZHV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCJRps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:45:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46125 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfCJRpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:45:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id i5so1425438qkd.13;
        Sun, 10 Mar 2019 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Et0COeORfa9jig2CdFxD5Z1J1otj4MFOV8zBbjVTkA0=;
        b=Hn4IZHV2Ztq8qOc63lkCyyA/k5ZDuoLAYMKpyRk3o6WZsKjEXW3dXlLNyinM8LwG7d
         4XXOP3BbJVodiflFdPXUsaIyfCqNA95O9rImvs6X/p0LwtskeCk69zKU6ePBRyRuVAsX
         uRMK1Xnm2UOToh4A+gkCfZM+LtsaVP/OSgCJTs5scCFhUyTvY/U9V/tF4LPIc9smo5RC
         /CSucwZep7xZ1A+/qk2nFFZ09E6MJ7YR54CEtX8EKwsdOksNXmz/QYIzsmFsjt4/APFK
         IHBldEYSa6lMmOCydBUUbQMCTh9flsn9gfObM0SalvO5LX5p9tXsRfMyGo2KZvaA4N3z
         o1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Et0COeORfa9jig2CdFxD5Z1J1otj4MFOV8zBbjVTkA0=;
        b=Voe/Atu3nqzsmTj7Vf7Z6HeH3nIa1v9Cb/HvdB6CalCbOfWt5ff3MVTiSlewru15WO
         XM7skgUC87DnWCxa9gnbAJlGXSoRbDhTKOLBZohYw1yho1++iAzFOuMaEy/BNuSyNsoY
         PbuYlD4WvQycFqMYjwwZ/kY2nVhH4j+nHCz/vsQHbMmJPZ6FL4/atDwlnoi/YtD3VbVL
         4cf4pMldfqDAQd6hOshvI+vpqXx/+4UW1dOcw/F9VQ5Bc2etM74MTWGfK+mPBcK6KcUg
         0XesvKMWp9vn9jD76gzFvo7b50x70VTFdagSPQYmWMPD7GxYZmqQplztKu6WCaxQlHXK
         B50Q==
X-Gm-Message-State: APjAAAW0CzyObyPckpaGDzj0U7mPZlEE3DqhF0rJtgB6VIiH+odYvewM
        C4HInREx4gSPCeGdYfCqnAA=
X-Google-Smtp-Source: APXvYqzf5fv2XmEyyIv8Vkhz/TAsvx+pzbVKflA1aVfO7r63+EU6+x0QAac8mKYXctOwYYjiwnRqEw==
X-Received: by 2002:a05:620a:14b2:: with SMTP id x18mr21143480qkj.82.1552239946660;
        Sun, 10 Mar 2019 10:45:46 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g7sm1352838qkd.12.2019.03.10.10.45.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:45:46 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:45:42 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 3/7] staging: iio: ad5933: add SPDX identifier
Message-ID: <20190310174542.3qsy6bmb654ej3a7@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier of GPL-2.0 for the ad5933 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index c2a7a59e469c..d75bdfbf93de 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD5933 AD5934 Impedance Converter, Network Analyzer
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/clk.h>
-- 
2.20.1

