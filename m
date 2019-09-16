Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA6C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79E021670
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfIPOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfIPOmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:42:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8F520830;
        Mon, 16 Sep 2019 14:42:40 +0000 (UTC)
Date:   Mon, 16 Sep 2019 10:42:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: page_alloc.shuffle=1 + CONFIG_PROVE_LOCKING=y = arm64 hang
Message-ID: <20190916104239.124fc2e5@gandalf.local.home>
In-Reply-To: <1568289941.5576.140.camel@lca.pw>
References: <1566509603.5576.10.camel@lca.pw>
        <1567717680.5576.104.camel@lca.pw>
        <1568128954.5576.129.camel@lca.pw>
        <20190911011008.GA4420@jagdpanzerIV>
        <1568289941.5576.140.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 08:05:41 -0400
Qian Cai <cai@lca.pw> wrote:

> >  drivers/char/random.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index 9b54cdb301d3..975015857200 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -1687,8 +1687,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
> >  	print_once = true;
> >  #endif
> >  	if (__ratelimit(&unseeded_warning))
> > -		pr_notice("random: %s called from %pS with crng_init=%d\n",
> > -			  func_name, caller, crng_init);
> > +		printk_deferred(KERN_NOTICE "random: %s called from %pS "
> > +				"with crng_init=%d\n", func_name, caller,
> > +				crng_init);
> >  }
> >  
> >  /*
> > @@ -2462,4 +2463,4 @@ void add_bootloader_randomness(const void *buf, unsigned int size)
> >  	else
> >  		add_device_randomness(buf, size);
> >  }
> > -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
> > \ No newline at end of file
> > +EXPORT_SYMBOL_GPL(add_bootloader_randomness);  
> 
> This will also fix the hang.
> 
> Sergey, do you plan to submit this Ted?

Perhaps for a quick fix (and a comment that says this needs to be fixed
properly). I think the changes to printk() that was discussed at
Plumbers may also solve this properly.

-- Steve
