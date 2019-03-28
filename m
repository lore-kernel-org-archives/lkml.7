Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A369C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAE5204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="LXaWDevn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfC1A2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:28:18 -0400
Received: from chill.innovation.ch ([216.218.245.220]:46478 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfC1A2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:28:18 -0400
Date:   Wed, 27 Mar 2019 17:28:17 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch B0F3064012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553732897;
        bh=PnD/kJ5jljm83pOyhUHVhxzvfANwJQLt3lLt3UoHwWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXaWDevnMEJrf1Uvh9scLDEGAqMvT3W5Vw/MCnxWfJIsPLMjXli31JGe9CTMewh6K
         D/CWNlTS1LtwgMekgqIUn4bixxScAkjs3R0rqCfvcgj3n9xXRVZ/+JPIqdqr5LqacY
         CqTRbbBj6LPZ08ygCeanNklnTL7Po8UWsR3VB2zdxVAVNjrqj/N1EaPh/UhU5OwwcN
         YDneO9kc1jStqvt+35qj7MNqp9Za3/BKbY0cLGuCeVBz5iypjiUFoTHnGeDW4RlqMR
         B9ee1IKyDXNKl2CkMAFoYguxLzEJa6W03hYj+jHs4Bvq1MmmTlXpaCkHfP+UtX0FSm
         a2mFsv9afsOtg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Message-ID: <20190328002817.GF24753@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327023757.GB20766@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > instead of straight printk() to match other dev_xxx() logging functions.
> > ---
> >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/device.h | 15 +++++++++++++++
> >  2 files changed, 58 insertions(+)
> 
> No signed-off-by?

Aargh! Apologies, fixed for the future.

> Anyway, no, please do not do this.  Please do not dump large hex values
> like this to the kernel log, it does not help anyone.
> 
> You can do this while debugging, sure, but not for "real" kernel code.

As used by this driver, it is definitely called for debugging only and
must be explicitly enabled via a module param. But having the ability
for folks to easily generate and print out debugging info has proven
quite valuable.

> Worst case, just create a debugfs file for your device that you can read
> the binary data from if you really need it.  For any "normal" operation,
> this is not something that you should ever need.

Ok, can do that.

I'll retract the two print_hex_dump related patches then.


  Cheers,

  Ronald

