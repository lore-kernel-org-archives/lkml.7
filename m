Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7976220830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="C77j+YjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbfDARwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:52:06 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41886 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbfDARwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554141123; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zNcHYMrA9NPNDv164IAAHOmVlnT57ChU1ex6cYItfs=;
        b=C77j+YjIwrHuDMaL4pOfblUbXMzx9qB6+iV4rznBtPSgXDZNnyabMcjDa7r0scIwpXs+7s
        b+w5JJCKWchlgnXhmEa+a42xKq8ubM2GwEg08jq4whdcrRbgTFnDyve7+UNGsbrMvIgaF6
        ms5N2dv25zd5BGzudLmMAraGJ5Pw2ZA=
Date:   Mon, 01 Apr 2019 19:51:59 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: Silence error about blacklisting hubs if
 !CONFIG_USB
To:     Bin Liu <b-liu@ti.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1554141119.10471.1@crapouillou.net>
In-Reply-To: <20190401154333.GJ25852@uda0271908>
References: <20190319135146.25995-1-paul@crapouillou.net>
        <20190401154333.GJ25852@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 1 avril 2019 =E0 17:43, Bin Liu <b-liu@ti.com> a =E9crit :
> On Tue, Mar 19, 2019 at 02:51:46PM +0100, Paul Cercueil wrote:
>>  Some drivers, like jz4740-musb, don't depend on CONFIG_USB.
>=20
> CONFIG_USB_OTG_BLACKLIST_HUB is about hub, so should it depend on
> CONFIG_USB instead in drivers/usb/core/Kconfig?

It's already the case, indirectly - it depends on CONFIG_USB_OTG,
which only exists if CONFIG_USB is set.

>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/usb/musb/musb_core.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>>  diff --git a/drivers/usb/musb/musb_core.c=20
>> b/drivers/usb/musb/musb_core.c
>>  index b7d56272f9d1..9f5a4819a744 100644
>>  --- a/drivers/usb/musb/musb_core.c
>>  +++ b/drivers/usb/musb/musb_core.c
>>  @@ -1497,10 +1497,11 @@ static int musb_core_init(u16 musb_type,=20
>> struct musb *musb)
>>   	} else {
>>   		musb->is_multipoint =3D 0;
>>   		type =3D "";
>>  -#ifndef	CONFIG_USB_OTG_BLACKLIST_HUB
>>  -		pr_err("%s: kernel must blacklist external hubs\n",
>>  -		       musb_driver_name);
>>  -#endif
>>  +		if (IS_ENABLED(CONFIG_USB) &&
>>  +		    !IS_ENABLED(CONFIG_USB_OTG_BLACKLIST_HUB)) {
>>  +			pr_err("%s: kernel must blacklist external hubs\n",
>>  +			       musb_driver_name);
>>  +		}
>>   	}
>>=20
>>   	/* log release info */
>=20
> Regards,
> -Bin.

=

