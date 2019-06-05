Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA1C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F365220866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAfvdFSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfFEQLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:11:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53655 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfFEQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:11:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so2841222wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GB15BWhJAhFYS24v4xU4U4zTm67QHH55ytl2QpsKhh8=;
        b=HAfvdFSpd0tyKLZQCP4QW9gkFu0g7irFnuGdsk7Qc8Dk1Oshi3m4zSYZZGne/7vJs1
         lZhGYvtgIhtb/S14QRmxwVO+YWlOd0fwK9QZQVURWjg2egEPdiy0kKsI2/YMvQfBTiSL
         Nk4AxRpMYHsgtH9Qa2eSAtQUWaEr8+//CIIuNqcKwHc3H4giS+t6pM7kIoWgBSarhCuj
         msiHbVqe8vtGPFnH9g2tm9hPwTWnJzzg+HwNVuk8Lh1n47rtJAxLkoqtrObq6lcGrSbY
         tAmxER90lS79+udB8CSGDuTEpDx5RbtjAbXq7HNU+0BRWwiY6Xar2jhkEAbWvdgOttOe
         9AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GB15BWhJAhFYS24v4xU4U4zTm67QHH55ytl2QpsKhh8=;
        b=Z7+qMtw5EGeX+LVQwPc+mH6z9NasvhGlQjL+06QQBaAkIVBct84qLYvqAFjWmAu+ul
         NezU/2umZmTR9NC/c1WN/pEQpH+YOSzZyxEkKTNXHkB3YgP0IU0UuKaD0JVIm6qQ8DBX
         DG6uL3Vu1Ph627XurgKHIh26p/nx0vfsQ6majACCLPu9iduQG0DlIuXqjG84qfURRkft
         ziyuVj2V8ZqLRKVnlvAAeziJ1PnAq7Qg2MMXxbl8JtR6G/drUfYC5kZedUcpLXY2cfc7
         tsXBGZxlyElo73EzzrSiHxFYVm4y8UamohYzEupJLnA3nCfPO2hi2RDjyVyHEyolloqD
         ZfGw==
X-Gm-Message-State: APjAAAW1J3izoIzaQ6tiI6bDrrkIM/7N8cD7VVHmEmzgb39Ton2bWpPD
        lNaskdk0OStwI2yOCPsltpOijNo9
X-Google-Smtp-Source: APXvYqwmhOx5FLK6YA+i722pB9GKjTKZK5xF4FIxP4bwXK8N1PVIE/7e7Kqt/OB2Pvc5JECFJMJ+rw==
X-Received: by 2002:a1c:bbc1:: with SMTP id l184mr9550224wmf.111.1559751111398;
        Wed, 05 Jun 2019 09:11:51 -0700 (PDT)
Received: from zhanggen-UX430UQ ([108.61.173.19])
        by smtp.gmail.com with ESMTPSA id r131sm10240068wmf.4.2019.06.05.09.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 09:11:50 -0700 (PDT)
Date:   Thu, 6 Jun 2019 00:11:41 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     inaky.perez-gonzalez@intel.com, linux-wimax@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wimax: debug: fix a missing-check bug in d_parse_params()
Message-ID: <20190605161141.GA4538@zhanggen-UX430UQ>
References: <20190530093937.GA4457@zhanggen-UX430UQ>
 <3f496fad-cfc8-2d13-327f-075011e542fc@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f496fad-cfc8-2d13-327f-075011e542fc@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 08:33:31AM +0200, Jiri Slaby wrote:
> On 30. 05. 19, 11:39, Gen Zhang wrote:
> > In d_parse_params(), 'params_orig' is allocated by kstrdup(). It returns
> > NULL when fails. So 'params_orig' should be checked.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/include/linux/wimax/debug.h b/include/linux/wimax/debug.h
> > index aaf24ba..bacd6cb 100644
> > --- a/include/linux/wimax/debug.h
> > +++ b/include/linux/wimax/debug.h
> > @@ -496,6 +496,11 @@ void d_parse_params(struct d_level *d_level, size_t d_level_size,
> >  	if (_params == NULL)
> >  		return;
> >  	params_orig = kstrdup(_params, GFP_KERNEL);
> > +	if (!params_orig) {
> > +		printk(KERN_ERR "%s: can't duplicate string '%s'\n",
> > +		       tag, _params);
> 
> We use pr_err these days.
Thanks for your reply. I used printk() because at least in this file, 
printk() is used.

Should I change printk() to pr_err() and revise this patch, or should 
all printk() in this file be changed? I hope you can give me some 
specific instructions. Actually I don't know what to do when getting 
this reply...

Thanks
Gen
> 
> thanks,
> -- 
> js
> suse labs
