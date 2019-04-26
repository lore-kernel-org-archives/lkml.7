Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07262C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA59120869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDZVvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:51:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:18194 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfDZVvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:51:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Apr 2019 14:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,399,1549958400"; 
   d="scan'208";a="227078436"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2019 14:51:05 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hK8kJ-0003Bo-WB; Sat, 27 Apr 2019 00:51:03 +0300
Date:   Sat, 27 Apr 2019 00:51:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without
 UPF_BOOT_AUTOCONF
Message-ID: <20190426215103.GD9224@smile.fi.intel.com>
References: <20190426084038.6377-1-esben@geanix.com>
 <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com>
 <871s1og11u.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s1og11u.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Fri, Apr 26, 2019 at 10:40:37AM +0200, Esben Haabendal wrote:
> >> With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
> >> is not possible to register a port without having
> >> serial8250_request_std_resource() called.
> >> 
> >> For adding a 8250 port to an MFD device, this is problematic, as the
> >> request_mem_region() call will fail, as the MFD device (and rightly  so)
> >> has requested the region.  For this case, the 8250 port should accept
> >> having passed mapbase and membase, and just use that.
> >
> > You need to simple set port type and use UPF_FIXED_TYPE.
> > No need for this patch.
> 
> The reason for this patch is to be able to do exactly that (set port
> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
> 
> In the current serial8250_register_8250_port() there is:
> 
>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
> 
> So, even though I set UPF_FIXED_TYPE, I get
> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF. 

Yes.

> So I need this patch.

Why? I don't see any problems to have these flags set. Moreover, some drivers
are used as MFD counterparts with exactly same bits set.

> I think it is unfortunate that UPF_BOOT_AUTOCONF is or'ed to flags like
> that, but changing that will surely break stuff.

True.

-- 
With Best Regards,
Andy Shevchenko


