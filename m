Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E7BC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3BE20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jzJ6IUbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbfJPJZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:25:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46318 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732124AbfJPJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:25:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9G9P0Cr049206;
        Wed, 16 Oct 2019 04:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571217900;
        bh=JCp9NDVOPJ/jkmiAXxjMw3QseopHXTfTuzXh/Aea6Dg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jzJ6IUbHI5OFOT1UTFz8OC+sOk5BmdIaP77KTFW7SJanw9JG+nT3AsjgWqRKwarCX
         jWyFcAJ848zUGztqS0df4NNJcfRh4QV/BQx9OS3DxMg0icIgDhE6mpYuG9LGAehuCT
         ZxRQBOFz7rHJFJwTY9i/cB/HXSeIobcyN+AgRtAQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G9P0mQ034719;
        Wed, 16 Oct 2019 04:25:00 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 04:24:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 04:24:53 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9G9Ou6H015203;
        Wed, 16 Oct 2019 04:24:56 -0500
Subject: Re: [RFC][PATCH 3/3] usb: dwc3: Registering a role switch in the DRD
 code.
To:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-4-john.stultz@linaro.org>
 <9e86bb7b-5dd2-760e-c324-fe1c1ee41868@ti.com>
 <CALAqxLUVd5Eo_9tuP9aQUpNT0gnewBv8Dpvsj8UT3MucmzCJVQ@mail.gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <fc74130f-bc8e-5d44-2c4a-340934c7b1d3@ti.com>
Date:   Wed, 16 Oct 2019 12:24:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLUVd5Eo_9tuP9aQUpNT0gnewBv8Dpvsj8UT3MucmzCJVQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 22:10, John Stultz wrote:
> On Tue, Oct 15, 2019 at 1:25 AM Roger Quadros <rogerq@ti.com> wrote:
>> On 03/10/2019 02:16, John Stultz wrote:
>>> @@ -487,7 +539,28 @@ int dwc3_drd_init(struct dwc3 *dwc)
>>>        if (IS_ERR(dwc->edev))
>>>                return PTR_ERR(dwc->edev);
>>>
>>> -     if (dwc->edev) {
>>> +     if (device_property_read_bool(dwc->dev, "usb-role-switch")) {
>>
>> I think we should use role switch unconditionally and get rid of the
>> debugfs role status/change mechanism.
>>
>>> +             struct usb_role_switch_desc dwc3_role_switch = {0};
>>> +             u32 mode;
>>> +
>>> +             if (device_property_read_bool(dwc->dev,
>>> +                                           "role-switch-default-host")) {
>>> +                     dwc->role_switch_default_mode = USB_DR_MODE_HOST;
>>> +                     mode = DWC3_GCTL_PRTCAP_HOST;
>>> +             } else {
>>> +                     dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
>>> +                     mode = DWC3_GCTL_PRTCAP_DEVICE;
>>> +             }
>>> +             dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
>>> +             dwc3_role_switch.set = dwc3_usb_role_switch_set;
>>> +             dwc3_role_switch.get = dwc3_usb_role_switch_get;
>>> +             dwc->role_sw = usb_role_switch_register(dwc->dev,
>>> +                                                     &dwc3_role_switch);
>>> +             if (IS_ERR(dwc->role_sw))
>>> +                     return PTR_ERR(dwc->role_sw);
>>> +
>>> +             dwc3_set_mode(dwc, mode);
>>> +     } else if (dwc->edev) {
>>
>> Role switch should exist regardless if dwc->edev is present or not.
> 
> Does that risk duplicative mode sets when things change (via the
> dwc3_drd_notifier and dwc3_usb_role_switch_set calls?).

Yes, we need to deal with it in the driver. e.g. in current case
when debugfs overrides a role from "otg" to "host" or "device",
we ignore the notifier.

Something similar could be done with role switch I think.

Felipe, what do you think?

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
