Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2DBCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1734D222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLw4kgK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfJSH2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:28:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34194 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfJSH2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:28:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so10785974wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 00:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Fr2NikG6Tj2uHhMBe2Mkt6L0jUcAk7enEP452906uXE=;
        b=BLw4kgK+cmpzbOJU9K0NFE4vLuzs47u37DDF+nCJnAntl0/SDWwHatDa9JwpA77tJb
         F5HnbBVeTH0jlGnVZsfOHWY95iQe6GhDf8wjbiTaVhxLPdUqxyktcVh1lkzlOgUU2ko6
         PTq7AO9uMz0AA1PVwUTYpTl8rvkXnEqb/UtqxDkwP7QIiN2TvwFBncP6lIvP1jtXiK65
         K1QY7IJmUGLB5S3O3ZsO+3GA9VdS1Oswrr9FI2ipL9aB5xiqzWXMKBqcKSYxC9YRFFpU
         5ckwoIiS3Znrg3tycBhGvjM/L0PBeOvWH9f9F5Ox+ZQIJZiuHQrQ+sJU5wtbi0vMq1h6
         FHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fr2NikG6Tj2uHhMBe2Mkt6L0jUcAk7enEP452906uXE=;
        b=Ww+LZE3PJ18zesxBE+WyedA5ykk2F4LHqwjM/3JtEFBYJE19wNrt/eNwTyiYn9BZdF
         BaVohhEe4Jfz/JMWZtkF6KkROAOaHNJzTXflaEebtLOKEGTmq+R0fTFxIxT8IjvJxAGx
         E9K2rEuIrKvzA2Ynf7UDlce72sbqUX1+fkZc807cZ1f0b7fw3ukF2K87E2e+WBK5Sh3r
         6nJ9Ky3fZeYlNHnYWwlhzC/0p4rarPMRps7XsH8a8YWcAk5cUMl0vNSJfwa1r5huQqEf
         hgHDjOKodl1mSdudMl+PcZYiF0Zh8nV/izznvHcgaCH60F3PHg39vy/2hnu4TvmSIOHy
         DtnA==
X-Gm-Message-State: APjAAAXOZraM3mW/RfrNlG1nZO3oW8cz7MDrIpVtoCl5ZQ+2KD/4CBFZ
        3mrlhUb7uAhlasSdcQUSQOi/JA==
X-Google-Smtp-Source: APXvYqwBhR7P6UqTDRz+njy9FXXBvhp+4umjAhhV9A+lzUkV+U7s7V+AWjdrnegkIkSF2YsxNA77IQ==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr11454552wme.0.1571470093037;
        Sat, 19 Oct 2019 00:28:13 -0700 (PDT)
Received: from dell ([95.149.164.96])
        by smtp.gmail.com with ESMTPSA id g5sm3353151wmg.12.2019.10.19.00.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Oct 2019 00:28:12 -0700 (PDT)
Date:   Sat, 19 Oct 2019 08:28:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de, baohua@kernel.org,
        stephan@gerhold.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] mfd: mfd-core: Honour Device Tree's request to
 disable a child-device
Message-ID: <20191019072809.GX4365@dell>
References: <20191018122647.3849-1-lee.jones@linaro.org>
 <20191018122647.3849-3-lee.jones@linaro.org>
 <b7c59d6e-2ad8-30a1-013a-53c116f7b6ba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7c59d6e-2ad8-30a1-013a-53c116f7b6ba@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Robin,

It's been a while.  I hope that you are well.

Thanks for taking an interest.

On Fri, 18 Oct 2019, Robin Murphy wrote:
> On 18/10/2019 13:26, Lee Jones wrote:
> > Until now, MFD has assumed all child devices passed to it (via
> > mfd_cells) are to be registered.  It does not take into account
> > requests from Device Tree and the like to disable child devices
> > on a per-platform basis.
> > 
> > Well now it does.
> > 
> > Reported-by: Barry Song <Baohua.Song@csr.com>
> > Reported-by: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/mfd/mfd-core.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index eafdadd58e8b..24c139633524 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -182,6 +182,11 @@ static int mfd_add_device(struct device *parent, int id,
> >   	if (parent->of_node && cell->of_compatible) {
> >   		for_each_child_of_node(parent->of_node, np) {
> >   			if (of_device_is_compatible(np, cell->of_compatible)) {
> > +				if (!of_device_is_available(np)) {
> > +					/* Ignore disabled devices error free */
> > +					ret = 0;
> > +					goto fail_alias;
> > +				}
> 
> Is it possible for a device to have multiple children of the same type? If
> so, it seems like this might not work as desired if, say, the first child
> was disabled but subsequent ones weren't.
> 
> It might make sense to use for_each_available_child_of_node() for the outer
> loop, then check afterwards if anything was found.

The subsystem in its current guise doesn't reliably support the
situation you describe. We have no way to track which child nodes have
been through this process previously, thus mfd-core will always choose
the first child node with a matching compatible string.

If you have any suggests in terms of adding support for multiple
children with matching compatible strings, I'd be very receptive.

> >   				pdev->dev.of_node = np;
> >   				pdev->dev.fwnode = &np->fwnode;
> >   				break;
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
