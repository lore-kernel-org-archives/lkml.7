Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA3C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJplduLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392981AbfIGRh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:37:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37262 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392520AbfIGRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:37:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so3847747pfo.4;
        Sat, 07 Sep 2019 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmtTMtCRHXQkcD6mr0VeqyrZqlBycsF5/nM1vue7H+8=;
        b=rJplduLGDf4fqgHaIss9wjJ6B2xyohXHLiBWJbgXzIjnm0k1LTHT0YqPCKcaszgYSh
         oJbUtgThxnY7MsyqbEuk9l2o+IM9kbpcdN6VWx6BdvKGPvAfDEDC+DU/R9FACbeCeS1u
         LLQKXNSe2CJVMlAJ2prBj7fZUPdLuUmweqvHx73yq/Z944xiwNN/E6Ba53LcqToK45sy
         KGct7VrJGNefLsSxWMIn5xlqIMsCoVcumfP3FxrKCkl1V2yAwDOKOCPz1UsA8Sn0N15h
         ebdZc2qC1MU2K7Op17OppUDcfNUfQD+vRdKNByxwy7PAxflS5EPVGTOTprl3zCd40WfX
         RC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmtTMtCRHXQkcD6mr0VeqyrZqlBycsF5/nM1vue7H+8=;
        b=H0wez8bTvA88g+FwVRtCN7nhJUkmh9SH3BU1UEhxLoNeNNZ/54YSCPJWbY+14kr1B4
         55Wr13Qx/FbTr0sxCqR3rEZRvtqCEZfC3up0uI9Em3KUUrjqfiRUPWnK6x9jLPt/XJ9n
         gkHfaR9tjiARXdyEfDa02PYnJA8blA/MskqKnatLSztXMxL9g24ltauiA7SA9UJnn88n
         Xc6Sy7+TiVEnBZ/KTR02Tlda/W3CFlgQwtLh6eljOa9uHbfgSBL73SGFe+1vdCXIJx0z
         8rD/7OqWEi0DB6/lkREM90qSx4FoclYN1qR+MWcqpl8wYX6GMNHjes9NpIaUMcqq4O3z
         jBjw==
X-Gm-Message-State: APjAAAWllcyWoQz091BKsa3Y11Cm3POH8QJ1VkFwzNNvFrul7RwQ253V
        UkmNp36gvcycrCowJX7ZY8732ziU
X-Google-Smtp-Source: APXvYqzhoyFkgwajRfjIdUrkeCnUjGm4bqYwojIgJe2xKEXLxtsfWp772hVXqud1TTzozz2bQxNw9Q==
X-Received: by 2002:a65:6104:: with SMTP id z4mr13201717pgu.27.1567877847273;
        Sat, 07 Sep 2019 10:37:27 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h18sm10325391pfn.53.2019.09.07.10.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 10:37:26 -0700 (PDT)
Date:   Sat, 7 Sep 2019 10:37:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/3] software node: implement reference properties
Message-ID: <20190907173724.GA145199@dtor-ws>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
 <20190907160819.GH2680@smile.fi.intel.com>
 <20190907163240.GA27112@dtor-ws>
 <20190907171251.GL2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907171251.GL2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 08:12:51PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 07, 2019 at 09:32:40AM -0700, Dmitry Torokhov wrote:
> > On Sat, Sep 07, 2019 at 07:08:19PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 06, 2019 at 03:26:09PM -0700, Dmitry Torokhov wrote:
> 
> > > > +	} else if (src->type == DEV_PROP_REF) {
> > > > +		/* All reference properties must be arrays */
> > > > +		return -EINVAL;
> > > 
> > > Hmm... What about to duplicate pointer under value union and use is_array to
> > > distinguish which one to use? Because...
> > 
> > Then we have to special-case copying this entry, similar to the pains we
> > are going with the strings.
> 
> I can't see it as a pain. Simple do the same kmemdup() for the case when
> is_array = false and DEV_TYPE_REF?

And then you need to make sure it is freed on error paths and when we
remove property entries. This requires more checks and code. In contrast
we already know how to handle out of line objects of arbitrary size.

The only reason we have inline strings is because for shorter strings we
save 4/8 bytes.

> 
> By the way, don't we need to update property_entry_{get,set}_pointer()?

I do not see these, where are they?

> 
> > > > +	.is_array = true,						\
> > > 
> > > I really don't like this "cheating".
> > 
> > This is not cheating. Any single value can be represented as an array of
> > one element. Actually, the only reason we have this "is_array" business
> > is because for scalar values and short strings it is much cheaper to
> > store single value in-line instead of out of line + pointer, especially
> > on 64 bit arches.
> 
> Yes, and this is a lot of benefit!

Yes, nobody argues against it. Here however we are dealing with a larger
structure. There is absolutely no benefit of trying to separate single
value vs array here.

> 
> > If you want we can change is_array into is_inline.
> 
> Nope, is_array is exactly what it tells us about the content. Its functional
> load is to distinguish which union (value vs. pointer) we are using.

No, it signifies whether the value is stored within property entry or
outside. I can fit probably 8 bytes arrays into property entry
structure, in which case is_array will definitely not reflect the data
type.

It is the type-specific accessors that know how to parse and fetch data
from properties.

Thanks.

-- 
Dmitry
