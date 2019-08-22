Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D6DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1B621743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566480941;
	bh=f4Shi7OJbAQFddQCcIcON3P7HQpCrzkyUrHEv2JczA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JjN5FtFfTEVU/bOftNZnhixb/DGLW2GfLriHVkJdVUJ1AbIcPxThEW0/Lo+L/42Ue
	 R+iKIpTkorMW9L01eEfIDc/tGOWAIU4rd7pmpPcxssFZW7fW6INEIZHaQLbj1vMF1c
	 ClZa3dfBQMHTRWPzM36INgsnVHoJIyWqlEDglmOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388815AbfHVNfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfHVNfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:35:40 -0400
Received: from localhost (unknown [12.166.174.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E407A21743;
        Thu, 22 Aug 2019 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566480939;
        bh=f4Shi7OJbAQFddQCcIcON3P7HQpCrzkyUrHEv2JczA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iO6wEfmf+gQ7nOlKfwuyFjU5jeVI2rZnSgOeM16Ti0I2n+JOS+OOymdFz46oOsFdJ
         FFeIclTryQIqpryLiAElcVWvluKx8e8BAxk5GG4v9rPWJUbxFnRXsKkL2+teb9YrI1
         ERMaC6zvC664/tiaAiwM8qWYQXDDsSkjQ1LBVVRU=
Date:   Thu, 22 Aug 2019 06:35:38 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
Message-ID: <20190822133538.GA16793@kroah.com>
References: <20190820222403.GB8120@kroah.com>
 <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908220959.x7M9xP8r011133@www262.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 06:59:25PM +0900, Tetsuo Handa wrote:
> Tetsuo Handa wrote:
> > Greg Kroah-Hartman wrote:
> > > Oh, nice!  This shouldn't break anything that is assuming that the read
> > > will complete before a signal is delivered, right?
> > >
> > > I know userspace handling of "short" reads is almost always not there...
> > 
> > Since this check will give up upon SIGKILL, userspace won't be able to see
> > the return value from read(). Thus, returning 0 upon SIGKILL will be safe. ;-)
> > Maybe we also want to add cond_resched()...
> > 
> > By the way, do we want similar check on write_mem() side?
> > If aborting "write to /dev/mem" upon SIGKILL (results in partial write) is
> > unexpected, we might want to ignore SIGKILL for write_mem() case.
> > But copying data from killed threads (especially when killed by OOM killer
> > and userspace memory is reclaimed by OOM reaper before write_mem() returns)
> > would be after all unexpected. Then, it might be preferable to check SIGKILL
> > on write_mem() side...
> > 
> 
> Ha, ha. syzbot reported the same problem using write_mem().
> https://syzkaller.appspot.com/text?tag=CrashLog&x=1018055a600000
> We want fatal_signal_pending() check on both sides.

Ok, want to send a patch for that?

And does anything use /dev/mem anymore?  I think X stopped using it a
long time ago.

> By the way, write_mem() worries me whether there is possibility of replacing
> kernel code/data with user-defined memory data supplied from userspace.
> If write_mem() were by chance replaced with code that does
> 
>    while (1);
> 
> we won't be able to return from write_mem() even if we added fatal_signal_pending() check.
> Ditto for replacing local variables with unexpected values...

I'm sorry, I don't really understand what you mean here, but I haven't
had my morning coffee...  Any hints as to an example?

thanks,

greg k-h
