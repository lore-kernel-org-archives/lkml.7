Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3AE21E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cxQpOi2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfHGLFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:05:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39142 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfHGLFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:05:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77B5LtZ028565;
        Wed, 7 Aug 2019 06:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565175921;
        bh=nIyjRqOCV+fa1wLbVQ5oPPsgl+jCvyZgKCB0XcNKbgg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cxQpOi2upgbFMxfhgV/yXDjyMTgt2bQVI906VDgUS8FtjAqFhOxsr65b9nX3fBC4/
         xgWpOCTxcejRAS7V10Quw2K9kUrrV6tifR3K+gZUPXWyye44o80px7gqYWDmQ1HfD6
         nsrcgsqPmiP+WC5qkB/CI7CXriIYUJkCCxe49R8Q=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77B5LTn029362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 06:05:21 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 06:05:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 06:05:20 -0500
Received: from [137.167.41.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77B5IRL002412;
        Wed, 7 Aug 2019 06:05:18 -0500
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
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <93b4a702-227b-0410-a414-76873088ad72@ti.com>
Date:   Wed, 7 Aug 2019 14:05:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB470966850323EE3003B3097ADDC70@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel,

On 23/07/2019 07:32, Pawel Laszczak wrote:
> Hi, 
> 
>> On Mon 2019-07-22 13:56:44, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>>>>>>
>>>>>>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>>>>>>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>>>>>>> Host Only (XHCI)configurations.
>>>>>>
>>>>>> I see you are using debugfs to select between DRD, peripheral-onlyh and XHCI...
>>>>>>
>>>>>> Is that good idea?
>>>>>
>>>>> Yes driver allows selecting dr_mode by debugfs. Controller also support such functionality
>>>>> so I don't understand why would it not be a good idea.
>>>>>
>>>>> I personally use this for testing but it can be used to limit controller functionality without
>>>>> recompiling kernel.
>>>>
>>>> debugfs is ONLY for debugging, never rely on it being enabled, or
>>>> mounted, on a system in order to have any normal operation happen.
>>>>
>>>> So for testing, yes, this is fine.  If this is going to be the normal
>>>> api/interface for how to control this driver, no, that is not acceptable
>>>> at all.
>>>
>>> It makes a lot of sense for end-user to toggle this... for example
>>> when he is lacking right cable for proper otg detection. As it is
>>> third driver offering this functionality, I believe we should stop
>>> treating it as debugging.
>>
>> At least renesas usb controller seems to have variables in sysfs:
>> drivers/phy/renesas/phy-rcar-gen3-usb2.c : functions role_show and
>> role_store. See also
>> Documentation/ABI/testing/sysfs-platform-phy-rcar-gen3-usb2 .
>>
>> I believe this driver should do same.
>>
> 
> CDNS3 driver use the role framework and also has such variable defined 
> in role switch framework.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/roles/class.c

Can we get rid of the debugfs interface for user initiated role change and just
rely on role switch framework via sysfs?

We do need user initiated role changes in production systems. So we can't
rely on debugfs for this.

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
