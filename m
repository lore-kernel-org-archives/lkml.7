Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D78820843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557923604;
	bh=VWrSIMxtMzJf0EqTLwNfDFyQZNKkVmMfiMtoWaE8mYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3aJiMdSB7rlYS8y3qCBS8OalyrJ6r6mbBiqmYM10kNdxhybzHnLvRlZN5hornjse
	 mnAdhyJM+GwpHOKiFwLVXDKdQu05ReEsyUQYgwWQF8rBozaz0uu+ICXBbUKeq0/Lzc
	 l9+dk5X6pHWG0uz5tShdcLA/dUoEa7v1aN5+Ss3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfEOMdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfEOMdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:33:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC9720843;
        Wed, 15 May 2019 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557923602;
        bh=VWrSIMxtMzJf0EqTLwNfDFyQZNKkVmMfiMtoWaE8mYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4aXCzp/93XjO1tys4+y8zAvyuzJOmcEbZWeFE4KBExtUqA11G1qL6IlcWOypkl/z
         DEXZ+zIs5y+hdARNrlDdz8MGkIXXYMv1PFPTWVSvPoUoslnuISmp72fSPALWRqqQwG
         deY22jA6+FnhSAQHcEa6NX/Y43bvdmKp5xsLJNwo=
Date:   Wed, 15 May 2019 14:33:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
Message-ID: <20190515123319.GA435@kroah.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
 <20190515114022.GA18824@kroah.com>
 <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:54:58PM +0800, Kai-Heng Feng wrote:
> at 19:40, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, May 15, 2019 at 07:24:01PM +0800, Kai-Heng Feng wrote:
> > > The rtl8821ce can be found on many HP and Lenovo laptops.
> > > Users have been using out-of-tree module for a while,
> > > 
> > > The new Realtek WiFi driver, rtw88, will support rtl8821ce in 2020 or
> > > later.
> > 
> > Where is that driver, and why is it going to take so long to get merged?
> 
> rtw88 is in 5.2 now, but it doesn’t support 8821ce yet.
> 
> They plan to add the support in 2020.

Who is "they" and what is needed to support this device and why wait a
full year?

> > > 296 files changed, 206166 insertions(+)
> > 
> > Ugh, why do we keep having to add the whole mess for every single one of
> > these devices?
> 
> Because Realtek devices are unfortunately ubiquitous so the support is
> better come from kernel.

That's not the issue here.  The issue is that we keep adding the same
huge driver files to the kernel tree, over and over, with no real change
at all.  We have seen almost all of these files in other realtek
drivers, right?  Why not use the ones we already have?

But better yet, why not add proper support for this hardware and not use
a staging driver?

thanks,

greg k-h
