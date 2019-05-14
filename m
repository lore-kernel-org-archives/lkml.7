Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD66C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49ECC20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfENMmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:42:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:14908 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfENMmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:42:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 05:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,468,1549958400"; 
   d="scan'208";a="171569884"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 14 May 2019 05:42:43 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1hQWlV-00080i-VZ; Tue, 14 May 2019 15:42:41 +0300
Date:   Tue, 14 May 2019 15:42:41 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Message-ID: <20190514124241.GD9224@smile.fi.intel.com>
References: <87pnp11112.fsf@haabendal.dk>
 <20190507093239.GB4529@dell>
 <87sgtqjy3l.fsf@haabendal.dk>
 <20190507115325.GV9224@smile.fi.intel.com>
 <87k1f2jvyd.fsf@haabendal.dk>
 <20190507150847.GW9224@smile.fi.intel.com>
 <87k1etmrfk.fsf@haabendal.dk>
 <CAHp75VfrP6SLVzmp6LepN7dU1c7QYxfRDRtj7dCTuWzmYp2tCA@mail.gmail.com>
 <CAHp75VetoajaeqUnUuj4sNjhujqDkbqvQmxE+LMtzFN4so_jwA@mail.gmail.com>
 <87zhnpkzvj.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhnpkzvj.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 02:02:40PM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> 
> > On Tue, May 14, 2019 at 12:23 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Tue, May 14, 2019 at 10:24 AM Esben Haabendal <esben@haabendal.dk> wrote:
> >
> >> > Please take a look at https://lkml.org/lkml/2019/4/9/576
> >> > ("[PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip")
> >>
> >> Thank you for this link.
> >> Now, look at this comment:
> >>
> >> + /*
> >> + * Map all IOC3 registers.  These are shared between subdevices
> >> + * so the main IOC3 module manages them.
> >> + */
> >>
> >> Is it your case? Can we see the code?
> >
> > They do not request resources by the way.
> 
> Actually, that looks like a bug in ioc3.c driver.

Nope. This is the right thing to do.

> It is using mfd_add_devices() with a mem_base that has not been properly
> requested, and the platform_get_resource() calls made by child drivers
> does not guarantee exclusive access to the memory resources, as they are
> not inserted in the root memory resource tree.

Should platform_get_resource() guarantee that? I think no, otherwise entire MFD
and other logic will collapse.

> > You may do the same, I told you this several times.
> 
> In drivers/mfd/ioc3.c:
> 
> First, the uart resources are defined.  The register memory resource is
> defined relative to the mfd driver memory resource.
> 
> +static struct resource ioc3_uarta_resources[] = {
> +	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uarta),
> +		       sizeof_field(struct ioc3, sregs.uarta)),
> +	DEFINE_RES_IRQ(6)
> +};
> 
> This is then used when creating the uart cell.
> 
> +		cell->name = "ioc3-serial8250";
> +		cell->id = ioc3_serial_id++;
> +		cell->resources = ioc3_uarta_resources;
> +		cell->num_resources = ARRAY_SIZE(ioc3_uarta_resources);
> 
> Finally, the mfd_add_devices() call is made, giving the resource for the
> BAR0 region (&ipd->pdev->resource[0]) as mem_base argument:
> 
> +	mfd_add_devices(&ipd->pdev->dev, -1, ioc3_mfd_cells,
> +			cell - ioc3_mfd_cells, &ipd->pdev->resource[0],
> +			0, ipd->domain);
> 
> This is just what I want to do.
> 

> But in order to guarantee exclusive access to the memory resource, I
> need to have it requested.

Here the root of our misunderstanding each other.

Every driver till now works fine and entire model works fine without resources
being requested.

I told you already that if you want your way that has to be done not in 8250
driver, but in generic code (driver core or even resource framework).

-- 
With Best Regards,
Andy Shevchenko


