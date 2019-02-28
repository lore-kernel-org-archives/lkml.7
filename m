Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C792171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOSerX4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfB1OWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:22:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfB1OWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:22:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so22137098wrg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9N+9t9ja6hje8oSOcYPUEt2SpVLCg1jRZ/xYyjM4aPM=;
        b=xOSerX4nxxIpRfSA3tFlpKtgLbMPzeVH7ivxnF8DPpPKVIv26aB78jRlZO8t83RJIW
         iL+iualMYmx3Hqs9UcdpAyu1r0gVBFKU3R9uEX0z86XLqH2Evg3gjOPWXqZX/gFdg851
         3jCmQRbRrbtZEj5hfoEvLAliRl0o/QIO4VXPOmvi/zGvofwxrRAEp1JpvfQgET2dxHZT
         IDxacSPEGZPUMtenKXl4D7gJmAZaJWYfe8HJrI/WsKUsehPZskiK5AXa/xqiOOrg/KnY
         8KtKaS0IwUeqAglp/lfPGnc+Hb3rKSUdkqXcF5d30fvK41Qsb+3l2QGG6MNxPT4EoZVq
         MD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9N+9t9ja6hje8oSOcYPUEt2SpVLCg1jRZ/xYyjM4aPM=;
        b=OZv0SfV5XS/I57XU2fIiXGQijVXRWP6i+maBcakSdLIhHwCtSs8qx9xprrzxMJd3H+
         /ZV/MhwKRjggg58nk//RnR6P6xqikzeDUL/eGBVzGndNrn6xDTikQHJFSzDOJBoy+qvk
         3gw/vNRo0oHcX4l2E+zM1RHeBdn4oiaMQb8vuJPRKq+Pquuz2kzhvScy6UJobbsXQyPw
         TU8NANwtYttxmeOkOuPhF34UUY7TAi/SJuTHLYTxqv1JaS8oPtyBOryhPJfw7ySg1nTJ
         Ba/myIxOHhptHp1fuT12PXNBa28O7mEnxIfeqqSb4Rqs1GAEOn5MZ902bRHrc4bQfc1P
         4Y5A==
X-Gm-Message-State: APjAAAWUIClEL3MJfNdoG9LZuIA6xqaOmIxJ2RDHuwzTekF8Qcvzcgxn
        SrNv/NABhNyih2iFz6YV0CuGlfzJU1E=
X-Google-Smtp-Source: APXvYqzToHs7qN9JgsN2jS6aohmcYhWT2Ib2fPUtSXl0T9UDsPxOywuy3sbRuqjcDMiWQN2xfmOuKQ==
X-Received: by 2002:a05:6000:10c9:: with SMTP id b9mr6433914wrx.281.1551363728555;
        Thu, 28 Feb 2019 06:22:08 -0800 (PST)
Received: from localhost.localdomain (45.red-83-34-201.dynamicip.rima-tde.net. [83.34.201.45])
        by smtp.gmail.com with ESMTPSA id d15sm38783652wrw.36.2019.02.28.06.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Feb 2019 06:22:07 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: core: fix read_buffer in place
Date:   Thu, 28 Feb 2019 15:22:04 +0100
Message-Id: <20190228142204.9873-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All unused/extra bytes in the cell buffer must be zeroed.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/nvmem/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f7301bb4ef3b..65e198adebac 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1162,7 +1162,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_put);
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 {
 	u8 *p, *b;
-	int i, bit_offset = cell->bit_offset;
+	int i, extra, bit_offset = cell->bit_offset;
 
 	p = b = buf;
 	if (bit_offset) {
@@ -1179,7 +1179,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell *cell, void *buf)
 		}
 
 		/* result fits in less bytes */
-		if (cell->bytes != DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE))
+		extra = cell->bytes - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
+		while (--extra >= 0)
 			*p-- = 0;
 	}
 	/* clear msb bits if any leftover in the last byte */
-- 
2.20.1

