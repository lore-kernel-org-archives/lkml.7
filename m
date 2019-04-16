Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E902C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D94223FA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424634;
	bh=MyDUAMdE2UVqG6u26F/4EtyZAVIYop3lVZCXBzWTYMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uDVx13X8+QdtYOY3obaEwXbVG5vjOtSioLMDtwcsFD/meFz4P9ans8Xg6B+Uqt6kb
	 Zz0WUZIYhQbc8+nYcLoYgjrcZvW3eKhxKGC1BJTpF/EldiOw+zxHiqG2WrmOjCMR7Y
	 DY2QG8KwZCv83kH6Cgz/pA9nRwfi4XTY/DeX4yOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfDPOXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfDPOXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:23:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C121223F9;
        Tue, 16 Apr 2019 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424632;
        bh=MyDUAMdE2UVqG6u26F/4EtyZAVIYop3lVZCXBzWTYMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KuvT9NuNvAl5WweHXPb59dmvE1+RXnlpBQkpS5E6S62AEsNHUIhLgSacvHXrzGxa0
         ppEEIg77oqFa6Wyyshs7f+e82y2x7qo4fRTzT9r26mlPSlJzYR3hAZA4M7WPbUgziK
         5oc/F8Foi+cnTZluWYx8xV2e6o8dMB8GK01O7aUg=
Date:   Tue, 16 Apr 2019 16:23:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel Development <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 64/76] parisc: Detect QEMU earlier in boot process
Message-ID: <20190416142350.GB31920@kroah.com>
References: <20190415183707.712011689@linuxfoundation.org>
 <20190415183726.478117691@linuxfoundation.org>
 <e99d8712-6352-a94c-74c7-395b66293b9f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99d8712-6352-a94c-74c7-395b66293b9f@gmx.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:50:16PM +0200, Helge Deller wrote:
> Hi Greg,
> 
> please do NOT apply this patch to the 4.9 tree.
> See below, it was tagged for v4.14+ only.

Yes, but I added it to 4.9 because:

> > commit d006e95b5561f708d0385e9677ffe2c46f2ae345 upstream.
> >
> > While adding LASI support to QEMU, I noticed that the QEMU detection in
> > the kernel happens much too late. For example, when a LASI chip is found
> > by the kernel, it registers the LASI LED driver as well.  But when we
> > run on QEMU it makes sense to avoid spending unnecessary CPU cycles, so
> > we need to access the running_on_QEMU flag earlier than before.
> >
> > This patch now makes the QEMU detection the fist task of the Linux
> > kernel by moving it to where the kernel enters the C-coding.
> >
> > Fixes: 310d82784fb4 ("parisc: qemu idle sleep support")

This commit is in 4.9.76.  So why wouldn't it be valid in 4.9.y (with
the exception of the fact that it doesn't build...)?

thanks,

greg k-h
