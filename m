Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8618C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6594206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="kQV1hvyM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1K33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:29:29 -0400
Received: from chill.innovation.ch ([216.218.245.220]:33982 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1K33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:29:29 -0400
Date:   Thu, 28 Mar 2019 03:29:28 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch A966C640114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553768968;
        bh=RTPWUaWZRBMujFLU36QCKrAQYGhZNM4FWg3ATKGdYzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQV1hvyMjYgr9u8HmlE0ojDfHMGXhBr6KmRciNTzK6PZ0uu26U5gaWFqIt9IH35rE
         /t7nUpIJJUO2uDB5+P9SeoOMUJcPPFn0JNPPyBw0rpM0hvDU8RH94gRFSZ4lzBi/px
         7AaBG/D7NCavl4pTzVuJcKYksBIs0xB8WQLV+9zbATVvLJ1ch/ehfO+wfWQ7Wwp0Zl
         beB/1PiyU4gPhv0pidz219jnvqofhkadMx3LOSvIZa3GYcwVdZ16XdFY7wMHYjk0AO
         lUOCuirNVWmoOqwaA2vFsKCu6pn3c2xrMeheyaE9Ozkeej/T6fCDCGp5sHujJtZ2/H
         /QmI0EZTZDeXg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] lib/hexdump.c: factor out generic hexdump
 formatting for reuse.
Message-ID: <20190328102928.GB26446@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-3-ronald@innovation.ch>
 <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
 <20190328003459.GG24753@innovation.ch>
 <20190328090350.GS9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328090350.GS9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 28, 2019 at 11:03:50AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 27, 2019 at 05:34:59PM -0700, Life is hard, and then you die wrote:
> > 
> > On Wed, Mar 27, 2019 at 09:46:48AM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 27, 2019 at 3:49 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> > > >
> > > > This introduces print_hex_dump_to_cb() which contains all the hexdump
> > > > formatting minus the actual printk() call, allowing an arbitrary print
> > > > function to be supplied instead. And print_hex_dump() is re-implemented
> > > > using print_hex_dump_to_cb().
> > > >
> > > > This allows other hex-dump logging functions to be provided which call
> > > > printk() differently or even log the hexdump somewhere entirely
> > > > different.
> 
> > > In any case, don't do it like this. smaller non-recursive printf() is
> > > better than one big receursive call.
> > > When it looks like an optimization, it's actually a regression.
> > 
> > Not sure where you see recursion here - are you referring to the
> > callback approach?
> 
> %pV is a recursive printf().

Ah!

> > Since dev_printk() ends up calling printk with a
> > dictionary as well as additional formatting, vs print_hex_dump()'s
> > stright use of printk, this seemed like the best way accommodate
> > various possible ways of logging the messages. But as per below I
> > guess this is moot.
> 
> I recommend to read this: https://lwn.net/Articles/780556/

Thanks, quite informative.


  Cheers,

  Ronald

