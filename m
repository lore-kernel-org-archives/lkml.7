Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607CEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397702064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSJun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:50:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:45708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfLSJum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:50:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7831AF41;
        Thu, 19 Dec 2019 09:50:40 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:50:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191219095038.hplirl7sxlpreo4w@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
 <50d2c44a15960760c6a9d24442a93fa4b31b7594.camel@kernel.crashing.org>
 <20191211091740.p6bgjy7sy75maenw@pathway.suse.cz>
 <0511b917d8ebcf594480349b79fcb9f14aa882f9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0511b917d8ebcf594480349b79fcb9f14aa882f9.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-12-16 11:09:33, Benjamin Herrenschmidt wrote:
> On Wed, 2019-12-11 at 10:17 +0100, Petr Mladek wrote:
> > The reverse search of list of console does not work for ttySX
> > consoles because the number is omitted when matching. And the messages
> > will appear only on the first matched serial console. There is
> > a paragraph about this in the commit message of my patch.
> 
> About that specific issue...
> 
> I see indeed that 8250_core.c registers a "generic" console with index
> -1 which will match whetever we hit first in the array.
> 
> This is actually wrong isn't it ? Without any change such as what we've
> been proposing, it means that an arch doing add_preferred_console of
> any ttyS* will override anything on the command line, and it also means
> that a command line with multiple ttyS entries will stop at the first
> one, not the last one.
> 
> IE. In both case the code will select a console that isn't
> preferred_console... or am I missing something subtle ?
> 
> So yes, fixing that will "regress" in the sense that it will change the
> behaviour, but to make it match what's documented... am I wrong ?
> 
> The question then becomes what's the most broken ? Changing the
> behaviour that might have become expected or leaving the (alledgedly)
> broken behaviour in place ?

I though the same. But then I found the following in
Documentation/admin-guide/serial-console.rst

  "If no console device is specified, the first device found capable of
  acting as a system console will be used. At this time, the system
  first looks for a VGA card and then for a serial port. So if you don't
  have a VGA card in your system the first serial port will automatically
  become the console."


In addition, there is the "documentation" how systemd handles serial
console and login prompts, see
http://0pointer.de/blog/projects/serial-console.html


I agree that the current behavior is wrong. I really would like
to change it. But the result would be that some users will not
get login prompt after a kernel update. I am afraid that we are
blocked by the "do not break userspace" rule.

Best Regards,
Petr
