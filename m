Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0EFC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15872082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhleFojP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfDMKeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50487 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfDMKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so14280463wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UJsUq0al+z8VSLuQXKgxXfbAFcihpCllFp+tuBhEIAY=;
        b=YhleFojPFmN1yVhcIxJH5BZR+m5nZRubo2UFIWJLWl/4dzRnEJl97nxCQ+gqcnVR6i
         nZzC9pXTWlNT/siUKt8K9wzE05x1KOGOm2qe80YsWAqyEnWtEtX5H4PmvBaNeX/JHnF4
         RiZTDhItCU7lj/r/I0N+/3VzlUfwGyULOBsMTCQJypyf6l3jnPbRocilIzDko74rOarr
         9CmR0jJAttou8w6BqvGAulDfUGQPTaBS51hDzSw2wWFEI/mRo0aOE61fsrWgylMeeX8U
         cKfMySpNr8aZQQ9bxZvjv7w1YIUMLz2jbkUPmvOVIcw6oXAiXkowfclW+FJd+nx+dGKS
         VgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJsUq0al+z8VSLuQXKgxXfbAFcihpCllFp+tuBhEIAY=;
        b=CsaGmqhm38EmHXwNKSqRQn/Wu5pCbumEufyRUuif/SEx6PXrDjyKXg07WkBMcMTX16
         Ek6s3AVYDIyv0J2M5yq5TMHqZqj0FgCWFpcxyuqvfzF5nGKLDZ+utJX+Cr8gSzbUocyr
         CsL8ZFHFfSvPEjw+zDmDqVl694ZtnV6fiDAweFiyvtxS68XANjn9kM26NjMf+eUbVGqd
         TvHae3TP05mLHb0fk9dXrLcTJC4wZHtXjYg4gFqjD1mTRBuqOw2ucefegCtHD7AZkz4B
         Svnz61JH9ZbReHxGj5Yx9Rvs7D33QOvcuCIBSOlxmf24G7MjA2HKvvwxo9i35OYXIWra
         CBjA==
X-Gm-Message-State: APjAAAWq0rXIkGROuxEa3PlH6eFoxsUvXRm/sha7U5AnB1Itnr3Rzq1s
        RKlwDQ90npfvruqyn9ZypVJIKg==
X-Google-Smtp-Source: APXvYqyb46+T+fM0i5ojxHVHFI+rp4dIIknmmpAKZfvDq7o6L/03zKbXoF20/407v+hE0NmJ6TPT8A==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr14602099wml.24.1555151600983;
        Sat, 13 Apr 2019 03:33:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 13/20] nvmem: core: fix read buffer in place
Date:   Sat, 13 Apr 2019 11:32:58 +0100
Message-Id: <20190413103305.9576-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

When the bit_offset in the cell is zero, the pointer to the msb will
not be properly initialized (ie, will still be pointing to the first
byte in the buffer).

This being the case, if there are bits to clear in the msb, those will
be left untouched while the mask will incorrectly clear bit positions
on the first byte.

This commit also makes sure that any byte unused in the cell is
cleared.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1d00f5671368..5abebf2128b8 100644
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
2.21.0

