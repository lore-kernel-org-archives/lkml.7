Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D171C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4FE206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jjra4u+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgAHR03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:26:29 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:37106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgAHR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1578504384; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1C87d/9wmB9b0Kh7sgb9rQjZKP4LGxrzK55NGLAZA8=;
        b=jjra4u+J1Z5T6DcXVIQheaaHeylugxiEeeDAuYtZSP2E5iljr4QiSvUXc3b7oLP9ERVUu6
        lZUeQgQLQhnUa3cXEfHhuCaolWDsPvA3D7e1nc92PzFlhJgocBmP+QDlCGXmVUBy8VBXVN
        DYJwjxMBuxPe9tirwc45ueb9fGBdKGE=
Date:   Wed, 08 Jan 2020 14:26:10 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register charger
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1578504370.3.1@crapouillou.net>
In-Reply-To: <20200108165323.GA2506374@kroah.com>
References: <20200107002901.940297-1-paul@crapouillou.net>
        <20200108165323.GA2506374@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,


Le mer., janv. 8, 2020 at 17:53, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> a =E9crit :
> On Tue, Jan 07, 2020 at 01:29:01AM +0100, Paul Cercueil wrote:
>>  Register a power supply charger, whose online state depends on=20
>> whether
>>  the USB role is set to device or not.
>=20
> That says _what_ you are doing, but I have no idea _why_ you want to=20
> do
> this.
>=20
> What is this going to cause to have happen?  What new userspace api is
> going to result?  What will a user do with this?

This is useful when the USB role is the only way to know if the device=20
is charging from USB.

The API is the standard power supply charger API, you get a=20
/sys/class/power_supply/xxx/online node which tells you the state of=20
the charger.

The sole purpose of this is to give userspace applications a way to=20
know whether or not the charger is plugged.

> Is this going to always show up, no matter if the role is not even
> relevant for a power supply?

I guess it'd always show up, yes. In which case would the role not be=20
relevant for a power supply? Is gpio-b-connector not always used for=20
OTG connectors?

Cheers,
-Paul


> You need a lot more text here to make this mergable.
>=20
> thanks,
>=20
> greg k-h

=

