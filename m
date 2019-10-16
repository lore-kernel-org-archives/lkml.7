Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1C0FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD86A20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393462AbfJPNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:09:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:37918 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391745AbfJPNJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:09:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 06:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="208407779"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 16 Oct 2019 06:09:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 16 Oct 2019 16:09:54 +0300
Date:   Wed, 16 Oct 2019 16:09:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     pumahsu <pumahsu@google.com>
Cc:     gregkh@linuxfoundation.org, badhri@google.com, kyletso@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Add sysfs node to show cc orientation
Message-ID: <20191016130954.GD17542@kuha.fi.intel.com>
References: <20191016034314.231363-1-pumahsu@google.com>
 <20191016125846.GC17542@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016125846.GC17542@kuha.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:58:50PM +0300, Heikki Krogerus wrote:
> On Wed, Oct 16, 2019 at 11:43:14AM +0800, pumahsu wrote:
> > Export the Type-C cc orientation so that user space can
> > get this information.
> 
> For what do you need this information in user space? I'm guessing you
> have something else in mind besides exposing this as just generic
> information, or debugging purposes, no?
> 
> Please keep in mind that we do not always know the cable orientation.
> UCSI for example does not give any clues about which way the cable
> plug was connected to the connector. That means this sysfs file will
> most likely need to be hidden in those cases, which I guess is
> acceptable, but definitely not ideal.
> 
> > Signed-off-by: pumahsu <pumahsu@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec |  7 +++++++
> >  drivers/usb/typec/class.c                   | 11 +++++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > index d7647b258c3c..419f952c991d 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -108,6 +108,13 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >  Description:
> >  		Revision number of the supported USB Type-C specification.
> >  
> > +What:		/sys/class/typec/<port>/cc_orientation
> > +Date:		September 2019
> > +Contact:	Puma Hsu <pumahsu@google.com>
> > +Description:
> > +		Indicates which cc orientation is active now, or 0 when
> > +		nothing is connected.
> 
> cc_orientation is a bit cryptic. I think if this is part of the port
> ABI, then we should talk about something like "connector_orientation".
> 
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >  
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 7d8805d9bf37..00edae63da8e 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1238,6 +1238,16 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(usb_power_delivery_revision);
> >  
> > +static ssize_t cc_orientation_show(struct device *dev,
> > +						struct device_attribute *attr,
> > +						char *buf)
> > +{
> > +	struct typec_port *p = to_typec_port(dev);
> > +
> > +	return sprintf(buf, "%d\n", typec_get_orientation(p));
> > +}
> > +static DEVICE_ATTR_RO(cc_orientation);
> 
> Now you are returning 0, 1 or 2 which to me is not ideal. This really
> should return a string, something like "normal" / "reversed", and in
> case the orientation is TYPEC_ORIENTATION_NONE, empty string.

Or maybe TYPEC_ORIENTATION_NONE could be handle with "unknown" string.
That way we may not need to hide the file.

thanks,

-- 
heikki
