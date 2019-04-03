Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7D9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085B220830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554298301;
	bh=i+csG34p3l522y2X6/WNOz0nkBgh+Pgqokr3JLyYuR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v+idBiiXOGaW4JSThG9Qy06MQ6zPNPndCtuScwYfokUdvs6JHasDR2mdZ7QtKrFrR
	 TBUNXroxLjsRHVeOTzEwjLPfxEq2vojJ5GMc/hYBt70RMmz7uxj5LdwPdn960Saoay
	 Jn6G9awI+XpTmwLYCLuIIWm2eJN0k67fTXE7bokU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDCNbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfDCNbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:31:39 -0400
Received: from localhost (217-101-180-136.cable.dynamic.v4.ziggo.nl [217.101.180.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF7D20830;
        Wed,  3 Apr 2019 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554298298;
        bh=i+csG34p3l522y2X6/WNOz0nkBgh+Pgqokr3JLyYuR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hoDZNtXZQIfXjhSLhe/YlXFfx3OPSl2emZhVu9VnT9WZ6eVZMnkWGIC56shW6vaAX
         otz1er5i5jZO7Lspf+0jPpuZYw/yxxsAl4fca5yF++oNLU9uTAv3WOfms148wLG1c8
         JZjVAJViPZI4Bk80tvqU7D9YFStm44Dm+ZaZx4kE=
Date:   Wed, 3 Apr 2019 15:12:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH] tty: Add NULL TTY driver
Message-ID: <20190403131213.GA4246@kroah.com>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403113327.3628-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 01:33:27PM +0200, Vincent Whitchurch wrote:
> If no console driver is enabled (or if a non-present driver is selected
> with something like console=null in an attempt to disable the console),
> opening /dev/console errors out, and init scripts and other userspace
> code that relies on the existence of a console will fail.  Symlinking
> /dev/null to /dev/console does not solve the problem since /dev/null
> does not behave like a real TTY.
> 
> To just provide a dummy console to userspace when no console driver is
> available or desired, add a ttynull driver which simply discards all
> writes.  It can be chosen on the command line in the standard way, i.e.
> with console=ttynull.

If they have a broken system that sets "console=null", why would they
know to fix it to be "console=ttynull"?

I'm all for adding new functionality, but to provide kernel code because
userspace just isn't configured properly, that feels really wrong to me.

Now if this were to be the "default" if nothing is set up at all, that
might make a bit more sense, but as-is, this doesn't seem very useful.

thanks,

greg k-h
