Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D180C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 00:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306624683
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLPAKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 19:10:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:47746 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfLPAKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 19:10:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xBG09YtQ028879;
        Sun, 15 Dec 2019 18:09:35 -0600
Message-ID: <0511b917d8ebcf594480349b79fcb9f14aa882f9.camel@kernel.crashing.org>
Subject: Re: [RFC/PATCH] printk: Fix preferred console selection with
 multiple matches
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        AlekseyMakarov <aleksey.makarov@linaro.org>
Date:   Mon, 16 Dec 2019 11:09:33 +1100
In-Reply-To: <20191211091740.p6bgjy7sy75maenw@pathway.suse.cz>
References: <b8131bf32a5572352561ec7f2457eb61cc811390.camel@kernel.crashing.org>
         <20191210091502.qoq55fdjad6aixab@pathway.suse.cz>
         <50d2c44a15960760c6a9d24442a93fa4b31b7594.camel@kernel.crashing.org>
         <20191211091740.p6bgjy7sy75maenw@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 10:17 +0100, Petr Mladek wrote:
> The reverse search of list of console does not work for ttySX
> consoles because the number is omitted when matching. And the messages
> will appear only on the first matched serial console. There is
> a paragraph about this in the commit message of my patch.

About that specific issue...

I see indeed that 8250_core.c registers a "generic" console with index
-1 which will match whetever we hit first in the array.

This is actually wrong isn't it ? Without any change such as what we've
been proposing, it means that an arch doing add_preferred_console of
any ttyS* will override anything on the command line, and it also means
that a command line with multiple ttyS entries will stop at the first
one, not the last one.

IE. In both case the code will select a console that isn't
preferred_console... or am I missing something subtle ?

So yes, fixing that will "regress" in the sense that it will change the
behaviour, but to make it match what's documented... am I wrong ?

The question then becomes what's the most broken ? Changing the
behaviour that might have become expected or leaving the (alledgedly)
broken behaviour in place ?

Cheers,
Ben.


