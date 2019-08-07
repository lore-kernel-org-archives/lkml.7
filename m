Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4841C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2B321BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t+p5KfXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfHGKRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:17:53 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54990 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfHGKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:17:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77AHfkU032484;
        Wed, 7 Aug 2019 05:17:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565173061;
        bh=8B80rQzmFHzuKbIbEagU7c0QVOGuVAxvx2pdNKzWNGw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t+p5KfXq0pL/RD1jJh6CZpyP5SfjHdM7Aeo4yvKfFqMn1hmu74EQtVLUtFq9+BVP1
         W+gmSWM+rUi5Ujr8+sbALgxEhBH17E1U21uYJGyK79JukhSxVaWlupFSVzQPyxri6u
         VTagJ5FFrYZgIO7b7P4I2CYXl5r+xZifMKqN37a0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77AHfrc105749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 05:17:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 05:17:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 05:17:41 -0500
Received: from [137.167.41.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77AHcSE118254;
        Wed, 7 Aug 2019 05:17:38 -0500
Subject: Re: [PATCH v9 2/6] usb:gadget Separated decoding functions from dwc3
 driver.
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com>
 <1562324238-16655-3-git-send-email-pawell@cadence.com>
 <87tvc0lngz.fsf@linux.intel.com>
 <BYAPR07MB4709964C1D0AA2A851BF2F55DDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <b66216dd-6fcf-2900-e67b-42fdb81af78a@ti.com>
Date:   Wed, 7 Aug 2019 13:17:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB4709964C1D0AA2A851BF2F55DDF50@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/07/2019 14:44, Pawel Laszczak wrote:
> 
>> EXTERNAL MAIL
>>
>>
>>
>> Hi,
>>
>> Pawel Laszczak <pawell@cadence.com> writes:
>>> diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
>>> index da82606be605..d388a3a5ab7e 100644
>>> --- a/include/linux/usb/ch9.h
>>> +++ b/include/linux/usb/ch9.h
>>> @@ -70,4 +70,29 @@ extern enum usb_device_speed usb_get_maximum_speed(struct device *dev);
>>>   */
>>>  extern const char *usb_state_string(enum usb_device_state state);
>>>
>>> +/**
>>> + * usb_decode_ctrl - Returns human readable representation of control request.
>>> + * @str: buffer to return a human-readable representation of control request.
>>> + *       This buffer should have about 200 bytes.
>>> + * @size: size of str buffer.
>>> + * @bRequestType: matches the USB bmRequestType field
>>> + * @bRequest: matches the USB bRequest field
>>> + * @wValue: matches the USB wValue field (CPU byte order)
>>> + * @wIndex: matches the USB wIndex field (CPU byte order)
>>> + * @wLength: matches the USB wLength field (CPU byte order)
>>> + *
>>> + * Function returns decoded, formatted and human-readable description of
>>> + * control request packet.
>>> + *
>>> + * The usage scenario for this is for tracepoints, so function as a return
>>> + * use the same value as in parameters. This approach allows to use this
>>> + * function in TP_printk
>>> + *
>>> + * Important: wValue, wIndex, wLength parameters before invoking this function
>>> + * should be processed by le16_to_cpu macro.
>>> + */
>>> +extern const char *usb_decode_ctrl(char *str, size_t size, __u8 bRequestType,
>>> +				   __u8 bRequest, __u16 wValue, __u16 wIndex,
>>> +				   __u16 wLength);
>>> +
>>
>> where's the stub when !TRACING?
> 
> Right, I will add 
> #ifdef	CONFIG_TRACING 
> 	.....
> #endif 

Can usb_decode_ctrl() be used even when CONFIG_TRACING is not set?
If yes then above #ifdefe is not sufficient.

You might need to do something like

#if defined(CONFIG_TRACING)

extern const char *usb_decode_ctrl(..)

#else

static inline const char *usb_decode_ctrl(..) {
	return NULL;
}

#endif

--
cheers,
-roger 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
