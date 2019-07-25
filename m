Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70BEC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9A322BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564037961;
	bh=yrDu6i8kJTZ5JgPYIQrkoqt/GawfokDLPdWoND6VkrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y8tlKbtW6iAVqBpitcC3O65hmRW4BdNlpOY1NfVJCVvqU6BM16z6iIGJpt3j+h5ri
	 Z5w93kuNE52MjYXOj+lvmhgIPy2YS5iZTqeFIWVMeiUX3BUl2zrw0nEIjpVvwuEgDZ
	 hybpfbdy2RXbHcKCiNNBhrKB9NQhZW+TDcmCulcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfGYG7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfGYG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:59:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887EE2081B;
        Thu, 25 Jul 2019 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564037959;
        bh=yrDu6i8kJTZ5JgPYIQrkoqt/GawfokDLPdWoND6VkrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhA3qo5UGHPzaCyjcxJMzKu3MlbprMP0hmGZf0lFRsEbfkw56ZihXzlt/7eeQw7Ld
         7MyiDnCVqwg1pDz006LwzwTD1uRJy9c+3fLIeJtpouRswZ1AfWivz7wRZ4QzeqEYMR
         wKVdBvAfK+whz4xhYvNKD/gumZqKlSLoylgZMRjc=
Date:   Thu, 25 Jul 2019 08:24:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be
 reserved
Message-ID: <20190725062447.GB5647@kroah.com>
References: <20190723130513.GA25290@kroah.com>
 <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com>
 <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com>
 <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
 <20190724161634.GB10454@kroah.com>
 <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:20:34PM +0200, Thomas Gleixner wrote:
> On Wed, 24 Jul 2019, Thomas Gleixner wrote:
> 
> > On Wed, 24 Jul 2019, Greg KH wrote:
> > > On Wed, Jul 24, 2019 at 06:03:41PM +0200, Thomas Gleixner wrote:
> > > > > Gotta love old tool-chains :(
> > > > 
> > > > Oh yes. /me does archaeology to find a VM with old stuff
> > > 
> > > I can provide a binary if you can't find anything.
> > 
> > Found GNU ld (GNU Binutils for Debian) 2.25 and after fiddling with
> > LD_PRELOAD it builds without failure.
> > 
> > ld.gold from that binutils version dies with a segfault on various files ...
> 
> Then tried that old ld.bfd with GCC8 and that causes ld.bfd to segfault on
> every other file.
> 
> Copied that config to the clang build directory and it causes the same
> explosions with ld.bfd.
> 
> What a time waste...
> 
> 
> 

Ugh, sorry about this.  I can't seem to track it down either, and at
this point am just going to punt and let the Android build people try to
figure it out as it is their custom build system that is failing at the
moment, only for x86, and if this single patch is reverted, it starts
working again.

voodo...

thanks,

greg k-h
