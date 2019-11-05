Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78AFC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1E620717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="vq5W//hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfKEJQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:16:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:58854 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbfKEJQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572945397; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=no3TrOXPIr0fb/tqGISxsTogfkVht99KnNkO4ofz60M=;
        b=vq5W//hPFzbGEyBcqtgjAWIk3JU4FOQdB3QjM1LbXjuiaFJKNXYW0nYzdGurjRyoY2Qhvu
        N8T+SFiQmKA3tQvgWFgjwY3V+/Nb59Xu0mWKfNUhnSh8lhI0pVPG9S1lem3ba6E5+TtMWB
        Z6TXGP/IVLwclNA4ZfNytBlcpvtOoF4=
Date:   Tue, 05 Nov 2019 10:16:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: power/supply: Document generic USB
 charger
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Message-Id: <1572945391.3.1@crapouillou.net>
In-Reply-To: <CAL_Jsq+aSXPT-vmHbDLygO0G3RmM3svTeS+S5FKKjj_Auf3gPw@mail.gmail.com>
References: <20191103220801.10666-1-paul@crapouillou.net>
        <CAL_Jsq+aSXPT-vmHbDLygO0G3RmM3svTeS+S5FKKjj_Auf3gPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


Le lun., nov. 4, 2019 at 07:52, Rob Herring <robh+dt@kernel.org> a=20
=E9crit :
> On Sun, Nov 3, 2019 at 4:08 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Add documentation about the devicetree bindings for the generic USB
>>  charger.
>=20
> What makes it generic?

It only uses the USB PHY subsystem, which already has some half-baked=20
support for chargers but not bound to the power-supply subsystem.


>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../bindings/power/supply/usb-charger.txt     | 24=20
>> +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/power/supply/usb-charger.txt=20
>> b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>  new file mode 100644
>>  index 000000000000..fd46734cb0e5
>>  --- /dev/null
>>  +++ b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>  @@ -0,0 +1,24 @@
>>  +Generic USB charger bindings
>>  +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  +
>>  +Required properties :
>>  + - compatible : should be "usb-charger"
>>  + - phys: phandle to the USB PHY
>>  +
>>  +Example:
>>  +
>>  +usb_con: extcon {
>>  +       compatible =3D "linux,extcon-usb-gpio";
>>  +       vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
>>  +};
>>  +
>>  +usb_phy: usb-phy@0 {
>>  +       compatible =3D "usb-nop-xceiv";
>>  +       #phy-cells =3D <0>;
>>  +       extcon =3D <&usb_con>;
>=20
> extcon is deprecated in favor of usb-connector binding. See
> .../bindings/connector/usb-connector.txt. There's also some pending
> patches for adding GPIO based connector controls including Vbus sense
> (GPIO input) and control (regulator via a GPIO).
>=20
> Rob

I understand that the usb-connector binding is better, but the current=20
code doesn't integrate at all with the USB PHY subsystem, which has its=20
own code to handle ID and VBUS GPIOs and supports notifiers. Is that=20
deprecated then?

What's the big picture here?

Thanks,
-Paul


=

