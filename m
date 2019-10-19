Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D15DCA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9D2222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpdHQ9e/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfJSHbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:31:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38226 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfJSHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:31:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so8076099wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OzPJDxGi1MrI8ZR9UuASyVPLDi4zzBY6pZdlj+5WowY=;
        b=BpdHQ9e/XotjqdUYekfRD7DitgfTp/dQ2Cmzh3Z2QleXn0izgIgKpzA7lA4X5qK3oE
         m6j1Q8ctp32GU6U3TCpenqgGXbOcUH65pg48i2p/o+RKEzsmOUDdquGdmH6hJJjVvrIz
         3ZidY7ge55WqtGuL2aNK2u1Cn5k/y9OWYDi1qKv+iMaQ4LRidOockcKWFKWXAQ50LGyg
         67xnpr17wg2APC2k7kcuTPDCZ2IzoLyy5gB9S0Y+JzT7Z3EDVkSDl+/WZyJLUL1u4Ovi
         jGeKJMIV3c5B0TpVp8o67jm3d84PMeIGOle0NBNrKrYw7fh0MnyYVCaZRAjQf8NUz29I
         Q6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OzPJDxGi1MrI8ZR9UuASyVPLDi4zzBY6pZdlj+5WowY=;
        b=Y2DUVMHowygvgC7d4V5EYFboagwbTWRTY4AYW96nFP2vDm7EYOImI9eiRVamwLno5N
         Z73jBsDHt/TAg5xOb+5xei9FkcScTTqXVFBhBH0rkN4GmVs7y1LyNZPlSng2lYM/1Avz
         Havar5MR8hp+hnJL/adaiq/q11yEn7GqXZcSYDBxs4zY43sigAzbfGbeGypvC7XWxG2d
         wrFkRqrdH0IAApW6EZ70k18ibEMxFw+4OVN6cZlLVtjMoYjE8fj939YX4KAgmFzDbwDn
         +zM23L9id29nD2paTENizrifvkrB/AnuqkL2hUrA5yRWQS2WDGicz64bO9duBLt6ufS4
         Ta+w==
X-Gm-Message-State: APjAAAXMtMoeI+pvxzeWhbtp43/jZkszX3zh4w6ZQll3XHvbZuuz62jy
        6Opj9kvsDYHeuM95LlbU8bSSEw==
X-Google-Smtp-Source: APXvYqxK/zt38rwIEroHa0npO4eL6VInoZD2zOOunp2BHmbhx4voiu0yBoCmi0QYU+qcMd3WMiO4Mg==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr11324006wml.31.1571470309026;
        Sat, 19 Oct 2019 00:31:49 -0700 (PDT)
Received: from dell ([95.149.164.96])
        by smtp.gmail.com with ESMTPSA id t10sm10005418wrw.23.2019.10.19.00.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Oct 2019 00:31:48 -0700 (PDT)
Date:   Sat, 19 Oct 2019 08:31:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH 1/2] mfd: mfd-core: Allocate reference counting memory
 directly to the platform device
Message-ID: <20191019073145.GY4365@dell>
References: <20191018122647.3849-1-lee.jones@linaro.org>
 <20191018122647.3849-2-lee.jones@linaro.org>
 <20191018160419.rm2ogvh3k3jdx3tn@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018160419.rm2ogvh3k3jdx3tn@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019, Daniel Thompson wrote:

> On Fri, Oct 18, 2019 at 01:26:46PM +0100, Lee Jones wrote:
> > MFD provides reference counting (for the 2 consumers who actually use it!)
> > via mfd_cell's 'usage_count' member.  However, since MFD cells become
> > read-only (const), MFD needs to allocate writable memory and assign it to
> > 'usage_count' before first registration.  It currently does this by
> > allocating enough memory for all requested child devices (yes, even disabled
> > ones - but we'll get to that) and assigning the base pointer plus sub-device
> > index to each device in the cell.
> > 
> > The difficulty comes when trying to free that memory.  During the removal of
> > the parent device, MFD unregisters each child device, keeping a tally on the
> > lowest memory location pointed to by a child device's 'usage_count'.  Once
> > all of the children are unregistered, the lowest memory location must be the
> > base address of the previously allocated array, right?
> > 
> > Well yes, until we try to honour the disabling of devices via Device Tree
> > for instance.  If the first child device in the provided batch is disabled,
> > simply skipping registration (and consequentially deregistration) will mean
> > that the first device's 'usage_count' pointer will not be accounted for when
> > attempting to find the base.  In which case, MFD will assume the first non-
> > disabled 'usage_count' pointer is the base and subsequently attempt to
> > erroneously free it.
> > 
> > We can avoid all of this hoop jumping by simply allocating memory to each
> > single child device before it is considered read-only.  We can then free
> > it on a per-device basis during deregistration.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/mfd-core.c | 42 ++++++++++++++++++------------------------
> >  1 file changed, 18 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 23276a80e3b4..eafdadd58e8b 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -404,7 +398,7 @@ int mfd_clone_cell(const char *cell, const char **clones, size_t n_clones)
> >  		cell_entry.name = clones[i];
> >  		/* don't give up if a single call fails; just report error */
> >  		if (mfd_add_device(pdev->dev.parent, -1, &cell_entry,
> > -				   cell_entry.usage_count, NULL, 0, NULL))
> > +				   NULL, 0, NULL))
> 
> I think this change is broken.
> 
> Cloned cells are supposed to share the same reference counter as their
> template and this change results in each clone having its own counter.
> That means the "the 2 consumers who actually use it" will both end up
> calling cs5535_mfd_res_enable() (and whichever loses the race will fail
> to probe).
> 
> To be honest it might be easier to move the request_region() into
> cs5535_mfd_probe() and rip out the entire reference counting mechanism
> since at that point it would be unused (the other callers of
> mfd_cell_enable() look safe w/o a counter).

Thanks for the review.  Great point(s).

I will fix this and submit a v2 shortly.

> >  			dev_err(dev, "failed to create platform device '%s'\n",
> >  					clones[i]);
> >  	}

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
