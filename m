Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1300321872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfCOKeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:34:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:42093 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbfCOKeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:34:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 03:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="155309035"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 15 Mar 2019 03:34:18 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Mar 2019 12:34:17 +0200
Date:   Fri, 15 Mar 2019 12:34:17 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/6] usb: roles: add API to get usb_role_switch by node
Message-ID: <20190315103417.GH7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
 <20190315081835.GD7752@kuha.fi.intel.com>
 <1552641204.10179.133.camel@mhfsdcap03>
 <20190315092644.GG7752@kuha.fi.intel.com>
 <1552642379.10179.138.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552642379.10179.138.camel@mhfsdcap03>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 05:32:59PM +0800, Chunfeng Yun wrote:
> Hi,
> On Fri, 2019-03-15 at 11:26 +0200, Heikki Krogerus wrote:
> > Hi Chunfeng,
> > 
> > On Fri, Mar 15, 2019 at 05:13:24PM +0800, Chunfeng Yun wrote:
> > > I encounter a build error when CONFIG_USB_ROLE_SWITCH is not enabled,
> > > 
> > > drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_role_sw_register':
> > > ./drivers/usb/mtu3/mtu3_dr.c:460: undefined reference to
> > > `usb_role_switch_register'
> > > drivers/usb/mtu3/mtu3_dr.o: In function `ssusb_otg_switch_exit':
> > > ./drivers/usb/mtu3/mtu3_dr.c:491: undefined reference to
> > > `usb_role_switch_unregister'
> > 
> > So you need to add dependency on USB_ROLE_SWITCH, right?
> Yes
> 
> > 
> > --- a/drivers/usb/mtu3/Kconfig
> > +++ b/drivers/usb/mtu3/Kconfig
> > @@ -43,6 +43,7 @@ config USB_MTU3_DUAL_ROLE
> >         bool "Dual Role mode"
> >         depends on ((USB=y || USB=USB_MTU3) && (USB_GADGET=y || USB_GADGET=USB_MTU3))
> >         depends on (EXTCON=y || EXTCON=USB_MTU3)
> > +       depends on USB_ROLE_SWITCH
> >         help
> >           This is the default mode of working of MTU3 controller where
> >           both host and gadget features are enabled.
> > 
> > > the following patch has fixed the issue, but seems not get into kernel,
> > > [v3,08/12] usb: roles: Add usb role switch notifier.
> > > https://patchwork.kernel.org/patch/10836525/
> > 
> > I don't understand how that fixes the problem? That patch will in any
> > case be targeting v5.2. We are in the middle of merge window, so
> > nothing is happening until v5.1-rc1 is tagged.
> It provides some dummy inline functions when USB_ROLE_SWITCH is not
> enabled, this will avoid build error

Ah, true. Those should brobable be introduced in their own patch.


thanks,

-- 
heikki
