Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEB720883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHKtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:49:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36260 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:49:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so10781046ljg.3;
        Mon, 08 Apr 2019 03:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNvDnWFUi7oLGJe16w2MEZduBWFKJmeFIcfhrdOnJDs=;
        b=bTewvL30Pf38VUGM/kH40tI0cq6iLvKOG/1dJk3vhaq7BXYFhvscxWFn7/0R91H4Eq
         Dbi7ddEV2/0EplOHFP9opUJSIMgD2PLKxf59PHVMAoHRfmmKvAawqfjq4yoyQXK4oPUl
         nRIT9odRh4i8l3+nnJ2fOICQHZxVxHu9ZvsS/i9goRFY4L8uAxaoYYHXF22bl75kfN3a
         Lz57qvq8L3a9VYhwLT9zvQV5vZn4GNYD8ig8l4DAmbTXyCjB+whhYlV0SnjwB27+DiCz
         Mg0XmjTX8/twmNwhf2jTYcHP/BoYcox84mc0RXggek9eEgI1noliRO+vJrec2o8twwDl
         ao7A==
X-Gm-Message-State: APjAAAUAYm5CxXBNLIHqvdkw3B+IiTjX0gCdXI35eLhdCfsEEAnC/1Qc
        bi73/r3CCq+H9vTV6TR3Pc8=
X-Google-Smtp-Source: APXvYqwHttfHKKm2freCA2Ns3K+ko26f7zr2gbmnMdH4qyCIe97xAMBbTDSvlX1x3GcyPwASojCH/w==
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr15140111lji.94.1554720584710;
        Mon, 08 Apr 2019 03:49:44 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q77sm5903847lje.11.2019.04.08.03.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 03:49:44 -0700 (PDT)
Date:   Mon, 8 Apr 2019 13:49:41 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks
 list
Message-ID: <20190408104941.GB17594@localhost.localdomain>
References: <20190404215344.6330-1-sboyd@kernel.org>
 <20190404215344.6330-2-sboyd@kernel.org>
 <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com>
 <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 01:37:24PM -0700, Stephen Boyd wrote:
> Quoting Vaittinen, Matti (2019-04-04 23:51:43)
> > On Thu, 2019-04-04 at 14:53 -0700, Stephen Boyd wrote:
> > > We recently introduced a change to support devm clk lookups. That
> > > change
> > > introduced a code-path that used clk_find() without holding the
> > > 'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
> > > list and so we need to prevent the list from being modified while
> > > iterating over it by holding the mutex. Similarly, we don't need to
> > > hold
> > > the 'clocks_mutex' besides when we're dereferencing the clk_lookup
> > > pointer
> > 
> > /// Snip
> > 
> > > -out:
> > > +static struct clk_lookup *clk_find(const char *dev_id, const char
> > > *con_id)
> > > +{
> > > +     struct clk_lookup *cl;
> > > +
> > > +     mutex_lock(&clocks_mutex);
> > > +     cl = __clk_find(dev_id, con_id);
> > >       mutex_unlock(&clocks_mutex);
> > >  
> > > -     return cl ? clk : ERR_PTR(-ENOENT);
> > > +     return cl;
> > > +}
> > 
> > I am not an expert on this but reading commit message abowe and seeing
> > the code for clk_find() looks a bit scary. If I understand it
> > correctly, the clocks_mutex should be held when dereferencing the
> > clk_lookup returned by clk_find. The clk_find implementation drops the
> > lock before returning - which makes me think I miss something here. How
> > can the caller ever safely dereference returned clk_lookup pointer?
> > Just reading abowe makes me think that lock should be taken by whoever
> > is calling the clk_find, and dropped only after caller has used the
> > found clk_lookup for whatever caller intends to use it. Maybe I am
> > missing something?
> > 
> 
> The only user after this patch (devm) is doing a pointer comparison so
> it looks OK. But yes, in general there shouldn't be users of clk_find()
> that dereference the pointer because there isn't any protection besides
> the mutex.

If the only (intended) user for clk_find is devm_clk_release_clkdev,
then we might want to write it in devm_clk_release_clkdev - just to
avoid similar errors (as I did with devm) in the future? I might even
consider renaming __clk_find to clk_find or to clk_find_unsafe - but
that's all just nitpicking :) Go with what you like to maintain :D

Best regards
    Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
