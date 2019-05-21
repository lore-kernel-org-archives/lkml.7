Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF227C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D282171F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcPEysMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfEUC3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:29:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43253 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfEUC3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:29:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so8189816pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qMYs7A9DUfxjSa4/BdCbURvdQcnbXXndFxXlWbC2VcI=;
        b=tcPEysMj7VmRxPCDgaAzoSuELPARd6JUs8hsKo1MTtc3tStq78LVwpZjjR6+i+VSL7
         UDfztBuPyp/2KhEsKRPYyxdufxS+SVnHCsynpO9W467mc9k6P7EwnMMeJUi+0X3m28xE
         8U2iiBU9fEEIo86O+lZEp70vy75VI7Bo7qRXkd74mffOMmOeI267Em/Dr70zoKF+cu/x
         xWghgNYbxXoxHWCG+yqz1KoxYfRHE701e8iyz+zJNS9hxuWti+j6SkMTfRVaamEcC85f
         xiTM1+or4kRTorDa6fJpS+umMG8+hu7O4f73IK+T1gPeF7iWDLGkygWNqnPnd2b7oUt2
         Jjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qMYs7A9DUfxjSa4/BdCbURvdQcnbXXndFxXlWbC2VcI=;
        b=IW4TFV13NiXhBNoyV9/FPELC2kzyt4OqGlulzNmI5S9W9Xihfo2oH4cR6ThF25fOyE
         +nFN7Ba7+bJssEJD+JdwV2zsieSuKfcrgLyO6zsV3Fm2au6icYDcnpHpP9SWXN6jIJ3D
         qoM6lDJhYTxkzskXoBvd+ek17r+paEbOwSPZTiL5DLBr7FK+X3E+MyoTAmskvsk6vagD
         OBriYML1rGKqiPa1G4uF7XpZSzMFge+xQQNaur1A3zve97AEaRB5sl6L2GR5y8aBt7mc
         2PKp4op/OHjuzeYihoAkNE5IkHhaIE1/rgg5/rKsjukw9xnEOIE3kCtVPBDi/su4atjS
         /+mQ==
X-Gm-Message-State: APjAAAUu8IfDXoFOLLjkBGZnZ4dumxQ6Osx0ZkdgN9JQfd7nDTcMI210
        CuoIcfkD/kMvSTw8za2qdrmO/IM66tM=
X-Google-Smtp-Source: APXvYqymrtKrsg3mtRM/VFakwYMZToHY2vAWQF3HIz4pfGondzNo6FKtbZXeACe+5KeAQvP2rxGiag==
X-Received: by 2002:a62:5201:: with SMTP id g1mr10135981pfb.152.1558405791767;
        Mon, 20 May 2019 19:29:51 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 135sm34848161pfb.97.2019.05.20.19.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 19:29:51 -0700 (PDT)
Date:   Tue, 21 May 2019 10:29:40 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     nico@fluxnic.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190521022940.GA4858@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
include/uapi/linux/vt.h. So there is no need to unwind the loop.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fdd12f8..b756609 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3350,10 +3350,14 @@ static int __init con_init(void)
 
 	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
+		if (!vc_cons[currcons].d || !vc)
+			goto err_vc;
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
 		visual_init(vc, currcons, 1);
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
+		if (!vc->vc_screenbuf)
+			goto err_vc_screenbuf;
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
 			currcons || !vc->vc_sw->con_save_screen);
 	}
@@ -3375,6 +3379,14 @@ static int __init con_init(void)
 	register_console(&vt_console_driver);
 #endif
 	return 0;
+err_vc:
+	console_unlock();
+	return -ENOMEM;
+err_vc_screenbuf:
+	console_unlock();
+	kfree(vc);
+	vc_cons[currcons].d = NULL;
+	return -ENOMEM;
 }
 console_initcall(con_init);
 
 ---
