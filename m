Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08114C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B845F2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oQsq/To7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfG0TUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:20:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50229 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0TUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:20:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so50568756wml.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4n2rUT6ZGdvoy/BsktvZgyBHxTE8rabTOOnA69x0k8=;
        b=oQsq/To7J5ogzOa0TSjkybKTMPS3rtaiNVWREDB3u4pj4MaZ7uneyrh5zmved/Gntk
         gLlWhpYQ8qveg6e+khO+Q8L0L8buTannUuOs0zyD/dNw8891kufDYrJMD1SH4Ca/6EkO
         9bkTW8xa2yrodLmVWGiJMQH6V7EBjWTzPu0SoeSnFXzH9+C2VbfXumyVgSgEzXBTU+ME
         FfqTxYedHGWQRdA+aPa8Xfh6cdzseXvGgksOCz9d2mBKvb6d43wjCW5MfqQT4LjfsblU
         RhY8+CLcDC6+/mhIU0KI+m0SXawZdENqWoy/ofH/7/4QdWLmUOhI1/9gdoIg06vsJw6Y
         Jxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h4n2rUT6ZGdvoy/BsktvZgyBHxTE8rabTOOnA69x0k8=;
        b=tNlu3tTF1jZNVqwV7VTJEtAIsNa/B7k/6ynk4Z1h7HH+STzJsVKYj3x+LepXCLYlNG
         vrFR8EBx3uLq2YGDdqRaa7C5naUPct9HhVT44sAguB7ZDY/JXSrFa/2SZ2LFHDIxsT7+
         1740k5IB0mxZFBCXiT4pCOabmtZrD+pxosFh+OXaJ6N29S1T4Oo/r9rVE1AWWh1hTwzU
         NzQK7Zx9vSgJDQWy+/X7kB4qdswdxQb5iIcOEiCKbgJw/1fGz9ff6vCpBkhnFF53a3Th
         1wn6y36vRVPvfHch6+oideiwMeb0+nC/5N5cNjzkxhMbZONjnNlpfTKDsetTKYJ+67NZ
         u6LQ==
X-Gm-Message-State: APjAAAXPY9NtDIWjlFIa3HfNpIEn4oPw2HpqL8gpbZk3xUKpttF5uqwN
        GzG+Cassl9q3grGt0V67Kb8=
X-Google-Smtp-Source: APXvYqzg0efJoczgVWfrxUdgaiXSFNAa16hmUCsmIbTjaatCammoQ2y4fvocHoaMMKYHdCOH+tfyjA==
X-Received: by 2002:a7b:cf0b:: with SMTP id l11mr95920292wmg.143.1564255209778;
        Sat, 27 Jul 2019 12:20:09 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C65C00B418D0F4A25A19EC.dip0.t-ipconnect.de. [2003:f1:33c6:5c00:b418:d0f4:a25a:19ec])
        by smtp.googlemail.com with ESMTPSA id e7sm51506988wmd.0.2019.07.27.12.20.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:20:09 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] nvmem: meson-mx-efuse: allow reading data smaller than word_size
Date:   Sat, 27 Jul 2019 21:19:58 +0200
Message-Id: <20190727191958.27240-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Amlogic boards store the Ethernet MAC address inside the eFuse. The
Ethernet MAC address uses 6 bytes. The existing logic in
meson_mx_efuse_read() would write beyond the end of the data buffer when
trying to read data with a size that is not aligned to word_size (4
bytes on Meson8, Meson8b and Meson8m2).

Calculate the remaining data to copy inside meson_mx_efuse_read() so
reading 6 bytes doesn't write beyond the end of the data buffer.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/nvmem/meson-mx-efuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 2976aef87c82..d5ccde1abd8e 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -155,7 +155,7 @@ static int meson_mx_efuse_read(void *context, unsigned int offset,
 		if (err)
 			break;
 
-		memcpy(buf + i, &tmp, efuse->config.word_size);
+		memcpy(buf + i, &tmp, min(bytes - i, efuse->config.word_size));
 	}
 
 	meson_mx_efuse_mask_bits(efuse, MESON_MX_EFUSE_CNTL1,
-- 
2.22.0

