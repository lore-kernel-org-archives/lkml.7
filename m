Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE65C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300F9206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c8tpYGFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbfCARi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:38:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfCARi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:38:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so13341294wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 09:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oq1NBNm7cacxaNq8LhHi5ab7jL27LRskn76/oRv86xo=;
        b=c8tpYGFJYKz4ZF6FXSQquU3Fm5435+e8eY+mx9p/62fxOei9RK280tntkwDFZOE85G
         NnDSmHoRQF2B7/5aBPDtQFPjOs0ahZ44U/751ED8ch94W4L5UawctNA9jhjr8Y+zarlM
         LPNSR6jbb5airKrvent2+aBuouKL/yIJBGUpYRWbUKgX6ToTPOPEnbPamFxbtfFGCb3q
         Gti9pttWYvqO24XS6Cg/T+GbYks4ibGZ9fgv6GFOLU9FIetERhkvOLigaWEs4WjCOIYU
         nvx0XK3V+NkBVgFWPyFoXyrWucPBEWsjh/rq2Iwt2lpWVLTOcpPuPThgMrs+8gU6L3WS
         CdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oq1NBNm7cacxaNq8LhHi5ab7jL27LRskn76/oRv86xo=;
        b=N/SpwDe2QwRvUHHg8guBr9X7j07qdWurndvJQxhr7qs5smgMFiaV5IiNY5L/7AKNg6
         h88ggLsi24Pvz7MY2j/27dKA8JZSoWbzLk/iNSi6Z7DjaQ7YdLR0He0EJjgR52TRANE9
         A1V0rRnbOc2Fh/IICEOCCVTaG6jH1jgZZeN4y6paclZHypnU5+9SX8f254CvDXxsXnu/
         p4bXag1PFfesDxLKh8fqUXdf4V7w4qCLrCfqtHWWvjrBTRYnxjVYzkFWLneCYbRGlsGv
         P5mwvXju14dSa79gg4TXa8DdbD/oyMpuS4aroo0wdJ3+M6Xv1OczRXC6OcAzAjVz0VRL
         t5ww==
X-Gm-Message-State: AHQUAuaO5e4H9D4f/Pm3cOxJ1hDlt1huNOWdeU3wKLnJLto6WeMXXsrg
        jNWly/d9n8RD891rAIGFkwY=
X-Google-Smtp-Source: AHgI3IYq1Ld3vaGWPBjr1KBASjs74zkk5b42jI/B51TIsHzBuf5ubjXGZ9z28w8cVMNofYavIqKxeQ==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr3863770wme.54.1551461935041;
        Fri, 01 Mar 2019 09:38:55 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD7109200428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d710:9200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id y5sm48577069wrd.97.2019.03.01.09.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:38:54 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        liang.yang@amlogic.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
Date:   Fri,  1 Mar 2019 18:38:19 +0100
Message-Id: <20190301173820.30776-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190301173820.30776-1-martin.blumenstingl@googlemail.com>
References: <20190301173820.30776-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc() can return NULL if memory could not be allocated. Check the
return value of the kzalloc() call in meson_nfc_read_buf() to make it
consistent with other memory allocations within the meson_nand driver.

Fixes: 8fae856c53500a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 3e8aa71407b5..a1d8506b61c7 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -528,6 +528,9 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	u8 *info;
 
 	info = kzalloc(PER_INFO_BYTE, GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
 	ret = meson_nfc_dma_buffer_setup(nand, buf, len, info,
 					 PER_INFO_BYTE, DMA_FROM_DEVICE);
 	if (ret)
-- 
2.21.0

