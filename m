Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717A3C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9492084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ejjO79R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfILJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:28:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39033 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbfILJ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:28:52 -0400
Received: by mail-io1-f67.google.com with SMTP id d25so52941480iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySusEsEvIA1p7Ok5MeAC6hgYTUozA4I6kAXqI82zhqE=;
        b=ejjO79R3dG15jay2GvSB7zkWjnzn7JGpb2WokQ8V16v5w8JmDpD1ugMmEJijAjND7j
         Xymg+XPaHSscKaMChl399p9WZvVn+txz6OSLwbpTgQlls2BVfXXh6Swc1cAkR1QK1g/K
         WJtGq95B0KvPHNpdCwhvk+SNR1BNJw80XxtaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySusEsEvIA1p7Ok5MeAC6hgYTUozA4I6kAXqI82zhqE=;
        b=FWIph6AcsJn2p4QQuaHuecoHpIkt8GSJie+8r9ONOWsHLC5IFKF+Mmg+XaY5VkmLc8
         ZGzo7LQiTC4YFJ/k4sHM3Y2QE+jRxFcYYkefC7xiYR0t4kV+jp/4SXxyXhYwq57dhd91
         m6AP+uWX2vd087rHyWN8wI82rz0k/VEc5L0JgNPHCdBBVfb29u4BnOsEIYDdpnbN5C48
         9F3b5qvDH0JTLak4rmg3hVDwG5QpbpRDwhAHC4QshFWJVGfOZsfScOQ4N/qsfwPbquGp
         aVSncNbg01HFHrxephREnyKW9ktToe3QRjX7puvPjgt+CQjXJ+YZR8Xzwmt3BXv56vss
         nwgQ==
X-Gm-Message-State: APjAAAWBIHR4Wyqn8sLd+EtnBIQP6MR7rXD/9VQ66GqOelr7IocEOkEI
        bJHKiSgT9f4UHg9tkzcOIlRoXOghbnmG08H913arlQ==
X-Google-Smtp-Source: APXvYqwKtyjoNjSXdno7ZVe7FfQu1Nx0FJSMjH78DCZyjeB4BZrHt6OOPtbuFZl7IsH3X/FMzz9J645srsCQV3vf1JU=
X-Received: by 2002:a6b:6602:: with SMTP id a2mr3022334ioc.63.1568280530746;
 Thu, 12 Sep 2019 02:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <1568265511-1622-1-git-send-email-dingxiang@cmss.chinamobile.com> <CAOQ4uxjNK9BQxmNqbx8Hix0yd5op-i17BiqvOmmEmr=3bHtm_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjNK9BQxmNqbx8Hix0yd5op-i17BiqvOmmEmr=3bHtm_A@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 11:28:39 +0200
Message-ID: <CAJfpeguVGk7Fpusx83YDstBgNtFZbVwP61aDin6kvA1f5CKCcA@mail.gmail.com>
Subject: Re: [PATCH V2] ovl: Fix dereferencing possible ERR_PTR()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 8:02 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 12, 2019 at 8:24 AM Ding Xiang
> <dingxiang@cmss.chinamobile.com> wrote:
> >
> > if ovl_encode_real_fh() fails, no memory was allocated
> > and the error in the error-valued pointer should be returned.
> >
> > V1->V2: fix SHA1 length problem
> >
> > Fixes: 9b6faee07470 ("ovl: check ERR_PTR() return value from ovl_encode_fh()")
> > Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> > ---
> >  fs/overlayfs/export.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> > index cb8ec1f..50ade19 100644
> > --- a/fs/overlayfs/export.c
> > +++ b/fs/overlayfs/export.c
> > @@ -229,7 +229,7 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
> >                                 ovl_dentry_upper(dentry), !enc_lower);
> >         err = PTR_ERR(fh);
> >         if (IS_ERR(fh))
> > -               goto fail;
> > +               return err;
> >
>
> Please fix the code in warning message instead of skipping the warning.

Not sure that makes sense.   ovl_encode_real_fh() will either return
-EIO in case of an internal error with WARN_ON() or it will return
-ENOMEM on memory allocation failure, which doesn't warrant a debug
message.

Thanks,
Miklos
