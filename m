Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5A4C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 03:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF01D20850
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 03:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGxn4xIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfELD1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 23:27:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43920 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfELD1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 23:27:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so5296803pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pkGc+Ifj+PLRIa/aCIKyyn1GSi2IVhQXb1sDl5TqHvU=;
        b=TGxn4xInxvPhqLmJWKSmYSRsWj27O9CrVJ5CkhbvJHDfYLSR3rd6nIgNup79jY6cls
         6E4xpTj4oKciFch3EFo2Dn2ApKFKqk9vbZf26FXoF9maiQcVx9aMrnHDuwUwh70ENczc
         AMWbHOxr1I0Iuey0YBfYduohpWW/OTB/zF1SHURZkdsVn0EeZ2pA5DwujK02uKcKVLnO
         TBmZ/SQ7ouApy3gQZqo2tQPewzTBdkMs3TRdLX/WSiSDywUlzDPTaDjgUs8kwRktOhHl
         ziXwIJKaB07HH2PgEcS0zLddPSXNlB+oI8ndbNT/2nRw7j9OqTicA4klLXyFTTBkhbKR
         /DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pkGc+Ifj+PLRIa/aCIKyyn1GSi2IVhQXb1sDl5TqHvU=;
        b=UOYna1Ie1D2bANvjeF8AybHnA+poS2bsio87jGT5OeQEee+oqDWTYkrNQnovuWTg/h
         yoIEj8zG24ac5J1WcAzd3ZLlTvV/LZ3Ct/ypdxEcmgNGpMa9yUcCvpBKbftWJhIRjA8U
         pzuVqPT+wptSIlH3VeKfgTykBTzdTmUmzs8UMpuytYHLfe3T5rW6LxyjurImx0BbwCsw
         UIh/VamX2xRFqYNSu3limo+xxwaNyY7cd+OihABPQQGt8+yqZLzm1AKG1h6a3pi8wsFt
         p4EztRAWOqCYpy+gRxTE26sEm9uKpjcUeTGjLRX82j9qQA/mLv4mYWnfx4/+34xAPBv/
         gmFA==
X-Gm-Message-State: APjAAAW3XOdzgJT/j3CZpTuO7M/BxmRHG5tvMoCYUaBH+SZfXOpJ1oZ2
        x+GUb8MA4UeOnVEahLGX5UyKsk6ujAy1ZQ==
X-Google-Smtp-Source: APXvYqx/3WvOA/0mErwupIMLCdfxpzV7JoCuf/I4wZEcGshmtMnPPhDhUVy6y3PYlRhBqV2n7h/pZA==
X-Received: by 2002:aa7:90d3:: with SMTP id k19mr24928715pfk.1.1557631649568;
        Sat, 11 May 2019 20:27:29 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id g83sm9908061pfb.158.2019.05.11.20.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 20:27:29 -0700 (PDT)
Date:   Sun, 12 May 2019 11:27:19 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190512032719.GA16296@zhanggen-UX430UQ>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511060741.GC18755@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 08:07:41AM +0200, Greg KH wrote:
> Look at the patch above, all of the whitespace is damaged.  There is no
> way you took the raw email and then were able to apply that to the
> kernel tree.
> 
> You can not cut/paste patches into gmail, please read the kernel
> Documentation file all about email clients and how to get them to work
> properly to send patches.
Hi Greg,
I switched to mutt and get rid of cut/paste.
I patched it successffully with commit 1fb3b526df3bd7647e7854915ae6b22299408baf.
The patch file is:
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
I hope that the format is not broken any more.
As for whether the patch should be applied, it is totally your call.
Anyway, thanks for your patient reply!
Gen
