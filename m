Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E54DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00260222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EflmrY3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKLQzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:55:51 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33026 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:55:50 -0500
Received: by mail-qv1-f65.google.com with SMTP id x14so6663556qvu.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BlMAkrnyKu5xWVexX9Ig76FoxRSKHEIU4K4rFq7jLsk=;
        b=EflmrY3H+qMQUDULMQBmeTImNrztCWF14X6J4HahrD2sJPXQ9iwf9j3m6ryXjgEXCK
         3C8ohaLtqvUtrfb+RPNPrvWgozS5sM6enZkzjISxTDqIqie1AWNxhX9FjcOEzWNXu+hj
         mHNGa62t+dWFSVQXVqXjqM1h13d/HI8FHjKFxLRc+5V9d68VKEuMhZuVC/srnZxMLVo3
         04Ji9SKYeaKKFAD4Il1W9+nxXzB2cYHAAejS/+DhtyoOZqht01fdCNUMlmJQw9n4KYaU
         SNrlBFCD4ucm8wuRPe716YFiT1lqUmNLRlJlwTDlbqCNPjadTntN6N0kBzwzV8xKaOFY
         84bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BlMAkrnyKu5xWVexX9Ig76FoxRSKHEIU4K4rFq7jLsk=;
        b=O/b3JOH30HLUqfkQbxUF7e58A3jkSbDx4KxhaIFDzcopKOB9vA4U8oRPXkGgEEm0Vy
         ObLnkuNbkDnCmZ6qBQq7wrLcd/lhNnvgsoAVTsgEv4jlzvEdNQ+TKYdwn1fHJJUrRCwO
         3k/xcW0yyAT4/87NVQ2vzbA+Ns5J/kjYpdE/IFCEIbaNYXO2nRTc39JydUC0WRL8tSin
         mWFLZxuwdOkZ12S2j6irYRV/yDCzwtKdR3WvYAHdEiZfudjfAMXBr5Iyq8je4sFW5iZh
         KhXiNk/9zWg/HkwJp0XAJ913IneF6tkPNzVG15IV0GJt2w2Vi9Knc2Zf5prf/lsNxMc3
         JnjA==
X-Gm-Message-State: APjAAAVqWuXbmBw9wQBqKO34sXXmTvdY8Kc5Q9LPG37YDRoNXnFkUoHb
        txQ+sqDPDfPOaDn0+7/Vh8k=
X-Google-Smtp-Source: APXvYqyulr7h65zx8nem3bMKk/mbMW0p6bBZEhE/YLu/aLxCeCFFcXpdRudX8aYRGZ+R/CP5XmWJGA==
X-Received: by 2002:ad4:53ab:: with SMTP id j11mr4372671qvv.47.1573577750006;
        Tue, 12 Nov 2019 08:55:50 -0800 (PST)
Received: from gmail.com (dynamic-186-154-98-65.dynamic.etb.net.co. [186.154.98.65])
        by smtp.gmail.com with ESMTPSA id n17sm9737301qke.53.2019.11.12.08.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 08:55:49 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:55:47 -0500
From:   "Javier F. Arias" <jarias.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 8/9] staging: rtl8723bs: Remove unnecessary conditional block
Message-ID: <08de17788f3fa0db1645319720082cef412356ba.1573577309.git.jarias.linux@gmail.com>
Mail-Followup-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1573577309.git.jarias.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573577309.git.jarias.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a conditional block that had no effect.
It also reformat the affected lines to set the right indentation
after the removal.
Issue found by Coccinelle.

Signed-off-by: Javier F. Arias <jarias.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 0f5dd4629e6f..b4b535c66bae 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -551,18 +551,13 @@ static void HalRxAggr8723BSdio(struct adapter *padapter)
 
 	pregistrypriv = &padapter->registrypriv;
 
-	if (pregistrypriv->wifi_spec) {
-		/*  2010.04.27 hpfan */
-		/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
-		/*  Timeout value is calculated by 34 / (2^n) */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	} else {
-		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
-		/*  TX/RX Balance */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	}
+	/*  2010.04.27 hpfan */
+	/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
+	/*  Timeout value is calculated by 34 / (2^n) */
+	valueDMATimeout = 0x06;
+	valueDMAPageCount = 0x06;
+	/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
+	/*  TX/RX Balance */
 
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH + 1, valueDMATimeout);
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, valueDMAPageCount);
-- 
2.20.1

