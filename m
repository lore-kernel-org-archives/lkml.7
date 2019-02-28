Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D82AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540A5218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="sFkClUBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732804AbfB1S4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:56:22 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:57458 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfB1S4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1551380179; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=30SEL/MMjAJMNKdXS74lACgIJDPDuweQsqa9AAKNPLY=;
        b=sFkClUBdoDytdf3XaP4n7TzR37bpcg7LwUxkoAUExpo7QrNg2AoDSk/1mYlYS/2jmS2PAd
        TkujAnzaDXvNLbZN8ua3YLX519oFTcgOf0xYvDegmxufwTtBanwW5F72Bp8aK7VX/WSrx+
        99dggwQkWMK/GDL6muNyZBi9GeizuD0=
Date:   Thu, 28 Feb 2019 15:56:04 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
To:     Rob Herring <robh@kernel.org>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <1551380164.10612.0@crapouillou.net>
In-Reply-To: <20190228184822.GA17624@bogus>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
        <20190217142914.17433-4-contact@artur-rojek.eu>
        <20190228184822.GA17624@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le jeu. 28 f=E9vr. 2019 =E0 15:48, Rob Herring <robh@kernel.org> a =E9crit=20
:
> On Sun, Feb 17, 2019 at 03:29:13PM +0100, Artur Rojek wrote:
>>  Add documentation for the ingenic-battery driver, used on JZ47xx=20
>> SoCs.
>>=20
>>  Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>>  ---
>>   .../bindings/power/supply/ingenic,battery.txt | 31=20
>> +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644=20
>> Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>>=20
>>  diff --git=20
>> a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt=20
>> b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>>  new file mode 100644
>>  index 000000000000..66430bf73815
>>  --- /dev/null
>>  +++=20
>> b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>>  @@ -0,0 +1,31 @@
>>  +* Ingenic JZ47xx battery bindings
>>  +
>>  +Required properties:
>>  +
>>  +- compatible: Must be "ingenic,jz4740-battery".
>>  +- io-channels: phandle and IIO specifier pair to the IIO device.
>>  +  Format described in iio-bindings.txt.
>>  +- monitored-battery: phandle to a "simple-battery" compatible node.
>>  +
>>  +The "monitored-battery" property must be a phandle to a node using=20
>> the format
>>  +described in battery.txt, with the following properties being=20
>> required:
>>  +
>>  +- voltage-min-design-microvolt: Drained battery voltage.
>>  +- voltage-max-design-microvolt: Fully charged battery voltage.
>>  +
>>  +Example:
>>  +
>>  +#include <dt-bindings/iio/adc/ingenic,adc.h>
>>  +
>>  +simple_battery: battery {
>>  +	compatible =3D "simple-battery";
>>  +	voltage-min-design-microvolt =3D <3600000>;
>>  +	voltage-max-design-microvolt =3D <4200000>;
>>  +};
>>  +
>>  +ingenic_battery {
>>  +	compatible =3D "ingenic,jz4740-battery";
>>  +	io-channels =3D <&adc INGENIC_ADC_BATTERY>;
>>  +	io-channel-names =3D "battery";
>>  +	monitored-battery =3D <&simple_battery>;
>=20
> Isn't this just an ADC monitored battery? What's specific to JZ4740?
>=20
> Maybe a generic binding is appropriate here?
>=20
> Rob

There is no generic driver, is there? The generic-adc-battery driver
isn't OF-compatible and looks like dead code (nothing uses it).

-Paul
=

