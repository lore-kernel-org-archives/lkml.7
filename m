Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3D62147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfCLOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:40:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:10221 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:40:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 07:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="141341129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 12 Mar 2019 07:40:53 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h3iaK-0007xM-PH; Tue, 12 Mar 2019 16:40:52 +0200
Date:   Tue, 12 Mar 2019 16:40:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] auxdisplay: hd44780: Fix memory leak on ->remove()
Message-ID: <20190312144052.GC9224@smile.fi.intel.com>
References: <20190312131830.4253-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVTKRJJDqtpgExmEmwnYcpF8h2xTtbXwKLnVmVPz0bZqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVTKRJJDqtpgExmEmwnYcpF8h2xTtbXwKLnVmVPz0bZqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:47:01PM +0100, Geert Uytterhoeven wrote:
> On Tue, Mar 12, 2019 at 2:18 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > We have to free on ->remove() the allocated resources on ->probe().
> >
> > Fixes: d47d88361fee ("auxdisplay: Add HD44780 Character LCD support")
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks, nice catch!
> 
> (wearing a newer (and hopefully wiser ;-) hat than when I wrote the code)
> 
> While this is correct for the current implementation of struct charlcd_priv,
> this may be a bit fragile.

This patch will be the same in the next version due to possibility to easy
backport.

> What about adding a charlcd_free() wrapper, which can do kfree(to_priv(lcd)),
> and be used in the probe failure path, too?

This has been partially done in the rest of the series, but I got your advise
and will change to use to_priv() in v2. Thanks!

-- 
With Best Regards,
Andy Shevchenko


