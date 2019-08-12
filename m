Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B2C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA08206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHLIT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:19:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:42460 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfHLIT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:19:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 01:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="asc'?scan'208";a="175816374"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 01:19:24 -0700
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
In-Reply-To: <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <877e8tm25r.fsf@linux.intel.com> <BYAPR07MB4709152CB29B6B027ABEB688DDCF0@BYAPR07MB4709.namprd07.prod.outlook.com> <8736idnu0q.fsf@gmail.com> <BYAPR07MB4709B0A4FADFB76183D651DCDDD10@BYAPR07MB4709.namprd07.prod.outlook.com> <87k1bjvtvi.fsf@gmail.com> <BYAPR07MB470926DA6241B54FC5AF3C2ADDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Mon, 12 Aug 2019 11:19:19 +0300
Message-ID: <87imr2u77c.fsf@gmail.com>
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
>>> I have such situation in which one interrupt line is shared with ehci a=
nd cdns3 driver.
>>> In such case this function returns error code.
>>
>>which function returns error code?
>
> devm_request_threaded_irq, of course if I set IRQF_SHARED | IRQF_ONESHOT.
> As I remember it was EBUSY error.

oh, right. That's probably because the handlers must agree on IRQ flags.

>>> So probably I will need to mask only the reported interrupts.
>>
>>you should mask all interrupts from your device, otherwise you top-halt
>>may still end up reentrant.
>>
>>> I can't mask all interrupt using controller register because I can miss=
 some of them.
>>
>>why would you miss them? They would be left in the register until you
>>unmask them and the line is raised again.
>
> I consult this with author of controller.=20
> We have:
> USB_IEN  and USB_ISTS for  generic interrupts
> EP_IEN and EP_ISTS for endpoint interrupts=20
>
> Both these group works different.
> For endpoint I can disable all interrupt and I don't miss any of them.=20
> So it's normal behavior.
>
> But USB_ISTS work little different. If we mask all interrupt in USB_IEN
> then when new event occurs the EP_ISTS will not be updated.=20

wait a minute. When you mask USB_ISTS, then EP_ISTS isn't updated? Is
this a quirk on the controller or a design choice?

> It's not standard and not expected behavior but it works in this way.=20

Yeah, sounds rather odd.

>>>>>>> +	/* check USB device interrupt */
>>>>>>> +	reg =3D readl(&priv_dev->regs->usb_ists);
>>>>>>> +
>>>>>>> +	if (reg) {
>>>>>>> +		writel(reg, &priv_dev->regs->usb_ists);
>>>>>>> +		cdns3_check_usb_interrupt_proceed(priv_dev, reg);
>>>>>>> +		ret =3D IRQ_HANDLED;
>>>>>>
>>>>>>now, because you _don't_ mask this interrupt, you're gonna have
>>>>>>issues. Say we actually get both device and endpoint interrupts while
>>>>>>the thread is already running with previous endpoint interrupts. Now
>>>>>>we're gonna reenter the top half, because device interrupts are *not*
>>>>>>masked, which will read usb_ists and handle it here.
>>>>>
>>>>> Endpoint interrupts are masked in cdns3_device_irq_handler and stay m=
asked
>>>>> until they are not handled in threaded handler.
>>>>
>>>>Quick question, then: these ISTS registers, are they masked interrupt
>>>>status or raw interrupt status?
>>>
>>> Yes it's masked, but after masking them the new interrupts will not be =
reported
>>> In ISTS registers. Form this reason I can mask only reported interrupt.
>>
>>and what happens when you unmask the registers? Do they get reported?
>
> No they are not reported in case of USB_ISTS register.
> They should be reported in case EP_ISTS, but I need to test it.=20

okay, please _do_ test and verify the behavior. The description above
sounds really surprising to me. Does it really mean that if you mask all
USB_ISTS and then disconnect the cable while interrupt is masked, you
won't know cable was disconnected?

>>>>>>> +		struct cdns3_aligned_buf *buf, *tmp;
>>>>>>> +
>>>>>>> +		list_for_each_entry_safe(buf, tmp, &priv_dev->aligned_buf_list,
>>>>>>> +					 list) {
>>>>>>> +			if (!buf->in_use) {
>>>>>>> +				list_del(&buf->list);
>>>>>>> +
>>>>>>> +				spin_unlock_irqrestore(&priv_dev->lock, flags);
>>>>>>
>>>>>>creates the possibility of a race condition
>>>>> Why? In this place the buf can't be used.
>>>>
>>>>but you're reenabling interrupts, right?
>>>
>>> Yes, driver frees not used buffers here.
>>> I think that it's the safest place for this purpose.
>>
>>I guess you missed the point a little. Since you reenable interrupts
>>just to free the buffer, you end up creating the possibility for a race
>>condition. Specially since you don't mask all interrupt events. The
>>moment you reenable interrupts, one of your not-unmasked interrupt
>>sources could trigger, then top-half gets scheduled which tries to wake
>>up the IRQ thread again and things go boom.
>
> Ok, I think I understand.  So I have 3 options:
> 1. Mask the USB_IEN and EP_IEN interrupts, but then I can lost some USB_I=
STS
> events. It's dangerous options.=20

sure sounds dangerous, but also sounds quite "peculiar" :-)

> 2. Remove implementation of handling unaligned buffers and assume that=20
>     upper layer will worry about this. What with vendor specific drivers =
that=20
>     can be used by companies and not upstreamed  ?=20
>     It could be good to have such safety mechanism even if it is not curr=
ently used.

dunno. It may become dead code that's NEVER used :-)

> 3. Delegate this part of code for instance to separate thread that will b=
e called=20
>    In free time.=20

Yet another thread? Can't you just run this right before giving back the
USB request? So, don't do it from IRQ handler, but from giveback path?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1RIQcACgkQzL64meEa
mQbv3xAAuDWFJdZz6Yuz9RG8Y+enrvQvRYTHt9yWD3BXYAxGIh8xI3DxxhDhfN7L
op0NZQGwAavUcjFrKFHCXnfmjG1kCaVl7XSe2fXV0TpjM/7pDMxjcruYRa+RvJia
kqI0a1V8uxLIzsjaNoWYcxNm+5x7YoyBvJhIVpqxhs4A40yKK/rmasF7uD9h+htE
/j/EjWC69OjuZDvYdEcZg0T5miFPJutIUYLJt31NLen2PhCeGhoDpmmgxn2CJM/3
GB5WLPuge2m5vYgRuAzeCkCPkmgfU4qKbXohx8R2S0oCA0AA8HwpvKUCtDPXKpai
0E4cTnDlr+SubBjCGPbO8g8LHegrCIGFDXOCv8ma2CB1Tqm3mK9jvCpXOMzFKHqB
fNjmg0d6Rym4A5eq68D7aMHn1pxIzqaHUran600hIuBcCclDmL5xFwKfk4jGTah4
Zmi1g3fqx6bbJwUYIr9BoRRks6h0E2/9Q9aaL/SADEvqsEwvc9owbHjwAXmOYCim
BCkzSmMr0Q/+otKaJPZlwdP+DDqhqjbSgYzIE5DzdzY6MdqVANAB6+A9Te8T6cBZ
D4eVYyvVMwYq4FmJguGAVglpwu3KXVau5uhTc2AwRntuSd53yrQvGlW7Iz7xnuDr
MXnIZKXUK/Wi09vfbir0IlllbO7RLucADGRx2CNezMYqtNhNA/8=
=s/Jz
-----END PGP SIGNATURE-----
--=-=-=--
