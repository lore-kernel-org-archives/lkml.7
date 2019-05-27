Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990B2C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F03720883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfE0KpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:45:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:30969 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE0KpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:45:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 03:45:12 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 27 May 2019 03:45:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 27 May 2019 13:45:06 +0300
Date:   Mon, 27 May 2019 13:45:06 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
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
Message-ID: <20190527104506.GA7167@kuha.fi.intel.com>
References: <20190520083601.GE1887@kuha.fi.intel.com>
 <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20190521095839.GI1887@kuha.fi.intel.com>
 <OSBPR01MB21032206146152983C8F4E8EB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <1558517436.10179.388.camel@mhfsdcap03>
 <OSBPR01MB21038F2B99EF74831A22727BB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20190522142640.GN1887@kuha.fi.intel.com>
 <1558606570.10179.403.camel@mhfsdcap03>
 <20190524114036.GO1887@kuha.fi.intel.com>
 <1558926443.10179.438.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558926443.10179.438.camel@mhfsdcap03>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > IMO that case should be handled in USB role switch API initially, not
> > in the device connection API. If there is another user for it one day,
> > then we can move it to device connection API, but not before that.
> Ok
> > 
> > How about this on top of the two patches I sent:
> I just test it, it works well.
> I'll prepare a patch and put into this series.
> 
> > 
> > diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> > index aab795b54c7f..36ac9d181e09 100644
> > --- a/drivers/usb/roles/class.c
> > +++ b/drivers/usb/roles/class.c
> > @@ -114,6 +114,19 @@ static void *usb_role_switch_match(struct device_connection *con, int ep,
> >         return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> >  }
> > 
> > +static struct usb_role_switch *
> > +usb_role_switch_is_parent(struct fwnode_handle *parent)
> > +{
> > +       struct device *dev;
> > +
> > +       if (!parent || !fwnode_property_present(parent, "usb-role-switch"))
> > +               return NULL;
> > +
> > +       dev = class_find_device(role_class, NULL, parent, switch_fwnode_match);
> > +
> > +       return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
> > +}
> > +
> >  /**
> >   * usb_role_switch_get - Find USB role switch linked with the caller
> >   * @dev: The caller device
> > @@ -125,6 +138,10 @@ struct usb_role_switch *usb_role_switch_get(struct device *dev)
> >  {
> >         struct usb_role_switch *sw;
> > 
> > +       sw = usb_role_switch_is_parent(fwnode_get_parent(dev_fwnode(dev)));
> > +       if (sw)
> > +               return sw;
> Do we also need to get parent module before return?

Yes.

thanks,

-- 
heikki
