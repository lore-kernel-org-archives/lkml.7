Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BEFC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E19E222D0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCVjBZgJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfJCA2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:28:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40189 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbfJCA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:28:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so552455pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iL69b6SZhjeHqz7z9KlPv28qExZ+KYl8s7du84qUeS8=;
        b=CCVjBZgJNoZXNmUjGe6FbDFZNAoTKdPA5z/K3o2b0kXvq+yxh5d71q0qScFjbdJjfa
         xhx2L7zDBHspwU144G0iCenrQbVHQTaoMaJIMZL1gLLFK0Ql4X662BevGMszLnTe0Rgo
         8yWL+thmAaoBbI2N/bhM42gbcX3W0/auI4UZYKsX4xCjB5TPCWtGGE+yI+v6AFQI57sA
         DDG9BSspxuYtG38gWEpz629rzpQ2fb6NvkAijYdESDKGAtbEx0d845ZpiR/sL2ux454q
         n9UvgSYnzvwy3K8zs6bHqG4/k5cyteWcT0XMt8uhscYZq8JMh8ak73rSS2qVJwKl4pZK
         qw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iL69b6SZhjeHqz7z9KlPv28qExZ+KYl8s7du84qUeS8=;
        b=dcRyEKpAhScE0bCZmuS+myP+DsQmTs/DnBCqS7zCYonWhrVwALl1XirVEfMner9aEL
         OSQ7RKZPedEl127tp5bFibxHgKNQ+UKkj1p/s3y4x1Tqu6ixtwjZxlPdH6mOZeTV/Rr0
         1/FQSDunLfym7D6iQV8f76jx20HqsGwJfDaYMteOHvfawV/NiG0TQTV7e0YwLhsPnBxN
         psf6BTeJyftf0lc+bvA7oDKnQPv2bE0lF3IR2kXoIvsVexvI5eU36hpQSSzmum9lIm70
         SSinK+WJpwAz+Cb6Oq8r5ia+PL1hNGaRpyJDuyyCSX5qxy1+BOhprk5w1gQWtD0e19Zr
         2tIg==
X-Gm-Message-State: APjAAAXFulqO0aPdZ08xRjyNCgqCZi0bhvUb7pISEzMUqh/gra/nArnl
        X2JGKj8dyIKiWvZN3BzKt7A=
X-Google-Smtp-Source: APXvYqwFP2HkZRPrbol5vIsSYp/fffUusMuEcHddPRE2ALruoM69Yon/0d4gO7dbUS6vv2cn2uppiA==
X-Received: by 2002:a63:f5f:: with SMTP id 31mr6520184pgp.265.1570062514976;
        Wed, 02 Oct 2019 17:28:34 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 2sm617591pfa.43.2019.10.02.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 17:28:34 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:28:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: arizona: switch to using devm_gpiod_get()
Message-ID: <20191003002832.GA13466@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that gpiolib recognizes wlf,reset legacy GPIO and will handle it
even if DTS uses it without -gpio[s] suffix, we can switch to more
standard devm_gpiod_get() and later remove devm_gpiod_get_from_of_node().

Note that we will lose "arizona /RESET" custom GPIO label, but since we
do not set such custom label when using the modern binding, I opted to
not having it here either.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/arizona-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 4a31907a4525..f73cf76d1373 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -814,11 +814,7 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 	int ret, i;
 
 	/* Handle old non-standard DT binding */
-	pdata->reset = devm_gpiod_get_from_of_node(arizona->dev,
-						   arizona->dev->of_node,
-						   "wlf,reset", 0,
-						   GPIOD_OUT_LOW,
-						   "arizona /RESET");
+	pdata->reset = devm_gpiod_get(arizona->dev, "wlf,reset", GPIOD_OUT_LOW);
 	if (IS_ERR(pdata->reset)) {
 		ret = PTR_ERR(pdata->reset);
 
-- 
2.23.0.444.g18eeb5a265-goog


-- 
Dmitry
