Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E7DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23499206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="BTM3kLNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfDCPw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:52:27 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:34260 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfDCPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554306744; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCtHr8Int/M+XOTrbONnCRwTC5/kxayL/eNDSpPX30k=;
        b=BTM3kLNL280YmMRgmo/WpOVQs1mReDubNMw4sKiUkTOywFUEDXtqWvmu3k+z4K3HcvJj/q
        sVgQ4iTYHcPwOdGoufakSVvtNzA+5w96aSuAcaVmGOBTlErBceVsWwaBZDUSbueJ+GxK7p
        O4DNnbHvaM329V3wh36JNskkXOyyLvA=
Date:   Wed, 03 Apr 2019 17:52:20 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: Force-disable pullup on shutdown
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me
Message-Id: <1554306740.1177.1@crapouillou.net>
In-Reply-To: <20190403154654.GR25852@uda0271908>
References: <20190321144246.3547-1-paul@crapouillou.net>
        <20190401171725.GK25852@uda0271908> <1554140782.10471.0@crapouillou.net>
        <20190401182008.GL25852@uda0271908> <1554235122.13181.0@crapouillou.net>
        <20190403132600.GQ25852@uda0271908> <1554305491.1177.0@crapouillou.net>
        <20190403154654.GR25852@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le mer. 3 avril 2019 =E0 17:46, Bin Liu <b-liu@ti.com> a =E9crit :
> On Wed, Apr 03, 2019 at 05:31:31PM +0200, Paul Cercueil wrote:
>>=20
>>=20
>>  Le mer. 3 avril 2019 =E0 15:26, Bin Liu <b-liu@ti.com> a =E9crit :
>>  >On Tue, Apr 02, 2019 at 09:58:42PM +0200, Paul Cercueil wrote:
>>  >> Hi,
>>  >>
>>  >> Le lun. 1 avril 2019 =E0 20:20, Bin Liu <b-liu@ti.com> a =E9crit :
>>  >> >On Mon, Apr 01, 2019 at 07:46:22PM +0200, Paul Cercueil wrote:
>>  >> >>
>>  >> >>
>>  >> >> Le lun. 1 avril 2019 =E0 19:17, Bin Liu <b-liu@ti.com> a=20
>> =E9crit :
>>  >> >> >On Thu, Mar 21, 2019 at 03:42:46PM +0100, Paul Cercueil=20
>> wrote:
>>  >> >> >> When the musb is shutdown, for instance when the driver is
>>  >> >>unloaded,
>>  >> >> >> force-disable the pullup. Otherwise, the host will still=20
>> see
>>  >> >> >>the gadget
>>  >> >> >> device even after the shutdown.
>>  >> >> >
>>  >> >> >how would this happen?
>>  >> >> >
>>  >> >> >when musb-hdrc driver is unloaded, udc core removes the bound
>>  >> >>gadget
>>  >> >> >driver which calls musb_gadget_pullup() to disable the=20
>> pullup.
>>  >> >>
>>  >> >> I'm testing with the jz4740-musb driver. I don't unload the
>>  >> >>module (it's
>>  >> >> built-in) but unbind it from sysfs.
>>  >> >
>>  >> >I did unbind too.
>>  >> >
>>  >> >root@am335x-evm:/sys/bus/platform/drivers/musb-hdrc# echo
>>  >> >musb-hdrc.0 > unbind
>>  >> >
>>  >> >or unbind the glue driver:
>>  >> >
>>  >> >root@am335x-evm:/sys/bus/platform/drivers/musb-dsps# echo
>>  >> >47401400.usb > unbind
>>  >> >
>>  >> >musb_gadget_pullup() is called in both cases.
>>  >> >
>>  >> >[ 3880.597014] [<bf444ab0>] (musb_gadget_pullup [musb_hdrc])=20
>> from
>>  >> >[<bf402cbc>] (usb_gadget_disconnect+0x3c/0xf4 [udc_core])
>>  >> >[ 3880.607959] [<bf402cbc>] (usb_gadget_disconnect [udc_core])
>>  >> >from [<bf403b28>] (usb_gadget_remove_driver+0x4c/0x90=20
>> [udc_core])
>>  >> >[ 3880.619338] [<bf403b28>] (usb_gadget_remove_driver=20
>> [udc_core])
>>  >> >from [<bf403d20>] (usb_del_gadget_udc+0x5c/0xc0 [udc_core])
>>  >>
>>  >> In my case this stops here, usb_del_gadget_udc() does not call
>>  >> usb_gadget_remove_driver(), that's why the pullup is never=20
>> disabled.
>>  >>
>>  >> I guess that's because udc->driver is NULL; I'm testing with
>>  >
>>  >then the pullup should be disable by now.
>>  >
>>  >> CONFIG_USB_CONFIGFS,
>>  >> and I don't configure anything in sysfs before unbinding the=20
>> driver.
>>  >
>>  >I didn't check on this, but I could imagine that
>>  >- when a configfs gadget is bound to the udc, .pullup() is called;
>>  >- when the configfs gadget is unbound from the udc, .pullup should=20
>> be
>>  >  called again to disable the pullup.
>>=20
>>  An important thing that I did not mention, is that the SoC boots
>>  from USB,
>>  so the pullup is active before the musb driver loads. Since in my=20
>> case a
>=20
> It sounds to me that the musb driver should disable the pullup during
> init.  Isn't it?

Yes. I can move it to musb_gadget_setup(). Should I still protect it=20
with
the spinlock then?

>>  configfs gadget is never bound, then .pullup() is never called, and=20
>> when
>>  I unbind the driver the pullup is still enabled.
>=20
> Regards,
> -Bin.

=

