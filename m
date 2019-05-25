Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DABC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41649217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 06:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsnbJVNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEYGE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 02:04:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40733 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEYGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 02:04:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so4996193plb.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MM6OOzM4T+V4zslooatuonhXlfRCNs+JVKlRCY2343A=;
        b=WsnbJVNyUx6si4w8yZ0Coji5M1mNT8dklbTY1i/pqVceKyQ0JePsbV/qSYPbBPVIxC
         bLSmCxtYp+tJmRKdL1lKgG1ltIrK+cT59yyGaR1u/F2UfFv32+ce7+PxsQFsxb37WrjQ
         RAeh9YCIJeyVVI9ssqly5jzmOd0n4s8EcdFlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MM6OOzM4T+V4zslooatuonhXlfRCNs+JVKlRCY2343A=;
        b=A/OaNYlbfe9SZd2Ra125Z88jWrLHJxUp9uaSUuESpzsME3fSEMwMEamL1REeatlu1j
         F+Kzdlhhzobttg0eUwSLdY3INpGvZv0AeegGWwtx1U+U5AzfFCWa/+u2Z+XgWvl9YY5d
         FA/a+rkmWcgWviAAXtyWv6Cl7Iuu+XJEA2UeQT2PKEFFIFrFUf/GbSN7SVQpGPbYH+pZ
         iNEsKjIi/uRPre6dIic3qD2T0oiDEWoLM7wgOeImo91XOZsUZkKWwje0TiR4LVskpAXK
         aNzrl0UHQepzkfYuPtxQMK5kMSjmL4a0w+ynieKztwNmH2yyo6vsYl93mF+H9SslPu9N
         MUjw==
X-Gm-Message-State: APjAAAV6Ajiiye4JJeoKr3+8FWrVaIix4smInGQno0QJsABJrGdsTZZn
        0czpZOXAfXJ2cezC4s+HlgW/U9LAqU4=
X-Google-Smtp-Source: APXvYqwICLfXnKeJ8xfZCs/kzlcTsSn3305CxzDQkAlhNZk+8mMauIsrtG1lTUmYKNco22sHdW5dqQ==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr6541998plb.231.1558764267844;
        Fri, 24 May 2019 23:04:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e184sm6631260pfa.169.2019.05.24.23.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 23:04:26 -0700 (PDT)
Date:   Fri, 24 May 2019 23:04:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Gen Zhang <blackgod016574@gmail.com>, jslaby@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <201905242302.139A912@keescook>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
 <20190523003452.GB14060@zhanggen-UX430UQ>
 <201905230952.B47ADA17A@keescook>
 <b99d0da6-a1d6-1c04-66ff-b2937d21d346@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99d0da6-a1d6-1c04-66ff-b2937d21d346@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:37:59AM +0100, Jon Hunter wrote:
> Kees,
> 
> On 23/05/2019 17:54, Kees Cook wrote:
> > On Thu, May 23, 2019 at 08:34:52AM +0800, Gen Zhang wrote:
> >> In function con_insert_unipair(), when allocation for p2 and p1[n]
> >> fails, ENOMEM is returned, but previously allocated p1 is not freed, 
> >> remains as leaking memory. Thus we should free p1 as well when this
> >> allocation fails.
> >>
> >> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > 
> > As far as I can see this is correct, as it's just restoring the prior
> > state before the p1 allocation.
> 
> Are you sure this is correct? It looks like p1 is only allocated if
> p->uni_pgdir[n = unicode >> 11] == NULL.

Thanks, yes, I looked more closely, and this is wrong. It's probably
fine to leave it as it was (since it appears to just be allocating
on demand). If we really want to restore the state on failure, we
also can't re-use "n", which is no longer valid. Here, I think,
would be a complete patch to check for allocation and use a separate
index for the other array:


diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index b28aa0d289f8..5f77cffc53b8 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -474,7 +474,8 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
 static int
 con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 {
-	int i, n;
+	int i, n, high;
+	bool p1_alloced = false;
 	u16 **p1, *p2;
 
 	p1 = p->uni_pgdir[n = unicode >> 11];
@@ -482,14 +483,22 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 		p1 = p->uni_pgdir[n] = kmalloc_array(32, sizeof(u16 *),
 						     GFP_KERNEL);
 		if (!p1) return -ENOMEM;
+		p1_alloced = true;
 		for (i = 0; i < 32; i++)
 			p1[i] = NULL;
 	}
 
-	p2 = p1[n = (unicode >> 6) & 0x1f];
+	p2 = p1[high = (unicode >> 6) & 0x1f];
 	if (!p2) {
-		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		p2 = p1[high] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
+		if (!p2) {
+			if (p1_alloced) {
+				kfree(p1);
+				p->uni_pgdir[n] = NULL;
+			}
+			return -ENOMEM;
+		}
+
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
 	}
 

But, frankly, probably the patch should just be removed...

-Kees

> 
> I only mention this because I have seen a few patches from Gen today
> regarding memory leaks and devm_kzalloc() that are not correct.
> 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> >> ---
> >> diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> >> index b28aa0d..79fcc96 100644
> >> --- a/drivers/tty/vt/consolemap.c
> >> +++ b/drivers/tty/vt/consolemap.c
> >> @@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
> >>  	p2 = p1[n = (unicode >> 6) & 0x1f];
> >>  	if (!p2) {
> >>  		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
> >> -		if (!p2) return -ENOMEM;
> >> +		if (!p2) {
> >> +			kfree(p1);
> >> +			p->uni_pgdir[n] = NULL;
> >> +			return -ENOMEM;
> >> +		}
> >>  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
> >>  	}
> >>  
> >> ---
> 
> Cheers
> Jon
> 
> -- 
> nvpublic

-- 
Kees Cook
