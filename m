Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A2C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6564C21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CtbMOKFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfJINvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:51:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47934 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfJINu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:50:59 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x99Dorv0099169;
        Wed, 9 Oct 2019 08:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570629053;
        bh=aDMkgJ6As2ITUR97XtoWkxRL978K35Np9E194tf40gc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CtbMOKFs1SFYTEzRJGXh8pFoYIHerhlxDF5mT6JYJBmZghZkDBNqi695zzp74MU/Z
         g4ZNMr/LFo+YlHjDzrr43xGvZLrkbwiAJRx5gASA0HWke8YOzUq4B6NB3o1Ohy/BPM
         VEcWe/xMbEiswClf52kjh4fRS9tjxAA+yzJzqFJ8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x99Dor7Q082395
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 08:50:53 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 08:50:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 08:50:51 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x99Don2b093308;
        Wed, 9 Oct 2019 08:50:49 -0500
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Peter Chen <peter.chen@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com>
 <20191008065619.GE5670@b29397-desktop> <87a7abv1f2.fsf@gmail.com>
 <BYAPR07MB4709490136F8F65A008C219EDD950@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <80047a82-4b01-8f54-7efa-c32f696ced43@ti.com>
Date:   Wed, 9 Oct 2019 16:50:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB4709490136F8F65A008C219EDD950@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 09/10/2019 06:58, Pawel Laszczak wrote:
> Hi,
> 
>>
>> Hi,
>>
>> Peter Chen <peter.chen@nxp.com> writes:
>>> On 19-10-07 07:39:11, Pawel Laszczak wrote:
>>>> Patch fixes issue with Halt Endnpoint Test observed
>>>
>>> %s/Endnpoint/Endpoint
>>>
>>>>
>>>> during using g_zero
>>>> driver as DUT. Bug occurred only on some testing board.
>>>
>>> g_zero is legacy, please use configfs function source_sink or loopback
>>> instead.
>>
>> We still want fixes for those ;-)
> 
> So, if my understanding is correct in new production systems
> using legacy gadget drivers is not recommended and we are not going to fix
> any more bugs there.

We can't really control who uses what. So we need to support legacy
drivers as well.

The issue detected by using g_zero is a controller driver issue and not an
issue with g_zero itself.

cheers,
-roger

> 
> The legacy gadget drivers remains in the kernel only to support the old
> products.
> 
> So because we introduce new driver we should not worry  about legacy
> gadget drivers.
> 
> Is my understanding correct ?
> 
> pawell
>   
>>
>>>> Endpoint can defer transition to Halted state if endpoint has pending
>>>> requests.
>>>
>>> The implementation of halt handling is a little complicated, you may
>>> consider return -EAGAIN for functional stall through usb_ep_set_halt
>>> from function driver if the requests are pending, it doesn't need to
>>> defer such kinds of functional stall.
>>
>> -EAGAIN, IIRC is only supposed to be used for IN endpoint stalls.
>>
>> --
>> balbi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
