Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B7ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942FA206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfJKPMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:12:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:20748 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:12:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2019 08:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; 
   d="scan'208";a="219419398"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 11 Oct 2019 08:12:21 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIwaa-0000bg-F3; Fri, 11 Oct 2019 18:12:20 +0300
Date:   Fri, 11 Oct 2019 18:12:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ipmi: use %*ph to print small buffer
Message-ID: <20191011151220.GB32742@smile.fi.intel.com>
References: <20191011145213.65082-1-andriy.shevchenko@linux.intel.com>
 <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eaca9a1bcbf9d87c1fb3c9135876c3ecb72a91b.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 07:58:14AM -0700, Joe Perches wrote:
> On Fri, 2019-10-11 at 17:52 +0300, Andy Shevchenko wrote:
> > Use %*ph format to print small buffer as hex string.
> > 
> > The change is safe since the specifier can handle up to 64 bytes and taking
> > into account the buffer size of 100 bytes on stack the function has never been
> > used to dump more than 32 bytes. Note, this also avoids potential buffer
> > overflow if the length of the input buffer is bigger.
> []
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> []
> > @@ -48,14 +48,7 @@ static int handle_one_recv_msg(struct ipmi_smi *intf,
> >  static void ipmi_debug_msg(const char *title, unsigned char *data,
> >  			   unsigned int len)
> >  {
> > -	int i, pos;
> > -	char buf[100];
> > -
> > -	pos = snprintf(buf, sizeof(buf), "%s: ", title);
> > -	for (i = 0; i < len; i++)
> > -		pos += snprintf(buf + pos, sizeof(buf) - pos,
> > -				" %2.2x", data[i]);
> > -	pr_debug("%s\n", buf);
> > +	pr_debug("%s: %*ph\n", title, len, buf);
> >  }
> >  #else
> >  static void ipmi_debug_msg(const char *title, unsigned char *data,
> 
> Now you might as well remove the #ifdef DEBUG above this
> and the empty function in the #else too.

It's up to maintainer.

-- 
With Best Regards,
Andy Shevchenko


