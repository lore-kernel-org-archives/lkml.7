Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92B520896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfFLMAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:00:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727503AbfFLMAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:00:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 724F4AFC3;
        Wed, 12 Jun 2019 12:00:13 +0000 (UTC)
Date:   Wed, 12 Jun 2019 14:00:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190612120012.mmokgz4yybywfs26@pathway.suse.cz>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
 <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <20190603065153.GA13072@jagdpanzerIV>
 <20190606071039.txqczrjlntrljlrx@pathway.suse.cz>
 <20190612083643.GA7722@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612083643.GA7722@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-06-12 17:36:43, Sergey Senozhatsky wrote:
> On (06/06/19 09:10), Petr Mladek wrote:
> > Just to be sure. I wanted to say that I like the idea with
> > KERN_UNSUPRESSED. So, I think that we are on the same page.
> 
> I understand. All I wanted to say is that KERN_UNSUPRESSED is
> per-message, while the most interesting (and actually broken)
> cases, IMHO, are per-context, IOW things like this one
> 
> 	console_loglevel = NEW
> 	foo()
> 	  dump_stack()
> 	     printk
> 	     ...
> 	     printk
> 	console_loglevel = OLD
> 
> KERN_UNSUPRESSED does not help here. We probably can't convert
> dump_stack() to KERN_UNSUPRESSED.

I agree. I take KERN_UNSUPRESSED like a nice trick how to pass
the information about the unsupressed printk context via
printk_safe and printk_nmi per-CPU buffers.

The single line in sysrq __handle_sysrq() seems to be the only
location where KERN_UNSUPRESSED can be used directly.

Best Regards,
Petr
