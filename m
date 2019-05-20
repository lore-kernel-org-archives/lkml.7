Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82047C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566F721019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lF2o1SjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfETUDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:03:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39411 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfETUDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:03:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so561344wmk.4;
        Mon, 20 May 2019 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBbcf5smXwn2ERqZmWxMF9pKx3odOzZfT39bu+z+NO0=;
        b=lF2o1SjAnq7Xp1obe3LurDFZKd5BN4khe9sRyPhqgRBSwXBdkoewCBHFf8zoEzEx3t
         waxWgk5yCdtpMkuIOw5iniH4lLAYZqDMMLGCnfXqfrHbgEYFj366Pmunus0UqhMLDz6N
         lUIiposDj1jZjf4bLcYTXv/O61vYSkhJM/7nHXruOZQ5Dc5G28mPA9h5j1CCdfX4yZx6
         Maym0sCKZgVswaiC2gxIrp4w3V2P/K8rwqIMIWm0NAme6TuS7h3Do3JSHUdLUxBnuB3E
         kwQTXI/91n85e85WkrN1yM/EC4WLajIH3hna/bJWB5kFlsm8P8Cn8lGaGXZLXEM7HE5J
         u4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBbcf5smXwn2ERqZmWxMF9pKx3odOzZfT39bu+z+NO0=;
        b=nhlWfTBkpxn1ZyoX7uYeXZxeup/yUKiiP+PTwknCeVXl19KvKirt0OKh82HW5Df3GK
         21zr10+rPHR0pmcUENEyDbWAo/Sy7ddv4WFkIWHn9hBfdJ31J+6s75UmKyypNGQeLyJL
         HlbdlIgRuL8Q+lBA5J2ykkBbdWtMBmqHDEdc3Ap+RAAKstDic3R3fabW6B3fKMocLz0L
         pYJns6zfhoH5rGrJxf/vhsAAXd3hisag7YfVrsuiT1mC3kcrw8eDUr4EY/3MT+tfEC++
         H37BMw6r7wapp9F/A5m9DzH+MfnYEJhFoXQhe5NnU0AXfARM3Qva/RkTZThMejNehETN
         OsPg==
X-Gm-Message-State: APjAAAUFnXTrcbMyc8qplXymAeilDsT+LL8G4zxUXYt4uC82E5c/N2oN
        pNfERt1zC1eqWDjxj8H7UwU=
X-Google-Smtp-Source: APXvYqzXRf4StT7i+KCej0246pfMyRIOamHfikr5+acfST7ileYaaYz3AnW9nN10il0xEYLcJxFksA==
X-Received: by 2002:a05:600c:23d2:: with SMTP id p18mr613218wmb.66.1558382609718;
        Mon, 20 May 2019 13:03:29 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id t7sm23583379wrq.76.2019.05.20.13.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:03:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/4] dt-bindings: clock: meson8b: add the audio clocks
Date:   Mon, 20 May 2019 22:03:16 +0200
Message-Id: <20190520200319.9265-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
References: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio controllers on Meson8, Meson8b and Meson8m2 use similar
(potentially the same) audio clocks as GXBB, GXL and GXM. Add the
CLKID_CTS_AMCLK, CLKID_CTS_MCLK_I958 and CLKID_CTS_I958 clock IDs so
they can be used for the audio controllers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 47556539f0ee..68862aaf977e 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -112,5 +112,8 @@
 #define CLKID_VDEC_HCODEC	199
 #define CLKID_VDEC_2		202
 #define CLKID_VDEC_HEVC		206
+#define CLKID_CTS_AMCLK		209
+#define CLKID_CTS_MCLK_I958	212
+#define CLKID_CTS_I958		213
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.21.0

