Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8622BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512D32173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfC1NQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:16:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:38371 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfC1NQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:16:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 06:16:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="332842049"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2019 06:15:58 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9Usv-0002kh-A4; Thu, 28 Mar 2019 15:15:57 +0200
Date:   Thu, 28 Mar 2019 15:15:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>, Joe Perches <joe@perches.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] x86/boot: Split out parse_serial_port() helper
 for earlyprintk
Message-ID: <20190328131557.GY9224@smile.fi.intel.com>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
 <20190328123504.GF22720@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328123504.GF22720@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:35:04PM +0100, Borislav Petkov wrote:
> On Tue, Mar 19, 2019 at 09:43:21PM +0300, Andy Shevchenko wrote:
> > The newly introduced helper will be used later on to parse serial port
> > in different type of earlyprintk command line arguments.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/boot/early_serial_console.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
> > index 05d02cd4de99..85a227a21f95 100644
> > --- a/arch/x86/boot/early_serial_console.c
> > +++ b/arch/x86/boot/early_serial_console.c
> > @@ -66,6 +66,20 @@ static void early_serial_init(unsigned long port, int baud)
> >  	early_serial_base = port;
> >  }
> >  
> > +static unsigned long parse_serial_port(const char *arg, int off, int *pos)
> > +{
> > +	unsigned long port;
> > +	char *e;
> > +
> > +	port = simple_strtoull(arg + off, &e, 16);
> 
> WARNING: simple_strtoull is obsolete, use kstrtoull instead
> #41: FILE: arch/x86/boot/early_serial_console.c:74:
> +       port = simple_strtoull(arg + off, &e, 16);

kstrtox() simple can't cover _all_ simple_strtox() cases.

> Please do a conversion patch ontop.

I don't feel like uglifying code to satisfy a tool producing a silly warning.

-- 
With Best Regards,
Andy Shevchenko


