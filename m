Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9D3C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5D2146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHEv75dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfELItw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:49:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38420 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfELItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:49:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id y2so61996pfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTz8ks950uiG7ImKsofD9QejdtCMFcMllki0BP6A19A=;
        b=bHEv75dl+OKs603PS82DK9Pm+GRFn3mrbC2f91/d7fdKN/cQz+lhUFmpTooptfYrIN
         Wvp+PfHa4hqHZZhi8PXNbE980IDlD/FUW1Eis+GsLKy8O8rr1gFAlvkww2RgaXayToyD
         KXjY4NGenyVzQm6GuS45drIkANbuPi1y+8Whedkr2kzgT3G/ne4l8soEkE1pG/LUY5M4
         sQuIXgO/mDJ/C/OJt6woVoU5eLMNXOj42RTzoym67yUOctMD9TexJxuOboAv7Xxb5RmY
         0pZnDH+0zeYQJyyTstaw3+LBYgzNUKgIYDqKHAyKB0gMb/w3gyA6v+JfILKr9FijcWR2
         IvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTz8ks950uiG7ImKsofD9QejdtCMFcMllki0BP6A19A=;
        b=qcW3eGctQ82G57T/dP+EOl0gv1AmZdT35tliWwZPQIiOWh9U4N6njGJ12D13pgZAFW
         8ljceQ284CNm8WpiIWG4tngpW9+YF6peJnx42KbnJx01KjYSPTf9OSOpHSFJSqi8O/eb
         25CGIihxCUgNbNCHcDNV+eozCJK7rux0GIVu3xFUszWSkT+eG9XgVqaFoVvQ4EbH3tR4
         UHRskJRwsQRwEhF1MhxQiNX0rxY9zEhR11VkQH0fM6hUl2se5d0Rt9PcBC6Uscmq1+I9
         8r5CVgO+X1WUVk35c2p/wC9Dpb7wcqtvy4LI64+y4bI+xr9rBrun35GuMITbU6jmGSyz
         7oNw==
X-Gm-Message-State: APjAAAXedwq2ZyVawtBIKupsMnnromhjsfmUv7gL4GkVTzAldxz5gHRU
        lQwZj8iH1qj3cCDZusDqmMj6ckeffSnjTw==
X-Google-Smtp-Source: APXvYqxIj6vqERyHfJXMm+0+nm7SXkrCsXh2HYpJ0i3OBy255KlbUVlug9kg/3FoIyvvCE5hgsFy6g==
X-Received: by 2002:a65:5244:: with SMTP id q4mr24064154pgp.79.1557650990938;
        Sun, 12 May 2019 01:49:50 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id v1sm16487204pgb.85.2019.05.12.01.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 01:49:50 -0700 (PDT)
Date:   Sun, 12 May 2019 16:49:39 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file
 of Linux 5.0.14
Message-ID: <20190512084916.GA4615@zhanggen-UX430UQ>
References: <CAAie0ar11_mPipN=d=mrgnVdEMO1Np0cCYdqcRfZrij_d-5zaQ@mail.gmail.com>
 <20190510051415.GA6073@kroah.com>
 <CAAie0ao_O0hcUOuUf67oog+dSswdQRpAtX8NyQvDAr_XQr=xQg@mail.gmail.com>
 <20190510151206.GA31186@kroah.com>
 <CAAie0arnSxFvkNE1KSxD1a19_PQy03Q4RSiLZo9t7C9LeKkA9w@mail.gmail.com>
 <20190511060741.GC18755@kroah.com>
 <20190512032719.GA16296@zhanggen-UX430UQ>
 <20190512062009.GA25153@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512062009.GA25153@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 08:20:09AM +0200, Greg KH wrote:
> Yes, that worked!  Now, can you resend it in a proper format that I can
> apply it in?  (with changelog text, signed-off-by, etc.) as described in
> Documentation/SubmittingPatches, I will be glad to review it after the
> 5.2-rc1 release happens.
> 
> thanks,
> 
> greg k-h
From: Gen Zhang <blackgod016574@gmail.com>
Date: Sun, 11 May 2019 15:31:30 +0000
Subject: [PATCH] vt: Fix a missing-check bug in drivers/tty/vt/vt.c file of Linux 5.0.14

Hi,
I found this missing-check bug in drivers/tty/vt/vt.c when I was examining the source code. 

In function con_init(), the pointer variable vc_cons[currcons].d, vc and vc->vc_screenbuf is allocated a memory space via kzalloc(). 
And they are used in the following codes. 

However, when there is a memory allocation error, kzalloc can  be failed. 
Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf) dereference may happen. 
And it will cause the kernel to crash. Therefore, we should check return value and handle an error.

And this patch works in 5.1.1.

Thank you!

Kind regards
Gen

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
--- drivers/tty/vt/vt.c
+++ drivers/tty/vt/vt.c
@@ -3349,10 +3349,14 @@ static int __init con_init(void)
 
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
@@ -3374,6 +3378,14 @@ static int __init con_init(void)
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
