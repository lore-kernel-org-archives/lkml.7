Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42EFC606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DB720838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfGJMrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:47:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCF12064B;
        Wed, 10 Jul 2019 12:47:33 +0000 (UTC)
Date:   Wed, 10 Jul 2019 08:47:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190710084731.2e3caa29@gandalf.local.home>
In-Reply-To: <20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
        <20190709101230.GA16909@jagdpanzerIV>
        <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
        <20190710080402.ab3f4qfnvez6dhtc@axis.com>
        <20190710081922.GA7020@jagdpanzerIV>
        <20190710121049.rwhk7fknfzn3cfkz@pathway.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 14:10:49 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2019-07-10 17:19:22, Sergey Senozhatsky wrote:
 
> > > arch/powerpc/xmon/xmon.c
> > > 2836:	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
> > > 2837-		buf[len] = '\0';
> > > 
> > > arch/um/kernel/kmsg_dump.c
> > > 29:	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
> > > 30-		line[len] = '\0';
> > > 
> > > I guess we should fix these first and leave this patch as is?  
> > 
> > We certainly need to fix something here, and I'd say that we
> > better handle it on the msg_print_text() side. There might be
> > more kmsg_dump_get_line() users doing `buf[len] = '\0'' in the
> > future.  

So basically the issues is that callers may expect that the return size
is still in the buffer and they append a '\0' to it. This is the same
issue with strncpy() and will cause the same kinds of bugs.

> 
> I though more about it and I agree with Sergey. One unused byte does
> not look worth the risk. Especially when we are talking about strings
> where many people expect the trailing '\0'.
> 
> I would even modify msg_print_text() to always add the trailing '\0'.
> All bytes will be used and it will be more error-proof API. I guess
> that this is what Sergey meant by better handling it on the
> msg_print_text() side.

I agree too. We either keep it as is and let the callers be able to add
the '\0', or we preferably add the '\0' ourselves and return the length
written (not counting the terminating '\0'), and we can then remove the
callers adding the '\0' later.

That's the safest approach.

-- Steve

