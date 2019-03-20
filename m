Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77BCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF5921873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uu9oRmEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCTTct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:32:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37906 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:32:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so4106791wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynaleAgMhlwaGg4TQUwydIHUo2lHIkdidB1ei/USpcw=;
        b=Uu9oRmEl+z3eLQb2JZs2y4Me2w0xCyq4aXMzqfXCoBr+W6QG8W6m8kCZlfgYo/UpcL
         f0lt6ZQwcmrnVP7fV3OEVvtCupy5Mzqupyn04+hc+sN5jstNqveyj8z4xA+ZGXw/yLDs
         mM5Pw7dbJGbGY62mK1wUClAIrgybSc9vT0DUULfgaV5TzOKmQJcPAhD1uqhj9M52zPI2
         i5mBGVCom+oeKR7S2RBPQ2OGgqkeB+6DnPPCehc2k3Tb9hRVhMvsojgfkeFdvEZQ+DYx
         d2YUGmKsaXzHvHHdb0SZcgK/1lfTJmZMLsdgo13wl6JqtqXkYCWAx6G161Wv2Tplw5O0
         bkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynaleAgMhlwaGg4TQUwydIHUo2lHIkdidB1ei/USpcw=;
        b=EsRjyHajCtf1dk9Tym4Da3GQbcPJBZ3sHpoLAEAONAZ2AXy9MHVDIwH0jNzGqaUFcn
         9fmsfKrjtFKPSnKoXPi+ufW6ReosyMxCUM4NU0RdoNMxexVXZMeAzCg0o6rx/+/783K5
         SeVeZwlOuVjAryHR5RBg66TuzX/t9KQDHUG22LKY02OXq1pjQWlH7USDCoIDxTYLUVYp
         eXzIl1mGTz9z76jQRPPoC4iq8VFBxP9pCOYBI3N25cgk1ttBufTe9abmg2bUHJ5/EWXW
         MDEzQpYmfsSeJ9NG+HP5EDrYKHo9a2R30TqKKkPz2ieH2S/SPd/V8aN9KgeqR1XQmr7h
         xh0g==
X-Gm-Message-State: APjAAAWAI2d9XTKxB2tdpQKFVT6kUAquUWNac4lthbHFiIPFK7YdP8iZ
        j1xRv8VjxTfb1LqlFGFhRMv95AEnK3g=
X-Google-Smtp-Source: APXvYqywERzuXiitJUvbI0/vu/y4MRvRlegXLFk7Drdd1Lqi5BJSuyWg+tFtkVcTkzWeKEG97L7rfA==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr12336222wru.150.1553110366758;
        Wed, 20 Mar 2019 12:32:46 -0700 (PDT)
Received: from localhost.localdomain (52.red-95-121-90.dynamicip.rima-tde.net. [95.121.90.52])
        by smtp.gmail.com with ESMTPSA id b10sm3429889wru.92.2019.03.20.12.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 12:32:45 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Subject: [PATCH] nvmem: core: fix read buffer in place
Date:   Wed, 20 Mar 2019 20:32:42 +0100
Message-Id: <20190320193242.20159-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the bit_offset in the cell is zero, the pointer to the msb will
not be properly initialized (ie, will still be pointing to the first
byte in the buffer).

This being the case, if there are bits to clear in the msb, those will
be left untouched while the mask will incorrectly clear bit positions
on the first byte.

This commit also makes sure that any byte unused in the cell is
cleared.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/nvmem/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b66826..53dc37574b5d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1166,7 +1166,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_put);
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 {
 	u8 *p, *b;
-	int i, bit_offset = cell->bit_offset;
+	int i, extra, bit_offset = cell->bit_offset;
 
 	p = b = buf;
 	if (bit_offset) {
@@ -1181,11 +1181,16 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 			p = b;
 			*b++ >>= bit_offset;
 		}
-
-		/* result fits in less bytes */
-		if (cell->bytes != DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE))
-			*p-- = 0;
+	} else {
+		/* point to the msb */
+		p += cell->bytes - 1;
 	}
+
+	/* result fits in less bytes */
+	extra = cell->bytes - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
+	while (--extra >= 0)
+		*p-- = 0;
+
 	/* clear msb bits if any leftover in the last byte */
 	*p &= GENMASK((cell->nbits%BITS_PER_BYTE) - 1, 0);
 }
-- 
2.20.1

