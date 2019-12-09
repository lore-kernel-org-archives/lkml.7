Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CDE2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ok+OvY/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLINNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:13:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLINNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 08:13:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so16086035wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V6S2uG2bG6JwtdT/qF7ic6vM73Q8ZwaAZIzcpihABZI=;
        b=ok+OvY/SBcUK1d0DFrzC6YOKnwJ+lpgYlx6JEoBfCE/SQja6ytOnC3QXkAEPqbmWsi
         2Dl01HguXyX628if25V3qc8x6SWZsBQ6H5mm2MUStG+mX4QaihhqRfAu+U10nWKyYJ0l
         GgeOKpIf1VPfnvZcIYHzDIkpucRUVoJUV8rV3p99ZlTYvT6KXm6YPOLqFN7NCrSuETxS
         i01556FallpVzggjVNQol1hdsNQz8Yk1+UcdXbPypX8UZUdU08BUA7c4cIFIcMvk3kFG
         rzSiFHOgAbREwHoKFfb+LF8Pf0v6E0iFlXFm02YuDpkqCjPT5HoxRInI+9tuLz0V7M7/
         YfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V6S2uG2bG6JwtdT/qF7ic6vM73Q8ZwaAZIzcpihABZI=;
        b=KRLHJsCAg2VfTYcco5r1L1mmcdqYX77tEIYsX/YHN6STRZW1YckIovsDcZxlzrXcB0
         CQvkzawSUWNTHgLTwymVHkif7tsIlXPtQba1GbAbz5xmzlZ1rwpPUTZaH6nRUDNKSPgc
         yDSSxqAZuF/5wDJ4tKPTeiGLL03Vz1lJnTL+LGSYJJO0vLC3QETZYwkywXAOVR8tUaXa
         8HnCmMkkjWS0yqSYMDqx2P4/fYcn68wYz9t+uzA9xOcsB7hdty5gL0kBUzWzIg5HRbR7
         udFOJYwOg/p16oW88Agbpf7clJ64QFPiTOhUjZ3yPMxu3dxNp0Zh4jbcYUuoyLEL3xCE
         zeBQ==
X-Gm-Message-State: APjAAAW3xPaFC01MJqHGLFjpdvawFNz+5eJclwNuePrWKu6fmspBMBjx
        wFacCDd/fLM3MFAg/ylqajccJQ==
X-Google-Smtp-Source: APXvYqx4S+GrW3f2FsYNXjh5rFBwceuWVufJGvl5oygrKSE4A5ekH8KROaL1wAzYGr8JEbprTeVuiw==
X-Received: by 2002:adf:a285:: with SMTP id s5mr2149590wra.118.1575897229283;
        Mon, 09 Dec 2019 05:13:49 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id p10sm13362353wmi.15.2019.12.09.05.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:13:48 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:13:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: sm501: fix mismatches of request_mem_region
Message-ID: <20191209131342.GJ3468@dell>
References: <20191116151308.17817-1-hslester96@gmail.com>
 <20191209090020.GG3468@dell>
 <CANhBUQ2+ogNxA7OGM87igDrCSfbhvCzV5HEzQUWgDqwuMHBE3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANhBUQ2+ogNxA7OGM87igDrCSfbhvCzV5HEzQUWgDqwuMHBE3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Dec 2019, Chuhong Yuan wrote:

> On Mon, Dec 9, 2019 at 5:00 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Sat, 16 Nov 2019, Chuhong Yuan wrote:
> >
> > > This driver misuses release_resource + kfree to match request_mem_region,
> > > which is incorrect.
> > > The right way is to use release_mem_region.
> > > Replace the mismatched calls with the right ones to fix it.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/mfd/sm501.c | 19 +++++++------------
> > >  1 file changed, 7 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> > > index 154270f8d8d7..e49787e6bb93 100644
> > > --- a/drivers/mfd/sm501.c
> > > +++ b/drivers/mfd/sm501.c
> > > @@ -1086,8 +1086,7 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
> > >       iounmap(gpio->regs);
> > >
> > >   err_claimed:
> > > -     release_resource(gpio->regs_res);
> > > -     kfree(gpio->regs_res);
> > > +     release_mem_region(iobase, 0x20);
> > >
> > >       return ret;
> > >  }
> > > @@ -1095,6 +1094,7 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
> > >  static void sm501_gpio_remove(struct sm501_devdata *sm)
> > >  {
> > >       struct sm501_gpio *gpio = &sm->gpio;
> > > +     resource_size_t iobase = sm->io_res->start + SM501_GPIO;
> >
> > Shouldn't this be 'struct resource *'?
> 
> sm501_register_gpio() uses resource_size_t, so I use the same type in remove.

Okay.  Just for the record, there are a few things I don't like about
this patch, but seeing as it's inline with the current coding style, I
will accept it based on the fact that it would be unreasonable to ask
for the driver to be bought back into line as a prerequisite for
acceptance.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
