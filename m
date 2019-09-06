Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C832A20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYWVllhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405104AbfIFWea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:34:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33829 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbfIFWea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:34:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so4316346pgc.1;
        Fri, 06 Sep 2019 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZpqMRDsEnWje8qDdOAN5oOPxtbn7bHOIOEWjxUrvi7s=;
        b=tYWVllhYKlMDZ2r7Wq7TnUhivSFF+Sy0Oi2/oJKauDogucHUjLMQsnKymMRmtDFw9w
         16yOKhr5U4093WUFM1MRWsMBKzbUZVdTvL5yrlNBYBrLA/xZoVOXYPk73fHBd5cZj8P4
         x73pFGmseM/d2+25erHgnC0QzWjj4JCmjtBihuupAf2GWRDvyFM1fcc4pCwdE9G3a5eR
         0SbKcNBkdZZhV9zZAVzUnTdS8x4t69uarKTv8b0EC3Ojqy3jq0ci9ky4iKriiKrvIzKi
         M5uf8SvvjYXgTOU8kGMUyQIl6CFjlvmURqqOFABwhPc7cMgIE4lPmm48qTCFhSCqeQ0X
         g1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZpqMRDsEnWje8qDdOAN5oOPxtbn7bHOIOEWjxUrvi7s=;
        b=nYjXnGNgP6AAgdHEXqfsGIz1qQx+tmS7WHgYE1F3PiER2MdXSXGn8L/Zr3bAL5Xn3o
         YJZFzyzFtwGmkBcrX6mu4KZs1WF3xAjlwmw2ioqQ/6wIzC2CHnTtcykhEyUvmVEegQdK
         598oB7qfx0mvLAtkuepreWqtQb8LDbtWSfSEasdgarwAaOhYMiPtZ1II/GNVtOAKeUVK
         Z+BILw8IMFY+cLtGgNkUVFEuRjMjx8ZSNXPYJh+UjDBoXHoocZ613RzhCy4XIXCOUkUq
         8/mG4dTfKr77hb5dMtGM/TeSkC8Z63gq/SaDTyaY+Bwn/Ivejv1wBFUxeST33lcE19g8
         /oTg==
X-Gm-Message-State: APjAAAWOs8TkDzqi3pPTF3eRerC2qOEq7P8dNkXcb/3xS3Rn9/vWsLlv
        F40GmV8jMa1nOJnSz6gXvrA=
X-Google-Smtp-Source: APXvYqwSwgbEqyupt+cgiLhsx1UPtyF+6lcx0Ugziqs9xtFa+lewzuAyx1CIMH5ZhDQLnyXD56As3g==
X-Received: by 2002:a62:75d2:: with SMTP id q201mr13434294pfc.43.1567809269057;
        Fri, 06 Sep 2019 15:34:29 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x9sm5223601pgp.75.2019.09.06.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:34:28 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:34:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/3] software node: implement reference properties
Message-ID: <20190906223426.GT187474@dtor-ws>
References: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
 <20190906122743.GQ2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906122743.GQ2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:27:43PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 05, 2019 at 09:38:07PM -0700, Dmitry Torokhov wrote:
> > It is possible to store references to software nodes in the same fashion as
> > other static properties, so that users do not need to define separate
> > structures:
> > 
> > const struct software_node gpio_bank_b_node = {
> > 	.name = "B",
> > };
> 
> Why this can't be __initconst?

It may or it may not. I'll remove __inticonst from below as well to not
confuse things.

> 
> > const struct property_entry simone_key_enter_props[] __initconst = {
> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > 	{ }
> > };
> 
> So it's basically mimics the concept of phandle, right?

Yes.

> 
> > +		ref_args = prop->is_array ?
> > +				&prop->pointer.ref[index] : &prop->value.ref;
> 
> Better to do if with explicit 'if ()' as it's done in the rest of the code.
> 
> 	if (prop->is_array)
> 		ref_args = ...;
> 	else
> 		ref_args = ...;

OK, it will be gone actually.

> 
> > -	DEV_PROP_MAX,
> > +	DEV_PROP_MAX
> 
> It seems it wasn't ever used, so, can be dropped completely.

OK.

> 
> > @@ -240,6 +255,7 @@ struct property_entry {
> >  			const u32 *u32_data;
> >  			const u64 *u64_data;
> >  			const char * const *str;
> > +			const struct software_node_ref_args *ref;
> >  		} pointer;
> >  		union {
> >  			u8 u8_data;
> > @@ -247,6 +263,7 @@ struct property_entry {
> >  			u32 u32_data;
> >  			u64 u64_data;
> >  			const char *str;
> > +			struct software_node_ref_args ref;
> 
> Hmm... This bumps the size of union a lot for each existing property_entry.
> Is there any other way? Maybe we can keep pointer and allocate memory for it
> when copying?

Right, I think we can always store references as arrays, even when we
only need single entry, thus we do not need to increase the size of the
structure.

I just posted v2 implementing that, please take another look.

Thanks.

-- 
Dmitry
