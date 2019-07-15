Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BFC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5633A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8qRxSKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfGOUXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:23:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40107 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731055AbfGOUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:23:01 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so36234930iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4sgcLOMbyXJn+TV7zW0h6BmBF+H1WzQkFZRqrEO1yk=;
        b=x8qRxSKXM/VFrSA9MdVLx5KR/z6b3iDcECgXoECDoiVev6JVwoSBGpwetlt5thhq44
         mY09gs1r9IhHQVndWTzDlOjvOu4KG8gL+sgLdJSxK3igsH2XG067Hzry6zF87XPqWHOM
         FXCowuUymmjDVWwzpv9J229PtLmL00goBLAvK1tzs2m+j1JcuKhz7xvFk+Yyw2PimOpZ
         E4dmSDWdV7RfrlmV5Su2W3xFWcWHZKi/SnrW+emDui2uJNr0Injpf6LZ9IUBS75tkPBF
         fUduPlI1iZUSCdklu3x/8fULWTmd4CjtfS9AKA6puwH6vHNJdgA3zPnQAxdEZxG1TjI0
         JfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4sgcLOMbyXJn+TV7zW0h6BmBF+H1WzQkFZRqrEO1yk=;
        b=P9Ces+fZheBDYsCJe4BKGnso4AyOATGsRtiycenbfUsT9+1fC48/84KjAzDLt5xF4p
         hwcJTroqknOoK3kXz09fw8aADP+Q1eYLYZB2yz0mk2wMJ9bdUUhX9QMF+F6CLSRORQq0
         zrrzbqdH9qEdiQlvJR3uJ84+AQdDHM++tvo4ZqMT5mepv/YmI3ShQWgGIY1dIkbyl8x+
         yGD6OySdPL5ULe4Sh60jrCok5U7CemitVLBrcEyoxgaKcZjzpGzV6fSHe5pF0p5skH1q
         vUPrQQYyB5tOr8G79dyHQ/citCG87iaxdbD7gfaGFgCmhMAvN+saKLBEAqu6sIbXflt7
         XwbA==
X-Gm-Message-State: APjAAAW+bid0xvtcDjOw06v/rz75e9Y7NjTkoo+BJvXdnQ+OvtGGiaQs
        Bp7UCybotsXhmVO1XZUxLyRa44gCf4IYQn2nsegYqQ==
X-Google-Smtp-Source: APXvYqxUdBXLkQNSTCf6BXUxQvwj8MwgN2wmZfnscGiL9J14U4GCW3ly/hYqzCTiXdS6t7GAf8gb6+fDRIEbeN5DQq4=
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr28360386iod.139.1563222180157;
 Mon, 15 Jul 2019 13:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190701190940.7f23ac15@canb.auug.org.au> <20190712105340.1520bce0@canb.auug.org.au>
In-Reply-To: <20190712105340.1520bce0@canb.auug.org.au>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 15 Jul 2019 14:22:49 -0600
Message-ID: <CANLsYkwNM7c6d-3+jpf+V=HppQ9cnA-RDmam_6qUuKC_g_Tq7A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, 11 Jul 2019 at 18:53, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 1 Jul 2019 19:09:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the char-misc tree got a conflict in:
> >
> >   drivers/hwtracing/coresight/of_coresight.c
> >
> > between commit:
> >
> >   418e3ea157ef ("bus_find_device: Unify the match callback with class_find_device")
> >
> > from the driver-core tree and commits:
> >
> >   22aa495a6477 ("coresight: Rename of_coresight to coresight-platform")
> >   20961aea982e ("coresight: platform: Use fwnode handle for device search")
> >
> > from the char-misc tree.
> >
> > I fixed it up (I removed the file and added the following merge fix patch)
> > and can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 1 Jul 2019 19:07:20 +1000
> > Subject: [PATCH] coresight: fix for "bus_find_device: Unify the match callback
> >  with class_find_device"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> > index 3c5ceda8db24..fc67f6ae0b3e 100644
> > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -37,7 +37,7 @@ static int coresight_alloc_conns(struct device *dev,
> >       return 0;
> >  }
> >
> > -int coresight_device_fwnode_match(struct device *dev, void *fwnode)
> > +int coresight_device_fwnode_match(struct device *dev, const void *fwnode)
> >  {
> >       return dev_fwnode(dev) == fwnode;
> >  }
>
> This is now a conflict between the driver-core tree and Linus' tree.
>
> The declaration of coresight_device_fwnode_match() also needs fixing up
> in drivers/hwtracing/coresight/coresight-priv.h (as done in the patch
> below supplied by Nathan Chancellor).

I have updated my next branch and you shouldn't see this again.

Thanks,
Mathieu

>
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Mon, 1 Jul 2019 11:28:08 -0700
> Subject: [PATCH] coresight: Make the coresight_device_fwnode_match declaration's fwnode parameter const
>
> drivers/hwtracing/coresight/coresight.c:1051:11: error: incompatible pointer types passing 'int (struct device *, void *)' to parameter of type 'int (*)(struct device *, const void *)' [-Werror,-Wincompatible-pointer-types]
>                                       coresight_device_fwnode_match);
>                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/device.h:173:17: note: passing argument to parameter 'match' here
>                                int (*match)(struct device *dev, const void *data));
>                                      ^
> 1 error generated.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 8b07fe55395a..7d401790dd7e 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -202,6 +202,6 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
>
>  void coresight_release_platform_data(struct coresight_platform_data *pdata);
>
> -int coresight_device_fwnode_match(struct device *dev, void *fwnode);
> +int coresight_device_fwnode_match(struct device *dev, const void *fwnode);
>
>  #endif
> --
> 2.22.0
>
> --
> Cheers,
> Stephen Rothwell
