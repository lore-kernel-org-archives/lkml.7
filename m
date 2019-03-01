Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF3FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1820854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb6rM24O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbfCACxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:53:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44980 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfCACxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:53:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id d2so26111234qti.11;
        Thu, 28 Feb 2019 18:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1dWlSdF/VUs9/9K5esBtgLKSgLb9YgXrY3lBZ+V781M=;
        b=Lb6rM24OksWcZSt2JkPf/WD0WBoF+ykC4AbGOpnESQu2EM45cf+5tNts3eu8l0fVvm
         QHXuYzElAszBugI3Yzjl1iPzs38ryVyLS0NSgnobEsCvjWbIc2wBwAyvGY9VrZskIsrG
         gIzh6ENoF89U573f0Fzo8FoAb0rNslOb0dorILI5t7yNNSxVn+bGfL0KPzwXlel0BL6u
         3EHltL1D9C5L/3YrARsznL7mtfDuOh62LYcrZjh5vWSeNG4kO6CIRWYfkk0ySFlv8Fhq
         ja0Zqt1PcnPwus4GpYy9b9PfqFdIaBnXoIX6I1Xb0uRazSj+ZnVapei6X2SsNHi8Tk7l
         g4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1dWlSdF/VUs9/9K5esBtgLKSgLb9YgXrY3lBZ+V781M=;
        b=tKV7sjx6Ww+cYXeO/pJD/KbHT8fOKYKUs+ODGuX6T+brzMU3tPa1g7W2hogmUf5qej
         pCgAUOplHS8hZPVNeu7ObWzDmUniHG0WzKgY8zk78NOoyCmfjRaUCua4K5kHPa+7Csd5
         ii57Rhpx1ysxPw5nhGuTmNMaZnStllUyv1jEYAMzLRjwvyCwfKmrv4UiGMwfPsrS56/t
         ALkODwo3wWx3R2RVlnaNrwsLwUrQkDkpX2Wh/H9hVh0RJNJSlTIfdON5jN/k3UbwCXG3
         MV8NaE0DvqXYr9UJdvQoL0vKDk6UkENmvu4WnivpPQfcn4z8z26SxnX8/+UWYPo7+RlB
         FA8g==
X-Gm-Message-State: APjAAAVp4jLpHiZCwdtTuF7DxmUHj2KaleLajvo/JEEPkjxgrNugRWcz
        egJofVmthMlLV2ZKcNbWvjs=
X-Google-Smtp-Source: APXvYqwmDf1j0s5QWxcv+MKGFxhNGJCDDANVonqpZgJRfzPR4JVTyf8myL/DD2qCk5TuW6P0INdtaw==
X-Received: by 2002:a0c:928a:: with SMTP id b10mr1985593qvb.89.1551408781928;
        Thu, 28 Feb 2019 18:53:01 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b66sm12872741qkj.57.2019.02.28.18.52.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Feb 2019 18:53:01 -0800 (PST)
Date:   Thu, 28 Feb 2019 23:52:58 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v2 2/4] staging: iio: ad5933: change help rule message
Message-ID: <20190301025258.bcvj5rg57io4najb@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the previous comment about direct access via sysfs which would
lead one think ad5933 driver has limitations it actually doesn't.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index dd97b6bb3fd0..b9a679cdd146 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -10,7 +10,7 @@ config AD5933
 	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
-	  Network Analyzer, AD5933/4, provides direct access via sysfs.
+	  Network Analyzer, AD5933/4.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5933.
-- 
2.20.1

