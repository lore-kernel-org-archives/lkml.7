Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96213222C5
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSEGWM+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfCXKCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:02:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43270 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 06:02:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so4363843pfd.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x9I6q04q+C60TaCX/jqS4U+8bqGSJ3c+wdeepC0CaCE=;
        b=uSEGWM+pCHlr1jv18VDC60MFtKC8iQCsPCWHQ9FZT9YMnO7y4Sox05i0sINvjEhNlG
         j8YkUd1gKLMzieupeGbtj4kJEGC/cCiJWBgfmrGuoqUIGGEamt/YmtYAebGBiEfSM8aq
         PuorCgRxgDfBm/pN3R1KLMa59lbIizFhP5PyQvVicdaElLECxG+sYQSdc2Z5/0nSALg1
         jG6TtCIVuCuYkdCLQlArFUSdSPYtui9e1E3LY1L0S6uCqX13/IrNH5H76jbtcio5ULwK
         v4Y8j5812IUJu4kOvU/Ja/9mC0dLhg6wM2SwCun3fxUlybJrgcdIeWvUXVL50DET7YAJ
         UBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x9I6q04q+C60TaCX/jqS4U+8bqGSJ3c+wdeepC0CaCE=;
        b=T20tRV5GJ9RBSFzm8DDHxNRuZMLAhRHqUxWwXXbiAlnxVj3eWt3IW4oXOp7v3mwrh9
         qDK9eVMllSYOOlQjwhnKt5VxJZdLqrKpc4l+fzBe0UQVmVeKSOcBOa1wm+WcciaR02Ni
         meFDJDaKs4Gj/qnkR+jIJZiYMTY8acaqnwtCSltGiWB1WQG3MqeNTQI5sUa5a7hHuloL
         h5fe3FNrxHgoE8n//iamA2W/C5L1ToNa0cH/s8sTsqD+0vhKg8HlQQQ9oSi1DYJAzqyF
         jAZ5mIU8QovCtqS5pvU84HAw1+k/bdJnJFL9PNUXYW5gwnfVzI95Juc11MYRxl7U0Imv
         cbMA==
X-Gm-Message-State: APjAAAUvpT202BD2lo153EsJhbBKH3rOKvUjVoOTGxiDt3s44BIernPH
        isrLRtW364lNFTySGNMBu2s=
X-Google-Smtp-Source: APXvYqwNBxg2BtIN4gj4rrwGFg2gsgN6ZE3h1fbbtS60QdIOh8OGEhDEl2bdo5IrA/o6uRhV08Svxw==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1mr7235061plb.129.1553421762302;
        Sun, 24 Mar 2019 03:02:42 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.35])
        by smtp.gmail.com with ESMTPSA id n65sm44398094pfb.160.2019.03.24.03.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 03:02:41 -0700 (PDT)
Date:   Sun, 24 Mar 2019 15:32:35 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, philipp.panzer@fau.de,
        matthias.bgg@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: Remove space after cast
Message-ID: <20190324100235.GA17038@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the checkpatch.pl check: "No space is necessary after the
cast".

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index dfdc425..04c551a 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -818,7 +818,7 @@ static int gdma_dma_probe(struct platform_device *pdev)
 	match = of_match_device(gdma_of_match_table, &pdev->dev);
 	if (!match)
 		return -EINVAL;
-	data = (struct gdma_data *) match->data;
+	data = (struct gdma_data *)match->data;
 
 	dma_dev = devm_kzalloc(&pdev->dev,
 			       struct_size(dma_dev, chan, data->chancnt),
-- 
2.7.4

