Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7127C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A310A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfDJIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:02:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbfDJIC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:02:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD311B0BD;
        Wed, 10 Apr 2019 08:02:24 +0000 (UTC)
Date:   Wed, 10 Apr 2019 10:02:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 2/2] panic: Enable to print out all printk msg in buffer
Message-ID: <20190410080224.hmyzv2mqcjyceiw3@pathway.suse.cz>
References: <1554115684-26846-1-git-send-email-feng.tang@intel.com>
 <1554115684-26846-2-git-send-email-feng.tang@intel.com>
 <20190409141430.w2fulp7jnnthojrc@pathway.suse.cz>
 <20190410015926.GC26212@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410015926.GC26212@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-04-10 10:59:26, Sergey Senozhatsky wrote:
> On (04/09/19 16:14), Petr Mladek wrote:
> > We should:
> > 
> >    + Flush the latest messages before we replay the log.
> 
> Do you mean the pending messages? When we replay the log we also should
> print "header line" and panic-cpu backtrace. So we will print panic-cpu
> oops twice

console_flush_on_panic() is just the last resort. I believe
that the panic header and backtrace reach the console even
without it in most cases. Explicit flush before reply
would just make it consistent.

> 	// from panic-cpu flush_on_panic
> 	[header]
> 	backtrace
> 	[end of header]
> 
>         // from console_replay
> 	then all logbuf messages
> 	and then the same header/backtrace one more time
> 
> 	[header]
> 	backtrace]
> 	[end of backtrace]
> 
> Is there any particular reason to flush pending messages before
> we play the buffer? Replaying the logbuf can take some time, so
> my guess would be that you want to print panic-cpu backtrace as
> soon as possible. Is there something else?

The panic() message is usually the most important one for debugging.
I feel a bit uneasy that we would delay it until full replay that
might get killed from several reasons:

   + external monitoring system would force reboot

   + user might realize, e.g. after 20 minutes, that the full
     log reply was probably not worth it.

I understand that people enabling this option would most likely
wait but still. I do not see it as a big deal to repeat
the messages.

Best Regards,
Petr
