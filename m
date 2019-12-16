Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38609C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB882067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576507393;
	bh=oqR/gExGTP7ByMWKm2lF7zL7kTYipS6tN0tjypeI9KA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sSE9/G6uXH4TfgzmRYTIHgkX/stiQcU8d875rSAyyo/UWEw4Z9Tt0zzf0HbzExM2g
	 EXxteR/5lpztJ9a0y2CnbLSb6L/K9UtcJ7ppWD8xS5Mp8H/gzWN7EDwSv4iTL2Xx10
	 qn5nAf4o/hKN2X1zRpvhorqEXMnHw7scfGu+hHAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfLPOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:43:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45836 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfLPOnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:43:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so4397070lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 06:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gv+/8rgLdpJtYfRlGB9W0qpf6rThSdzhIxSFY7hLXJI=;
        b=RLwVLjCFpWWZF4a7k0ZuY1F1S/X0F6uPUio0/j2/QwBM9K7rqEiTCzCOibLpJ6mdW6
         gl0lJOk/sPv1vL0R+/+FUI+xha3SjDDjlZ1rJOF/mOaJmbP1bRbeTzHzRYh9c3WuhwkT
         oX4vaF9ow/IvokUlC8vjc2wjEVReR9nJGJJaqvwj3aHZ/ZFRPrd2aq8noTtYdOxNVcwp
         dxvhqAuCq0tMNSmEJY2cqO4orVKuI+OWtuCZPYDU4VbX5TTAPlRmr3+X94AZH2FANDXO
         MtpMHFJ0zEKh3cslJY0z2rbcrTxVXDOt2Rh/gRhIluccpsc2TlghTZv+6h9W4GT0POqg
         IYWw==
X-Gm-Message-State: APjAAAUYjrw3u2H+muJx4D9oe9qwQxiTIx1v/J15nTZO/9WgrHdg0G5i
        wJ9hpkPqFUjuzntK00yb9fQ=
X-Google-Smtp-Source: APXvYqwHjsIT5o06Aax0VMVQOJutTX2B44vXA66R3ogbOX32pl0Gn46SqQ0yV0Whb8ChK1MM46E+oQ==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr17002707lfa.100.1576507389559;
        Mon, 16 Dec 2019 06:43:09 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id w6sm8980135lfq.95.2019.12.16.06.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 06:43:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1igraU-0004My-9j; Mon, 16 Dec 2019 15:43:06 +0100
Date:   Mon, 16 Dec 2019 15:43:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        Hildo Guillardi =?iso-8859-1?Q?J=FAnior?= <hildogjr@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>
Subject: Re: [PATCH] staging: rtl8192e: rtllib_module: Fix memory leak in
 alloc_rtllib
Message-ID: <20191216144306.GF22665@localhost>
References: <20191214230603.15603-1-navid.emamdoost@gmail.com>
 <20191215132330.GB10631@localhost>
 <CAEkB2ETdiewDBk=2O16LkL73cQ1BtrRJDiUOeTsqH1Sq3Qzi+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2ETdiewDBk=2O16LkL73cQ1BtrRJDiUOeTsqH1Sq3Qzi+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 08:42:47PM -0600, Navid Emamdoost wrote:
> Hi Johan,
> 
> On Sun, Dec 15, 2019 at 7:23 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Sat, Dec 14, 2019 at 05:05:58PM -0600, Navid Emamdoost wrote:
> > > In the implementation of alloc_rtllib() the allocated dev is leaked in
> > > case of ieee->pHTInfo allocation failure. Release via free_netdev(dev).
> > >
> > > Fixes: 6869a11bff1d ("Staging: rtl8192e: Use !x instead of x == NULL")
> >
> > This is not the commit that introduced this issue.
> Oops! That should be  94a799425eee8
> 
> >
> > > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192e/rtllib_module.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> > > index 64d9feee1f39..18d898714c5c 100644
> > > --- a/drivers/staging/rtl8192e/rtllib_module.c
> > > +++ b/drivers/staging/rtl8192e/rtllib_module.c
> > > @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
> > >
> > >       ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
> > >       if (!ieee->pHTInfo)
> > > -             return NULL;
> > > +             goto failed;
> >
> > And you're still leaking ieee->networks and possibly a bunch of other
> > allocations here. You need to call at least rtllib_networks_free() in
> > the error path.
> I'm not familiar with this code, but based on your hint I believe
> there should be something like free_rtllib() here, right?

Right.

> More specifically, rtllib_softmac_free() and
> lib80211_crypt_info_free() are needed along with
> rtllib_networks_free(). If you confirm that it works I can go ahead to
> prepare patch v2 with these releases.

I can't confirm anything, that's your job. ;)

You need to trace the calls and allocations made in in alloc_rtllib()
and make sure everything is released on errors. For a well-designed
subsystem and driver this should end up looking a lot like the release
function (free_rtllib()), but that's unfortunately not always the case.

Judging from a quick look at least rtllib_softmac_free() is also needed
besides rtllib_networks_free(). And you probably want
lib80211_crypt_info_free() as well for consistency even if the
corresponding init functions doesn't seem to do any allocations
currently.

Johan
