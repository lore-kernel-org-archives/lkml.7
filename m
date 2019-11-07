Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88268C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D112187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573136261;
	bh=kj/zDEFUeE9Rv7iNW1qq6DtsQCfrs+zOavoixL7CR44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oIo97wIBfIzy+vP7G6e+ASsPPjYoHPut5i/vliHc6tPa4wYzakYX5dhUC7BiUIMYx
	 lOhY2Vmuzax5UJ5FUwm11mGTSvl42F795prSuKYLM66eufIA46LLpv2y8m63ryxtPv
	 YRJx3/SWZc3l8qwVEHW3a5kn0xnPrAgE/u5TUZfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbfKGORk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfKGORk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:17:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6853D2178F;
        Thu,  7 Nov 2019 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573136258;
        bh=kj/zDEFUeE9Rv7iNW1qq6DtsQCfrs+zOavoixL7CR44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9lAHV48TxsfsgdM158pewo5vHRrRxfIerJuafqYswJpuQOub7PHwc5J9ZI4qalnM
         GElN2iktgVmcWeNPYkmYmCPt8uUgzi7MA8Wy2waX85c38diO7h8mqHsgyXzRThyo0v
         nZvM6RMBkKro6I3r/jORIsMZD3Yymb8bFCQz6/+0=
Date:   Thu, 7 Nov 2019 15:17:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [GIT PULL] fsi changes for 5.5
Message-ID: <20191107141736.GA109902@kroah.com>
References: <CACPK8XdtyQhK6OHJKbP=Fk50jRQQZeWzxqKDbX6kW0S5=eGuTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdtyQhK6OHJKbP=Fk50jRQQZeWzxqKDbX6kW0S5=eGuTg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 12:09:50PM +0000, Joel Stanley wrote:
> Hi Greg,
> 
> Here's a set of changes I'd like merged for 5.5. They've been well
> tested in the openbmc tree over the past month or so as we've done
> hardware bring up using them. Aside from the three fixes I applied
> today they have seen time in linux-next too.
> 
> This is the first time I've sent you a pull request, so please let me
> know if you'd prefer it done differently.
> 
> The following changes since commit 755b0ef68f1802c786d0a53647145a5a7e46052a:
> 
>   fsi: aspeed: Clean up defines and documentation (2019-11-07 22:24:18 +1030)

The pull request looks good, but some of the individual patches, I have
questions on.  Also, a diffstat would be good so that I know I got it
right for the next time you send this.

As they aren't here in the emails, let me try to figure out how to
respond:
	- You have new dt bindings, yet no review from the DT
	  maintainers.
	- you move things around in sysfs, yet no documentation updates
	  happen
	- in 0005-fsi-Add-ast2600-master-driver.patch you have lots of
	  dev_dbg() lines left that shoudl be dropped as that's what
	  ftrace is for
	- you don't have any reviewers for some of these patches, that's
	  not good to stick in a pull request.
	- 0007-fsi-aspeed-Fix-OPB0-byte-order-register-values.patch does
	  not have a Fixes: tag, nor a stable@vger cc:, why not?
	- 0010-fsi-fsi_master_class-can-be-static.patch has no changelog
	  text at all, which is not ok.

Can you fix all of this up, and send it as a set of normal patches so at
least I can review the things that do not have any other reviewers on
it?

thanks,

greg k-h
