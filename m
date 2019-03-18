Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F86CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4102085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqs7n6w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfCRBIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:08:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38246 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfCRBIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:08:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id v1so5475363pgi.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 18:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G8COMw3UY9e0RGVFlMz91WUIoTjkq8UjNxcsPZBVxXc=;
        b=gqs7n6w13E3pKr2Kc9PzrjykTT1SlMXqmU3MS9LYqRIauZPsn6vJugUUsoSYzKsy+I
         DLecoglAJQDWd0JDU+qyy4Th5PQx8sdxw67PYdSJW9KyluSNb6cVH8qx8xpdyWWCMq2a
         PvLlwJ4qXD4eHT/iYs4UOHdkgWENJTrcCS+2/LxT6zHKSpZJkppy3Lpilf4ym7dg6h1A
         /Ch1bhiYfWiJUJcJbsBKSOgW7uxYs8xCzRGZQ0+KnfMrO1KRHr2ciMdvjWQBr0KQ16eV
         F+dimqyPGyHDBWi58QCJrX/GKDipmdaKLbmocrC1QxYiJvMOoZY0WeeZ92LX7aF7ZCxm
         raiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G8COMw3UY9e0RGVFlMz91WUIoTjkq8UjNxcsPZBVxXc=;
        b=j6QrzzM57WnqRmLucnshiRkEEztfmNM0w48UKvC6Se7rdeQIwNzolL4LGbKXQ/RInp
         lnDQoFcKmzQ6KuF4DnrXqt6XMvKfQXFRSxJAl0HlfZ2SDO03E1ZFRr1YoDkxcIjZzxOA
         XUt2EZij56KPBsMDFggwAlF7X15INwKcYS/UfFjC0NLONpIo4LFImWiVutfVzsdZpKr/
         SSfpIc8JeLvvowZwkQmyAQecDGGNlpsMKQLfxAiVESz2wMO90xnpiKJji9n0pZTbFhxU
         UBnVpK2lYkeCu+0SvlItxrH6KzA6hf+mNA0Y+0jNC5dgs6MMFB6FyXoeFXhjRse3MXmt
         3E4w==
X-Gm-Message-State: APjAAAXPKvyVpjNXUOxRKiM+DCEiAD7rLxVICxSmbb+YdzpF+MiDXLM8
        4Cqh4KbqCpZ/MzyHdLh0S3U=
X-Google-Smtp-Source: APXvYqxRcMNF5Dc5qq05UbQ5WERDtIeXPfH64e5Owmw021yNJe73sJtDZ0T1AIeer8wvHZkLqH0OyQ==
X-Received: by 2002:a63:c118:: with SMTP id w24mr15143524pgf.67.1552871284539;
        Sun, 17 Mar 2019 18:08:04 -0700 (PDT)
Received: from localhost ([175.223.21.125])
        by smtp.gmail.com with ESMTPSA id x62sm16082480pfx.117.2019.03.17.18.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 18:08:03 -0700 (PDT)
Date:   Mon, 18 Mar 2019 10:08:00 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATHv3] staging: rtl8723bs: do not use __constant_cpu_to_le16
Message-ID: <20190318010800.GA7218@jagdpanzerIV>
References: <20190317152014.28694-1-sergey.senozhatsky@gmail.com>
 <20190317153553.GA8298@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317153553.GA8298@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/17/19 16:35), Greg Kroah-Hartman wrote:
> On Mon, Mar 18, 2019 at 12:20:14AM +0900, Sergey Senozhatsky wrote:
> > cpu_to_le16() is capable enough to detect __builtin_constant_p()
> > and to use an appropriate compile time ___constant_swahbXX()
> > function.
> > 
> > So we can use cpu_to_le16() instead of __constant_cpu_to_le16().
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/include/wifi.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> What changed from the previous versions of this patch?

In short - nothing :) Just updated email address.

> That always has to go below the --- line.
>
> v4?  :)

OK :)

	-ss
