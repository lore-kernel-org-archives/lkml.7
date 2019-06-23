Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D55C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4924720673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P//5KQJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFWRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:47:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43168 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFWRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:47:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so8331598lfk.10;
        Sun, 23 Jun 2019 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDhw7qv5Q+/BXJJ0stCvtC79undlN+qMj6BtzDp7pak=;
        b=P//5KQJDw9St6fTDS5RMDunpsFHQpHwqe+/LBTeLnJ2LMwOkdQH566CJCtT4VU/ZMK
         1V3lb6Z/cpkUyDzfVd7giE0YSGTNVabSjFsMQMhmyDltIVu7B5jCA6vHdLQbLbgZeh/x
         k0MvfeUlXMkbmuqwMGZindQSv7lSyCtn0jsl9tnMMjDoXlm/xzAwexoBdejeAoq1OabG
         Ma55ikpUno/i2KGL8P3sxgxExq6zEBsMShKxfeap7vtM1fSzayYAS5b+xctfiIgdHiUg
         Yg1achdvSqxf4CjUxNvSF5GS7mxFany4ykf7GS9e6Onq2YLTQdU9JZjx0payhWy6NSdV
         3oyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDhw7qv5Q+/BXJJ0stCvtC79undlN+qMj6BtzDp7pak=;
        b=pMv0JXYIV/+iaCqUfes5T3LwKwFBhtcoW8ckOvKx5z1EWXGT2zPIzEUe8ylyscgw0C
         Iju50SEKKbs40wpbjUJ+SazGJnBpwwwz5m2eI690RJMR17unfw40LYDXmRKNur3HnH6Q
         yE4djIAixdbTH1jxmnYofEL5g6pHLMOsqUWAsovbS23CeL6gbQvAnaF2EFUJJZa0UhWV
         uCoaN5BiGnN4gtm7uuiQv4j0hDUbuyGvxsxrUcAl5VXfFqBueGB2jyvb56i9CaYHZuUu
         6QlRtdTeAQaByrK6XOAzG0qbrrE3CyO+FTsWFekbqFta8Moi/UUTiCHDYHKKMOtM0gsV
         XV2w==
X-Gm-Message-State: APjAAAWNIGaV/103rZILInutVJSCzWgG8dPN+klFqw4uXhuoBlc1jooz
        qx03EqqZWr3kAA+aBqsmenw=
X-Google-Smtp-Source: APXvYqy6AkdQgXyPOrROxiYPXlbLohhB4gLkxwcBUAJhRhJz3pAReBRehbd/h/LdKfjfzFKWxzOSKw==
X-Received: by 2002:a19:4c05:: with SMTP id z5mr64264185lfa.5.1561312061983;
        Sun, 23 Jun 2019 10:47:41 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m24sm1219553lfl.41.2019.06.23.10.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:47:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: tegra: Add Dmitry as a reviewer
Date:   Sun, 23 Jun 2019 20:46:55 +0300
Message-Id: <20190623174655.25445-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm contributing to Tegra's upstream development in general and happened
to review the Tegra's I2C patches for awhile because I'm actively using
upstream kernel on all of my Tegra-powered devices and initially some of
the submitted patches were getting my attention since they were causing
problems. Recently Wolfram Sang asked whether I'm interested in becoming
a reviewer for the driver and I don't mind at all.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ac347278f1fc..402c6ee32db6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15588,6 +15588,7 @@ F:	drivers/dma/tegra*
 
 TEGRA I2C DRIVER
 M:	Laxman Dewangan <ldewangan@nvidia.com>
+R:	Dmitry Osipenko <digetx@gmail.com>
 S:	Supported
 F:	drivers/i2c/busses/i2c-tegra.c
 
-- 
2.22.0

