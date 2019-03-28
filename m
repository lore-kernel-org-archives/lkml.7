Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F68221773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfC1JDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:03:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:56419 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfC1JDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:03:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 02:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="332784754"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2019 02:03:52 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1h9Qww-0000Mu-PT; Thu, 28 Mar 2019 11:03:50 +0200
Date:   Thu, 28 Mar 2019 11:03:50 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
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
Message-ID: <20190328090350.GS9224@smile.fi.intel.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-3-ronald@innovation.ch>
 <CAHp75VebbroyOt6DPnqKVk99RowZsxgjuHbi6HoXf-tAuZLMqA@mail.gmail.com>
 <20190328003459.GG24753@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328003459.GG24753@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 05:34:59PM -0700, Life is hard, and then you die wrote:
> 
> On Wed, Mar 27, 2019 at 09:46:48AM +0200, Andy Shevchenko wrote:
> > On Wed, Mar 27, 2019 at 3:49 AM Ronald Tschalär <ronald@innovation.ch> wrote:
> > >
> > > This introduces print_hex_dump_to_cb() which contains all the hexdump
> > > formatting minus the actual printk() call, allowing an arbitrary print
> > > function to be supplied instead. And print_hex_dump() is re-implemented
> > > using print_hex_dump_to_cb().
> > >
> > > This allows other hex-dump logging functions to be provided which call
> > > printk() differently or even log the hexdump somewhere entirely
> > > different.

> > In any case, don't do it like this. smaller non-recursive printf() is
> > better than one big receursive call.
> > When it looks like an optimization, it's actually a regression.
> 
> Not sure where you see recursion here - are you referring to the
> callback approach?

%pV is a recursive printf().

> Since dev_printk() ends up calling printk with a
> dictionary as well as additional formatting, vs print_hex_dump()'s
> stright use of printk, this seemed like the best way accommodate
> various possible ways of logging the messages. But as per below I
> guess this is moot.

I recommend to read this: https://lwn.net/Articles/780556/

> > And yes, debugfs idea is not bad.
> 
> So it seems like that is the consensus. As per my other response, I'll
> do this then and leave the print_hex_dump() alone.
> 
> > P.S. Also check %*ph specifier.

-- 
With Best Regards,
Andy Shevchenko


