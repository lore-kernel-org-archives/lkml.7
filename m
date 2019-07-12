Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C8DC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D586F2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfGLMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:43:17 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:49151 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfGLMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:43:16 -0400
Received: from [167.98.27.226] (helo=[10.35.6.255])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hlutK-0005qb-Ha; Fri, 12 Jul 2019 13:43:10 +0100
Subject: Re: [PATCH v1 03/11] dt-bindings: display/bridge: Add config property
 for ti948
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
 <20190611140412.32151-4-michael.drake@codethink.co.uk>
 <20190611180710.GT5016@pendragon.ideasonboard.com>
From:   Michael Drake <michael.drake@codethink.co.uk>
Message-ID: <80e585a3-222a-5b98-7835-85b721a3beb1@codethink.co.uk>
Date:   Fri, 12 Jul 2019 13:43:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190611180710.GT5016@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 11/06/2019 19:07, Laurent Pinchart wrote:
> Hi Michael,
> 
> Thank you for the patch.

My pleasure, and thank you for the feedback!

> On Tue, Jun 11, 2019 at 03:04:04PM +0100, Michael Drake wrote:
>> The config property can be used to provide an array of
>> register addresses and values to be written to configure
>> the device for the board.
> 
> Please don't. DT describes the hardware (or more accurately the system),
> it's not meant to store arbitrary configuration data. All the registers
> specified below should instead be set by the driver based on a
> combination of hardware description and information obtained at runtime.

OK, understood.  I'll work on this.  For some of them
explicit firmware properties would be appropriate.

I'll go through it to ascertain what can be determined
at runtime.

>> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
>> Cc: Patrick Glaser <pglaser@tesla.com>
>> Cc: Nate Case <ncase@tesla.com>
>> ---
>>  .../bindings/display/bridge/ti,ds90ub948.txt  | 21 +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
>> index f9e86cb22900..1e7033b0f3b7 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
>> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
>> @@ -12,6 +12,8 @@ Required properties:
>>  Optional properties:
>>  
>>  - regulators: List of regulator name strings to enable for operation of device.
>> +- config: List of <register address>,<value> pairs to be set to configure
>> +  device on powerup.  The register addresses and values are 8bit.
>>  
>>  Example
>>  -------
>> @@ -21,4 +23,23 @@ ti948: ds90ub948@0 {
>>  
>>  	regulators: "vcc",
>>  	            "vcc_disp";
>> +	config:
>> +	        /* set error count to max */
>> +	        <0x41>, <0x1f>,
>> +	        /* sets output mode, no change noticed */
>> +	        <0x49>, <0xe0>,
>> +	        /* speed up I2C, 0xE is around 480KHz */
>> +	        <0x26>, <0x0e>,
>> +	        /* speed up I2C, 0xE is around 480KHz */
>> +	        <0x27>, <0x0e>,
>> +	        /* sets GPIO0 as an input */
>> +	        <0x1D>, <0x13>,
>> +	        /* set GPIO2 high, backlight PWM (set to 0x50 for normal use) */
>> +	        <0x1E>, <0x50>,
>> +	        /* sets GPIO3 as an output with remote control for touch XRES */
>> +	        <0x1F>, <0x05>,
>> +	        /* set GPIO5 high, backlight enable on new display */
>> +	        <0x20>, <0x09>,
>> +	        /* set GPIO7 and GPIO8 high to enable touch power and prox sense */
>> +	        <0x21>, <0x91>;
>>  };
> 

-- 
Michael Drake                 https://www.codethink.co.uk/
