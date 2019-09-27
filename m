Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377B2C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC6D207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fGAQuYaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfI0HLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:11:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36674 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfI0HLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:11:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so1025087pfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=v4CYbDgI+ZExVL7Ey3SHDVJYdquQ6nNneks9sNV/1zM=;
        b=fGAQuYaUuJS0onXta9DcP5iWkDlCdRyhW6e05Srzg1F77NNnN1B8+yp3U3Ne3I2eke
         3VznwdYIPtImlztVmwSxvWqx0oVEZ9/fik0CGbbk7JzqXeuS0/aJRlseVEL9V38qbbgr
         hI7W36dxeFE5xEkU74/b9n1KW+FHDOsMtcCv9vBKX7SWKSQsFd/pJzb0S6bPJ7Jko5Ke
         F+S+yrbazWCAk2was1TAONqtYf3BZ2Y10J+z2iUDT8FfzKv6D4lyXuVCDlRDkN65qUBi
         yHFTJpHRHShe2hjBe+uLONkIhf/yP2V2Eequ5BmO+hyexkwSQd22M6KtsRzI7ehL6PQQ
         ZmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=v4CYbDgI+ZExVL7Ey3SHDVJYdquQ6nNneks9sNV/1zM=;
        b=fTf8gExaH997eJzNuGde/v3qb+Y4YEsEsINRZub3rnV+32vEzUy6yyfLR/GoOEF6YI
         hMzbE1W3VyfOTo4MojULuKQaIGobu7zceqMVUyfsFY5ZOCLOQCzquTKTDYHkXb7L2pXy
         zhP4s7y37DTOli32iPIYMTo3jQD2TD1DAPO4WUSodhHj12XexKQQFQz0vfbFHhTk3tBN
         Rxxcvy3+1HONzixgZ64imNFo3I1zxcZhLgmIFFdcCdh9t5Bb2odKzEYMmHUi3rKuWzeq
         /rmf0d43bJaOh6QsSA1xMMU1xglWop4MddVykQX2zSEL3ibeuT+tv5aYsPSZgCtjoqvA
         2A8g==
X-Gm-Message-State: APjAAAXNuDkjjH2camuKHa16oTU1Wqb0Ox++63Djn+FYMMOfYQsIJRz9
        t5H+xh+i7qygWlnLq0BZY8vDcA==
X-Google-Smtp-Source: APXvYqyjLyv0T6+Soc8rfhuCL36fszrICz2GNTzWHVICEtG9+dfgEtnvtmGxPXAFCsekAXIAbgksJw==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr8096278pjb.105.1569568274050;
        Fri, 27 Sep 2019 00:11:14 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f74sm1733288pfa.34.2019.09.27.00.11.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 00:11:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwspinlock: sprd: Change to use devm_platform_ioremap_resource()
Date:   Fri, 27 Sep 2019 15:10:44 +0800
Message-Id: <00916cd2409a5607fc4023a4cae351f1b2e84d8a.1569567749.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1569567749.git.baolin.wang@linaro.org>
References: <cover.1569567749.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/sprd_hwspinlock.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index dc42bf5..7a8534f 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -83,7 +83,6 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct sprd_hwspinlock_dev *sprd_hwlock;
 	struct hwspinlock *lock;
-	struct resource *res;
 	int i, ret;
 
 	if (!pdev->dev.of_node)
@@ -96,8 +95,7 @@ static int sprd_hwspinlock_probe(struct platform_device *pdev)
 	if (!sprd_hwlock)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sprd_hwlock->base = devm_ioremap_resource(&pdev->dev, res);
+	sprd_hwlock->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sprd_hwlock->base))
 		return PTR_ERR(sprd_hwlock->base);
 
-- 
1.7.9.5

