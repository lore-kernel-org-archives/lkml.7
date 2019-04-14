Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF12C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2414020896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3umnvAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDNSfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:35:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40724 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfDNSfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:35:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so7482230pgl.7;
        Sun, 14 Apr 2019 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vr9Yxy09dcI79rLRMP6LFducxJaWKK+SNjuB6UlLuzI=;
        b=M3umnvAymjfsRX3ZodG4nkg4h8Z98VEFMNwXpDVaSo8a4kNhRFdf7FDJ7KHvlvo4E1
         13uBAAfmsLdxiTO9kDzwseA0neyoOCly2gjs0+2sOon8VKQZOsil9HFHHTvhkunPcuxg
         U+2ftFjOeAnJP+mzlJOJCygUWQCQ6oPeiDiXu+5x8BHo3AN2P3frNG00apof9C78OULY
         27/wEktviO1Z/0pVz7iP42E8145TQo54fijUzX75a5dz5fxGcPgTzHENecwf8x68Blz2
         Kup6QGLD1f+0NuOyLluj7lfJqjkA7SJK/uanr693P6GAKNpqTqNVIDQz5QwKq0Q+py8D
         gNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vr9Yxy09dcI79rLRMP6LFducxJaWKK+SNjuB6UlLuzI=;
        b=jCNJF395sk67O0TqwZhF1zcvvwBzr+7zSfRVSpq0rqGC8hsyQMlLX1wXwShzwsLeeD
         KdYWsd0bn7Al5UqmANINCJxFLgpRMWDHkIJOtdceExuJxUQ43mxl+uCF/x4f/N8l+7Mz
         oGjpKytYG69Ls5RETV/o7aojWoLi654zWwa+HxlxdUPKY2t3O2gxX/Wnhvs1BTezES0v
         JjDZSJBpuwEDao/R/oVMKhLm3MruZR1+f+biI896+VUQQB43VpLhzANViLIS0Jf+ME/D
         dEuGhuJ2qIjCqQ0MyQJzfmYazA9bjs8QuoYmS1M9+EhBXVlFNDk6NqNI3U3oTDdiz8LO
         tHVw==
X-Gm-Message-State: APjAAAXsETA09vRquJs4JvUHr9YipxHZ8Ff6bSriR4P/OyN7LgScl8cJ
        WVwBCq3a/ps44cREOsEdkDPzchMR
X-Google-Smtp-Source: APXvYqz0XqRuErm7f9n8JBvG+SjAhjmzNH9lSMrnIWoN86s6RzkykNw19hIi0Brx20vlMr73coXjKw==
X-Received: by 2002:a62:1318:: with SMTP id b24mr69771631pfj.201.1555266910684;
        Sun, 14 Apr 2019 11:35:10 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p7sm83791758pfp.70.2019.04.14.11.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:35:09 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] i.MX7D ADC improvements
Date:   Sun, 14 Apr 2019 11:34:58 -0700
Message-Id: <20190414183504.23286-1-andrew.smirnov@gmail.com>
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

Changes [v1]:

    - Renamed imx7d_adc_resume() to imx7d_adc_enable()
    
    - Renamed imx7d_adc_suspend() to imx7d_adc_disable()

    - Reordered the series to have "iio: imx7d_adc: Use
      devm_iio_device_register()" as the last patch to avoid
      concurrency problems during removal

[v1] lore.kernel.org/lkml/20190403070325.1077-1-andrew.smirnov@gmail.com

Andrey Smirnov (6):
  iio: imx7d_adc: Add local struct device pointer in imx7d_adc_probe()
  iio: imx7d_adc: Replace pr_err with dev_err
  iio: imx7d_adc: Use devm_platform_ioremap_resource()
  iio: imx7d_adc: Simplify imx7d_adc_probe() with imx7d_adc_resume()
  iio: imx7d_adc: Simplify imx7d_adc_remove() with imx7d_adc_suspend()
  iio: imx7d_adc: Use devm_iio_device_register()

 drivers/iio/adc/imx7d_adc.c | 175 +++++++++++++++---------------------
 1 file changed, 74 insertions(+), 101 deletions(-)

-- 
2.20.1

