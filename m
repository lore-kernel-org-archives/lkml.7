Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D44C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087D620882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk8M9dtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDCHDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:03:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:03:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so7680769pfd.1;
        Wed, 03 Apr 2019 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxvd07/GyCgB1s1Ith2tno05xPtjzC0OyzmBfn81yfw=;
        b=Bk8M9dtZAPS4jiaz0HDfSGG4dmATP4QesJE1gGcmKfE482phpKGDWt+tlecDI4nnlv
         ZRyrS+9GeHyfeT8LMV6QZxjBClw9GLdXIsNn7Rk++05JiJb9AwJF7f+nUrCxvwPMR2F2
         csoHiJ10mLCSsJa2CJcW9Ygp7Oyku85dXEKvzE9FXk/u6X+yTTp0Iu/ss2/OKLgWoIIH
         KxL2/gL8Z0fQOlWcksC9rOl40J4JqXb5ajUVLhwBPOrGmSuGq0z8ebsJUEtKjQT+pDiJ
         SSxUznMcE3n+hiRo6KWkfl3GL3vgrhX7L0bHKspPbWaNrlzNQs36tw+0FHm0c4XtFCNg
         RDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pxvd07/GyCgB1s1Ith2tno05xPtjzC0OyzmBfn81yfw=;
        b=oJmatD/yf7EoWMTnEUfq/6p4wc8CQizAsqXKa5fNxJSWb78tkJOXOlvr0etLchUHkE
         8HA5ySriBGOtIX4Ow8pDBSksKkRUjiXEWYw1Adp3YagtuarZb/mfguBZo7z7nr2eVwJ8
         qLi+T7EIpLnUwE0ydqqgJ4HsR4T0Hn0mbOqMABqKHuPNS1pS/aM7LVEidci1G/DuwpPH
         f8Lv0NkDciue4oxnT4OGN07HaN8rU8C/9m9YaYtfKQY+iiBPFfc+pM8zBB+zTtuvOY+K
         +E0eHHX1H7Hf6XdymVQpstLnJlPhNTE02238nnJyboy5bLQii2/UonHyqn1Ek7/VgCal
         eWVQ==
X-Gm-Message-State: APjAAAWArE5ZhUOMJkzwzc3ncBIpvyxQBjuQyhVkrt5tBnJRxYvG0mxD
        KysWnmJQ3nornDmAB3oACbQmPLts
X-Google-Smtp-Source: APXvYqz49Q+SR5D+b1S25gg1E9/u44jDLHesNEm7To5vUSt/kbbEaxl+U7eVVH65Vd10J32RjVe8wA==
X-Received: by 2002:a63:1003:: with SMTP id f3mr61167025pgl.227.1554275023651;
        Wed, 03 Apr 2019 00:03:43 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e22sm20602750pfi.126.2019.04.03.00.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:03:42 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] i.MX7D ADC improvements
Date:   Wed,  3 Apr 2019 00:03:19 -0700
Message-Id: <20190403070325.1077-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This series is a number of small improvements I made to i.MX7D ADC
driver. Hopefully each patch is self-explanatory.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (6):
  iio: imx7d_adc: Add local struct device pointer in imx7d_adc_probe()
  iio: imx7d_adc: Replace pr_err with dev_err
  iio: imx7d_adc: Use devm_iio_device_register()
  iio: imx7d_adc: Use devm_platform_ioremap_resource()
  iio: imx7d_adc: Use imx7d_adc_resume() in imx7d_adc_probe()
  iio: imx7d_adc: Drop imx7d_adc_remove()

 drivers/iio/adc/imx7d_adc.c | 175 +++++++++++++++---------------------
 1 file changed, 73 insertions(+), 102 deletions(-)

-- 
2.20.1

