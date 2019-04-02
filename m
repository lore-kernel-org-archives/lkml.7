Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05D0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D412082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tHKcp/Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDBT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:58:50 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:54406 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDBT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554235126; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucqDwDOGXGI6jS55GyrdLlnLrH9n9y70DM1gv/tM+j4=;
        b=tHKcp/LwO71VA7bEx18TlOOCfjcigi+S5URmbFK/D9cr7GCT0T9J1oxMOrbTSpjHjP+03x
        zk7y03IVDM9yMPJHQNAEzG2yZfV9lAUmcgKUWEidtVByyjv0O8bux9WF0V6jWjXREmkb0W
        SOzYn8E94m9lqY+HzCSOcd7FIrXI8BY=
Date:   Tue, 02 Apr 2019 21:58:42 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me
Message-Id: <1554235122.13181.0@crapouillou.net>
In-Reply-To: <20190401182008.GL25852@uda0271908>
References: <20190321144246.3547-1-paul@crapouillou.net>
        <20190401171725.GK25852@uda0271908> <1554140782.10471.0@crapouillou.net>
        <20190401182008.GL25852@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun. 1 avril 2019 =E0 20:20, Bin Liu <b-liu@ti.com> a =E9crit :
> On Mon, Apr 01, 2019 at 07:46:22PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le lun. 1 avril 2019 =E0 19:17, Bin Liu <b-liu@ti.com> a =E9crit :
>>  >On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil wrote:
>>  >> When the musb is shutdown, for instance when the driver is=20
>> unloaded,
>>  >> force-disable the pullup. Otherwise, the host will still see
>>  >>the gadget
>>  >> device even after the shutdown.
>>  >
>>  >how would this happen?
>>  >
>>  >when musb-hdrc driver is unloaded, udc core removes the bound=20
>> gadget
>>  >driver which calls musb_gadget_pullup() to disable the pullup.
>>=20
>>  I'm testing with the jz4740-musb driver. I don't unload the module=20
>> (it's
>>  built-in) but unbind it from sysfs.
>=20
> I did unbind too.
>=20
> root@am335x-evm:/sys/bus/platform/drivers/musb-hdrc# echo musb-hdrc.0=20
> > unbind
>=20
> or unbind the glue driver:
>=20
> root@am335x-evm:/sys/bus/platform/drivers/musb-dsps# echo=20
> 47401400.usb > unbind
>=20
> musb_gadget_pullup() is called in both cases.
>=20
> [ 3880.597014] [<bf444ab0>] (musb_gadget_pullup [musb_hdrc]) from=20
> [<bf402cbc>] (usb_gadget_disconnect+0x3c/0xf4 [udc_core])
> [ 3880.607959] [<bf402cbc>] (usb_gadget_disconnect [udc_core]) from=20
> [<bf403b28>] (usb_gadget_remove_driver+0x4c/0x90 [udc_core])
> [ 3880.619338] [<bf403b28>] (usb_gadget_remove_driver [udc_core])=20
> from [<bf403d20>] (usb_del_gadget_udc+0x5c/0xc0 [udc_core])

In my case this stops here, usb_del_gadget_udc() does not call
usb_gadget_remove_driver(), that's why the pullup is never disabled.

I guess that's because udc->driver is NULL; I'm testing with=20
CONFIG_USB_CONFIGFS,
and I don't configure anything in sysfs before unbinding the driver.

> [ 3880.630471] [<bf403d20>] (usb_del_gadget_udc [udc_core]) from=20
> [<bf439ff8>] (musb_remove+0x50/0x134 [musb_hdrc])
> [ 3880.640648] [<bf439ff8>] (musb_remove [musb_hdrc]) from=20
> [<c05668cc>] (platform_drv_remove+0x28/0x48)
> [ 3880.649831] [<c05668cc>] (platform_drv_remove) from [<c0564e3c>]=20
> (device_release_driver_internal+0xe4/0x1b4)
> [ 3880.659708] [<c0564e3c>] (device_release_driver_internal) from=20
> [<c05633e4>] (bus_remove_device+0xe0/0x140)
> [ 3880.669409] [<c05633e4>] (bus_remove_device) from [<c055f358>]=20
> (device_del+0x140/0x374)
> [ 3880.677455] [<c055f358>] (device_del) from [<c0566ff0>]=20
> (platform_device_del.part.3+0x18/0x80)
> [ 3880.686110] [<c0566ff0>] (platform_device_del.part.3) from=20
> [<c0567098>] (platform_device_unregister+0x24/0x30)
> [ 3880.696170] [<c0567098>] (platform_device_unregister) from=20
> [<bf48c3e0>] (dsps_remove+0x1c/0x38 [musb_dsps])
> [ 3880.706010] [<bf48c3e0>] (dsps_remove [musb_dsps]) from=20
> [<c05668cc>] (platform_drv_remove+0x28/0x48)
> [ 3880.715190] [<c05668cc>] (platform_drv_remove) from [<c0564e3c>]=20
> (device_release_driver_internal+0xe4/0x1b4)
> [ 3880.725065] [<c0564e3c>] (device_release_driver_internal) from=20
> [<c0562b2c>] (unbind_store+0x64/0xd8)
> [ 3880.734253] [<c0562b2c>] (unbind_store) from [<c0350c58>]=20
> (kernfs_fop_write+0xf4/0x1cc)
>=20
> Regards,
> -Bin.
>=20
>=20

=

