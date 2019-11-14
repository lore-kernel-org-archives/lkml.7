Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FD9206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKNJ5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:57:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:41516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfKNJ5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:57:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59227ADBB;
        Thu, 14 Nov 2019 09:57:38 +0000 (UTC)
Date:   Thu, 14 Nov 2019 10:57:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jonathan Richardson <jonathan.richardson@broadcom.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        sergey.senozhatsky@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: console output duplicated when registering additional consoles
Message-ID: <20191114095737.wl5nvxu3w6p5thfc@pathway.suse.cz>
References: <CAHrpVsUHgJA3wjh4fDg43y5OFCCvQb-HSRpyGyhFEKXcWw8WnQ@mail.gmail.com>
 <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpVsW6jRUYK_mu+dLaBvucAAtUPQ0zcH6_NxsUsTrPewiY_w@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-11-13 17:28:45, Jonathan Richardson wrote:
> Adding printk maintainers.
> This commit seems to have introduced the error:
> 
> commit f92b070f2dc89a8ff1a0cc8b608e20abef894c7d
> Author: Petr Mladek <pmladek@suse.com>
> Date:   Thu Sep 13 14:34:06 2018 +0200
> 
>     printk: Do not miss new messages when replaying the log
> 
> If I checkout to the commit before
> (a06b0c82a049d34d4dc273e8692ed0894458c468), the console output is
> normal when registering 2 bootconsoles and 2 normal consoles. I've
> added the log for 4.19.0-rc3 for comparison (previous version was
> 5.1.0). I don't think this commit took into account that more than one
> console could be registered. When the second console is registered,
> 'console_seq >= exclusive_console_stop_seq' is true (both are 0) and
> exclusive_console is always set to NULL resulting in the log being
> replayed again to the uart8250 console:

This race should not happen because Both exclusive_console and
exclusive_console_stop_seq are manipulated under console_lock.
And the log is replayed before console_lock is released.

>         /* Output to all consoles once old messages replayed. */
>         if (unlikely(exclusive_console &&
>                  console_seq >= exclusive_console_stop_seq)) {
>             exclusive_console = NULL;
>         }
> 
> I'm looking into it but any input is helpful. Thanks.

IMHO, the problem is that the log should not be replayed at all.
See the following code in register_console():

	/*
	 * If we have a bootconsole, and are switching to a real console,
	 * don't print everything out again, since when the boot console, and
	 * the real console are the same physical device, it's annoying to
	 * see the beginning boot messages twice
	 */
	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV))
		newcon->flags &= ~CON_PRINTBUFFER;

I already see two problems there:

1. CON_PRINTBUFFER is cleared only when the new console has
   CON_CONSDEV flag set. It is set only for the console
   that is defined as the last on the command line.
   It is a so-called preferred console.

2. bcon is set to the first console in console_drivers list.
   It is the first registered boot console.

Sigh, this works for simple configuration. But it fails badly when
more different consoles are configured.

We should clear CON_PRINTBUFFER flag when the real console
replacing an already registered boot console is registered.

BTW: Similar bug is also at the end of register_console().
The boot consoles are unregistered only when the preferred
console is installed.

For a proper solution we would need to match boot and real
consoles that write messages into the physical device.
But I am afraid that there is no support for this.
con->match() callback compares the name defined on
the command line. And it has side effects (the matching
console is prepared for registration).

To be honest I am not much familiar with the device interface.
I am not sure if there is a way to detect the two drivers
use the same physical hardware.

Sigh, it is a huge historical mess. It would needed a lot
of work to clean it up.

Best Regards,
Petr
