Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB91C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E229208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EQdpt0It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406136AbfHIKg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:36:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33720 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:36:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x79AaHGK016340;
        Fri, 9 Aug 2019 05:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565346977;
        bh=4q79CmyOdwKe5gEnV4N+f7u36GkT/njQTib00vp3ZGA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EQdpt0ItbBKzlaZ7GyIcPgTgs4S3QM0KMnP+tV4FgkFDhBGpap9PX0r2ro1c88weu
         NkKxB2zLn7TstBOn2u8tsRKZirE440d2g9cREsCKKQl7VZmRUEedgeT1jgFCzFUm/K
         MVRtoZpgzWaES05OxnJxxYN69NbmYf3UjgkmcH3g=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x79AaHBx126062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Aug 2019 05:36:17 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 9 Aug
 2019 05:36:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 9 Aug 2019 05:36:16 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x79AaDxk006489;
        Fri, 9 Aug 2019 05:36:14 -0500
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
To:     Pawel Laszczak <pawell@cadence.com>, Pavel Machek <pavel@denx.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <20190721190335.GA19831@xo-6d-61-c0.localdomain>
 <BYAPR07MB470904ACCD1ED91B10BB6BEFDDC40@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20190722114839.GA10515@kroah.com> <20190722115644.GA12069@amd>
 <20190722210021.GA25235@amd>
 <BYAPR07MB470966850323EE3003B3097ADDC70@BYAPR07MB4709.namprd07.prod.outlook.com>
 <93b4a702-227b-0410-a414-76873088ad72@ti.com>
 <BYAPR07MB47095895491CFD211EE9E051DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <3fce07ee-5e69-58a9-58f6-750f60b66296@ti.com>
Date:   Fri, 9 Aug 2019 13:36:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB47095895491CFD211EE9E051DDD70@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 08/08/2019 07:12, Pawel Laszczak wrote:
> Hi Roger,
> 
>>
>>
>> On 23/07/2019 07:32, Pawel Laszczak wrote:
>>
>>> Hi,
>>
>>>
>>
>>>> On Mon 2019-07-22 13:56:44, Pavel Machek wrote:
>>
>>>>> Hi!
>>
>>>>>
>>
>>>>>>>>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>
>>>>>>>>>
>>
>>>>>>>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>
>>>>>>>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>
>>>>>>>>> Host Only (XHCI)configurations.
>>
>>>>>>>>
>>
>>>>>>>> I see you are using debugfs to select between DRD, peripheral-onlyh and XHCI...
>>
>>>>>>>>
>>
>>>>>>>> Is that good idea?
>>
>>>>>>>
>>
>>>>>>> Yes driver allows selecting dr_mode by debugfs. Controller also support such functionality
>>
>>>>>>> so I don't understand why would it not be a good idea.
>>
>>>>>>>
>>
>>>>>>> I personally use this for testing but it can be used to limit controller functionality without
>>
>>>>>>> recompiling kernel.
>>
>>>>>>
>>
>>>>>> debugfs is ONLY for debugging, never rely on it being enabled, or
>>
>>>>>> mounted, on a system in order to have any normal operation happen.
>>
>>>>>>
>>
>>>>>> So for testing, yes, this is fine.  If this is going to be the normal
>>
>>>>>> api/interface for how to control this driver, no, that is not acceptable
>>
>>>>>> at all.
>>
>>>>>
>>
>>>>> It makes a lot of sense for end-user to toggle this... for example
>>
>>>>> when he is lacking right cable for proper otg detection. As it is
>>
>>>>> third driver offering this functionality, I believe we should stop
>>
>>>>> treating it as debugging.
>>
>>>>
>>
>>>> At least renesas usb controller seems to have variables in sysfs:
>>
>>>> drivers/phy/renesas/phy-rcar-gen3-usb2.c : functions role_show and
>>
>>>> role_store. See also
>>
>>>> Documentation/ABI/testing/sysfs-platform-phy-rcar-gen3-usb2 .
>>
>>>>
>>
>>>> I believe this driver should do same.
>>
>>>>
>>
>>>
>>
>>> CDNS3 driver use the role framework and also has such variable defined
>>
>>> in role switch framework.
>>
>>>
>>
>>> https://urldefense.proofpoint.com/v2/url?u=https-
>> 3A__elixir.bootlin.com_linux_latest_source_drivers_usb_roles_class.c&d=DwICaQ&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-
>> _haXqY&r=e1OgxfvkL0qo9XO6fX1gscva-w03uSYC1nIyxl89-rI&m=_jBsEOB3gtoQVvsVk8k2Pz8dp9zhzZbbL4M0tINJLR8&s=mq5ce-d4Td-
>> lc3OvcvektfSHhXPAL2Go2gWP-q9QwTY&e=
>>
> 
> The meaning is little different. Role switch framework allow to changing role [ host -> device, device -> host ]
> 
> The debugfs.c allows to limit dr_mode. 
> 
>>
>> Can we get rid of the debugfs interface for user initiated role change and just
>>
>> rely on role switch framework via sysfs?
>>
>>
>>
>> We do need user initiated role changes in production systems. So we can't
>>
>> rely on debugfs for this.
> 
> But I assume that in production systems this will be disabled. 
> cdns3-$(CONFIG_DEBUG_FS)		+= debugfs.o
> 

But we do want user space based role switching in production systems.

> I think that I understand your concerns. My idea was not to expand the supported 
> dr_mode. Rather I wanted to have possibility to limit this (only for testing). 
> 
> Eg. 
> If  cdns->dr_mode = USB_DR_MODE_OTG
> then we can limit mode to HOST or DEVICE or DRD

In this case we register with role switch framework.

> if cdns->dr_mode == USB_DR_MODE_HOST || 
>    cdns->dr_mode == USB_DR_MODE_PERIPHERAL) 
> then driver can't change anything

In this case we don't register to role switch framework.

> 
> It allows me for testing some functionality using only single board 
> and even with lacking right cable for proper otg detection. 
> 
> So, removing this can cause that testing some functionality 
> will  be limited on my boards.
> 
> If you rely want to remove this, maybe we could do this 
> after putting this driver to kernel ?.  

I don't want you to remove the user based role change functionality.
I'm just asking to rely on role switch framework for that and not debugfs.

> 
> Maintaining this as my internal code before putting this driver 
> to kernel will be problematic.
> 
> Regards,
> Pawell
> 
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
