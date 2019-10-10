Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEADC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD108206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnOJV7YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbfJJJuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:50:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40395 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:50:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so6050344wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yNx+8n36uJ0WGHxBC9aaDo5XpCmOIJvnh/6Zg8N6jFk=;
        b=XnOJV7YI/chmZQMSTTcgcjcrpoZZh39oUa9LFBeXkUiykjjr5JEBgkK+KfCLOJG6O8
         6+NIc/vyXLmNqfB90MKN8p2Unok1c+fSiHgnwCyrXBJKeaQPqrFkhiy2P/mLshMb4fvb
         kB1pTofuj/RzTNiCrP5P+CFGWNF9hxdI1rBTBJP7STVGBnVmS1G7saGVLs5yod9EAWcS
         s7eZ+f9uqQ04q8bq3OcoV3Z9FvZ/0mp2Ibn69cbg0K9ejU+OuHVyhxeUwJhjfdA2m2K9
         WgkfJfrzns34UQNFKX1MMnVPj95NEovFrbRBNTgc3kzs4zUd37NIBrwK7WMsOH19ho8h
         xmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNx+8n36uJ0WGHxBC9aaDo5XpCmOIJvnh/6Zg8N6jFk=;
        b=EByYsqZOBP8p3k/YhM7Suh/U+rj7hmTGv6SO1AsEO16pyc3P3tvYc1YH4F79kAOveO
         8t+AhjUIFodlJCoQZbTp+SWYQWV9SD1c6oAod5iCIsUv2pbbi0/GZA9a4znxrAnYhcOx
         2MjnQenZnQ+xFClbCXvc9jfRrR/RuAH74U6CWRxjwJXq93+kmKVdgkQ+lzmyjl0W5Ttm
         sW/1d2bK9QQBR3wN43Eg3aYlS6JZJiGOPtZwAtSWC+sArP4cdaXvHfDyodJRwNeCF/zI
         XXnmQb2IFJvdQtASz4rTldh2La0iM93/oZBhqQGRCa0i2mJTe20fl7crP7sGR2oCzg3Z
         hptw==
X-Gm-Message-State: APjAAAX8ieMKgYfXAJWOb1ejVD9p0X8MavM7McmzGti3HCP/v3vVuSBq
        7Js9GpuUQllX7MNPLdfMs1oxtg==
X-Google-Smtp-Source: APXvYqzFLiv9I4jhmsqgSvPdg5cd8l8SX5O0wt8s2GhMRL49oWG4zEBcs3xLTe0L/Aic6+31c8mwog==
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr6926175wmg.79.1570701011994;
        Thu, 10 Oct 2019 02:50:11 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 207sm7788894wme.17.2019.10.10.02.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 02:50:11 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:50:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH v2 3/5] kdb: Remove special case logic from kdb_read()
Message-ID: <20191010095009.25a5zvoykpmvtktq@holly.lan>
References: <20191008132043.7966-1-daniel.thompson@linaro.org>
 <20191008132043.7966-4-daniel.thompson@linaro.org>
 <CAD=FV=W9Tdh2hPekzgSYnCqoTX_ms1GY-FXgnxd-uEW0SWbyuw@mail.gmail.com>
 <20191009093049.tnz442bo54bzmzmz@holly.lan>
 <CAD=FV=UuLYPpkJBWbkWoJzv97A6jxRFa4QmmD-0chSrsuT_bPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=UuLYPpkJBWbkWoJzv97A6jxRFa4QmmD-0chSrsuT_bPg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:28:36AM -0700, Doug Anderson wrote:
> On Wed, Oct 9, 2019 at 2:30 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > > @@ -741,7 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> > > >
> > > >         /* check for having reached the LINES number of printed lines */
> > > >         if (kdb_nextline >= linecount) {
> > > > -               char buf1[16] = "";
> > > > +               char ch;
> > >
> > > The type of "ch" should be the same as returned by kdb_getchar()?
> > > Either "int" if you're keeping it "int" or "unsigned char"?
> >
> > Probably... although the assumption that kdb strings are char * is burnt
> > in a lot of places so there will still be further tidy up needed.
> 
> True.  It doesn't matter a whole lot so if you think it's easier to
> keep it as char that's OK too.

After looking at it from a number of angles I think we can have this
match the return type of kdb_getchar()... but the best way to achieve
this is to make kdb_getchar() return a unqualified char.

That ends up consistent across the sub-system and shouldn't do any
narrowing that wouldn't already have been happening inside kdb_read().


Daniel.
