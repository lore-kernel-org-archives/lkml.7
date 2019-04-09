Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9292C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A8D20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OyxosXHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDII5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:57:25 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44266 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDII5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7AvcGG11AZVIwBXsaMwvHO+S93qpkM4EoNfUPzLqGvc=; b=OyxosXHQtKi/QjmmBT4leOxJB
        NauaYVCtVpZPJrslgc3mdNbxZ8K0E12EhWRedfgh5IMNZK8gozDZlcnxKDjA3brBYExVDTtQEDAEK
        Ax4PkaWtHwJ/kIfur7KPG60zNb3DOrOmhtwPQeZnoca5MqHiq82kspYZLaLpfuC1DhHd5efN+pTZx
        Zjsbpvcco+bbb0ETzQpUPpSu37Jdtv8g6tPWDBUj1g7dg6sfK6kpGwp0o8/dpx+/u6mxE3moAMeA1
        5M81IWmTNhV9V598mD6qV3rbiwbtLKWEOMOrPmXNcJDgdt+o1cJMgLMM2XjobU+6/8Qo/7F4tNPmC
        4On6O9t3w==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37690)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hDmZE-0005sh-Aw; Tue, 09 Apr 2019 09:57:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hDmZB-00025c-LU; Tue, 09 Apr 2019 09:57:17 +0100
Date:   Tue, 9 Apr 2019 09:57:17 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks
 list
Message-ID: <20190409085717.d24c636fuzpoxume@shell.armlinux.org.uk>
References: <20190404215344.6330-1-sboyd@kernel.org>
 <20190404215344.6330-2-sboyd@kernel.org>
 <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com>
 <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com>
 <20190408104941.GB17594@localhost.localdomain>
 <155474280295.20095.182612336816713159@swboyd.mtv.corp.google.com>
 <20190408222106.ect7nwjsklzhmdwj@shell.armlinux.org.uk>
 <4e63d42b27bc5bdf7d991c00f9105ba96a34dc8a.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e63d42b27bc5bdf7d991c00f9105ba96a34dc8a.camel@fi.rohmeurope.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 05:31:48AM +0000, Vaittinen, Matti wrote:
> On Mon, 2019-04-08 at 23:21 +0100, Russell King - ARM Linux admin
> wrote:
> > On Mon, Apr 08, 2019 at 10:00:02AM -0700, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2019-04-08 03:49:41)
> > > > On Fri, Apr 05, 2019 at 01:37:24PM -0700, Stephen Boyd wrote:
> > > > > Quoting Vaittinen, Matti (2019-04-04 23:51:43)
> > > > > > On Thu, 2019-04-04 at 14:53 -0700, Stephen Boyd wrote:
> > > > > > > We recently introduced a change to support devm clk
> > > > > > > lookups. That
> > > > > > > change
> > > > > > > introduced a code-path that used clk_find() without holding
> > > > > > > the
> > > > > > > 'clocks_mutex'. Unfortunately, clk_find() iterates over the
> > > > > > > 'clocks'
> > > > > > > list and so we need to prevent the list from being modified
> > > > > > > while
> > > > > > > iterating over it by holding the mutex. Similarly, we don't
> > > > > > > need to
> > > > > > > hold
> > > > > > > the 'clocks_mutex' besides when we're dereferencing the
> > > > > > > clk_lookup
> > > > > > > pointer
> > > > > > 
> > > > > > /// Snip
> > > > > > 
> > > > > > > -out:
> > > > > > > +static struct clk_lookup *clk_find(const char *dev_id,
> > > > > > > const char
> > > > > > > *con_id)
> > > > > > > +{
> > > > > > > +     struct clk_lookup *cl;
> > > > > > > +
> > > > > > > +     mutex_lock(&clocks_mutex);
> > > > > > > +     cl = __clk_find(dev_id, con_id);
> > > > > > >       mutex_unlock(&clocks_mutex);
> > > > > > >  
> > > > > > > -     return cl ? clk : ERR_PTR(-ENOENT);
> > > > > > > +     return cl;
> > > > > > > +}
> > > > > > 
> > > > > > I am not an expert on this but reading commit message abowe
> > > > > > and seeing
> > > > > > the code for clk_find() looks a bit scary. If I understand it
> > > > > > correctly, the clocks_mutex should be held when dereferencing
> > > > > > the
> > > > > > clk_lookup returned by clk_find. The clk_find implementation
> > > > > > drops the
> > > > > > lock before returning - which makes me think I miss something
> > > > > > here. How
> > > > > > can the caller ever safely dereference returned clk_lookup
> > > > > > pointer?
> > > > > > Just reading abowe makes me think that lock should be taken
> > > > > > by whoever
> > > > > > is calling the clk_find, and dropped only after caller has
> > > > > > used the
> > > > > > found clk_lookup for whatever caller intends to use it. Maybe
> > > > > > I am
> > > > > > missing something?
> > > > > > 
> > > > > 
> > > > > The only user after this patch (devm) is doing a pointer
> > > > > comparison so
> > > > > it looks OK. But yes, in general there shouldn't be users of
> > > > > clk_find()
> > > > > that dereference the pointer because there isn't any protection
> > > > > besides
> > > > > the mutex.
> > > > 
> > > > If the only (intended) user for clk_find is
> > > > devm_clk_release_clkdev,
> > > > then we might want to write it in devm_clk_release_clkdev - just
> > > > to
> > > > avoid similar errors (as I did with devm) in the future? I might
> > > > even
> > > > consider renaming __clk_find to clk_find or to clk_find_unsafe -
> > > > but
> > > > that's all just nitpicking :) Go with what you like to maintain
> > > > :D
> > > > 
> > > 
> > > Sure. I was thinking along the same lines after you asked.
> > 
> > This is rubbish.  The reason clk_find() doesn't take the lock is that
> > you _need_ to hold the lock while you dereference the clk_lookup
> > data.
> 
> I think we all agreed on this already. Stephen pointed out that the
> current user(s) of clk_find() do _not_ dereference the pointer.

Which is actually another incorrect statement - clk_get_sys()
dereferences it, but Stephen's patch does rearrange the code there.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
