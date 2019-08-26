Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0A6C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B34C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbfHZNvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:51:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:5627 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731914AbfHZNvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:51:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 06:51:54 -0700
X-IronPort-AV: E=Sophos;i="5.64,433,1559545200"; 
   d="scan'208";a="209375290"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 06:51:53 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id CF34A20B48; Mon, 26 Aug 2019 16:51:51 +0300 (EEST)
Date:   Mon, 26 Aug 2019 16:51:51 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ACPI: Enable driver and firmware hints to control
 power at probe time
Message-ID: <20190826135151.GS31967@paasikivi.fi.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
 <20190826083112.8888-2-sakari.ailus@linux.intel.com>
 <20190826084343.GA1095@kroah.com>
 <20190826103200.GQ31967@paasikivi.fi.intel.com>
 <20190826133439.GA13275@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826133439.GA13275@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 03:34:39PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 26, 2019 at 01:32:00PM +0300, Sakari Ailus wrote:
> > Hi Greg,
> > 
> > On Mon, Aug 26, 2019 at 10:43:43AM +0200, Greg Kroah-Hartman wrote:
> > 
> > ...
> > 
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index 6717adee33f01..4bc0ea4a3201a 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -248,6 +248,12 @@ enum probe_type {
> > > >   * @owner:	The module owner.
> > > >   * @mod_name:	Used for built-in modules.
> > > >   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
> > > > + * @probe_low_power: The driver supports its probe function being called while
> > > > + *		     the device is in a low power state, independently of the
> > > > + *		     expected behaviour on combination of a given bus and
> > > > + *		     firmware interface etc. The driver is responsible for
> > > > + *		     powering the device on using runtime PM in such case.
> > > > + *		     This configuration has no effect if CONFIG_PM is disabled.
> > > >   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> > > >   * @of_match_table: The open firmware table.
> > > >   * @acpi_match_table: The ACPI match table.
> > > > @@ -285,6 +291,7 @@ struct device_driver {
> > > >  	const char		*mod_name;	/* used for built-in modules */
> > > >  
> > > >  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> > > > +	bool probe_low_power;
> > > 
> > > Ick, no, this should be a bus-specific thing to handle such messed up
> > > hardware.  Why polute this in the driver core?
> > 
> > The alternative could be to make it I²C specific indeed; the vast majority
> > of camera sensors are I²C devices these days.
> 
> Why is this even needed to be a bus/device attribute at all?  You are
> checking the firmware property in the probe function, just do the logic
> there as you are, what needs to be saved to the bus's logic?

By the time the driver gets hold of the device, or gets to control its
power state, the I²C framework has already called dev_pm_domain_attach() to
power on the device. The I²C drivers on ACPI based systems expect the
device to be powered on for probe.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
