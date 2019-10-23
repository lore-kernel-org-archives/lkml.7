Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBCCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE7121872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406066AbfJWO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:29:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:7610 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403845AbfJWO3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:29:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 07:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="209932154"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 07:29:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Oct 2019 17:29:00 +0300
Date:   Wed, 23 Oct 2019 17:29:00 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Puma Hsu <pumahsu@google.com>, gregkh@linuxfoundation.org,
        badhri@google.com, kyletso@google.com, albertccwang@google.com,
        rickyniu@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] usb: typec: Add sysfs node to show connector
 orientation
Message-ID: <20191023142900.GA15396@kuha.fi.intel.com>
References: <20191022085924.92783-1-pumahsu@google.com>
 <20191023083221.GB8828@kuha.fi.intel.com>
 <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644d890b-86e8-f05a-cd4c-32937d971a45@roeck-us.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:44:39AM -0700, Guenter Roeck wrote:
> On 10/23/19 1:32 AM, Heikki Krogerus wrote:
> > +Guenter
> > 
> > On Tue, Oct 22, 2019 at 04:59:24PM +0800, Puma Hsu wrote:
> > > Export the Type-C connector orientation so that user space
> > > can get this information.
> > > 
> > > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > > ---
> > >   Documentation/ABI/testing/sysfs-class-typec | 11 +++++++++++
> > >   drivers/usb/typec/class.c                   | 18 ++++++++++++++++++
> > >   2 files changed, 29 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > > index d7647b258c3c..b22f71801671 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > @@ -108,6 +108,17 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > >   Description:
> > >   		Revision number of the supported USB Type-C specification.
> > > +What:		/sys/class/typec/<port>/connector_orientation
> > > +Date:		October 2019
> > > +Contact:	Puma Hsu <pumahsu@google.com>
> > > +Description:
> > > +		Indicates which typec connector orientation is configured now.
> > > +		cc1 is defined as "normal" and cc2 is defined as "reversed".
> > > +
> > > +		Valid value:
> > > +		- unknown (nothing configured)
> > 
> > "unknown" means we do not know the orientation.
> > 
> > > +		- normal (configured in cc1 side)
> > > +		- reversed (configured in cc2 side)
> > 
> > Guenter, do you think "connector_orientation" OK. I proposed it, but
> > I'm now wondering if something like "polarity" would be better?
> > 
> 
> Yes, or just "orientation". I don't see the value in the "connector_" prefix.
> I also wonder if "unknown" is really correct. Is it really unknown, or
> does it mean that the port is disconnected ?

Unknown means we don't know the orientation. We don't always have that
information available to us. With UCSI we simply do not know it.

I think this file needs to be hidden after all if we don't know the
cable plug orientation.

How about empty string instead of "unknown"?

thanks,

-- 
heikki
