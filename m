Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A37C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6A520868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wjhDRBgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfGOGFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 02:05:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:56402 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfGOGFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1563170752; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1MaOt0jW59xYgvE7c4XkSzT9zY9zvt+sXJ111t6oK4=;
        b=wjhDRBgyh9wpm9oRX0H1916idSKCg0Ie8HZwIh6+VLKjzbLkSFTPT0Es6B81OLvJ3lxWu8
        JNddxONRUczkKGDRXrB6wRxXkzafNLmBpM1ORhkdE8I1EAm0eWCWun3FDkkTPsR3tJ245f
        y8cvtm2KBkAf1Qf5MLBYd6WSAvJduKY=
Date:   Mon, 15 Jul 2019 02:05:40 -0400
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: Disable pullup in gadget setup
To:     Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1563170740.1702.0@crapouillou.net>
In-Reply-To: <20190430150506.GF20993@uda0271908>
References: <20190404093743.6470-1-paul@crapouillou.net>
        <20190404161046.GA30182@uda0271908> <20190430150506.GF20993@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,


Le mar. 30 avril 2019 =E0 11:05, Bin Liu <b-liu@ti.com> a =E9crit :
> Hi Paul,
>=20
> On Thu, Apr 04, 2019 at 11:10:46AM -0500, Bin Liu wrote:
>>  On Thu, Apr 04, 2019 at 11:37:43AM +0200, Paul Cercueil wrote:
>>  > The pullup may be already enabled before the driver is=20
>> initialized.
>>  > It has to be disabled at init time, as we cannot guarantee that a=20
>> gadget
>>  > driver will be bound to the UDC.
>>  >
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > ---
>>  >  drivers/usb/musb/musb_gadget.c | 1 +
>>  >  1 file changed, 1 insertion(+)
>>  >
>>  > diff --git a/drivers/usb/musb/musb_gadget.c=20
>> b/drivers/usb/musb/musb_gadget.c
>>  > index ffe462a657b1..094dc59c834c 100644
>>  > --- a/drivers/usb/musb/musb_gadget.c
>>  > +++ b/drivers/usb/musb/musb_gadget.c
>>  > @@ -1794,6 +1794,7 @@ int musb_gadget_setup(struct musb *musb)
>>  >
>>  >  	musb->is_active =3D 0;
>>  >  	musb_platform_try_idle(musb, 0);
>>  > +	musb_pullup(musb, 0);
>>  >
>>  >  	status =3D usb_add_gadget_udc(musb->controller, &musb->g);
>>  >  	if (status)
>>=20
>>  Applied.
>=20
> Sorry, I have dropped this patch from my tree. I realized the gadget
> core already defines callbacks to control the pullup. I think the
> proper fix should be calling usb_udc_vbus_handler() in musb gadget or
> glue layers.
>=20
> -Bin.

usb_udc_vbus_handler() requires a usb_gadget *, I don't see where I can
get that from the struct musb.

Besides, the point is to have the pullup disabled before a gadget is=20
bound,
so I don't understand why you suggest that?

-Paul

=

