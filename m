Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dfnrzugz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbfEVMT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:19:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39367 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVMT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:19:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so1240593pfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 05:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jWsOvlcYOxIXtOpraIA5T9PctmV/EptPwztKFrzGvOo=;
        b=DfnrzugzDyXh/iZid72Iz9u1Xl4oN9sE8R33qPGtvV7cHxMsGly8x1uuU1r+HX8DOE
         Hz1H5LSs4X+g9e5wUixU1Zx0ijMoeFC8/SIyd3CNbZpgSvBMXUMKJiIHTSyYQ8Wh7csd
         iIk06QwmoYcdL92po2NOdoXm1iIhzQrEpmYf+FVB3kGYK95o3kysJm4OpW89GdnGqwS9
         InWVtpXJEjgpcsdiesL07B0rWyGcqZOUwE3Zmf7VvZOl0VCwRjMRvb90yRwVKw4D3fBV
         pDTXDEo1Q2YkCQOAFX4PQg1kwvAlCoTs+UTxFWEGtfSXZivYqmeAn6nXtdz2j8sw5BGL
         Oshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jWsOvlcYOxIXtOpraIA5T9PctmV/EptPwztKFrzGvOo=;
        b=JPuQbT+nQeQv8WPIfcTGqhLspRKDmIwkqEFet8YLWzKUmMlDdXdBHtcGelhBgz7x/i
         oTiEcZwNUfurPgc9XwBEatYTgEbLYVf1mJNrI0/LhOzaxcpEtV/O1X81Ru0vQDjX2rU2
         DXLMuseTtvo4G4lQv83jcblJmMgU94LSE/DCkQS0mup30WqlvTOpwp7gS0DngFYV+Bh2
         d0SGf1+XerBViTxRJ1CC3aNcbWScAStvcQEyay+ALBmvREDSLUTNyqlKmDmHWd9XJpLK
         nn3x1tlYpP973/WmYrH4J1f3rF+16jcOAOX+b/tt5jNlxr6KbmLc5En83EfDTC9PPdOA
         YZHw==
X-Gm-Message-State: APjAAAXGOalpRj8qXBvP32vWrWs1ZSezoypyYJwaI5QiZ3CCYbDfoqDC
        VK7J32bdYFFeQlD/QDEovlsSyiBn01LrXQ==
X-Google-Smtp-Source: APXvYqwonLSAd2IV+8TakOGUIIFG6Oy80HZ8j5eJXtQlVcRo3aet90lsvfguJUxGDd0LRUHDKtxOqQ==
X-Received: by 2002:a62:6341:: with SMTP id x62mr94524316pfb.63.1558527568070;
        Wed, 22 May 2019 05:19:28 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id v23sm31403926pff.185.2019.05.22.05.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:19:27 -0700 (PDT)
Date:   Wed, 22 May 2019 20:19:08 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190522121908.GA6772@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
 <20190521030905.GB5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
 <20190521040019.GD5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905210022050.1558@knanqh.ubzr>
 <20190521073901.GF5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905212218090.1558@knanqh.ubzr>
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
