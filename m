Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4768E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfLLJJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:09:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:47892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbfLLJJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:09:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9B62AE74;
        Thu, 12 Dec 2019 09:09:49 +0000 (UTC)
Date:   Thu, 12 Dec 2019 10:09:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
Message-ID: <20191212090948.pcskgf6tc6iitkkk@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
 <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
 <b359a4a84d3dad08dc45899dc9b56e7323ffb734.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b359a4a84d3dad08dc45899dc9b56e7323ffb734.camel@kernel.crashing.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-12-12 11:35:23, Benjamin Herrenschmidt wrote:
> On Tue, 2019-12-10 at 10:15 +0100, Petr Mladek wrote:
> > 
> > Anyway, here is the patch that we use. Could you please check if it
> > works for you as well? Does it make sense, please?
> 
> It doesn't fix my problem. tty0 remains the default console instead
> of ttyS0 with your patch applied.

Sigh, I see.

> I suspect for the same reason, we match uart0 which isn't preferred,
> so we enable that but don't put it "first" in the list, and since
> we break out of the loop we never match ttyS0.

Yeah.

> I see 3 simple ways out of this that don't involve breaking up match()
> 
>  - Bite the bullet and use my patch assuming that calling setup()
> multiple times is safe. I had a look at the two you had concerns
> with, the zilog ones seems safe. pl1011 will leak a clk_prepare
> reference but I think that's a non-issue for a kernel console
> (I may be wrong)

This does not sound much convincing to me. Leaking reference
is an issue, definitely.


>  - Rework the loop to try matching against the array entry pointed
> by preferred_console first.

IMHO, in principle, we are trying to solve the same problem as
the commit cf39bf58afdaabc0b86f141 ("printk: fix double
printing with earlycon").

And it was reverted because it broke some setups, see
the commit dac8bbbae1d0ccba96402d25d ("Revert "printk: fix double
printing with earlycon").

Trying only the preferred console first is less invasive but
it might cause exactly the same regression.


>  - Rework the loop to try matching the entries from the command line
> before trying to match the entries added by the platform/arch.
> (Easily done by flagging them in the array, I can cook a patch).

This makes some sense. It would allow user to override the fallback
defined by platform/arch.

IMHO, it would solve all the problems that motivated people working
on this. And it should not cause regression that forced us to
revert the backward search.

There is still some risk of regressions. But I would give it a try.

Best Regards,
Petr
