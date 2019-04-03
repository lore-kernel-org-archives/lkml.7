Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988BBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 654FF2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCOLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:11:13 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:33114 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDCOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:11:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id DD952185BD;
        Wed,  3 Apr 2019 16:11:10 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gN1XOjtXSmBj; Wed,  3 Apr 2019 16:11:10 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id C57D0185EB;
        Wed,  3 Apr 2019 16:11:09 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACE3D1E06A;
        Wed,  3 Apr 2019 16:11:09 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A15561E066;
        Wed,  3 Apr 2019 16:11:09 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 16:11:09 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 9514F2720;
        Wed,  3 Apr 2019 16:11:09 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 8F80680D28; Wed,  3 Apr 2019 16:11:09 +0200 (CEST)
Date:   Wed, 3 Apr 2019 16:11:09 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Add NULL TTY driver
Message-ID: <20190403141109.3mdmqbt3mjxrie6k@axis.com>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403131213.GA4246@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:12:13PM +0200, Greg KH wrote:
> On Wed, Apr 03, 2019 at 01:33:27PM +0200, Vincent Whitchurch wrote:
> > If no console driver is enabled (or if a non-present driver is selected
> > with something like console=null in an attempt to disable the console),
> > opening /dev/console errors out, and init scripts and other userspace
> > code that relies on the existence of a console will fail.  Symlinking
> > /dev/null to /dev/console does not solve the problem since /dev/null
> > does not behave like a real TTY.
> > 
> > To just provide a dummy console to userspace when no console driver is
> > available or desired, add a ttynull driver which simply discards all
> > writes.  It can be chosen on the command line in the standard way, i.e.
> > with console=ttynull.
> 
> If they have a broken system that sets "console=null", why would they
> know to fix it to be "console=ttynull"?
> 
> I'm all for adding new functionality, but to provide kernel code because
> userspace just isn't configured properly, that feels really wrong to me.

Especially on embedded systems, it would be convenient to have a simple
way to disable the console (both for kernel and userspace) on a system
which normally uses it, to free up the UART for other things.

In my case some early init script in userspace was actually tring to
handle the lack of a console in this way:

 [ ! -w /dev/console ] || exec 2>/dev/console

but the problem is that /dev/console always exists but fails on write,
so the obvious way of handling missing devices doesn't work.  AFAICS the
only way to get rid of /dev/console would be to disable the TTY layer
entirely in the kernel or have early userspace delete the file from
devtmpfs.

> Now if this were to be the "default" if nothing is set up at all, that
> might make a bit more sense, but as-is, this doesn't seem very useful.

Making it the default now would break users, wouldn't it?  Since IIRC if
no console is selected, the first registered console will automatically
be used by default.
