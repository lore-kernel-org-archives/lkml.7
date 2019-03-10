Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEB0C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA1A207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 21:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDdeQIEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCJVWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 17:22:21 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37833 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfCJVWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 17:22:21 -0400
Received: by mail-qk1-f195.google.com with SMTP id m9so1605657qkl.4;
        Sun, 10 Mar 2019 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cUtzmHatgmbK0VxfWjdt/J/yS8O6Lq2aryN//8xIso8=;
        b=dDdeQIEcncezyh31faPKZoXsucIYp7NqKxZTSk4q06cbqO3SitlNdmFRsE0PTC2Vux
         M3qFOdj1efeF+tqvR7SHFrvrPbxTKAMT61uwqrqgWmpZtfL7qKhuVVIPkyDMx2Vty+LQ
         rCNDKVRXRpTKqft7dSo7YqJ/Tvt6MWFS6VBEMuWAJoWiOro6J7EQTP3g18FxauJy5VHP
         sai53fOobewvRfqKu/EDgAWf+jB9kWS8NCYuWtPdCAA6vDI8rC9FQlrV0EIVoHCaSPQQ
         snMZbQg13jD/8iOMFmnPjOiVGyVdyXHwgkZ7Uop7Cz4fLIH3w5/nD+/wCjggk1jPRLny
         R3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cUtzmHatgmbK0VxfWjdt/J/yS8O6Lq2aryN//8xIso8=;
        b=gbEXrYQERLO41rKerAEjijYHevE5yEf2ObcCYzsV8F9HU6DlQA0inpKI1LAdIJQjWM
         s59uqewnuGShjIUjXz986/DRe5pZL47PkEb3MHI3+m1bSDTk0zkFOc+qLOLgKDMgBPns
         B/sv5lMbBhluJb2kUEBKuoozHstsXSd0cmwhDJH1A8Pjvky5vrSMtXnBSbAbv0/R/b03
         cRls2+bnXNT9Yf+POqAEzNyaoZCw8d0TvWcii1NBi0Uyyy1shIT7R8SN3A8L6mUXoTva
         1oDkZvZgpoiw3HLBENjUkTlt4fJdo+2WzDmJaRcGfwdZGos42z9SVY46tEhRC7Kglq9D
         hnDw==
X-Gm-Message-State: APjAAAVlevukYEwOnhoyw2UEzXkAqsJNGBnPfAc59I04AKoa/hOseOxw
        9M5jPVLu/+gM6HThTxVyBXXog/XUmKg=
X-Google-Smtp-Source: APXvYqw/HswJPsnJlzU2kcerzYgBm3RU62lGV5NIaNMHu/S0I56JN9aGzr4R/Vsf1evr3PRbzUYnlA==
X-Received: by 2002:a37:d88:: with SMTP id 130mr21888058qkn.314.1552252939974;
        Sun, 10 Mar 2019 14:22:19 -0700 (PDT)
Received: from localhost.localdomain (host241.190-138-96.telecom.net.ar. [190.138.96.241])
        by smtp.gmail.com with ESMTPSA id t55sm2602845qtt.57.2019.03.10.14.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Mar 2019 14:22:18 -0700 (PDT)
From:   Karen Palacio <karen.palacio.1994@gmail.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org,
        Michael.Hennerich@analog.com, lars@metafoo.de
Cc:     Karen Palacio <karen.palacio.1994@gmail.com>
Subject: [PATCH] staging: iio: adc: ad7192: Add spaces around minus operator
Date:   Sun, 10 Mar 2019 18:22:11 -0300
Message-Id: <1552252931-10592-1-git-send-email-karen.palacio.1994@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around minus operator to fix readibility.

Signed-off-by: Karen Palacio <karen.palacio.1994@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07..7c632cf 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     in_voltage - voltage_scale_available,
 			     0444, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
-- 
2.7.4

