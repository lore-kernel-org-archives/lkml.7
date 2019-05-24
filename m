Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98318C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4669E217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIkbsY/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbfEXAuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:50:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbfEXAue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:50:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so3437492plo.2;
        Thu, 23 May 2019 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vq5OscFiBg+c2cP1NzGhhjMT3RLQCBEIhZHhvje2x5I=;
        b=WIkbsY/TDaVPI5z60Tn4ATxrtlgyarhuhzGl7tFy847LWwZlvijIngLI0XMBE9qCDb
         pSWLCeQqhHiem7oNeT9m0DChmWEfd5DeLjg5K/Sj6NBAxypME8zGxfHGd4UfxoojMpye
         qcRyjJropK5H1rp1yTvykFcrd2dxylvmLkk3ga1NZXe8PFOmdpzBxJTZeDuIvktKhwsR
         6uOraw9mlBinMu3w9myx+pjNB1C0+JcmVS2XOdmhNikr0cZOXnvrF/B+GOMmw8o3INqg
         YB27G/Znkl3oBugcnN0yqr4hwZnSnvZ5NjN0ExmeabwWdmNXKpfyKgHRsGJCZagUh9M8
         s4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vq5OscFiBg+c2cP1NzGhhjMT3RLQCBEIhZHhvje2x5I=;
        b=j0z5GWvCmcIavyoAIyLrAjTdnvP+wPDC/pwm2aA/fDNHTQ27qOsgn36N3epEXhZEZK
         T/5pToF3e8g3g6ysJoKHILhKHvSQrT2W2KjOTgNL+eXh3JyYo4GkLRX90yAKs1nGI2T8
         24Bv5NPncoRdoq86Nuz3nSbgx4ddiliwlzRAukZ5DVcVbb4SwxB4gyHQgbXhIjUURl7c
         0l9azxCctgSX9RxUpChbD5LgYhyi/4fFaWxBtzbo5bD99qsNj8aHAggYRRGsVvATSmVM
         c5zh9jcfatxAK7rZYSU/ZFDIYGGnutyyCiFaPGblW5Ou1nz11ZW57jr37us22oDxUEBW
         rvuw==
X-Gm-Message-State: APjAAAWVgNzmn2qxJcv1gSdTgEI3cc/aYZBm7TI0ySRZer5I2YWzXjlZ
        V/la65x8DbQK9vxtLBk6ZziFD3uRZ20=
X-Google-Smtp-Source: APXvYqyF047YsIZEkBz6n7WubO3vjZO5g0ZmOj56HpzuyWWN8qDAIdjpPPReYmER77uDaRH+jsnurw==
X-Received: by 2002:a17:902:59c3:: with SMTP id d3mr30818966plj.273.1558659033669;
        Thu, 23 May 2019 17:50:33 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id d4sm468985pju.19.2019.05.23.17.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 17:50:33 -0700 (PDT)
Date:   Fri, 24 May 2019 08:50:14 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     lgirdwood@gmail.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
Message-ID: <20190524005014.GA2289@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
platform_device_alloc(). When it is NULL, function returns ENOMEM.
However, 'machine' is allocated by devm_kzalloc() before this site.
Thus we should free 'machine' before function ends to prevent memory
leaking.

Further, we should free 'machine->util_data', 'machine->codec' and
'machine' before this function normally ends to prevent memory leaking.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
index 864a334..295c41d 100644
--- a/sound/soc/tegra/tegra_wm9712.c
+++ b/sound/soc/tegra/tegra_wm9712.c
@@ -86,7 +86,8 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
 	machine->codec = platform_device_alloc("wm9712-codec", -1);
 	if (!machine->codec) {
 		dev_err(&pdev->dev, "Can't allocate wm9712 platform device\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto codec_free;
 	}
 
 	ret = platform_device_add(machine->codec);
@@ -127,6 +128,10 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
 		goto asoc_utils_fini;
 	}
 
+	tegra_asoc_utils_fini(&machine->util_data);
+	platform_device_del(machine->codec);
+	platform_device_put(machine->codec);
+	devm_kfree(&pdev->dev, machine);
 	return 0;
 
 asoc_utils_fini:
@@ -135,6 +140,8 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
 	platform_device_del(machine->codec);
 codec_put:
 	platform_device_put(machine->codec);
+codec_free:
+	devm_kfree(&pdev->dev, machine);
 	return ret;
 }
 
---
