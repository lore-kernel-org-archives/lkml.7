Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE93BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF462465E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 02:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Zgh3J+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLPCm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:42:59 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44788 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 21:42:59 -0500
Received: by mail-io1-f66.google.com with SMTP id b10so5286089iof.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 18:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uegttgIeXuKO4mIuh4CL6lp4/ZMs1NOF6eJA2Ni/GmU=;
        b=l0Zgh3J+BLdsgWr3k7vvxBWqLTnOZqbnXDj3c7qoAxofaOVopr+kSJ2hAUlF7YzndT
         tipHaG+LyhAOEoJfCLRqTtJiSK8F0VFM+xAJv9lYL1QrIQsUS2jnSfTrMvEqTRy3HiY9
         GTET9SJUcUMmpoM5Kza0e4Ih9eMQH4Wt744ooVes/Du9MukDghMDETdPQCDZteGraaQ7
         Zmiexh2CQk9fEY7Fk87MyTmXbpYkoAzy7SQZTeUtAWf+7OcRjW6o8dYRKBKNyVCXe2B+
         0LMHVMK/BRPQTY6j6ZGq+Ecq+vhTSnYfWM9C8nmEWZ64bv9UCHlXkRk5Sdo22b/b1pmX
         H3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uegttgIeXuKO4mIuh4CL6lp4/ZMs1NOF6eJA2Ni/GmU=;
        b=OfKMDWUp5V9DSyJDjIJWnVbXFIpsSzoNqMu6e0oqurmqahfmkrgWwuxjedYBwysPK/
         93MHb7YjFOBbuG5PwjyubVDDPcsKW04XrvdEc+u8odfQWGMTSXM6M72kLLR5Rkqzuq13
         qVhI4y1BNFNEPFED8epOTnTYuJ6Q3uwMnbYCitAnW6xVX5Tra9u5paUED5k5RWZKRsyl
         gnbBKgEMhoANpZM2texNoG6iSPuIA9ryMVV4wwWh2fDVK672YOheyBHkDIqk7oL0OSME
         T6eo3U3gnMYHmyKiJlOwIlb6vV54S7TkgHGSLx2Y8wrTWFopGKfJwz9MJo3tyD7+xqZ5
         FgSw==
X-Gm-Message-State: APjAAAWYE2ma3q83390aMRq1BJ0RbdbUeLw7DlWWodKjt5OhNrvjrCHm
        iBxhmHTRyp7homORzHHjf+7wq2uUHHFRsXRNINg=
X-Google-Smtp-Source: APXvYqxhFN09rDkOVdPI2UiXVg9OUT+I5mmNxjcYBbHHxRRO7/YNOz1llgDOjQBNwtfCvZG8suStd4FoqLJaKzOfu0M=
X-Received: by 2002:a02:9a08:: with SMTP id b8mr3135752jal.1.1576464178055;
 Sun, 15 Dec 2019 18:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20191214230603.15603-1-navid.emamdoost@gmail.com> <20191215132330.GB10631@localhost>
In-Reply-To: <20191215132330.GB10631@localhost>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sun, 15 Dec 2019 20:42:47 -0600
Message-ID: <CAEkB2ETdiewDBk=2O16LkL73cQ1BtrRJDiUOeTsqH1Sq3Qzi+Q@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192e: rtllib_module: Fix memory leak in alloc_rtllib
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        =?UTF-8?Q?Hildo_Guillardi_J=C3=BAnior?= <hildogjr@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Sun, Dec 15, 2019 at 7:23 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Sat, Dec 14, 2019 at 05:05:58PM -0600, Navid Emamdoost wrote:
> > In the implementation of alloc_rtllib() the allocated dev is leaked in
> > case of ieee->pHTInfo allocation failure. Release via free_netdev(dev).
> >
> > Fixes: 6869a11bff1d ("Staging: rtl8192e: Use !x instead of x == NULL")
>
> This is not the commit that introduced this issue.
Oops! That should be  94a799425eee8

>
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/staging/rtl8192e/rtllib_module.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
> > index 64d9feee1f39..18d898714c5c 100644
> > --- a/drivers/staging/rtl8192e/rtllib_module.c
> > +++ b/drivers/staging/rtl8192e/rtllib_module.c
> > @@ -125,7 +125,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
> >
> >       ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
> >       if (!ieee->pHTInfo)
> > -             return NULL;
> > +             goto failed;
>
> And you're still leaking ieee->networks and possibly a bunch of other
> allocations here. You need to call at least rtllib_networks_free() in
> the error path.
I'm not familiar with this code, but based on your hint I believe
there should be something like free_rtllib() here, right?
More specifically, rtllib_softmac_free() and
lib80211_crypt_info_free() are needed along with
rtllib_networks_free(). If you confirm that it works I can go ahead to
prepare patch v2 with these releases.

>
> >
> >       HTUpdateDefaultSetting(ieee);
> >       HTInitializeHTInfo(ieee);
>
> Johan



-- 
Navid.
