Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE86C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CF7208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZX4u5D7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408937AbfFLLD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:03:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54974 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406521AbfFLLD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:03:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so6105605wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRVsNIFezwN+iFmcBdbEviK/+CqAMtf2Qx3jn0k/cq4=;
        b=KZX4u5D7ed6FD65XeikM9bjph1fJHoblo5WeT7sGLQNEZjhJtFnUVUMGOdAcqBs1FH
         MnLgXdWolCNAQ8kgyPppetW/t0GsZ0icP+UnP3hEAOWPOncSEFktdLNIn5vS23Lwi33u
         zCs0Z2VVIYiTx+78GEYCFt4gAWn8LjJKgIohnTcWZwfMC6TKHC115kYybpvyGdImEU32
         XygnPlgNTVKgl1U+SBKuSan8sX3hfxfHaeRx9jeK8giAgR3yIyC//OjUozPyedh9yq5O
         xqRtajj6T6Qs3iC+KbdKo0wH2B3CD4mkPEGbiQU911mpFBQVFt1Ej4ydiGb09BOjTRpO
         vFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRVsNIFezwN+iFmcBdbEviK/+CqAMtf2Qx3jn0k/cq4=;
        b=K8YGBGMz/P/95Bag15y2sQkBnsaQA624su0PVMmDi3qcDyB6gsUry97oGjJEVkrp4+
         +QZYL63RxR8lU/L8mLNbDhGiny8krBMzPf1YQoUgGamykUHh7PGBW2s+znUjHzvDxKsE
         VnEd+Aunb9NhAWiRWouH72Oo27jQ3F0tuyrhBREO27LKURFM+r2L6rG5E90BjerJp0FC
         KvfOiRkwq5QB0rzqV3k2EiarzCAh0s+2FcB+fbMgP35HqsVOUtZHAMDcMgjeHIaMTv7r
         1Wwelwuuf7ss1gKUCYrwPlmtH88Sk7IIUkBvS2BJpxQWqpBGX44IighBaJv/Ksce6pGP
         B+bg==
X-Gm-Message-State: APjAAAUypAzhuCAtkr0WB+iCV8ioWxQFlmpAlc3d3FsT9MVlkrh9GqS2
        zUDYJ9LFy36RYCKigqzCLHxjcw==
X-Google-Smtp-Source: APXvYqwGuZyXGxSIIsvN6tyq2Ob0bFN8ZLKHfbbJBMQQ0juJvA6/N3k51H0lF3LKfaNOn0uwJ8zEmg==
X-Received: by 2002:a1c:c907:: with SMTP id f7mr22192836wmb.142.1560337435377;
        Wed, 12 Jun 2019 04:03:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h8sm5317940wmf.12.2019.06.12.04.03.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 04:03:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] regmap: fix bulk writes on paged registers
Date:   Wed, 12 Jun 2019 12:03:43 +0100
Message-Id: <20190612110343.4463-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On buses like SlimBus and SoundWire which does not support
gather_writes yet in regmap, A bulk write on paged register
would be silently ignored after programming page.
This is because local variable 'ret' value in regmap_raw_write_impl()
gets reset to 0 once page register is written successfully and the
code below checks for 'ret' value to be -ENOTSUPP before linearising
the write buffer to send to bus->write().

Fix this by resetting the 'ret' value to -ENOTSUPP in cases where
gather_writes() is not supported or single register write is
not possible.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index f1025452bb39..19f57ccfbe1d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1637,6 +1637,8 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
 					     val, val_len);
+	else
+		ret = -ENOTSUPP;
 
 	/* If that didn't work fall back on linearising by hand. */
 	if (ret == -ENOTSUPP) {
-- 
2.21.0

