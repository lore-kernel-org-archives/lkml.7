Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E61BC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D4420815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfETIgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:36:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:40593 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbfETIgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:36:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 01:36:07 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2019 01:36:02 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 May 2019 11:36:01 +0300
Date:   Mon, 20 May 2019 11:36:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by node
Message-ID: <20190520083601.GE1887@kuha.fi.intel.com>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1557823643-8616-5-git-send-email-chunfeng.yun@mediatek.com>
 <20190517103736.GA1490@kuha.fi.intel.com>
 <20190517130511.GA1887@kuha.fi.intel.com>
 <1558319951.10179.352.camel@mhfsdcap03>
 <20190520080359.GC1887@kuha.fi.intel.com>
 <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 08:06:41AM +0000, Biju Das wrote:
> Hi Heikki,
> 
> > -----Original Message-----
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Sent: Monday, May 20, 2019 9:04 AM
> > To: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Mark Rutland <mark.rutland@arm.com>;
> > Matthias Brugger <matthias.bgg@gmail.com>; Adam Thomson
> > <Adam.Thomson.Opensource@diasemi.com>; Li Jun <jun.li@nxp.com>;
> > Badhri Jagan Sridharan <badhri@google.com>; Hans de Goede
> > <hdegoede@redhat.com>; Andy Shevchenko
> > <andy.shevchenko@gmail.com>; Min Guo <min.guo@mediatek.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > mediatek@lists.infradead.org; Biju Das <biju.das@bp.renesas.com>; Linus
> > Walleij <linus.walleij@linaro.org>
> > Subject: Re: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
> > node
> > 
> > On Mon, May 20, 2019 at 10:39:11AM +0800, Chunfeng Yun wrote:
> > > Hi,
> > > On Fri, 2019-05-17 at 16:05 +0300, Heikki Krogerus wrote:
> > > > Hi,
> > > >
> > > > On Fri, May 17, 2019 at 01:37:36PM +0300, Heikki Krogerus wrote:
> > > > > On Tue, May 14, 2019 at 04:47:21PM +0800, Chunfeng Yun wrote:
> > > > > > Add fwnode_usb_role_switch_get() to make easier to get
> > > > > > usb_role_switch by fwnode which register it.
> > > > > > It's useful when there is not device_connection registered
> > > > > > between two drivers and only knows the fwnode which register
> > > > > > usb_role_switch.
> > > > > >
> > > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > > Tested-by: Biju Das <biju.das@bp.renesas.com>
> > > > >
> > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > >
> > > > Hold on. I just noticed Rob's comment on patch 2/6, where he points
> > > > out that you don't need to use device graph since the controller is
> > > > the parent of the connector. Doesn't that mean you don't really need
> > > > this API?
> > > No, I still need it.
> > > The change is about the way how to get fwnode; when use device graph,
> > > get fwnode by of_graph_get_remote_node(); but now will get fwnode by
> > > of_get_parent();
> > 
> > OK, I get that, but I'm still not convinced about if something like this function
> > is needed at all. I also have concerns regarding how you are using the
> > function. I'll explain in comment to the patch 5/6 in this series...
> 
> FYI, Currently  I am also using this api in my patch series.
> https://patchwork.kernel.org/patch/10944637/

Yes, and I have the same question for you I jusb asked in comment I
added to the patch 5/6 of this series. Why isn't usb_role_switch_get()
enough?

thanks,

-- 
heikki
