Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D861206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="CoBy1iO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfC1K14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:27:56 -0400
Received: from chill.innovation.ch ([216.218.245.220]:33932 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1K14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:27:56 -0400
Date:   Thu, 28 Mar 2019 03:27:55 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 2F641640114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553768875;
        bh=4YIB/iEMRDd/B8VPHsfWvuGhG+iTEZtz6gaJhllPaS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CoBy1iO7j/D4DfSRFV6k4UGEMP+EEHlXzv8pcNXh/SbOSkkwPU4OsGQVOFYWn+Ma0
         lsqP7MikZBnodm8mO8N80npuLZBs/YCPq9acPr8P7D/rmSmF8Yf2LE+rnEw6PWIVs0
         H1KK66nvUPcz+yxkSZHdCuDMHgjQPbSa47SBIZEnMRva1P0InY4MNYCKy63CxMAvU1
         3FFgEMiv0MVvlDZKjm0RPFCIiO3nSprXsWfOvhGFA1juq4HSjjsaRaKu/h4KhGJNEL
         7CflhdBg55wilXuiDpNnn4TrisgjBWP5GYBxzx74tT3a4kENCuUF3Mxm6qgYwJJtPN
         YSzfoouHfwNzA==
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
Message-ID: <20190328102755.GA26446@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328052917.GB18668@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > 
> > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:
> > > > This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
> > > > instead of straight printk() to match other dev_xxx() logging functions.
> > > > ---
> > > >  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/device.h | 15 +++++++++++++++
> > > >  2 files changed, 58 insertions(+)
> > > 
> > > No signed-off-by?
> > 
> > Aargh! Apologies, fixed for the future.
> > 
> > > Anyway, no, please do not do this.  Please do not dump large hex values
> > > like this to the kernel log, it does not help anyone.
> > > 
> > > You can do this while debugging, sure, but not for "real" kernel code.
> > 
> > As used by this driver, it is definitely called for debugging only and
> > must be explicitly enabled via a module param. But having the ability
> > for folks to easily generate and print out debugging info has proven
> > quite valuable.
> 
> We have dynamic debugging, no need for module parameters at all.  This
> isn't the 1990's anymore :)

I am aware of dynamic debugging, but there are several issues with it
from the perspective of the logging I'm doing here (I mentioned these
in response to an earlier review already):

  1. Dynamic debugging can't be enabled at a function or line level on
     the kernel command line, so this means that to debug issues
     during boot you have to enable everything, which can be way too
     verbose

  2. The expressions to enable the individual logging statements are
     quite brittle (in particular the line-based ones) since they
     (may) change any time the code is changed - having stable
     commands to give to users and put in documentation (e.g.
     "echo 0x200 > /sys/module/applespi/parameters/debug") is
     quite valuable.

     One way to work around this would be to put every single logging
     statement in a function of its own, thereby ensuring a stable
     name is associated with each one.

  3. In at least two places we log different types of packets in the
     same lines of code (protected by a "if (log_mask & PKT_TYPE)") -
     dynamic-debug would only allow enabling or disabling logging of
     all packets. This could be worked around by creating a separate
     (but essentially duplicate) logging function for each packet type
     and some lookup table to call the appropriate one. Not very
     pretty IMO, though.

  4. In a couple places we log both the sent command and the received
     response, with the log-mask determining for which types of
     packets to do this. With a log mask there is one bit to set to
     get both logged; with dynamic debugging you'd have to enable the
     writing and receiving parts separately (not a huge deal, but yet
     one place where things are a bit more complicated than
     necessary).

Except for the first, none of these are insurmountable, but together
they don't make dynamic debugging very attractive for this sort of
logging.


  Cheers,

  Ronald

