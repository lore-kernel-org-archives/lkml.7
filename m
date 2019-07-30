Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56806C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C55E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564501913;
	bh=UAJPjXLp6QObQOA1+dhmRl9M72w8AhADPG8lAQIQt8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tEBnwcmuXx/Q9fvbOpl2NH0LoH71Sw8e2cT9vvP2ffybt9tMWdm4Kxgy3LAnUsqyj
	 s2abEU5Ub3EuEALl1kTYH6PI3UWy+4GWtR/4xlfgd7TENvMtR84XACpmWeMciwyvgr
	 +41kn1LZMetUjKba5Hz+TDlB1WR32GoZ2SRSqsWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfG3Pvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3Pvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:51:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133AA20644;
        Tue, 30 Jul 2019 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564501910;
        bh=UAJPjXLp6QObQOA1+dhmRl9M72w8AhADPG8lAQIQt8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZAuOTqNF6yqAXpB0RdOJUizbifavF4BqDssPJVLt1MPm5IP6XJC14xYyYqCFNhRc
         OlDUdOXg7sYVuwI7Xxs5ECm5M4z8ZxOGUtnx81V1SHNSQlw58nRP8l2ncjoZV/bnDL
         1jDj6S55CV36f7CdjMmSkmsCXKcyNUxuYosQs8Xo=
Date:   Tue, 30 Jul 2019 17:51:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v5 2/3] treewide: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190730155148.GA21985@kroah.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-3-swboyd@chromium.org>
 <20190730064917.GB1213@kroah.com>
 <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:35:59AM -0700, Stephen Boyd wrote:
> Quoting Greg Kroah-Hartman (2019-07-29 23:49:17)
> > On Mon, Jul 29, 2019 at 10:38:44PM -0700, Stephen Boyd wrote:
> > > We don't need dev_err() messages when platform_get_irq() fails now that
> > > platform_get_irq() prints an error message itself when something goes
> > > wrong. Let's remove these prints with a simple semantic patch.
> > > 
> > > // <smpl>
> > > @@
> > > expression ret;
> > > struct platform_device *E;
> > > @@
> > > 
> > > ret =
> > > (
> > > platform_get_irq(E, ...)
> > > |
> > > platform_get_irq_byname(E, ...)
> > > );
> > > 
> > > if ( \( ret < 0 \| ret <= 0 \) )
> > > {
> > > (
> > > -if (ret != -EPROBE_DEFER)
> > > -{ ...
> > > -dev_err(...);
> > > -... }
> > > |
> > > ...
> > > -dev_err(...);
> > > )
> > > ...
> > > }
> > > // </smpl>
> > > 
> > > While we're here, remove braces on if statements that only have one
> > > statement (manually).
> > 
> > I like this, and I like patch 1/3, but this is going to conflict like
> > crazy all over the tree with who ever ends up taking it in their tree.
> > 
> > Can you just break this up into per-subsystem pieces and send it through
> > those trees, and any remaining ones I can take, but at least give
> > maintainers a chance to take it.
> 
> Ok. Let me resend just this patch broken up into many pieces.

Thanks.

> > You are also going to have to do a sweep every other release or so to
> > catch the stragglers.
> 
> I was going to let the janitors do that.

We are all janitors :)
