Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF597C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF47C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VNSfaSrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfFUQ0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:26:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46082 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfFUQ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:26:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so3596983pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QGGXbtGqjT/8JHl90NENFneOyMcVx1pmW8SwPMxZhnc=;
        b=VNSfaSrYn6JtJnDJSfOqnDLzSNCiB097bMhMBgHC9puUkpdT8+LRmSz/4mvXIOC1H8
         6io6zQW68Cgj10MjA9+mZqbwu1ZM1h31FIB2uQMoAvk5oRFhAmQzNyPZ0R8wLwrLikUs
         OF8qHdeD2VyayW2MUP5Tj8YbN5YGsfIYBZdEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGGXbtGqjT/8JHl90NENFneOyMcVx1pmW8SwPMxZhnc=;
        b=HrXiZxZPcoYFt88SX6TEL4sZwvqMwMk80Bc5QX/Jz9F6OnwqCJY3MWPFuuHOjggK7O
         t/gW9gne49pI0epsXEioH+B/gYaOKgR2rFM2W/GI30jfqlehM8ho+wb0tE/vfY8yX0jW
         Nz/UiZdUMOr+7HJD818jvyuyAxdCuKIu0WPgH236KhuzeX3mJCyHOlf2tBfjZHkdQXxe
         RacMSOas8uP7J1r2jubfRwoPSXHHY3urprDurIbXg+TL2Tje72iDtkxqUJUGEU2h7Qs5
         2OMnUg5Vhjfq1kYYXgn811zi/rX13FXN8PMvYXIGl2Lh6v13q0QmjdzE9INh6PfvyqTm
         57dQ==
X-Gm-Message-State: APjAAAXU9M9LkQISnYyU0/HbhO1fV27jFvC7K9tgT6sYlUyhllRdG4Ky
        1vCetwniPGBiWJ1SkzQXGpuNsg==
X-Google-Smtp-Source: APXvYqw+SAN38dAvhi9oOLlGxcfaCHaZKK0bjk3Eto0s1p7ZRDvaj47kiKISLINxAAKjKSmW6FFpfQ==
X-Received: by 2002:a65:5302:: with SMTP id m2mr19204195pgq.369.1561134367215;
        Fri, 21 Jun 2019 09:26:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e22sm3198234pgb.9.2019.06.21.09.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 09:26:06 -0700 (PDT)
Date:   Fri, 21 Jun 2019 09:26:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lkdtm: remove redundant initialization of ret
Message-ID: <201906210920.E133B26C@keescook>
References: <20190614094311.24024-1-colin.king@canonical.com>
 <20190621140347.GA7011@kroah.com>
 <20190621140509.GB7011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621140509.GB7011@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:05:09PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 21, 2019 at 04:03:47PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jun 14, 2019 at 10:43:11AM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The variable ret is being initialized with the value -EINVAL however
> > > this value is never read and ret is being re-assigned later on. Hence
> > > the initialization is redundant and can be removed.
> > > 
> > > Addresses-Coverity: ("Unused value")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/misc/lkdtm/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> > > index bba093224813..92df35fdeab0 100644
> > > --- a/drivers/misc/lkdtm/core.c
> > > +++ b/drivers/misc/lkdtm/core.c
> > > @@ -390,7 +390,7 @@ static int __init lkdtm_module_init(void)
> > >  {
> > >  	struct crashpoint *crashpoint = NULL;
> > >  	const struct crashtype *crashtype = NULL;
> > > -	int ret = -EINVAL;
> > > +	int ret;
> > >  	int i;
> > >  
> > >  	/* Neither or both of these need to be set */
> > > -- 
> > > 2.20.1
> > > 
> > 
> > With this patch now applied, I get this build warning:
> > drivers/misc/lkdtm/core.c: In function lkdtm_module_init:
> > drivers/misc/lkdtm/core.c:467:9: warning: ret may be used uninitialized in this function [-Wmaybe-uninitialized]
> >   return ret;
> >          ^~~
> > 
> > So are you _sure_ it shouldn't be initialized?
> 
> In looking at the code in my tree, ret is used uninitialized with this
> patch, so maybe coverity is wrong, or I don't have all of the needed
> patches?

The path went away when the check for debugfs_create_file() was removed.
I thought that patch was in your tree already?

In master, this is the path to "return ret" without prior assignment:

                de = debugfs_create_file(cur->name, 0644, lkdtm_debugfs_root,
                                         cur, &cur->fops);
                if (de == NULL) {
                        pr_err("could not create crashpoint %s\n", cur->name);
                        goto out_err;
                }


-- 
Kees Cook
