Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A80C742BC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83762080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfGLMnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:43:10 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49108 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfGLMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:43:09 -0400
Received: from [167.98.27.226] (helo=[10.35.6.255])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hlut4-0005pT-Ur; Fri, 12 Jul 2019 13:42:55 +0100
Subject: Re: [PATCH v1 01/11] dt-bindings: display/bridge: Add bindings for
 ti948
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-2-michael.drake@codethink.co.uk>
 <20190611180316.GS5016@pendragon.ideasonboard.com>
From:   Michael Drake <michael.drake@codethink.co.uk>
Message-ID: <4f8c1aa9-0c0b-0337-b273-2ffd76d83ee1@codethink.co.uk>
Date:   Fri, 12 Jul 2019 13:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190611180316.GS5016@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 11/06/2019 19:03, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.

My pleasure, and thank you for the feedback!  I'm sorry it's
taken me a while to respond to it.

> On Tue, Jun 11, 2019 at 03:04:02PM +0100, Michael Drake wrote:
>> Adds device tree bindings for:
>>
>>   TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer
>>
>> The device has the compatible string "ti,ds90ub948", and
>> and allows an arrray of strings to be provided as regulator
> 
> s/arrray/array/

Thanks.  Fixed for the next version.

>> names to enable for operation of the device.
>>
>> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  .../bindings/display/bridge/ti,ds90ub948.txt  | 24 +++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
>> new file mode 100644
>> index 000000000000..f9e86cb22900
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
>> @@ -0,0 +1,24 @@
>> +TI DS90UB948-Q1 2K FPD-Link III to OpenLDI Deserializer
>> +=======================================================
>> +
>> +This is the binding for Texas Instruments DS90UB948-Q1 bridge deserializer.
>> +
>> +This device supports I2C only.
> 
> Then the DT node should be a child of its I2C controller, and have a reg
> property.

OK, thank you.  I'm not actually using DT, I'm using ACPI tables.

For DT, would this cause the device to get bound to the driver on
startup?

I tried adding a reg property with the value set to the device's
I2C address with device tree compatible properties, coupled with
the DT "compatible" string property, but that was insufficient to
bind the device to the driver.  At the moment, I'm using the ACPI
mechanism for achieving this.

So all I've done for this is add the "reg" property to the device
tree ti,ds90ub948.txt documentation file, in the Example section.

Is this what you were expecting?

For the other point, that the DT node should be a child of its I2C
controller, I've made the devices descendants of the I2C controller
in ACPI, but one of them is not a direct child.

The ti949 is a child of its I2C controller node, but the ti948
is a child of the ti949 node in the ACPI table.  I did this to
ensure that linux was aware of the dependency of the devices, so
that they would be brought up in the correct order and suspended
and resumed in the correct order.

>> +
>> +Required properties:
>> +
>> +- compatible: "ti,ds90ub948"
>> +
>> +Optional properties:
>> +
>> +- regulators: List of regulator name strings to enable for operation of device.
> 
> There's a standard binding for regulators, using *-supply properties.
> Please use them.

Thank you!  I've switched to using that, and it is less code.  :)

> You should also use the OF graph DT bindings to model the data
> connections.

I'm not clear on the implications of this from the driver code.
Does it need any code changes to the driver to support these
endpoints?  How are they used?

If it's just a documentation thing, I can easily do it, but
otherwise, I can't test Device Tree because we're using ACPI.

>> +
>> +Example
>> +-------
>> +
>> +ti948: ds90ub948@0 {
>> +	compatible = "ti,ds90ub948";
>> +
>> +	regulators: "vcc",
>> +	            "vcc_disp";
>> +};
> 

-- 
Michael Drake                 https://www.codethink.co.uk/
