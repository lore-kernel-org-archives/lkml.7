Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1EC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD39B21848
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEWQKA90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390672AbfIGSXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:23:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbfIGSXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:23:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so5351257pgb.10;
        Sat, 07 Sep 2019 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNmnr8j4Midw6a4fHrsIWOmTAQZnvdsrSLr43KAtD6U=;
        b=hEWQKA907qDPd2l8hrFkpE5yxWf3PthLgm5pqh8njd1Qj4j6DAR2MtK6pKi5/g0rtP
         858OkNlDEZkqLAsd/k1VQzJrN8+QRtBAtf3Q/q8+QIGCSppFQNoVnQ6Jc3p5Sz6hqVr5
         zTIfkTvW/fspreapeTmlRiiWjKyLb8BMSdMwQLMq7lvhzywGlJFbrteJVmo01iQDzL0U
         A2ke59whOFX1UKLbY0NE7bOP6t8r/ndgdUxOhXiNWV7y1k2Lye+edSrH7/fHIMS5rYJb
         FfKPtsrdSicneVecy9re0ZXL1CrCiHvsm2scZcW/WLSWg5qKNQvrz3Rpr6cEJACpPYwR
         oBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNmnr8j4Midw6a4fHrsIWOmTAQZnvdsrSLr43KAtD6U=;
        b=NwK6dYcCCwnAZX4PWakfxw46jgBrD0vtoL30eLgc3cNkNsXp63rfHzMFqu7bJONsy1
         Mw4WaEwMaAu1jxfKtCTWbHgXkIM4LhuERJW3QLZ/gVu6+WdkF5DnM2Wu6vH8aK9aSm74
         WZR/Ib82mPtBMEkAhDUwtOcmPX7KKfyLXUYrei6h9sjDzYQQsHMFshVMdV2Yy8GWOvEY
         1oJGTTjiZceyDG9rubtNzj1Gx3Ts4u49XaOSNSzxh+ZpFXaAk9uLQnd/ZysFpfXNhlHW
         WOAh5/cTbzAtomFmhgWyYeFgK1/jTSTx7gkPXLhJvMxYGMsnLdoYjH0iFbCMIPIlICfz
         lEmA==
X-Gm-Message-State: APjAAAXnQq7HzaEmdh408h2cUYFJJkVvEOKaiP4LBkym65o8Jlh/lcdd
        7D/vBw2+hdO/5EtP652Vdnk=
X-Google-Smtp-Source: APXvYqziLylck/M3X5LbRFTKirm/4rQ8AAT+thcLF/pdw2imjn/rFYCjL0TpTJ8Qs33qHSub5spv8w==
X-Received: by 2002:a62:3083:: with SMTP id w125mr18315690pfw.102.1567880618579;
        Sat, 07 Sep 2019 11:23:38 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o42sm2224412pjo.32.2019.09.07.11.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 11:23:38 -0700 (PDT)
Date:   Sat, 7 Sep 2019 11:23:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190907182335.GB145199@dtor-ws>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190907160819.GH2680@smile.fi.intel.com>
 <20190907163240.GA27112@dtor-ws>
 <20190907171251.GL2680@smile.fi.intel.com>
 <20190907173724.GA145199@dtor-ws>
 <20190907180348.GM2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907180348.GM2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 09:03:48PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 07, 2019 at 10:37:24AM -0700, Dmitry Torokhov wrote:
> > On Sat, Sep 07, 2019 at 08:12:51PM +0300, Andy Shevchenko wrote:
> > > On Sat, Sep 07, 2019 at 09:32:40AM -0700, Dmitry Torokhov wrote:
> > > > On Sat, Sep 07, 2019 at 07:08:19PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:
> > > 
> > > > > > +	} else if (src->type == DEV_PROP_REF) {
> > > > > > +		/* All reference properties must be arrays */
> > > > > > +		return -EINVAL;
> > > > > 
> > > > > Hmm... What about to duplicate pointer under value union and use is_array to
> > > > > distinguish which one to use? Because...
> > > > 
> > > > Then we have to special-case copying this entry, similar to the pains we
> > > > are going with the strings.
> > > 
> > > I can't see it as a pain. Simple do the same kmemdup() for the case when
> > > is_array = false and DEV_TYPE_REF?
> > 
> > And then you need to make sure it is freed on error paths and when we
> > remove property entries. This requires more checks and code. In contrast
> > we already know how to handle out of line objects of arbitrary size.
> 
> We can put it one level up to be a sibling to value / pointer unions.
> In that case is_array can be anything (we just don't care).

I think it would be better if you sketched out your proposed data
structure(s) so we are talking about the same things. But please note
that when you are dealing with property arrays we need to keep the easy
way of defining them, which means we should not be splitting individual
entries.

> 
> Actually strings aren't inlined.

Right. Maybe I should clean it up as well.

> 
> > > By the way, don't we need to update property_entry_{get,set}_pointer()?
> > 
> > I do not see these, where are they?
> 
> swnode.c. I meant property_{get,set}_pointer().

Yes, I think you are right about property_set_pointer() at least.

> 
> > > > > > +	.is_array = true,						\
> > > > > 
> > > > > I really don't like this "cheating".
> > > > 
> > > > This is not cheating. Any single value can be represented as an array of
> > > > one element. Actually, the only reason we have this "is_array" business
> > > > is because for scalar values and short strings it is much cheaper to
> > > > store single value in-line instead of out of line + pointer, especially
> > > > on 64 bit arches.
> > > 
> > > Yes, and this is a lot of benefit!
> > 
> > Yes, nobody argues against it. Here however we are dealing with a larger
> > structure. There is absolutely no benefit of trying to separate single
> > value vs array here.
> 
> Thus, moving to upper layer makes more sense. Right?
> 
> > > > If you want we can change is_array into is_inline.
> > > 
> > > Nope, is_array is exactly what it tells us about the content. Its functional
> > > load is to distinguish which union (value vs. pointer) we are using.
> > 
> > No, it signifies whether the value is stored within property entry or
> > outside. I can fit probably 8 bytes arrays into property entry
> > structure, in which case is_array will definitely not reflect the data
> > type.
> 
> Nope, since strings are not inlined AFAICS.

But u64 values are.

Thanks.

-- 
Dmitry
