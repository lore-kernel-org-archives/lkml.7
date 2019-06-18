Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B13C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8392080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="P7YCCzW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfFRJGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:06:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:06:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so13008084wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdBEjfvEZutCl08g74/u8ndD1BKwIGTQbgG1o/DDDto=;
        b=P7YCCzW5G2j4Vm7HbgIcCUt1XRRfb7UJ+uAqqNLT4fx9U+k6spky1eZLRo0b7LiYii
         ziz42k/waQxyV3Ke19hog6tDtLis1aBssebciKMyRWpnxLT8HaH5+/hP7Jn9WRy+r30o
         2Iezc5a/J0mUDTJtVLses5B8wDXwsFx58mcihSQt7EmMwMZDvxQBPyzyyn2nx50W/Zhe
         piSwEGvc3HB58ljVPrQ2iVLMBd4GhjEdI6DdZjLBNTDecEDLOJp+rtMyO+OJ1oWh6Hgp
         /8vWHQZ3QBElEs2v4VekrgXDAaTexRam1sWQiDVrxCOgneUFZWs+zkZgquw7cUw1bwl3
         p7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pdBEjfvEZutCl08g74/u8ndD1BKwIGTQbgG1o/DDDto=;
        b=jjsWiLZNaA8CWoKOf3SkMLZwNBKeUNXJGTLLPVD/XgK+pZZf7ududVjEaY24KycIu2
         DPJZKR4qfW5vgvlagkHQ7Tzhrhz1IIAqnMGy6rzEjlMo5A+A/DaK4FgedLr9XyeY+Psg
         jzidNQA/a1ZXM/dT4coQJhJptI+7EDAD7yavQxOcKDOHPeU9xfQ+VOy7+DbuFX59hxHf
         oARSF9cVVEhcy82gaCfOCJKbHR+JKPEFOg5QthwyY8zrqVQlmS+3cP3kPbI62/ELJbWL
         YdUDiteD50OPXnS/ilVp408wr71vJWT11RWpe8xUWHTk/c1z5ZtXeFImnMbXKEbBhbu0
         tnLg==
X-Gm-Message-State: APjAAAUm/1vQSHa/ornH53mitCiJ1yevaL+MmP6xYGcb2rhM/ZCYCj+6
        JMakOv7J34vHOYPXSQZysM6G3Ke9ML8=
X-Google-Smtp-Source: APXvYqziYZHFqu0Ks/fOERLHVLk91T8Eccy6Zg+Gq9UDM/ZgevbGJABIlQfdp4IUe48pyeyYLOs7PQ==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr10957114wrr.330.1560848768412;
        Tue, 18 Jun 2019 02:06:08 -0700 (PDT)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id z6sm15959619wrw.2.2019.06.18.02.06.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:06:07 -0700 (PDT)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 1/1] counter/ftm-quaddec: Add missing '>' in MODULE_AUTHOR
Date:   Tue, 18 Jun 2019 11:05:41 +0200
Message-Id: <20190618090542.13885-1-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last '>' chars were missing in the MODULE_AUTHOR entries.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
 drivers/counter/ftm-quaddec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index c83c8875bf82..68a9b7393457 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -352,5 +352,5 @@ static struct platform_driver ftm_quaddec_driver = {
 module_platform_driver(ftm_quaddec_driver);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com");
-MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com");
+MODULE_AUTHOR("Kjeld Flarup <kfa@deif.com>");
+MODULE_AUTHOR("Patrick Havelange <patrick.havelange@essensium.com>");
-- 
2.19.1

