Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE377C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E63D20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFd01kK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDAOha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:37:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39183 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:37:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id t28so11062476qte.6;
        Mon, 01 Apr 2019 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CZbh97nW17oTE1T+Z6+bSMcRH/a33irlHPTZJyWUCNQ=;
        b=aFd01kK5dBbfKWOnLjf1qPd+vOIHjXSPPLD8zmbQG8MVoQ5CfZI04Eghpjdn2eAt6L
         5Z7YWTRK2UnSrAdhHWWQm6a4yh7Ioy4SOlhfpO94rAZf8e6A6jMSsMxOedcMMmBRs6Hq
         y45v7ONSCw5Yq55up7XMwGM0YVS9bNcO2R+Cjzf3dOtp+u/vQvqYZRIV1t549lMcI9Ce
         7a8PIfDLAShy+zYQBd9ikW3bG9hZ0+xQE/LBwIkRUTO4HvIXANedPq5YTLuc/bBUaI+u
         kZ3pwmU6lutrmPZkuNpWK3A6jnbI5zNtA90l+52TmKJMzoi6XwFQ3xBEnPF92eoM8fGQ
         +m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CZbh97nW17oTE1T+Z6+bSMcRH/a33irlHPTZJyWUCNQ=;
        b=rQp8cL07Li6MdQhhumaOvA3UQ2302R3JeP9bmafAXJy2VfYaORZZidx6eQv0gbShYA
         xZ1uGcM4eIL8zqOi6hwuSvrK4fh+F8+KyApHyqbAUFPJ3WDETTB3eGeBHirMUL8EhXWv
         CRSnHhsi87BBUwpPpGl9wnamlz6nLKR1pER0fKUUm746yNfm9SUKwRmzGgbvryGffcIf
         kKr/Ey16pFbPYDfCmN5P5YrQ1E3VTVBOU2s5F5SJ48qmPVv+N1Nys5NbrcxIrI3tweDj
         dxLuds5Tpkx+e9O95CkCN4YvkNdRY+I22O3892ps9Kxg6qeio6W82LDGBIFwOkqYx84Z
         83Yw==
X-Gm-Message-State: APjAAAX4wfzbKrjt412XgdepkuGwJ7iTiZLMtzhlUemhMIs2LdrSLcpc
        kd1E9LY6ldPXj8LSAkLljfI=
X-Google-Smtp-Source: APXvYqyEMJ2LpSak2DAdT4MpS6vwbXDoOHFiG8/wtv82gFUXgMFYeO74pHV+3ni3zhQg+SC8a+MxCw==
X-Received: by 2002:a0c:98cb:: with SMTP id g11mr37636597qvd.141.1554129448913;
        Mon, 01 Apr 2019 07:37:28 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o50sm6493244qtc.23.2019.04.01.07.37.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 07:37:28 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:37:24 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/4] staging: iio: ad9832: add SPDX identifier
Message-ID: <20190401143724.mcn73jhdtq3zp3nk@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX identifier of GPL-2.0 for the ad9832 driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 50a583020072..d8d4a7936275 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD9832 SPI DDS driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <asm/div64.h>
-- 
2.20.1

