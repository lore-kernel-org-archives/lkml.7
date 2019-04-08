Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2868621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDHMHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:07:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:53002 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfDHMHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:07:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 05:07:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="132398440"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 08 Apr 2019 05:07:38 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hDT3o-0007Tr-Km; Mon, 08 Apr 2019 15:07:36 +0300
Date:   Mon, 8 Apr 2019 15:07:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging
 function.
Message-ID: <20190408120736.GN9224@smile.fi.intel.com>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-4-ronald@innovation.ch>
 <20190327023757.GB20766@kroah.com>
 <20190328002817.GF24753@innovation.ch>
 <20190328052917.GB18668@kroah.com>
 <20190328102755.GA26446@innovation.ch>
 <20190328112952.GA2232@kroah.com>
 <20190402024714.GA14213@innovation.ch>
 <20190402063326.GB7218@kroah.com>
 <20190407014613.GA14812@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190407014613.GA14812@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 06:46:13PM -0700, Life is hard, and then you die wrote:
> > On Mon, Apr 01, 2019 at 07:47:14PM -0700, Life is hard, and then you die wrote:
> > > On Thu, Mar 28, 2019 at 12:29:52PM +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Mar 28, 2019 at 03:27:55AM -0700, Life is hard, and then you die wrote:
> > > > > On Thu, Mar 28, 2019 at 06:29:17AM +0100, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Mar 27, 2019 at 05:28:17PM -0700, Life is hard, and then you die wrote:
> > > > > > > On Wed, Mar 27, 2019 at 11:37:57AM +0900, Greg Kroah-Hartman wrote:
> > > > > > > > On Tue, Mar 26, 2019 at 06:48:06PM -0700, Ronald Tschalär wrote:

> > You can do dynamic debugging from the kernel command line, if your code
> > is built into the kernel (but why would a tiny driver under testing like
> > this, not be built into the kernel?) what specifically did not work for you?
> 
> This may be part of our disconnect: there's almost no reason (and
> several downsides) to building it into the kernel instead of as a
> module:
> 
> - When developing, being able to just reload the module instead of
>   rebooting is just so much faster and more convenient.

modprobe -r foo
modprobe foo dyndbg=...

Not an argument.

> - For other users, having them build the driver as a dkms managed
>   module is also by far the simplest and least error-prone approach -
>   explaning to users how to rebuild their kernel (something most of
>   them have never done) takes a bunch of time and effort on both
>   sides for essentially no gain.
> 
> - Once the driver is part of the regular kernel, practically all
>   distro's will build it as a module (at least I'm fairly certain
>   about this).

Above seems a sub-items to the first one. So, reloading module with dyndbg
parameter is quite flexible. What else?

> > You can enable/disable logging per-function, which is what you want,
> > right?
> 
> Yes'ish: the problem is that if they are just part of regular
> functions, A) the chances are higher that the function may get renamed
> and hence any existing debug instructions broken, and B) this doesn't
> work if there are multiple debug statements in a function. Hence my
> assertion that for this work well (and yes, it can work well) you
> basically need to create a separate function for each debug statement
> (which that contains just that debug statement) (a sort of stable
> labelling of each debug statement).

I guess you tried and have an examples?

-- 
With Best Regards,
Andy Shevchenko


