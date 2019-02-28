Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87BCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB50218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbfB1UWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:22:19 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:60781 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1UWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:22:18 -0500
Received: from webmail.gandi.net (webmail6.sd4.0x35.net [10.200.201.6])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPA id CE609C000B;
        Thu, 28 Feb 2019 20:22:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 Feb 2019 21:22:15 +0100
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
In-Reply-To: <20190228184822.GA17624@bogus>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
 <20190217142914.17433-4-contact@artur-rojek.eu>
 <20190228184822.GA17624@bogus>
Message-ID: <ed7c6a70b6fe77fff440710fc72506d6@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

thanks for the review.

On 2019-02-28 19:48, Rob Herring wrote:
> On Sun, Feb 17, 2019 at 03:29:13PM +0100, Artur Rojek wrote:
>> Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.
>> 
>> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
>> ---
>>  .../bindings/power/supply/ingenic,battery.txt | 31 
>> +++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt 
>> b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>> new file mode 100644
>> index 000000000000..66430bf73815
>> --- /dev/null
>> +++ 
>> b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
>> @@ -0,0 +1,31 @@
>> +* Ingenic JZ47xx battery bindings
>> +
>> +Required properties:
>> +
>> +- compatible: Must be "ingenic,jz4740-battery".
>> +- io-channels: phandle and IIO specifier pair to the IIO device.
>> +  Format described in iio-bindings.txt.
>> +- monitored-battery: phandle to a "simple-battery" compatible node.
>> +
>> +The "monitored-battery" property must be a phandle to a node using 
>> the format
>> +described in battery.txt, with the following properties being 
>> required:
>> +
>> +- voltage-min-design-microvolt: Drained battery voltage.
>> +- voltage-max-design-microvolt: Fully charged battery voltage.
>> +
>> +Example:
>> +
>> +#include <dt-bindings/iio/adc/ingenic,adc.h>
>> +
>> +simple_battery: battery {
>> +	compatible = "simple-battery";
>> +	voltage-min-design-microvolt = <3600000>;
>> +	voltage-max-design-microvolt = <4200000>;
>> +};
>> +
>> +ingenic_battery {
>> +	compatible = "ingenic,jz4740-battery";
>> +	io-channels = <&adc INGENIC_ADC_BATTERY>;
>> +	io-channel-names = "battery";
>> +	monitored-battery = <&simple_battery>;
> 
> Isn't this just an ADC monitored battery? What's specific to JZ4740?
> 
> Maybe a generic binding is appropriate here?
This isn't quite a generic driver; see Jonathan's reply to patch 5/7.

- Artur
> 
> Rob

