Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9315EC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649F720578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfDYJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:20:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfDYJUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:20:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8682CAD18;
        Thu, 25 Apr 2019 09:20:04 +0000 (UTC)
Date:   Thu, 25 Apr 2019 11:20:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425092003.oj2p2o5rzrbnlah3@pathway.suse.cz>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
 <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
 <20190425035233.GA8532@jagdpanzerIV>
 <20190425064321.GA27270@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425064321.GA27270@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-04-25 15:43:21, Sergey Senozhatsky wrote:
> On (04/25/19 12:52), Sergey Senozhatsky wrote:
> > > Could we remove it in this patch? It touches it indirectly anyway.
> > 
> > Sure we can.
> > 
> > We also can take extra care of pr_info("%sconsole [%s%d] enabled\n".
> > Right now we do
> > 
> > 	...
> > 	console_unlock();
> > 	console_sysfs_notify();
> > 
> > 	pr_info("%sconsole [%s%d] enabled\n",....
> > 
> > 
> > But we can simply move that pr_info() a bit up:
> > 
> > 	pr_info("%sconsole [%s%d] enabled\n",
> > 	console_unlock();
> > 	console_sysfs_notify();
> > 
> > 
> > So the message will be printed on all consoles.
> 
> ---
> 
> Petr, Steven, would you prefer to have it as two separate patches - one
> removes the comment; the other one moves pr_info("console enabled") - or
> as one patch? It's sort of trivial enough to be in just one patch, but
> I also can submit it as separate changes.

One patch is enough from my point of view. The moved pr_info()
solves the problem that is described by the comment.

Best Regards,
Petr
