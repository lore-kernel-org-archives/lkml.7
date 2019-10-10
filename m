Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F3CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B8B2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvJGQsSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfJJIQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:16:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38139 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733057AbfJJIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:16:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so3393860pfe.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lIULWAfJ8ac9fSRouaYXz9QL/7zsR+COixG8JRGBZzA=;
        b=NvJGQsSwWbWweA9LHYTJ8PuRliMxWzd18o25n1mhCy6KzS00qvFaE/RDQ4uOipOYhO
         zOgBOMV7OABG7hRFBMgnM6U9SafQHxCzghs68GgX4iSwS1uVivWjCKM8E8vrtfSw/eGF
         RS3szEUX5yGJVun6BNw8WP+Pxecokkzcpu9UZ7pwUXcfGppj+OIHFebGgz9tiAR1WI0B
         asMAmBbyPf5ITdPU1HvPY8QegTcm2bV+kIvshnI3VmN6wfXV+F5dau42Pc8kWs72bds3
         nvxBc6emr0N5R85BoIfQ9dD5yso3SoimpFJbq1jOCzDy3022+HLmnDf4/2f5/W62K7AX
         ccBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIULWAfJ8ac9fSRouaYXz9QL/7zsR+COixG8JRGBZzA=;
        b=tkRxAH0PnM7ibz8yhp17WrVxYK/Y6BT6QlQi5Jzwn3OIsOkTs7vSZW8QdqU0tAyDKE
         A2r5ZIZ98lZysPkQC6k8BOFmKWWwldmw/4JTOqSaUIGhz2mEIVf62nUpBQ5oHiuRCl6h
         CNDhCG/j/NasgpyU+pgBbvyWaEmsoaxSWzdVEtYVpEPOC5jL9Ie8O5K1QAT0V/bno2Mw
         ADezfz81ja0NrRex8PZY8mIHo1LHkMDduwhdv3TCF7zEu0/lcxaLqQ6irTpieGWgkv0W
         p5WBu0v51XkJWUZt5jEVDn7mLGZIb97aAqmlAxlA4BnUErSNFFpU2oe6eMxXZy1gsTlZ
         pBeQ==
X-Gm-Message-State: APjAAAXGKu7UZ6g3XiquPYk6QajuUj/cGmorPaChsuYV6QNWMN6lGFll
        +aQScmGFyRwbyuX2IwIRMsM=
X-Google-Smtp-Source: APXvYqyGA0LGAd9vfNXLN/h9ltelfmDLZFHEvxUOyg9c1d8zLHfeUkkG6niUzbslc3ioZK9d1H/Rsg==
X-Received: by 2002:a63:5516:: with SMTP id j22mr9594111pgb.201.1570695394874;
        Thu, 10 Oct 2019 01:16:34 -0700 (PDT)
Received: from localhost ([2001:e60:1023:519f:3055:27ff:fe5a:5b5c])
        by smtp.gmail.com with ESMTPSA id v68sm5519387pfv.47.2019.10.10.01.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:16:33 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:16:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Qian Cai <cai@lca.pw>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, david@redhat.com,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191010081629.GA120986@jagdpanzerIV>
References: <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <20191007144937.GO2381@dhcp22.suse.cz>
 <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <1157b3ae-006e-5b8e-71f0-883918992ecc@linux.ibm.com>
 <20191009142623.GE6681@dhcp22.suse.cz>
 <20191010051201.GA78180@jagdpanzerIV>
 <20191010074049.GD18412@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010074049.GD18412@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/10/19 09:40), Michal Hocko wrote:
[..]
> > > Considering that console.write is called from essentially arbitrary code
> > > path IIUC then all the locks used in this path should be pretty much
> > > tail locks or console internal ones without external dependencies.
> > 
> > That's a good expectation, but I guess it's not always the case.
> > 
> > One example might be NET console - net subsystem locks, net device
> > drivers locks, maybe even some MM locks (skb allocations?).
> 
> I am not familiar with the netconsole code TBH. If there is absolutely
> no way around that then we might have to bite a bullet and consider some
> of MM locks a land of no printk.

So this is what netconsole does (before we pass on udp to net device
driver code, which *may be* can do more allocations, I don't know):

write_msg()
 netpoll_send_udp()
  find_skb()
   alloc_skb(len, GFP_ATOMIC)
    kmem_cache_alloc_node()

You are the right person to ask this question to - how many MM
locks are involved when we do GFP_ATOMIC kmem_cache allocation?
Is there anything to be concerned about?

> I have already said that in this thread. I am mostly pushing back
> on "let's just go the simplest way" approach.

I understand this. And don't have objections. Merely trying to get
better understanding.

> > But even more "commonly used" consoles sometimes break that
> > expectation. E.g. 8250
> >
> > serial8250_console_write()
> >  serial8250_modem_status()
> >   wake_up_interruptible()
>
> By that expectation you mean they are using external locks or that they
> really _need_ to allocate.

Sort of both. netconsole does allocations and has external lock
dependencies. Some of serial console drivers have external lock
dependencies (but don't do allocations, as far as I'm concerned).

> Because if you are pointing to wake_up_interruptible and therefore the rq
> then this is a well known thing and I was under impression even documented
> but I can only see LOGLEVEL_SCHED that is arguably a very obscure way to
> document the fact.

That's right. All I was commenting on is that console.write() callbacks
have external lock dependencies.

	-ss
