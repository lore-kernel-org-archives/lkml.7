Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDD1206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAACSMo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394938AbfIGQcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:32:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46328 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392683AbfIGQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:32:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so6522326pfg.13;
        Sat, 07 Sep 2019 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OWKMTVEpcjEgU67HpPrX0ZG66N8BrYaoMAyOS7ISkKw=;
        b=YAACSMo4u3WzOCuq9vZYRponMeG5TUtWEDgBWfe/TC9c4cqYfea+DvSZObHWa6pdj7
         Pe8jbcM+PEovYy1lKjoUxBiZYaYIF2jZGHHmEh08NcFiDNhAYRS3W+4aLhqYjaJ/cnk/
         2BOlurNIp59gDSJdp0JD5HmeYez6Yb78SbbheEH4qZANHgT6lvSmgJf5huBLfWN1Sh8i
         bxXUvaaPRY3dgHI5J9yXD1T2Zcs6pzy7Zc/IaIhWdvpwu7Z8eFUYW9N25Slu9gw520SP
         v0QDigl/lOLbSkWYwausocQxD6JAdD+cyDPToU2QOohsVZJoj1itwxDh6SWbTZ8Bu6mc
         /AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OWKMTVEpcjEgU67HpPrX0ZG66N8BrYaoMAyOS7ISkKw=;
        b=VIidkEbtriuXV2gL5lvzba3vUYXs9VcFCU8CWPoPwZALYO1QnzeEJ6bfoy3aULdwLP
         VE4XXrZIAXAcNxrGnw3SOyw6MnhDjJioG8eWRIKOQmquBQLq4TTuWdtTvAoIsrINHKuj
         kGsSVPe65EaZ7/R48wogddP98EcMZJharPmdtGxTX8xn/WSjnHwC6Bu6tRdHvWnZ0YbY
         UNldEv4YT/YJr7YS1enT1N66JHAYuKhjBNZJbHx/23OAYTubDyTuCtvInbNs1DsziKb2
         ueq2HWh48LpFr/M0VkABUfJf9I/Muc545F9OfvpdBgZ2bSbYFubJ64gLl1D20xAItgiz
         QaOw==
X-Gm-Message-State: APjAAAV7vYnaAlduUkTHLaGz+hwkS4GYyiDVZ6neHeXUVj4jw2m6aolg
        AH7CaVNJfa2g+XGxxm5er5w=
X-Google-Smtp-Source: APXvYqzHa92DDO9jXGHTroP2d6b2wkphlnLlSVKLHITC01IKwgahaaAGNPHPJsuQ6/zKIPGyykwEFA==
X-Received: by 2002:a63:5648:: with SMTP id g8mr13024920pgm.81.1567873963790;
        Sat, 07 Sep 2019 09:32:43 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c125sm13601189pfa.107.2019.09.07.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 09:32:43 -0700 (PDT)
Date:   Sat, 7 Sep 2019 09:32:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190907163240.GA27112@dtor-ws>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190907160819.GH2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907160819.GH2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 07:08:19PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:
> > It is possible to store references to software nodes in the same fashion as
> > other static properties, so that users do not need to define separate
> > structures:
> > 
> > static const struct software_node gpio_bank_b_node = {
> > 	.name = "B",
> > };
> > 
> > static const struct property_entry simone_key_enter_props[] = {
> > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > 	{ }
> > };
> > 
> 
> Thanks for an update, my comments below.
> 
> > +	} else if (src->type == DEV_PROP_REF) {
> > +		/* All reference properties must be arrays */
> > +		return -EINVAL;
> 
> Hmm... What about to duplicate pointer under value union and use is_array to
> distinguish which one to use? Because...

Then we have to special-case copying this entry, similar to the pains we
are going with the strings.

> 
> 
> > @@ -240,6 +254,7 @@ struct property_entry {
> >  			const u32 *u32_data;
> >  			const u64 *u64_data;
> >  			const char * const *str;
> > +			const struct software_node_ref_args *ref;
> >  		} pointer;
> 
> > +#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
> > +(struct property_entry) {						\
> > +	.name = _name_,							\
> 
> > +	.length = sizeof(struct software_node_ref_args),		\
> 
> Is it correct?

Yes, we length is element size * number of elements.

> 
> > +	.type = DEV_PROP_REF,						\
> 
> > +	.is_array = true,						\
> 
> I really don't like this "cheating".

This is not cheating. Any single value can be represented as an array of
one element. Actually, the only reason we have this "is_array" business
is because for scalar values and short strings it is much cheaper to
store single value in-line instead of out of line + pointer, especially
on 64 bit arches.

If you want we can change is_array into is_inline.

Thanks.

-- 
Dmitry
