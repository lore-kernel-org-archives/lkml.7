Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9169D2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553772599;
	bh=9iSpTUV713ibpEKBUDxFbyVaos8pRZJfXV5YPT2qxgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohPQ+lFGkpTrSd32Ew2vAFF2d22hHxOlIhVXbwC7gX2/j7uWpmV5wYMZ9nsbi0qDw
	 pcTALh9xZf/bEJTEZN6lzdE7WVmLV7WRp8P7bdQtna5wiXxzoUpGfxDXstHO4bLqfX
	 iYyXhkLhxfxIiVEmUBBT2BQIoO2HV6gJl84HzLg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfC1L36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1L36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:29:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103922075E;
        Thu, 28 Mar 2019 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553772596;
        bh=9iSpTUV713ibpEKBUDxFbyVaos8pRZJfXV5YPT2qxgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLrw3JfmaR0GP3o6BW7KnVzhBynpst0zr4CDPhmxGwWWBKyBEXrAd6LUSiu/G33xK
         3WyDgeiN04POxl5NFti6sK2bT0r3AOxW3gAUPVMMYP/ciYMcoVtAnnMz6ihAovimC6
         t4JFP/2TPDqSjIUWNiXxz2nDeYCp49xx20XfbpK8=
Date:   Thu, 28 Mar 2019 12:29:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
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
Message-ID: <20190328112952.GA2232@kroah.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
 <20190328102755.GA26446@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328102755.GA26446@innovation.ch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:27:55AM -0700, Life is hard, and then you die wrote:
> 
> On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > > 
> > > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > > > instead of straight printk() to match other dev_xxx() logging functions.
> > > > > ---
> > > > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/device.h | 15 +++++++++++++++
> > > > >  2 files changed, 58 insertions(+)
> > > > 
> > > > No signed-off-by?
> > > 
> > > Aargh! Apologies, fixed for the future.
> > > 
> > > > Anyway, no, please do not do this.  Please do not dump large hex values
> > > > like this to the kernel log, it does not help anyone.
> > > > 
> > > > You can do this while debugging, sure, but not for "real" kernel code.
> > > 
> > > As used by this driver, it is definitely called for debugging only and
> > > must be explicitly enabled via a module param. But having the ability
> > > for folks to easily generate and print out debugging info has proven
> > > quite valuable.
> > 
> > We have dynamic debugging, no need for module parameters at all.  This
> > isn't the 1990's anymore :)
> 
> I am aware of dynamic debugging, but there are several issues with it
> from the perspective of the logging I'm doing here (I mentioned these
> in response to an earlier review already):
> 
>   1. Dynamic debugging can't be enabled at a function or line level on
>      the kernel command line, so this means that to debug issues
>      during boot you have to enable everything, which can be way too
>      verbose

You can, and should enable it at a function or line level by writing to
the proper kernel file in debugfs.

You have read Documentation/admin-guide/dynamic-debug-howto.rst, right?

No need to do anything on the command line, that's so old-school :)

>   2. The expressions to enable the individual logging statements are
>      quite brittle (in particular the line-based ones) since they
>      (may) change any time the code is changed - having stable
>      commands to give to users and put in documentation (e.g.
>      "echo 0x200 > /sys/module/applespi/parameters/debug") is
>      quite valuable.
> 
>      One way to work around this would be to put every single logging
>      statement in a function of its own, thereby ensuring a stable
>      name is associated with each one.

Again, read the documentation, this works today as-is.

>   3. In at least two places we log different types of packets in the
>      same lines of code (protected by a "if (log_mask & PKT_TYPE)") -
>      dynamic-debug would only allow enabling or disabling logging of
>      all packets. This could be worked around by creating a separate
>      (but essentially duplicate) logging function for each packet type
>      and some lookup table to call the appropriate one. Not very
>      pretty IMO, though.

True, but you can use tracepoints as well, that would probably be much
easier when you are logging data streams.  You can also use an ebpf
program with the tracepoints to log just what you need/want to when you
want to as well.

>   4. In a couple places we log both the sent command and the received
>      response, with the log-mask determining for which types of
>      packets to do this. With a log mask there is one bit to set to
>      get both logged; with dynamic debugging you'd have to enable the
>      writing and receiving parts separately (not a huge deal, but yet
>      one place where things are a bit more complicated than
>      necessary).
> 
> Except for the first, none of these are insurmountable, but together
> they don't make dynamic debugging very attractive for this sort of
> logging.

Look into it some more, we have all of this covered today, no need for
just a single driver to do something fancy on its own :)

thanks,

greg k-h
