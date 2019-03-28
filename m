Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E831DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0E9204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="X7tj1Dfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfC1AfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:35:00 -0400
Received: from chill.innovation.ch ([216.218.245.220]:46602 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC1AfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:35:00 -0400
Date:   Wed, 27 Mar 2019 17:34:59 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 5A70F64012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553733299;
        bh=TrI78oTepP+/CgsWTM9cBNDK2/IRtIFgHtRujH+NxYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7tj1DflzaQmoYDxflPKzm+wgPdR8/k+1VOPUxwPkZdS+X/USt53pl/YP1MZ1Fog8
         eBv6QIU/8wJepJrYqAkDc725hYVaxf4UCdSVcdwSQwksNJWb2vbf/NUKIVcS+2/2oc
         MoRJlQP8lI05LIz/PrOd559/hEzmVQMQV+siitnpKyC+ajFvAK3xzYesSBFFgl3NJo
         YgvUHIkRU41NMKcjvd+UQ8hyyPJ9/Z0DReGq8XTI2sO8CI9+XA/oJFs8TO27uDyIRw
         mCJtCuSCXdSUi7fEygKl7eQCiGi+udw7iHLvbeadzrXbvb0z/RKJyNwZmGuNZLYVr3
         sVkO0G90JudBg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20190328003459.GG24753@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-3-ronald@innovation.ch>
 <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 27, 2019 at 09:46:48AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 27, 2019 at 3:49 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> >
> > This introduces print_hex_dump_to_cb() which contains all the hexdump
> > formatting minus the actual printk() call, allowing an arbitrary print
> > function to be supplied instead. And print_hex_dump() is re-implemented
> > using print_hex_dump_to_cb().
> >
> > This allows other hex-dump logging functions to be provided which call
> > printk() differently or even log the hexdump somewhere entirely
> > different.
> 
> No Sign-off?

Yeah, my screwup.

> In any case, don't do it like this. smaller non-recursive printf() is
> better than one big receursive call.
> When it looks like an optimization, it's actually a regression.

Not sure where you see recursion here - are you referring to the
callback approach? Since dev_printk() ends up calling printk with a
dictionary as well as additional formatting, vs print_hex_dump()'s
stright use of printk, this seemed like the best way accommodate
various possible ways of logging the messages. But as per below I
guess this is moot.

> And yes, debugfs idea is not bad.

So it seems like that is the consensus. As per my other response, I'll
do this then and leave the print_hex_dump() alone.

> P.S. Also check %*ph specifier.

Thanks!


  Cheers,

  Ronald

