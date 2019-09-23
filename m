Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0615120820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394695AbfIWM6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:58:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394080AbfIWM6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:58:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0111AF4E;
        Mon, 23 Sep 2019 12:58:52 +0000 (UTC)
Date:   Mon, 23 Sep 2019 14:58:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Will Deacon <will@kernel.org>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Theodore Ts'o <tytso@mit.edu>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: printk() + memory offline deadlock (WAS Re: page_alloc.shuffle=1
 + CONFIG_PROVE_LOCKING=y = arm64 hang)
Message-ID: <20190923125851.cykw55jpqwlerjrz@pathway.suse.cz>
References: <1566509603.5576.10.camel@lca.pw>
 <1567717680.5576.104.camel@lca.pw>
 <1568128954.5576.129.camel@lca.pw>
 <20190911011008.GA4420@jagdpanzerIV>
 <1568289941.5576.140.camel@lca.pw>
 <20190916104239.124fc2e5@gandalf.local.home>
 <1568817579.5576.172.camel@lca.pw>
 <20190918155059.GA158834@tigerII.localdomain>
 <1568823006.5576.178.camel@lca.pw>
 <20190923102100.GA1171@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923102100.GA1171@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-23 19:21:00, Sergey Senozhatsky wrote:
> So we have
> 
> port->lock -> MM -> zone->lock
> 	// from pty_write()->__tty_buffer_request_room()->kmalloc()
> 
> vs
> 
> zone->lock -> printk() -> port->lock
> 	// from __offline_pages()->__offline_isolated_pages()->printk()

If I understand it correctly then this is the re-appearing problem.
The only systematic solution with the current approach is to
take port->lock in printk_safe/printk_deferred context.

But this is a massive change that almost nobody wants. Instead,
we want the changes that were discussed on Plumbers.

Now, the question is what to do with existing kernels. There were
several lockdep reports. And I am a bit lost. Did anyone seen
real deadlocks or just the lockdep reports?

To be clear. I would feel more comfortable when there are no
deadlocks. But I also do not want to invest too much time
into old kernels. All these problems were there for ages.
We could finally see them because lockdep was enabled in printk()
thanks to printk_safe. Well, it is getting worse over time with
the increasing complexity and number of debugging messages.

> A number of debugging options make the kernel less stable.
> Sad but true.

Yeah. The only good thing is that most debug options are not
enabled on production systems. It is not an excuse for ignoring
the problems. But it might be important for prioritizing.

Best Regards,
Petr
