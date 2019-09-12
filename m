Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E1CC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2892520830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcKTC2yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfILKRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:17:38 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40155 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:17:38 -0400
Received: by mail-yw1-f67.google.com with SMTP id e205so5776969ywc.7;
        Thu, 12 Sep 2019 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9T1y2+STaahr7t0hlBPZawaXpmUrjDhCr4ONlZ1Ftns=;
        b=CcKTC2ycU+pSSU71sVSvNiuzRtnriuYWnJfCtTNVgP80JNYLninibRIzatp1LebYoT
         asHNM/0h+Jr9AjH7UOGS0ZixUFWSN+8qh1XG0LYTyJ6++kExpQcihJVBNWPvls4JWxa4
         P6DgiYZlGkbv/+lHgOE+5y0HVbmdzDUhwjAouRrwnQOgC7uo+JgYRYiTsXNYB4kSpETF
         hZ/vUH5NRaGxOG93T7+aukmhqVZryjLRcXzG3BFnc7SZU72I9ex+SR7NS+ONf/Fpn4eX
         BNdE+nqRD3f4j/YK3EGOwnnv+LgwwmKt0Me6fafsIerpr8RBT31FhdKNjA5HtxcQvjsj
         RV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9T1y2+STaahr7t0hlBPZawaXpmUrjDhCr4ONlZ1Ftns=;
        b=DQ+Xk5R51yicW7/bIGdc2QbuE70QcOwYMPGB0/h6MBwy+BAPPAt5J1BbqdwlFWhxql
         UE6UGXr5nrC5I2DZj00P0VmKfjD5QQCfM5iIOFFTL4Wibz3FuCrrpB8ue2tSNhtavgy6
         8OdATPU3ZB94tS9t8hbEY2JWsJvsXe0AqUsXQ+SltM8oij8x/wJblTjBPTFCc3F0xQa+
         BShiAfh737LG23VFBaWNWk4D+Q1a21jSTiiGHTK4sHorDWuIUBDHxtNE09XDOg2vVJrR
         5L1ZtoCH66+Yn7wv1juaVtz/1QFAzL9JdiCEpdNFccyrG6AMLeOavyhBhDSjUTpHwhm7
         TMnw==
X-Gm-Message-State: APjAAAXLRUr78GaN+/KomMOHlDWv+PbLyMV5UwtaqRWmqjvJCTouNuIj
        WwyUcLD5yKEZAPmCEh8T7d0ZkOfQDTogXERMGROzYA==
X-Google-Smtp-Source: APXvYqyDLxIi91H7D+imxbHKi3wKBGCFHHwsYxxPv5KvWgXbM2jhhqvlGhyrQ/VZhHOsI79ue54Wc8dbaveNMM0NTx4=
X-Received: by 2002:a81:6c8:: with SMTP id 191mr28832594ywg.181.1568283456917;
 Thu, 12 Sep 2019 03:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <1568265511-1622-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <CAOQ4uxjNK9BQxmNqbx8Hix0yd5op-i17BiqvOmmEmr=3bHtm_A@mail.gmail.com> <CAJfpeguVGk7Fpusx83YDstBgNtFZbVwP61aDin6kvA1f5CKCcA@mail.gmail.com>
In-Reply-To: <CAJfpeguVGk7Fpusx83YDstBgNtFZbVwP61aDin6kvA1f5CKCcA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 12 Sep 2019 13:17:25 +0300
Message-ID: <CAOQ4uxjZefwTki=ojQuTT1RC8-ce+o=XZtzyUQ=0iFi6Q757Qg@mail.gmail.com>
Subject: Re: [PATCH V2] ovl: Fix dereferencing possible ERR_PTR()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 12:28 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Sep 12, 2019 at 8:02 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Sep 12, 2019 at 8:24 AM Ding Xiang
> > <dingxiang@cmss.chinamobile.com> wrote:
> > >
> > > if ovl_encode_real_fh() fails, no memory was allocated
> > > and the error in the error-valued pointer should be returned.
> > >
> > > V1->V2: fix SHA1 length problem
> > >
> > > Fixes: 9b6faee07470 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
> > > Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> > > ---
> > >  fs/overlayfs/export.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > > index cb8ec1f..50ade19 100644
> > > --- a/fs/overlayfs/export.c
> > > +++ b/fs/overlayfs/export.c
> > > @@ -229,7 +229,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
> > >                                 ovl_dentry_upper(dentry), !enc_lower);
> > >         err = PTR_ERR(fh);
> > >         if (IS_ERR(fh))
> > > -               goto fail;
> > > +               return err;
> > >
> >
> > Please fix the code in warning message instead of skipping the warning.
>
> Not sure that makes sense.   ovl_encode_real_fh() will either return
> -EIO in case of an internal error with WARN_ON() or it will return
> -ENOMEM on memory allocation failure, which doesn't warrant a debug
> message.
>

Very well. I did not look that deep.

No objections then.

Thanks,
Amir.
