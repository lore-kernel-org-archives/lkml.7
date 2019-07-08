Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613DFC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F2D20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfGHG3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:29:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:49163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbfGHG3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:29:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 23:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="asc'?scan'208";a="192212086"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2019 23:29:11 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede\@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus\@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <87r274lmqk.fsf@linux.intel.com> <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 08 Jul 2019 09:29:01 +0300
Message-ID: <87a7dpm442.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>> +void cdns3_role_stop(struct cdns3 *cdns)
>>
>>not static? Why is it so that _start() is static but _stop() is not?
>>Looks fishy
>
> This function is used in cdns3_role_stop in debugfs.c file so it can't
> be static.

it's still super fishy. Why don't you need _start() from debugfs.c? In
any case, the role framework would remove the need for any of this, I
suppose.

>>> +static int cdns3_idle_role_start(struct cdns3 *cnds)
>>> +{	/* Hold PHY in RESET */
>>
>>huh?
>>
>>> +	return 0;
>>> +}
>>> +
>>> +static void cdns3_idle_role_stop(struct cdns3 *cnds)
>>> +{
>>> +	/* Program Lane swap and bring PHY out of RESET */
>>
>>double huh?
>>
>
> These functions were added for consistency with FSM described in controll=
er specification.=20
> Yes, I know that you don't like empty functions :), but it could be helpf=
ul in
> understanding how this controller work.

frankly, it really doesn't. An empty function doesn't really help IMHO.

>>> +static const char *const cdns3_mode[] =3D {
>>> +	[USB_DR_MODE_UNKNOWN]		=3D "unknown",
>>> +	[USB_DR_MODE_OTG]		=3D "otg",
>>> +	[USB_DR_MODE_HOST]		=3D "host",
>>> +	[USB_DR_MODE_PERIPHERAL]	=3D "device",
>>> +};
>>
>>don't we have a generic version of this under usb/common ?
>>
> Yes, there is a similar array, but it is defined also as static=20
> and there is no function for converting value to string.=20
> There is only function for converting string to value.

right. You can add the missing interface generically instead of
duplicating the enumeration.

> There is also:=20=20
> [USB_DR_MODE_UNKNOWN]		=3D "",
> Instead of:=20
> [USB_DR_MODE_UNKNOWN]		=3D "unknown",
>
> So, for USB_DR_MODE_UNKNOWN user will not see anything information.

But that's what "unknown" means :-) We don't know the information.

>>> +static irqreturn_t cdns3_drd_irq(int irq, void *data)
>>> +{
>>> +	irqreturn_t ret =3D IRQ_NONE;
>>> +	struct cdns3 *cdns =3D data;
>>> +	u32 reg;
>>> +
>>> +	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
>>> +		return ret;
>>> +
>>> +	reg =3D readl(&cdns->otg_regs->ivect);
>>> +
>>> +	if (!reg)
>>> +		return ret;
>>> +
>>> +	if (reg & OTGIEN_ID_CHANGE_INT) {
>>> +		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
>>> +			cdns3_get_id(cdns));
>>> +
>>> +		ret =3D IRQ_HANDLED;
>>> +	}
>>> +
>>> +	if (reg & (OTGIEN_VBUSVALID_RISE_INT | OTGIEN_VBUSVALID_FALL_INT)) {
>>> +		dev_dbg(cdns->dev, "OTG IRQ: new VBUS: %d\n",
>>> +			cdns3_get_vbus(cdns));
>>> +
>>> +		ret =3D IRQ_HANDLED;
>>> +	}
>>> +
>>> +	if (ret =3D=3D IRQ_HANDLED)
>>> +		queue_work(system_freezable_wq, &cdns->role_switch_wq);
>>> +
>>> +	writel(~0, &cdns->otg_regs->ivect);
>>> +	return ret;
>>> +}
>>
>>seems like you could use threaded irq to avoid this workqueue.
>
>
> This function is also called in cdns3_mode_write (debugfs.c file),
> therefor after changing it to threaded irq I will still need workqueue.=20

