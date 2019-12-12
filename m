Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB5C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfLLMtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:49:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:32452 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbfLLMtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:49:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 04:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="220686438"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 12 Dec 2019 04:49:38 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Dec 2019 14:49:37 +0200
Date:   Thu, 12 Dec 2019 14:49:37 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhong jiang <zhongjiang@huawei.com>, linux@roeck-us.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fusb302: Fix an undefined reference to
 'extcon_get_state'
Message-ID: <20191212124937.GE31345@kuha.fi.intel.com>
References: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com>
 <20191212090132.GC31345@kuha.fi.intel.com>
 <5DF20530.2040509@huawei.com>
 <20191212092805.GA1375559@kroah.com>
 <5DF20B18.4020601@huawei.com>
 <20191212111805.GD31345@kuha.fi.intel.com>
 <20191212122053.GA1541203@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212122053.GA1541203@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:20:53PM +0100, Greg KH wrote:
> On Thu, Dec 12, 2019 at 01:18:05PM +0200, Heikki Krogerus wrote:
> > On Thu, Dec 12, 2019 at 05:40:40PM +0800, zhong jiang wrote:
> > > On 2019/12/12 17:28, Greg KH wrote:
> > > > On Thu, Dec 12, 2019 at 05:15:28PM +0800, zhong jiang wrote:
> > > >> On 2019/12/12 17:01, Heikki Krogerus wrote:
> > > >>> On Thu, Dec 12, 2019 at 03:34:23PM +0800, zhong jiang wrote:
> > > >>>> Fixes the following compile error:
> > > >>>>
> > > >>>> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
> > > >>>> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
> > > >>>> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
> > > >>>> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
> > > >>>> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
> > > >>>> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
> > > >>>> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
> > > >>>> make: *** [vmlinux] Error 1
> > > >>> There are stubs for those functions so that really should not be
> > > >>> happening. I can not reproduce that.
> > > >> It can be reproduced in next branch. you can try it in the latest next branch.
> > > > Can it be reproduced in 5.5-rc1?
> > > >
> > > commit 78adcacd4edbd6795e164bbda9a4b2b7e51666a7
> > > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date:   Thu Dec 12 15:48:07 2019 +1100
> > > 
> > >     Add linux-next specific files for 20191212
> > > 
> > > I  reproduce it  based on this commit.  The related config is attached.
> > 
> > OK, now I get what's going on. EXTCON is build as a module, but
> > FUSB302 is not. This should be explained in the commit message.
> > 
> > That does not mean we have to force everybody to enable EXTCON in
> > order to use this driver. Try something like this:
> > 
> > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> > index 72481bbb2af3..06e026f6325c 100644
> > --- a/drivers/usb/typec/tcpm/Kconfig
> > +++ b/drivers/usb/typec/tcpm/Kconfig
> > @@ -31,6 +31,7 @@ endif # TYPEC_TCPCI
> > 
> >  config TYPEC_FUSB302
> >         tristate "Fairchild FUSB302 Type-C chip driver"
> > +       depends on EXTCON=n || EXTCON=y || (EXTCON=m && m)
> 
> Ugh.  We need a better "pattern" for stuff like this, it's getting more
> and more frequent.
> 
> And no, I don't have a better idea :(

I think this works:

        depends on EXTCON || !EXTCON

thanks,

-- 
heikki
