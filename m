Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381BAC04E87
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0672021744
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 02:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX2oIG20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfERCbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 22:31:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45456 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfERCbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 22:31:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id j1so5611778qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 19:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Aqqb8fq9rk5ariT5pZi1gMWAA/hlm63uYollEoNQ9/o=;
        b=NX2oIG20JAoVtNLysGBZjgsCPWyGlNz8/o0M4HyjPOaevISxddvGsVTvEBqlHvjEYA
         +R++OHTjqL5/hfHhbKUsvnY2VjnihuEscKAVmcGz1zv7sNFTecNnlY0lzObmPb/dU7Ss
         bpdoEBh7Qsq7JxPdm7mbtP1+X47V5ItemL7W35UMSqcuU2IfO6KZ1yPfSB2xfigQLglw
         iYxeweDBAx5e1ioXQKkY4tPe4HFh3uKzU/nKQfIry6RccfwwciNRIaOwwwQpbAP6PiDp
         DJrAZdzykHjhlWKCvhbDS/2pQsCo4btzHZkRmTmChzbdnkSBJT4gNgT04mmwlKcgmAHo
         FjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aqqb8fq9rk5ariT5pZi1gMWAA/hlm63uYollEoNQ9/o=;
        b=dCIvNAXeJrpbtChiqPkWM5dMhslB0A5Bcb35W67K8aRVfqkkysWQ4a3MlezuQgYyLg
         EP3+2eVHcPhz1++ITewSnB6kp9qmfWjXqS1iKyt72vnxsCyk7xHyhyZQO0y6ofTePnFV
         zQow1d9YsdrHBhOWv61we1ixd9T4H6K4LoI4d8lQZf/I0ecVtcvls+P3zBks890XO4L9
         cA5OUTSddxuqutxD01EhYJKc79dTOYKIXZQFOw9aRszwhB1eyC65o6EZguI34L8Xo3aK
         xw4xic82te69DCYx2bwfZdfc28NnDtjDKCwQzVidTvm033XbaAgivGPa+pL4FvbGSIqD
         KuFA==
X-Gm-Message-State: APjAAAWJbTnk4kDwAPUCqtZq8R8fjqURCjvf7t03of3LoaKBUZmPKi+u
        VMiNfsxGPTCaEXqrtNgRM4g=
X-Google-Smtp-Source: APXvYqx3Iadqq+BaRi9/tEvUBSeA6oMnA55YundP+V9Ug7zdXmHaIWVKYWoBjhUnN4ooMr5uP8eeng==
X-Received: by 2002:a37:680c:: with SMTP id d12mr47915959qkc.202.1558146669664;
        Fri, 17 May 2019 19:31:09 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.dc.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n66sm5210322qke.6.2019.05.17.19.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 19:31:09 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     gneukum1@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] staging: kpc2000: kpc_i2c: prevent memory leak in probe() error case
Date:   Sat, 18 May 2019 02:29:58 +0000
Message-Id: <ff94cd3b0d13c2785bc4d2cc7ac6d63f11691fd1.1558146549.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558146549.git.gneukum1@gmail.com>
References: <cover.1558146549.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe() function performs a kzalloc to dynamically allocate memory
at runtime. If the allocation succeeds, yet invoking the function
i2c_add_adapter fails, the dynamically allocated memory is never freed.
Change the allocation to use the managed allocation API instead and
remove the manual freeing of the memory in the remove() function.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
index 6cb63d20b00f..9b9de81c8548 100644
--- a/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
+++ b/drivers/staging/kpc2000/kpc_i2c/i2c_driver.c
@@ -628,7 +628,7 @@ int pi2c_probe(struct platform_device *pldev)
 
 	dev_dbg(&pldev->dev, "pi2c_probe(pldev = %p '%s')\n", pldev, pldev->name);
 
-	priv = kzalloc(sizeof(struct i2c_device), GFP_KERNEL);
+	priv = devm_kzalloc(&pldev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		return -ENOMEM;
 	}
@@ -685,10 +685,6 @@ int pi2c_remove(struct platform_device *pldev)
 	//pci_set_drvdata(dev, NULL);
 
 	//cdev_del(&lddev->cdev);
-	if(lddev != 0) {
-		kfree(lddev);
-		pldev->dev.platform_data = 0;
-	}
 
 	return 0;
 }
-- 
2.21.0

