Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5814DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27589206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y+7tCx1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfHMHsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:48:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46564 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfHMHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:48:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7D7m8EB000855;
        Tue, 13 Aug 2019 02:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565682488;
        bh=uNvryr3zhucZH7vFXqMFNma1Etgzbhp6KefrH72VEZY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Y+7tCx1FKaSCm/ff4Et4xDnlGfgYnGPxr8IY6jyDaTmfSoMT7Ut/7wO1obgEOXuTW
         ewkrsPFCYK4SVVRDHrhGyl0Z8bPXRDoWul7y9qPa/109pd+2oLEFqfbIaVfqro/PGq
         4RHBHX9XaHTdvhcQOA5TBfrQeWHSepuIvCsiOKrQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7D7m8BT016361
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Aug 2019 02:48:08 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 13
 Aug 2019 02:48:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 13 Aug 2019 02:48:07 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7D7m49O108423;
        Tue, 13 Aug 2019 02:48:04 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com>
 <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
 <1e557bcf-2d50-f600-0e81-1f9fba5499a1@ti.com>
 <BYAPR07MB4709F306EC472B7AABEB7D4CDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190812103147.GA4691@kuha.fi.intel.com>
 <d3bba104-9a85-df8d-c62d-6acb8913c3fe@ti.com> <874l2mtuu6.fsf@gmail.com>
 <679b82bc-9f33-91ad-4acf-bf6a29e51bc1@ti.com>
 <1565681434.23705.66.camel@mhfsdcap03>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <7c0c5de2-1100-333a-eb0e-52bab4eb9cd5@ti.com>
Date:   Tue, 13 Aug 2019 10:48:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565681434.23705.66.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 10:30, Chunfeng Yun wrote:
> On Mon, 2019-08-12 at 16:04 +0300, Roger Quadros wrote:
>>
>> On 12/08/2019 15:46, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Roger Quadros <rogerq@ti.com> writes:
>>>>> The sysfs file we expose from the class for the role switches is
>>>>> primarily meant for supporting proprietary protocols that require us
>>>>> to basically override the connector USB data role. The default role
>>>>> should always be selected in the drivers.
>>>>
>>>> OK. Let's take this example
>>>> - Port is dual-role port micro AB.
>>>> - microAB to type-A adapter is connected which pulls ID low. port transitions
>>>> to "host" role by the controller driver.
>>>> - proprietary protocol want to switch role to device role so writes "device" to
>>>> mode switch sysfs. port transitions to "device" role.
>>>>
>>>> Now, how does controller driver know to fall back to HW based role switching?
>>>
>>> Use a 'disconnect' or 'suspend' event to go reset it? But that should,
>>> probably, be done at kernel space, no?
>>>
>>
>> Yes that could be one option.
>> So after a disconnect, sysfs role should reflect actual hardware role. correct?
> 
> Maybe it's difficult to support both HW based role switch and SW based
> role switch by sysfs at the same if the HW's FSM rely on, such as, the
> state of Vbus pin or ID pin. Likes the upper example, when user writes
> "device" to mode switch sysfs, the driver should skip the HW state of ID
> pin, due to it's state is Low, or force it as High.
> 

We do need a clear way of indicating that SW wants to override so HW
state is ignored.

> Another option way is that introduces a property in DTS to indicate the
> way the driver want to use (HW based or SW based, usb_role_switch
> doesn't provide this information for the controller driver), but is not
> flexible enough.

That is not good enough for us. We need both HW and SW based role switching.

Can we introduce a new state (e.g. "auto") in usb_role_switch. This would
explicitly indicate the driver to do HW based switching.

This way we don't need to depend on connect/disconnect events and can
do role switch tests even without cable/device connected.

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
