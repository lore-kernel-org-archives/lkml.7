Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC0FC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7BC20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqpn2OIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403916AbfIMPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:25:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36003 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390565AbfIMPZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:25:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id t3so3247029wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/lU9jG5N7e3DGoVf3x6D+rPQKudYImqOCFLI9QDQ8k=;
        b=gqpn2OIiZdZR/ujxmZ4QKVcE0P5jWYnbShSyKwt+5OJvAk//DlifLDtqxfEpAUw/l6
         T/DR/0AYFynhblu0cN/SaXf0Xm/FdY9gTY17Cf+x5rj0ebfHya+BtDzrR2GF0JeAmAH7
         FBlDd/omPPc+NNNMxizNCrTMDPoo4YUiNtEBLP4tEJQh2+4lpgQjMCiHIXzAZMdIKtFd
         4nUHzhjGxdp75h5RzCVqrfg8ei+s69essebdX5VSw4Q8BunyAPSq7JDaG8vwaCBc0mE8
         EZE8mPG3Ez3C8SDVWhgaF0Blqb+gUejmRiFvL2MjAd6xJAoP0p4mIwrRifcogsqKZOKP
         datg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/lU9jG5N7e3DGoVf3x6D+rPQKudYImqOCFLI9QDQ8k=;
        b=oI7XYWu/ZoN+HWPpdtYW7UQjC4ee8IzI6OA5+SOZzCD2HKXey0S17iwdev4i0ZKnoT
         5+YimLIb+oQXcjMtJU6ymxf5sUK9ZFANQtOTFraa7vamO6dr3tJd0H3EA6wcq+1CJmlf
         mMaY8uqR2EOYT3m6zmJVLDvfqGu3JxIBNiCSns6pvmuLl4iUMVRK84JQriYhCLbIotNS
         1c9Q/BIVlZn+3cMUOEOl/TqoXdSE53vPaozTlXZvuU88GX/ZwBNqkXUm0PdGt313tj8o
         KDRIu1JfJla+E3s6n+vnPDh0HAPZ7bwEm6/+b3S8GX1uqajZcfuWoKqDgFbY7BrlnUSp
         0d4w==
X-Gm-Message-State: APjAAAXQNhTvTp3ZDCgzn3Ktyn3FMrAgnc0AdlsgShWlSCfM2TxtYaj6
        kSDUKCdqbxGGr3il1N/S/tfDaQ==
X-Google-Smtp-Source: APXvYqxWQ91NXtafTPXEFw1LY9BKh7iuZDpGVjdrEaEUx1UWzcdcwz4E003A0N8qBlfiRLGXJ/9RgA==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr3725176wmh.98.1568388338932;
        Fri, 13 Sep 2019 08:25:38 -0700 (PDT)
Received: from localhost.localdomain (69.red-83-35-113.dynamicip.rima-tde.net. [83.35.113.69])
        by smtp.gmail.com with ESMTPSA id d9sm48717728wrc.44.2019.09.13.08.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 08:25:38 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, gregkh@linuxfoundation.org,
        arnd@arndb.de, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/5] misc: fastrpc: fix memory leak from miscdev->name
Date:   Fri, 13 Sep 2019 17:25:29 +0200
Message-Id: <20190913152532.24484-3-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
References: <20190913152532.24484-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Fix a memory leak in miscdev->name by using devm_variant

Orignally reported by kmemleak:
    [<ffffff80088b74d8>] kmemleak_alloc+0x50/0x84
    [<ffffff80081e015c>] __kmalloc_track_caller+0xe8/0x168
    [<ffffff8008371ab0>] kvasprintf+0x78/0x100
    [<ffffff8008371c6c>] kasprintf+0x50/0x74
    [<ffffff8008507f2c>] fastrpc_rpmsg_probe+0xd8/0x20c
    [<ffffff80086b63b4>] rpmsg_dev_probe+0xa8/0x148
    [<ffffff80084de50c>] really_probe+0x208/0x248
    [<ffffff80084de2dc>] driver_probe_device+0x98/0xc0
    [<ffffff80084dec6c>] __device_attach_driver+0x9c/0xac
    [<ffffff80084dca8c>] bus_for_each_drv+0x60/0x8c
    [<ffffff80084de64c>] __device_attach+0x8c/0x100
    [<ffffff80084de6e0>] device_initial_probe+0x20/0x28
    [<ffffff80084dcbd0>] bus_probe_device+0x34/0x7c
    [<ffffff80084da32c>] device_add+0x420/0x498
    [<ffffff80084da680>] device_register+0x24/0x2c

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8903388993d3..bc03500bfe60 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1599,8 +1599,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	}
 
 	data->miscdev.minor = MISC_DYNAMIC_MINOR;
-	data->miscdev.name = kasprintf(GFP_KERNEL, "fastrpc-%s",
-				domains[domain_id]);
+	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
+					    domains[domain_id]);
 	data->miscdev.fops = &fastrpc_fops;
 	err = misc_register(&data->miscdev);
 	if (err)
-- 
2.23.0

