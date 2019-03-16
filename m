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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69E1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A718B218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3CuVYUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCPPHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:07:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42359 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfCPPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:07:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id u7so13354075qtg.9;
        Sat, 16 Mar 2019 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Et0COeORfa9jig2CdFxD5Z1J1otj4MFOV8zBbjVTkA0=;
        b=k3CuVYUpC3B/tWCCDXapS7Xr2vWcyyo/f5vX8rJ0JdEcZTpJ9igVsKmKM6EdJ9d+Lg
         6jTygfzmMczRvDBloE7TE2//8VN98shnidOb10/8NnY/YjTpkxIRK6rYG1/rVtDnsbpc
         CTuCJM4g001s2/iGbQMNC57igYoAYDzU3o5/s365k+fE/mEQef8N7UQOXWTFjDzAwmKb
         eqnwzDabw24UVIMvLmSK312Bqi7ITZH7G2ianW2f43lCsSw+BFBlYoV+2AVQjCYi4zj6
         A1Er2U4kDLLD4DI9DY8lV81VpdviStPUP9/OwoMBhUlXUJkxq5WZtV4YB7REgOQo1FtD
         vQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Et0COeORfa9jig2CdFxD5Z1J1otj4MFOV8zBbjVTkA0=;
        b=RB2wfOBDI/ysNwfDOOFtrCYquKlYdzYYstkuMeBIsa8fQXImjOKZx53Iyn2IEzqgYC
         /FYc2R2wZjOXbMJ15uvKSUeFKmEg/eQUkzVqs1LO4BQ/SZ7gxT2N3g4m24k0as/N2l2y
         4NEQc/j305BYjvhkDJZhwr9N83ckTQ7WBS5R5J1uGbemtphcR4mDgiH2QPsyyyGZnasV
         dWSjIidp3Ko76BLxc7sDtxZcLohAVFprnzz/Rb49VWhhunLHxXQrZ+I95KrUXceLtvxM
         8Di6lIzKAe2FCYtdz4MDaKn8ALt0dLkEdYm0zXRXHk+oxrWwLoVMZQZCF5WVq+fPU9Ea
         vG9A==
X-Gm-Message-State: APjAAAXrobctH12b7zYv3UTUMnbmXTVocSQuVMmY960KhqQ3crndtwSC
        ZvbkXhBuVXm+k7pux8StA+c=
X-Google-Smtp-Source: APXvYqzvdDb6+Q5e86VCxE3ljRk35hcONgVtymzfpHoeKOLkFumPJyy1q4pkI/pmmLiL3/XAlYtyIw==
X-Received: by 2002:ac8:23f7:: with SMTP id r52mr6926405qtr.378.1552748827513;
        Sat, 16 Mar 2019 08:07:07 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id x33sm3491302qth.7.2019.03.16.08.07.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:07:07 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:07:03 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 3/7] staging: iio: ad5933: add SPDX identifier
Message-ID: <20190316150703.n3nlcjl4a32fakb6@smtp.gmail.com>
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

