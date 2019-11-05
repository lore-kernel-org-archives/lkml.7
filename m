Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7E8C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA822190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbfKEMhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:37:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:17754 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388269AbfKEMhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:37:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 04:37:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="212533952"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2019 04:37:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 05 Nov 2019 14:37:27 +0200
Date:   Tue, 5 Nov 2019 14:37:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     Mao Wenan <maowenan@huawei.com>, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, nkristam@nvidia.com, arnd@arndb.de,
        johan@kernel.org, krzk@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] usb: gadget: Add dependency for USB_TEGRA_XUDC
Message-ID: <20191105123727.GA12204@kuha.fi.intel.com>
References: <20191104025945.172620-1-maowenan@huawei.com>
 <20191104100410.GB996639@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104100410.GB996639@ulmo>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:04:10AM +0100, Thierry Reding wrote:
> On Mon, Nov 04, 2019 at 10:59:45AM +0800, Mao Wenan wrote:
> > If CONFIG_USB_TEGRA_XUDC=y and CONFIG_USB_ROLE_SWITCH=m,
> > below erros can be seen:
> > drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_remove':
> > tegra-xudc.c:(.text+0x6b0): undefined reference to `usb_role_switch_unregister'
> > drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_probe':
> > tegra-xudc.c:(.text+0x1b88): undefined reference to `usb_role_switch_register'
> > drivers/usb/gadget/udc/tegra-xudc.o: In function `tegra_xudc_usb_role_sw_work':
> > tegra-xudc.c:(.text+0x5ecc): undefined reference to `usb_role_switch_get_role'
> > 
> > This patch add dependency USB_ROLE_SWITCH for UDC driver.
> > 
> > Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
> > Signed-off-by: Mao Wenan <maowenan@huawei.com>
> > ---
> >  drivers/usb/gadget/udc/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> > index acaec3a..d103154 100644
> > --- a/drivers/usb/gadget/udc/Kconfig
> > +++ b/drivers/usb/gadget/udc/Kconfig
> > @@ -445,6 +445,7 @@ config USB_TEGRA_XUDC
> >  	tristate "NVIDIA Tegra Superspeed USB 3.0 Device Controller"
> >  	depends on ARCH_TEGRA || COMPILE_TEST
> >  	depends on PHY_TEGRA_XUSB
> > +	depends on USB_ROLE_SWITCH
> 
> It looks like most other drivers that use the USB role switch class do
> "select" here. Now, that's suboptimal because USB_ROLE_SWITCH is a user-
> visible symbol, which can lead to conflicts, so it should be avoided. I
> think that in this case it might make sense to hide USB_ROLE_SWITCH and
> then convert all "depends on USB_ROLE_SWITCH" occurrences to "select
> USB_ROLE_SWITCH". The USB role switch class is, after all, not useful by
> itself. It always needs a host and/or gadget driver to make use of it.

USB host/gadget drivers actually never operate the role switches. If
the USB controller on the system is dual-role capable, then the driver
for that controller can supply the role switch, but it doesn't operate
it. Note that on some systems the USB host and USB peripheral
controllers are separate, and there is a mux (like the Intel USB role
mux) between them and the connector. On those systems the driver for
the mux represents the USB role switch.

The operation of the switch is done from the USB Type-C drivers with
USB Type-C connectors and from what ever driver can sense the ID-pin
and VBUS with micro-B/AB connectors, but with other type of
connectors the role swapping has to be done from user space. The use
case for that is probable something like Apple CarPlay that requires
the system to be able to swap the role even if the connector was good
old Type-A connector.

The point is in any case that the user of the switch is always
separate from the supplier of the switch.

I'm not sure hiding the option and converting all "depends on
USB_ROLE_SWITCH" to "select USB_ROLE_SWITCH" is the correct thing to
do. I would do the opposite and convert all "select USB_ROLE_SWTICH"
to "depends on USB_ROLE_SWITCH", and leave the option user selectable.

thanks,

-- 
heikki
