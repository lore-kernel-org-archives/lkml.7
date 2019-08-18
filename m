Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B3C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828B12146E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4zqhVk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHRJfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 05:35:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40949 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfHRJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 05:34:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so507141wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdcGXM6KsgrMmjpgvIUKi7bYgw0CC+Ry6Ot0JXzioGU=;
        b=U4zqhVk21/xwg51bUrRzjzkXoTugoOuVafHhqscFPKECyBWEMTJ2ujMikhpDcRBkbM
         AZdZ29GClmmu4XxAiQmULe6WUwl55YsBB7Z/ONS1JDCpKhVHup4BXRH0ox7zzko4IeSY
         xbYclxOGcUmXhEzB7rk4ZObkvm8eKperzVX+bW2NtWM5xFOxWcmTpoDE8fHDn1KULUPj
         chbgZj6jlv8HLDs7Q9fckoRz3cEVfAESDH0k6YvLlB4b9CLL5ewFLVrZ48M9xNdhhw0j
         wow70ZVgBixM8/200mc+1kT3crcf0afGBCQ+oY0zVi6j4JRgQb47/bRWFWmuNEV7/B0v
         GJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdcGXM6KsgrMmjpgvIUKi7bYgw0CC+Ry6Ot0JXzioGU=;
        b=AHhEAIKa1UW8T5vBTLrJQtaQOw3ek67LdNzyiOl33W7SV0ZAH25ObN3b2QPZHvBnat
         M7lGCVtA1wPNxVrsidDQ8gihoh5egrayin/D6fkG4foz2fNrxbcK2j5eL3JNcU6LulZ1
         uo71jzSH1a7wzZ1ACWei0rlfJpzSrhGKFpIftoeXMfwv9v00icjoF7v0Hsk6EjT499aU
         IY8GIgBFBi9DOK38/4GdCiFsx8LCBXpSAOZPdzN1ab3cm5kfe2UFbxYmoHxQufJZlznA
         X8F6v2gfcuSXbb/J1k0ffMpqP5F1D+OGzmtZTVWgvG/zFN3EZIT7nbXHygzVNQ7gUFEj
         YW+A==
X-Gm-Message-State: APjAAAWJGOWr4EwPJ1GjTBxp5hiD1KmWd9tehKGAS2mLe3ulK314iQkY
        GyYG5KbPQUjPj8Sw6aMh+Al0Lw==
X-Google-Smtp-Source: APXvYqxAKKJKCSOoYvTFWOYN0Pd0EkZ6PZlMBziAKqeMbSlyG/Vl+08iINrmRKiVaQZqzD8OK0ATzQ==
X-Received: by 2002:a1c:c542:: with SMTP id v63mr14628868wmf.97.1566120880901;
        Sun, 18 Aug 2019 02:34:40 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id w13sm25042828wre.44.2019.08.18.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 02:34:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/7] nvmem: mxs-ocotp: update MODULE_AUTHOR() email address
Date:   Sun, 18 Aug 2019 10:33:43 +0100
Message-Id: <20190818093345.29647-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
References: <20190818093345.29647-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <wahrenst@gmx.net>

The email address listed in MODULE_AUTHOR() will be disabled in the
near future. Replace it with my private one.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mxs-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index c34d9fecfb10..8e4898dec002 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -200,6 +200,6 @@ static struct platform_driver mxs_ocotp_driver = {
 };
 
 module_platform_driver(mxs_ocotp_driver);
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net");
 MODULE_DESCRIPTION("driver for OCOTP in i.MX23/i.MX28");
 MODULE_LICENSE("GPL v2");
-- 
2.21.0

