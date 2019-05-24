Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C67C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E650217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPhzGHIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbfEXC2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:28:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEXC2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:28:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so2148109pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3cpZrS1gQYWA804XDvn99we6TYNemMw9nD17Rft+xGU=;
        b=aPhzGHIavDeQPOiPuA74tRP5GhRo9/O+P6OtPK2EnC2Qyc7iRFzCGz0y71oUjDVW7v
         ESw/sLodd8OA/sQzQOgDfWFyvHdtNhz08u2+Seg4IXI0yjhjID3KoGaAKC6VvO/P4G1j
         gZU+K62a/h/qE6vaPTpGNMr2sXi4HEyGdtCpOBhWMQprL0ltZWYqAi0usZ63EduLYjZp
         /RsNyzf3Ah3jR351dqPoVeOyHlUZEbXdgHqOaXzcoaaZSDhLWLsI0xgZGRxDuO+KnFYk
         lcnaKqpyHExmecXmFzXRgscIu92Fob0nHmY7t3dRfUm9yumqa8jcc8ncrhxyb2tqF487
         NIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3cpZrS1gQYWA804XDvn99we6TYNemMw9nD17Rft+xGU=;
        b=bgqzAd4wuU/izg7tniGCaz5HFfTmyn7P5Agsc4KxVCI6W1nEPae/jktz15/mqSSLia
         U10KbuJlT2uqsur+T2Vx3t+0cP0NmyKSVQQeo/l4d+FGWcjF7CCtX/P/uv0tHKwGPcZa
         C5rpL3b8jebOGZdJMsx9gYmRzi9XMKFTBkPqRLqab2RIWxMRBz0y8Ck1XO+OBoF5byYc
         UMSH4QwHF22x0TI9CNdUsKxOeV5A4s8LTDqhJRm2AGvxIeHwuftTmXi78rQrOK7j2FWX
         tNV/N7lgfcogbmUq9xcpAadHhFMZHsQKKKJoHCYhNYoBIZnaCQOV0i+GBnLcx4JQWmkO
         QoOw==
X-Gm-Message-State: APjAAAVpc6hJSRxU8kRjSMsk1yAlXfzUgv5uNDwVeaBbRoYXhF6QPrdG
        54i4u4zpnVO4H+bsr2bWSacxXxsm1jQ=
X-Google-Smtp-Source: APXvYqxt0tVsoY1tue9ufRkb0Yac3ZlkiBxgcmyG5zIXMoxbVGFmvO/imQHIDHAv4zGTAA2DxN2quQ==
X-Received: by 2002:a62:87c6:: with SMTP id i189mr110854542pfe.65.1558664882724;
        Thu, 23 May 2019 19:28:02 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id k9sm777238pfa.180.2019.05.23.19.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:28:02 -0700 (PDT)
Date:   Fri, 24 May 2019 10:27:52 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     jslaby@suse.com
Cc:     mpatocka@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] vt: Fix a missing-check bug in con_init()
Message-ID: <20190524022752.GB4866@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
 <20190521030905.GB5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
 <20190521040019.GD5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr>
 <20190521073901.GF5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr>
 <20190522121908.GA6772@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905221018170.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905221018170.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function con_init(), the pointer variable vc_cons[currcons].d, vc and
vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
used in the following codes.
However, when there is a memory allocation error, kzalloc() can fail.
Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
dereference may happen. And it will cause the kernel to crash. Therefore,
we should check return value and handle the error.
Further, since the allcoation is in a loop, we should free all the 
allocated memory in a loop.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
---
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fdd12f8..d50f68f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3350,10 +3350,14 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (!vc)
+			goto fail1;
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (!vc->vc_screenbuf)
+			goto fail2;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
@@ -3375,6 +3379,16 @@ static int __init con_init(void)
 	register_console(&vt_console_driver);
 #endif
 	return 0;
+fail1:
+	while (currcons > 0) {
+		currcons--;
+		kfree(vc_cons[currcons].d->vc_screenbuf);
+fail2:
+		kfree(vc_cons[currcons].d);
+		vc_cons[currcons].d = NULL;
+	}
+	console_unlock();
+	return -ENOMEM;
 }
 console_initcall(con_init);
 
---
