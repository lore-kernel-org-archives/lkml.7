Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70691C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3088220693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfDOMfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:35:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbfDOMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:35:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 839D2AD6B;
        Mon, 15 Apr 2019 12:35:01 +0000 (UTC)
Date:   Mon, 15 Apr 2019 14:34:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: tie printk_once / printk_deferred_once into
 .data.once for reset
Message-ID: <20190415123459.f7meom5wm5wqggwu@pathway.suse.cz>
References: <1555121491-31213-1-git-send-email-paul.gortmaker@windriver.com>
 <20190415023216.GA27063@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415023216.GA27063@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-04-15 11:32:16, Sergey Senozhatsky wrote:
> On (04/12/19 22:11), Paul Gortmaker wrote:
> > In commit b1fca27d384e ("kernel debug: support resetting WARN*_ONCE")
> > we got the opportunity to reset state on the one shot messages,
> > without having to reboot.
> 
> Didn't know that.
> 
> > However printk_once (printk_deferred_once) live in a different file
> > and didn't get the same kind of update/conversion, so they remain
> > unconditionally one shot, until the system is rebooted.
> > 
> > For example, we currently have:
> > 
> >   sched/rt.c: printk_deferred_once("sched: RT throttling activated\n");
> > 
> > ..which could reasonably be tripped as someone is testing and tuning
> > a new system/workload and their task placements.  For consistency, and
> > to avoid reboots in the same vein as the original commit, we make these
> > two instances of _once the same as the WARN*_ONCE instances are.
> 
> Looks OK to me.
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been commited into printk.git, branch for-5.2.

Best Regards,
Petr
