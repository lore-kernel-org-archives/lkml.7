Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5664C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7BA2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4/aeTC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfHFOXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:23:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38298 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfHFOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:23:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so41611736pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0jQ/8nGJMXromLehaOONOEQKf1V5jEAdr8wiHPYFmI=;
        b=L4/aeTC76EnrR1jeqk2zB5wAqNkmO3vt/x7MV6JSWzJJgFY+f4RRGujclJri7Oeoyh
         h02gAiDHzNUdeftYVML93N/RNIlon2hJnXUW+J6fNqQ6S0Sz3Q2uCT+vdC76slsosu/y
         feAoVCMaBrr4buuYh73zv23JIxQ+61bqueNXFxgIqsqXOqn/C6oa0edf2mYGtkFRekyA
         JJXKYgqzAw0pRoE4qUDL+POSQVCOIOIf2Wg6pZoFACYF8mYC+/UU9g5zQFsCYeyAyPtc
         5x7XTJvIMZJfKkd8MZmWhaTrp7jv1LNhAG371B4Toyqy++pA6JrX9Uf+93cPqhbBr8gw
         1Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0jQ/8nGJMXromLehaOONOEQKf1V5jEAdr8wiHPYFmI=;
        b=CqvGeMzuECGloadfwO4u3eEShABiUBfRMsESzH3U4l1sIiPy6yTE+zsF5k3C6JQvWS
         IXoJrGSRwlBnrsj4Diii2ipeQCdhTB25HhQh/mqJUIDgZbmy8jUuUO8X1HJnJlCaq2Yc
         EbX5CHMrEp/kQQ/QRVl3yejLgeXX3FnWekf3E/llWilWhSWoTTZikE1oXBMbpX+n4cp9
         PBoCOpgJayx++NxIzEwH4n0MB//uu+mcWIJIF4rSkNNO/5sT9yPzT41VXMHMmbNoHUtU
         ZBiTG4OzoXZSYJqkW3JuGvTqeDe5wxos/m7P9jazCAhUCl9bKHA0YobqsKXRkGv6pgWY
         Y/LQ==
X-Gm-Message-State: APjAAAVR9X5Xkm+3lrAVMqiMtyAKie8UfvEBL+Rg44Vf8necUALiuqtq
        bkzZRbHs1zL8lf6aSDWFTRo=
X-Google-Smtp-Source: APXvYqxsesLKr8U1Szp8TYgMag5jtzCCHmH9LeEfxYAEuQ3oJKYIiRvFuzPL8DPZK4eHeo4gBIhQ+Q==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr3215699pgf.249.1565101416318;
        Tue, 06 Aug 2019 07:23:36 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id a3sm90682312pfo.49.2019.08.06.07.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 07:23:35 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id CB4942011CA; Tue,  6 Aug 2019 23:23:32 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        rdunlap@infradead.org, akpm@linux-foundation.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] auxdisplay: Fix a typo in cfag12864b-example.c
Date:   Tue,  6 Aug 2019 23:23:28 +0900
Message-Id: <20190806142328.5847-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in cfag12864b-example.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 samples/auxdisplay/cfag12864b-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/auxdisplay/cfag12864b-example.c b/samples/auxdisplay/cfag12864b-example.c
index 85571e90191f..bfeab44f81d0 100644
--- a/samples/auxdisplay/cfag12864b-example.c
+++ b/samples/auxdisplay/cfag12864b-example.c
@@ -245,7 +245,7 @@ int main(int argc, char *argv[])
 
 	if (argc != 2) {
 		printf(
-			"Sintax:  %s fbdev\n"
+			"Syntax:  %s fbdev\n"
 			"Usually: /dev/fb0, /dev/fb1...\n", argv[0]);
 		return -1;
 	}
-- 
2.23.0.rc1

