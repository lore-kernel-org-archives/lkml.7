Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F50EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6DC2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9o7/ZJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDZS3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:29:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38451 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDZS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:29:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so1954794plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Po5XlMh612vQY+hAAVgWL8z1Q/ZRLIQZKOB8nnLpNO4=;
        b=A9o7/ZJnUVu0Kr67T8FLR2WHHDQFgX9lO5U5wypjbf1gw+SI6F6Dykn7QHGbvSK/Et
         x/I6Up4l2gxSmfqI3Eh3YuZg1/dJ8Xwke8Y6qjsQLHG8DPrg9m6bjua1pgENtlK/jutU
         w3umiGfbbgK7XwckvCwx752+zCA7L/XnLWXrk0bJPL/kfgs1fhQRF2hcSpEAEJyX1U8M
         8nPwBne3BbYu+LsPUYux3y1zWEAzM9LS38jfkUN1RiLDnujNtLMjBuURiB/e1mvd3Dpx
         lUltduRFmXFILc0OIpJ3XJtQe22K0uqhKT1UpCK8Kh7U65hoyWMolIYrONmbu1jrC8rh
         8v3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Po5XlMh612vQY+hAAVgWL8z1Q/ZRLIQZKOB8nnLpNO4=;
        b=DR2AOItlMSqVFtJhnXXGpr4see2oybvnN1n31MKyixkDdpgZ2OorAXfSfBTQrUUzP3
         dIqO2+P5KMJN/JYwbu09DQjWgmTpNHNyazrUFddivhR2MFCx6BPisJVTNFDADLSnR2Wi
         vGLyWFd2+oi5oTmbWkQvV23fpUbMkMGyYhlq31r7Y1H2sQ0l4LzEoxvfpkdu/0ohJMTJ
         nZfmD/ds6C5uSfJJvQ0itWClnewdg/l2wZlijpshOEbcDbDGJhz+6OJDjdhaD9vg8hMx
         Q1S9iueCfpOZSJTbo1k6uA7X+yE/WPJRDFiDXwuMrife7f22xO97BV1ZqH/WdZJsNmhT
         YaoA==
X-Gm-Message-State: APjAAAU9b1CdFHhiXbl0rbe43xIZJ/DGMJM6cBbEXX3arfNOlvMKX/b2
        EWOCv092QsEe01dIWoNi18g=
X-Google-Smtp-Source: APXvYqzyRvBsk4iYcQ5qgxW4eNVHOcvU4mOiYt1TulCd9zpoXZgHlzW1UJq2IKRydBsxpEGOrUaVvw==
X-Received: by 2002:a17:902:1681:: with SMTP id h1mr13647244plh.102.1556303393852;
        Fri, 26 Apr 2019 11:29:53 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id u20sm36133819pfh.112.2019.04.26.11.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 11:29:53 -0700 (PDT)
Date:   Fri, 26 Apr 2019 23:59:48 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     tytso@mit.edu, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/random.c: Make add_hwgenerator_randomness static
Message-ID: <20190426182948.GA10020@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make add_hwgenerator_randomness static as it is only declared on
drivers/char/random.c

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38c6d1a..08fd00a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2342,7 +2342,7 @@ randomize_page(unsigned long start, unsigned long range)
  * Those devices may produce endless random bits and will be throttled
  * when our pool is full.
  */
-void add_hwgenerator_randomness(const char *buffer, size_t count,
+static void add_hwgenerator_randomness(const char *buffer, size_t count,
 				size_t entropy)
 {
 	struct entropy_store *poolp = &input_pool;
-- 
2.7.4

