Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD0C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D7C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqWAN5Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCSCUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:45 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53945 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbfCSCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:43 -0400
Received: by mail-it1-f196.google.com with SMTP id w85so6998047itc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+t0zVHPs47I9d5tL5665ViF1svCSYXr8jg/veuOUcY=;
        b=WqWAN5Rz5lBIJcgbTmM4h/p3YBYrUvY4I7d/T0u5efY5EkCD+YWBmsPunaga/9C1YT
         h3vUL6wIPTrDqNUhPDKiQ8jbpgkxqKcXrLLSMBUm8+r8kqy+eDwOmtFCsOHcw0jMB9GD
         A4q2lSIQ2U5kCnrZILo0FlJfgF3Cp5c6mSH2jBBf8+HY3uuXSYkU39PfC8BkvbmLdYGW
         NPTccUncIp90/P7bHOyh4pxabW6UnIRFQrbLopFU0GUbxbM4Zlu/qEyNl1g/MXrZXyZN
         MhuGXDqlv5H4JQbV5K0NLDVcjtAFlM+FmFtNBcJ0QzzQ7jnkRYWrhPZBFDzrdK9hZAvT
         AyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+t0zVHPs47I9d5tL5665ViF1svCSYXr8jg/veuOUcY=;
        b=buni78ReENeZQOyWvJxpQtBt1cMmSyW9HIeC5EQC25mLD5c2VS+kDJQVBnvTwC2wFH
         OyhZqDJVibZW9m9rk0TGV6X5fvxBvJoCBFzqE3M99XvnUWBAFA6rWEVVNZ9B9xSo+iil
         4c/ixZdgSEyYLSIR0w2ABop3cQU11V3kEliJOh5Ec1NNaIL6EL1AgIe3vqXYllXloWFX
         dq0uSsB77/PGmoBNe1NfgDnlsA4soNZFsXHf9ftmNEPhRHfMlt+IluvGkV1Xz0GvWddb
         b8LcscWwOvkxRKGqi8fPnDhaKRnt62F4KVTLAEsPrgueShrxWtlU3dm1zTZ40SUF9XfP
         /VCQ==
X-Gm-Message-State: APjAAAWLYvjZcGHvWgUysNXnnzlDCWtST4kLaY2UBJexfRymkVll1Udk
        x9aI1GNBhejx5CWy3o6cv8E=
X-Google-Smtp-Source: APXvYqxURWfkTndIruTHJ8Kv+xJNDAYk6k9lM4YyDybdd38vmqXq24DjoABWPlyc2UlsyaWD+WXMXQ==
X-Received: by 2002:a24:f001:: with SMTP id s1mr39803ith.60.1552962042682;
        Mon, 18 Mar 2019 19:20:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:42 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 09/11] staging: mt7621-mmc: Immediately notify mmc layer of card change detection
Date:   Mon, 18 Mar 2019 20:20:10 -0600
Message-Id: <20190319022012.11051-10-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to delay notifying the mmc layer.  Schedule the delayed
work to run immediately.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index df85888f3a03..f64d51c8bd42 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1352,7 +1352,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 	if (intsts & MSDC_INT_CDSC) {
 		if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
 			return IRQ_HANDLED;
-		schedule_delayed_work(&host->card_delaywork, HZ);
+		schedule_delayed_work(&host->card_delaywork, 0);
 		/* tuning when plug card ? */
 	}
 
-- 
2.21.0

