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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B474E217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slu70HmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfEXCOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:14:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41954 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387732AbfEXCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:14:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so3489437plt.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jmvJu0mVgTdzaX+eZTqpCianhRMHfBYRrsQSK2cXAeE=;
        b=Slu70HmP2ntiocmUfQbxEXahovLTdiaX0HqVwnXndLfws/OES+/wlv+Ygk2UcxYmnZ
         4p9TePnf+Zh5SS9i9tontIKGrmaGYYBze0r/6CdRAcmGToabR3u51S0BiCuFESajyQHv
         Uj2BavhPCbCcFwftPDK7OgVpQTq+QDIxTMo84u/LGBvR1xDvTIFWT0ENSb7tApt7X7gD
         PZBHqhOXeY1d+h/NyASHGod78rqbOxbqWwlawYHCLzizi4RLzN3ctQDKjsXu7CFyVs/r
         YEd06C3iOAtC7LICGXSYmCeOVS/hjO9zBG98nXdkl47FaffveUkdf2qAWWkrzFVpbsVZ
         YxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jmvJu0mVgTdzaX+eZTqpCianhRMHfBYRrsQSK2cXAeE=;
        b=p9dbnYh5Vd6mY1TPd5heqyG707FMoof3in0KkCMCwvoU+IfjZRHp6AL1kZqOmSi6tS
         kH2DwJmF0W6pZWACbQ7zYiUbaW9N4iqcjR+X4U47gsmKLa7GrFNQZTUJ+zTEhAR6J1ID
         oCjyf8h2lZxSdDcJlISng/A6Rw8FKOzBXxuJ8clmj1mdCkuaFCQQVw5K9dcU9gzAEd2n
         0fgsT+02NpnBbu0j9tulZH26oZGTQh6jYmGQdCRUXgQ9XJg9G2r/I+rxS/XW2FiBy4Ws
         D14TKsFi8c1GxR5ewodABzKArKLjXXE9PJbaOJAK5npb2giy9vpH2GTByvn2aBjHEsPH
         W6rw==
X-Gm-Message-State: APjAAAVeJd9XrbjvwwSedJi76+pJnCrCGnUcRpT7m2lb8AOijatfDLFM
        ELAvJc4KJg4q/RSR4/UzrYU=
X-Google-Smtp-Source: APXvYqyieNjT9sKJBCm5ZJWNl6/Y64Dd5T9hV8RUYnaHP0rOed9CTbrrpdRrlSOpn3qWJhGCv6hwMw==
X-Received: by 2002:a17:902:8c8f:: with SMTP id t15mr47169620plo.87.1558664093265;
        Thu, 23 May 2019 19:14:53 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q27sm777678pfg.49.2019.05.23.19.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:14:52 -0700 (PDT)
Date:   Fri, 24 May 2019 10:14:22 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <20190524021422.GB4753@zhanggen-UX430UQ>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
 <20190523003452.GB14060@zhanggen-UX430UQ>
 <201905230952.B47ADA17A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905230952.B47ADA17A@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:54:18AM -0700, Kees Cook wrote:
> On Thu, May 23, 2019 at 08:34:52AM +0800, Gen Zhang wrote:
> > In function con_insert_unipair(), when allocation for p2 and p1[n]
> > fails, ENOMEM is returned, but previously allocated p1 is not freed, 
> > remains as leaking memory. Thus we should free p1 as well when this
> > allocation fails.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> 
> As far as I can see this is correct, as it's just restoring the prior
> state before the p1 allocation.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
Thanks for your review, Kees!

Thanks
Gen
> > ---
> > diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
> > index b28aa0d..79fcc96 100644
> > --- a/drivers/tty/vt/consolemap.c
> > +++ b/drivers/tty/vt/consolemap.c
> > @@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
> >  	p2 = p1[n = (unicode >> 6) & 0x1f];
> >  	if (!p2) {
> >  		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
> > -		if (!p2) return -ENOMEM;
> > +		if (!p2) {
> > +			kfree(p1);
> > +			p->uni_pgdir[n] = NULL;
> > +			return -ENOMEM;
> > +		}
> >  		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
> >  	}
> >  
> > ---
> 
> -- 
> Kees Cook
