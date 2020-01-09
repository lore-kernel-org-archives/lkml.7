Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D5C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F020678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIWXTtGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgAIKkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:40:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35697 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgAIKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:40:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so6856539wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upaIV8pHTmu8DkqMf2ucWdaANgJGbhBCIIo9eq7N5vE=;
        b=uIWXTtGFPtepm38Gi+e+9VxpWTJGoQBY77KCIWMY/9kVH9p+F1wxQC39M4kUrFdkRF
         MiDTMrYPmJEKBBAxOl/wM98PSos9IdB4KwhoBC9EOTk+VLolT3f6WABl3qM/guiwm3QS
         wOTBbiZ9w3z3DLiSZG8QVQBUUQl3SnCFZk8Hh6u25Vv2aT75uM5oP4CAUW+vtAEPRNbR
         6iWhopQGK4J9x2bN9A3pC/LfdgF68Qmk0/OWaLWF7SvkwAPupb1VOXnV/1rImumlhUmJ
         wBCRfvPbI+A4VIntlnx7wXfMXTuj/rD79et/KxUCXAlSdcASoYJ/8X3JOp8ki5na4Jwe
         ELUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upaIV8pHTmu8DkqMf2ucWdaANgJGbhBCIIo9eq7N5vE=;
        b=j14XzpyxDxeyCMJqCXQlCRmS2CUvWnYOGFcNNLJ46myK4HKKYZXNABvUJbQWY83lDR
         vBdu+s8pgDUBH0VDP0B53o4rCOWhhNzQImp8uYNsHF2YYL1S65dgCUIGEoCLUzVSIcHF
         kOjuxVAA9kluKVnllRnKdscmAaCYY+9CTotWRIwX5Q17HGuZnRgYZEl29GU50dLhgWij
         QPqLXfi6BonfDRsZw3zv999jow3se9M5PkgkWQjYwQrOOO/J7VNqUZgEX2YurH4JermD
         Oima47uTCNvoBR6D00CyGmqcbxfGv7Rk7I0yeCDEbi6++oIkgQkh6pFj4boGpMPl048i
         +uew==
X-Gm-Message-State: APjAAAXR4+gsqCNrbSf3Zmr1irrXbJR+GJDklELusjJW/Mw1lKawDuTv
        CrqUYcKca386pxv97jYckp9ktw==
X-Google-Smtp-Source: APXvYqx70j5oWf1Jjvli8qCKa21+46Mee+BjkT3B98eov8DrLNdbn83ahlx9gVebcJy+lctiqUew+Q==
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr10023833wrn.347.1578566430578;
        Thu, 09 Jan 2020 02:40:30 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b10sm7858576wrt.90.2020.01.09.02.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:40:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] nvmem: imx: scu: correct the fuse word index
Date:   Thu,  9 Jan 2020 10:40:15 +0000
Message-Id: <20200109104017.6249-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
References: <20200109104017.6249-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8 fuse word row index represented as one 4-bytes word.
Exp:
- MAC0 address layout in fuse:
offset 708: MAC[3] MAC[2] MAC[1] MAC[0]
offset 709: XX     xx     MAC[5] MAC[4]

The original code takes row index * 4 as the offset, this
not exactly match i.MX8 fuse map documentation.

So update code the reflect the truth.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp-scu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 455675dd8efe..399e1eb8b4c1 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -138,8 +138,8 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 	void *p;
 	int i, ret;
 
-	index = offset >> 2;
-	num_bytes = round_up((offset % 4) + bytes, 4);
+	index = offset;
+	num_bytes = round_up(bytes, 4);
 	count = num_bytes >> 2;
 
 	if (count > (priv->data->nregs - index))
@@ -168,7 +168,7 @@ static int imx_scu_ocotp_read(void *context, unsigned int offset,
 		buf++;
 	}
 
-	memcpy(val, (u8 *)p + offset % 4, bytes);
+	memcpy(val, (u8 *)p, bytes);
 
 	mutex_unlock(&scu_ocotp_mutex);
 
@@ -188,10 +188,10 @@ static int imx_scu_ocotp_write(void *context, unsigned int offset,
 	int ret;
 
 	/* allow only writing one complete OTP word at a time */
-	if ((bytes != 4) || (offset % 4))
+	if (bytes != 4)
 		return -EINVAL;
 
-	index = offset >> 2;
+	index = offset;
 
 	if (in_hole(context, index))
 		return -EINVAL;
-- 
2.21.0

