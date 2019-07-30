Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A025FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636642089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564469363;
	bh=Lsl3RqHMrjwokN7eaK+/lMAsA9tj6roAriyHTwAklIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qIc684/6kcG70Kja7onaPsHWDxJutRNJ8kQp6VIHb2QvvYW+jXU3S4YGd/pH+u058
	 H9rmOvYQ4t7V75aEx/QqxNyH0uZUav3RyS4/4q+N1v3KrZyXlYJwZztXslZ2WCS8Hd
	 FawPYhFX8ognHxHEqFEdh0cyEzRjO0e/Co+q6/DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfG3GtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbfG3GtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:49:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A1F2087F;
        Tue, 30 Jul 2019 06:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564469360;
        bh=Lsl3RqHMrjwokN7eaK+/lMAsA9tj6roAriyHTwAklIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u663JfPTPps45y+mpqiwMvawaMkIGThPkUdklUv3MR700R5IQmpyy/m0OyVjyxwtw
         BpsMkz3sosOwZXstLN6u0lRY+vsqpy46CTyeuR5H6NcSQuTn/L6gwD0bHg86hsb/Ri
         IrVQtTlz+UbysJEwNjvJodkr2PJT5KdYbIxRmXho=
Date:   Tue, 30 Jul 2019 08:49:17 +0200
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
Message-ID: <20190730064917.GB1213@kroah.com>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190730053845.126834-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730053845.126834-3-swboyd@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:38:44PM -0700, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).

I like this, and I like patch 1/3, but this is going to conflict like
crazy all over the tree with who ever ends up taking it in their tree.

Can you just break this up into per-subsystem pieces and send it through
those trees, and any remaining ones I can take, but at least give
maintainers a chance to take it.

You are also going to have to do a sweep every other release or so to
catch the stragglers.

thanks,

greg k-h
