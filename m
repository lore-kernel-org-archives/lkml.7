Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D23C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08959207E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 07:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhGU9Ykr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfL1HPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 02:15:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34033 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1HPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 02:15:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so15515966pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 23:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=k0JHUMdPb9/y/l8kGYX9yC2dtDXKkQWi1TjqIT/Lnp0=;
        b=BhGU9YkrHRedEWGNE1jtchByCDGrUJj2m7LuQCZikr6o04SF9DjToxlfRG+Au9JtSG
         x72Gbcxsj/2F2EsMVdO1JfB2MArzqLfQuQMtmwBcPsIA8g1C1ca4hxK9fHTi7pVY3nFh
         9bJ2XjhXYUA/Y5L9LUg+rY3eKLV1brbvtFl/ZW+GWcbO4ql7xg+y8vnTTiq6rO64EA7j
         z5nwLrhbXB6PEdpflmq1tOIHuPgOH2pJdhahOUZTykheCXplOaLKYaGkiP7OQqWtnQs9
         lewh7UOv7ckdCNbRUtBuKCtoCT58bH5N7UTI0uBo9ldfCMkZOJ4rQasTR5jMD4lyPZk8
         YZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=k0JHUMdPb9/y/l8kGYX9yC2dtDXKkQWi1TjqIT/Lnp0=;
        b=R+EJypwcRYZoAQeDAMUB0J/m2kxK786VOCUAqME4EBk6G41l8TVu7Mbj0xBllZWgU/
         GvJVAERuJT5TgZxczsFf1+dEnLi4cxnPD+iaxW1wx3uJVTItfbKjyc/X6lxvYFuwtCaR
         I403IYKVMuZb5n5K6mgvmk74SrNqmcmrwaKFFYpjYf6cUvFA+uxoy4Aa7sL52Lq0yLzu
         l80QGBhQgXMSxpchM8RU7CWsZPrggE/8nVJk2WkHNkUvpkZz73+EAAAVa9ORIlJkBO6w
         B999pxYg9ssyOwg+Cm4M+HvnxLySaoNzvrheqa8Dkkls8gyXlbt2GZawFvyPxS/1RfTx
         GH+g==
X-Gm-Message-State: APjAAAWb6443WKS4tFwTIhbnUFX7N337yQAu6b3JajhMtwSdFYo03zLG
        nC3097Epk1EXDZJuQbftNymfPInF8VntiA==
X-Google-Smtp-Source: APXvYqzMHpvaL4Pbl8TdyvYnBORUSUHfbmJ/8+xWUcX8QH9K0QnIVfPcNyLN0fVh9HCROxKA/DijUQ==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr57811288pgk.399.1577517354874;
        Fri, 27 Dec 2019 23:15:54 -0800 (PST)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id b65sm40913411pgc.18.2019.12.27.23.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Dec 2019 23:15:54 -0800 (PST)
Date:   Sat, 28 Dec 2019 12:45:48 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Thorsten Scherer <t.scherer@eckelmann.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] siox: Use the correct style for SPDX License Identifier
Message-ID: <20191228071544.GA5214@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to Ecklemann SIOX driver.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/siox/siox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/siox/siox.h b/drivers/siox/siox.h
index c674bf6fb119..f08b43b713c5 100644
--- a/drivers/siox/siox.h
+++ b/drivers/siox/siox.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015-2017 Pengutronix, Uwe Kleine-König <kernel@pengutronix.de>
  */
-- 
2.17.1

