Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE1FC43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8098524658
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 11:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576322900;
	bh=81hWOd6Qqqxwb56zYhk0nrhWVt4JaFtoYSXNMBLaUEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vxfuuw2+mREyLArFilqm75hEKE77/zgYymSMBkz1VVnR4PV/MUweohHjfxv58qi0X
	 xbXGAiaz3BIuWR3R31hzPmnXOwvJbn8gonQJsQDFESF50uaaitIvr5AwzXuRQpAAO3
	 8jpdPoPetK2XvDaAFyqvw7HywTwhnfToJkNkDu+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLNL2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 06:28:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfLNL2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 06:28:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E412720706;
        Sat, 14 Dec 2019 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576322898;
        bh=81hWOd6Qqqxwb56zYhk0nrhWVt4JaFtoYSXNMBLaUEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3p2LPHCw+yBV8HQTMhza/sHPmmQ/F1fcfYqntv3wJzGQxeUHwKhYvje6R8nHzqQM
         pGITV30s/Sdl/k0JF+1iJf7DBq6ZQDOhlyf6/wFj68ieeqQyWcJtse05Jh4V2GRCpC
         fKka8eIHGWX8ZQVlWRGjjJ+H8Kt9GGTQpReC7c1s=
Date:   Sat, 14 Dec 2019 12:28:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Moses Christopher <moseschristopherb@gmail.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, devel@driverdev.osuosl.org
Subject: Re: [PATCH v1 6/7] staging: axis-fifo: add unspecified HAS_IOMEM
 dependency
Message-ID: <20191214112815.GA3335535@kroah.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211192742.95699-7-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:27:41AM -0800, Brendan Higgins wrote:
> Currently CONFIG_XIL_AXIS_FIFO=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> ld: drivers/staging/axis-fifo/axis-fifo.o: in function `axis_fifo_probe':
> drivers/staging/axis-fifo/axis-fifo.c:809: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Saying you reported a problem and then fixed it kind of does a bit of
disservice to the "reported-by:" tag which we normally use only to
credit the people that do not actually fix the problem.

So in the future, no need for this to be there for patches that you
write yourself.

thanks,

greg k-h
