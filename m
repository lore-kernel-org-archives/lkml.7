Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BF320652
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfD2Nfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:35:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:10022 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2Nfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:35:39 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 06:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="153269775"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Apr 2019 06:35:36 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1hL6RT-0008Mj-IN; Mon, 29 Apr 2019 16:35:35 +0300
Date:   Mon, 29 Apr 2019 16:35:35 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
Message-ID: <20190429133535.GG9224@smile.fi.intel.com>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com>
 <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com>
 <87tvejakot.fsf@haabendal.dk>
 <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
 <87y33tz5oz.fsf@haabendal.dk>
 <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
 <87ef5lxiqm.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef5lxiqm.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:29:05AM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Mon, Apr 29, 2019 at 9:27 AM Esben Haabendal <esben@haabendal.dk> wrote:
> >> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> >> > On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> >> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
> >> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> So maybe we should go down that direction intead, extending 8250 driver
> to replace mapbase with a resource struct instead?
> 
> > Btw, we have PCI MFD driver which enumerates 8250 (more precisely
> > 8250_dw) w/o any issues.
> 
> I am aware of that (sm501.c).  It avoids the problem by not requesting
> the parent memory region (sm->io_res), and requesting all child memory
> regions directly in root instead of relative to the sm->io_res parent.
> 
> But as resoure management is designed for managing a parent/child
> resource tree, this looks much more like a workaround than the right
> solution.
> 
> >> It would be nice if child drivers requesting memory would pass the
> >> parent memory resource.  Maybe 8250 driver could be changed to accept a
> >> struct resource pointer instead of a simple mapbase value, allowing to
> >> setup the resource with parent pointing to the MFD memory resource.
> >
> > I don't see the problem in certain driver, I guess you are trying to
> > workaround existin Linux device resource model.
> 
> No, I actually try to do the right thing in relation to Linux device
> resource model.  But 8250 is just not behaving very well in that
> respect, not having been made really aware of the resource model.

The point here is that. MFD driver can re-use existing platform drivers which
may be used standalone. They and only they are the right owners of the
requesting *their* resources.

When parent request resources on the behalf of its child it simple will break
this flexibility.

-- 
With Best Regards,
Andy Shevchenko


