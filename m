Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F67CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0D4206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfC1JJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:09:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:51420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfC1JJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:09:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 02:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="155974327"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 28 Mar 2019 02:09:39 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9R2Y-0000Pl-57; Thu, 28 Mar 2019 11:09:38 +0200
Date:   Thu, 28 Mar 2019 11:09:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] x86/boot: Convert early_serial_base to unsigned
 long
Message-ID: <20190328090938.GT9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-2-andriy.shevchenko@linux.intel.com>
 <20190328082823.GC22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328082823.GC22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 09:28:23AM +0100, Borislav Petkov wrote:
> On Tue, Mar 19, 2019 at 09:43:19PM +0300, Andy Shevchenko wrote:
> > As a preparatory of adding flexible serial I/O accessors, convert
> > early_serial_base to unsigned long to cover all possible bus addresses
> > on the system.

> > @@ -48,7 +48,7 @@ static void parse_earlyprintk(void)
> >  	int baud = DEFAULT_BAUD;
> >  	char arg[32];
> >  	int pos = 0;
> > -	int port = 0;
> > +	unsigned long port = 0;
> >  
> >  	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
> >  		char *e;
> > @@ -118,7 +118,7 @@ static void parse_console_uart8250(void)
> >  {
> >  	char optstr[64], *options;
> >  	int baud = DEFAULT_BAUD;
> > -	int port = 0;
> > +	unsigned long port = 0;
> 
> Here and above:

Agree on above and will fix, but don't see how this different in the latter?

> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type A> longest_variable_name;
> 	<type B> shorter_var_name;
> 	<type C> even_shorter;
> 	<type D> i;
> 

-- 
With Best Regards,
Andy Shevchenko