Why? debugfs writes are not atomic. They run in process context, right?
Just don't disable interrupts while running this and you should be fine.

>>> +	cdns->desired_dr_mode =3D cdns->dr_mode;
>>> +	cdns->current_dr_mode =3D USB_DR_MODE_UNKNOWN;
>>> +
>>> +	ret =3D devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
>>> +					cdns3_drd_irq,
>>> +					NULL, IRQF_SHARED,
>>
>>if you don't have a threaded handler, you should set IRQF_ONESHOT. I
>>would prefer if you implement a threaded handler that doesn't require
>>IRQF_ONESHOT, though.
>>
>
> IRQF_ONESHOT can be used  only in threaded handled.=20
> "
>  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler fi=
nished.
>  *                Used by threaded interrupts which need to keep the
>  *                irq line disabled until the threaded handler has been r=
un.
> "

so?

>>> +	} else {
>>> +		struct usb_request *request;
>>> +
>>> +		if (priv_dev->eps[index]->flags & EP_WEDGE) {
>>> +			cdns3_select_ep(priv_dev, 0x00);
>>> +			return 0;
>>> +		}
>>> +
>>> +		cdns3_dbg(priv_ep->cdns3_dev, "Clear Stalled endpoint %s\n",
>>> +			  priv_ep->name);
>>
>>why do you need your own wrapper around dev_dbg()? This looks quite unnec=
essary.
>
> It's generic function used for adding message to trace.log.  It's not wra=
pper to dev_dbg=20
>
> void cdns3_dbg(struct cdns3_device *priv_dev, const char *fmt, ...)
> {
> 	struct va_format vaf;
> 	va_list args;
>
> 	va_start(args, fmt);
> 	vaf.fmt =3D fmt;
> 	vaf.va =3D &args;
> 	trace_cdns3_log(priv_dev, &vaf);
> 	va_end(args);
> }

oh. Don't do it like that. Add a proper trace event that actually
decodes the information you want. These random messages will give you
trouble in the future. I had this sort of construct in dwc3 for a while
and it became clear that it's a bad idea. It's best to have trace events
that decode information coming from the HW. That way your trace logs
have a "predictable" shape/format and you can easily find problem areas.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0i4q8ACgkQzL64meEa
mQbupxAAoD9jP3fUR7sr+ju1et+756dRsmCz7XHRrOZ9P3xUMg34BanHMCMQ+mbv
80xqcplc95kH8ZEujbDdv863UNdUdvTRdtS6arMAT0OAwayXJPIA38zI7iFkIlkW
UupgYUSNJydp9IUGUE7VzvcaAPmULCFfJA3oorUTVSZb9+YTkLnZGmoBrZY7viEi
Q1gS/Kv74vJMaSQNdYoTyhNNWguoWPn3spfzRpf49DwIzoe5f3LFoff2BT1wFh3B
cFsB3n8hu9+4TR8SCCQtvyXHqws70B7ePXaOltIdGPvjJLgniHxDbMyDbvqPwv4d
SUIdqcx2NORh5u1Q1SB/XuR08Q73CsjdQnxdOp1AV3qLA6J8sOPV/WuXPuqxkFmv
vwjWsqaT9VX0iCbY5p8FTwKJ7qlLCmLVnMbDTyGl8lQqofRb/4s/zUf5IPqDEwHu
9sg+srJere77OybK48AkBTwfoNLqYrgFauQNVXSqEiIfOp/RuXoXhJNXoA/fcVOw
KTOrwLikCHvwzX2g7Hs+j6efx5EvzJ9UhYrvO3KIPs2THgZvSt+/exsgT4x8DI5E
sMqNVpHuHCMZ6r0/cG51O82AamnmNq/gxZKIuhxj14wnBDkvX8Ytjzj/7lftwF9G
URecaNSnwLSjhHRc/KTDIKbSzaDyIwfKbDzONwIGThB3DvwKNbk=
=KpNf
-----END PGP SIGNATURE-----
--=-=-=--
