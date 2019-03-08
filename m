Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0F7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72236214AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552064713;
	bh=Ho5aTKGFV5yb5Y+QfOZ5dT6bGWYeXab2mibTdldN4kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I2ELrhBrE2spj8nD5H9XOcHu4UXnOWoo/hrJP5ngca7kIpTRE5XfUJ9AAAVPdszYs
	 h8vlDANEUSpLVELXCAyGV1yrlL624bHC/KnVj+ZQM/qzndivmOJSekduZetQmOmgr4
	 v9fxbBX1QhC1VQgBsP8cIQwRTuKsctOYcuVd7rVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCHRFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfCHRFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:05:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4EF720868;
        Fri,  8 Mar 2019 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552064711;
        bh=Ho5aTKGFV5yb5Y+QfOZ5dT6bGWYeXab2mibTdldN4kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWf5a6V1UY2aJGPuDZMUDTBjqZAwu6yF1YmX7jS18zDQx+j6mqYU09eqhjVupiu+S
         ZYz0lcDnBxjEmq0wAfEV4fPr3aNu/0o1uxSyclpRYykySuag1N42uM6jckERFTM4ZV
         EGQdmeLGnFTbaO7zxeYPovdBHe2IzImIC0iEp9Vk=
Date:   Fri, 8 Mar 2019 17:34:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Calvin Owens <calvinowens@fb.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] printk: Add consoles to a virtual "console" bus
Message-ID: <20190308163411.GA12898@kroah.com>
References: <cover.1551486732.git.calvinowens@fb.com>
 <087b13f7812b32cc7c3f9efea71c9bcf324dd031.1551486732.git.calvinowens@fb.com>
 <87ef7ioyzw.fsf@linutronix.de>
 <20190308155814.rzsjrzgwfcm4p5sk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308155814.rzsjrzgwfcm4p5sk@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 04:58:14PM +0100, Petr Mladek wrote:
> On Fri 2019-03-08 03:56:19, John Ogness wrote:
> > On 2019-03-02, Calvin Owens <calvinowens@fb.com> wrote:
> > > This patch embeds a device struct in the console struct, and registers
> > > them on a "console" bus so we can expose attributes in sysfs.
> > 
> > I expect that "class" would be more appropriate than "bus". These
> > devices really are grouped together based on their function and not the
> > medium by which they are accessed.
> 
> Good point. "class" looks better to me as well.
> 
> Greg, any opinion, where to put the entries for struct console ?

Hang them off of the device that the console belongs to?

Classes and busses are almost identical except:
	- busses is the binding of a driver to a device (usb, pci, etc.)
	- classes are usually userspace interactions to a device (input,
	  tty, etc.)

So this sounds like a class to me.

If you want me to review this, I'll be glad to so do once 5.1-rc1 is
out...

thanks,

greg k-h
