Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803D8C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428AC20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AQegVWfh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfHLLF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:05:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44404 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfHLLF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:05:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CB5rkm038865;
        Mon, 12 Aug 2019 06:05:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565607953;
        bh=cjivHJk4IodMTUukuihyQ2B6xNrqOnifJ+g4ftsgd5I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AQegVWfhEZIqplkFo780/I6OF6Zl/kZXqPv/PWjSUvueY6f9/dyx8OjcyW/d792K1
         fbIRAWuI1T1KGJ5kOZHiJbfF77HrZl9D77Mtv6LWBnqP//Oi2y6+m+SaC8FvezTZLM
         N1UuSk1QqdYa5eo1EkBM4HJMYbLgnd1PXGc92C6s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CB5q3q058043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 06:05:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 06:05:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 06:05:52 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CB5nZX046855;
        Mon, 12 Aug 2019 06:05:50 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
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
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d3bba104-9a85-df8d-c62d-6acb8913c3fe@ti.com>
Date:   Mon, 12 Aug 2019 14:05:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812103147.GA4691@kuha.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2019 13:31, Heikki Krogerus wrote:
> Hi,
> 
>>>>>> +	real_role = cdsn3_real_role_switch_get(cdns->dev);
>>>>>> +
>>>>>> +	current_role = role;
>>>>>> +	dev_dbg(cdns->dev, "Switching role");
>>>>>> +
>>>>>> +	ret = cdns3_role_start(cdns, real_role);
>>>>>> +	if (ret) {
>>>>>> +		/* Back to current role */
>>>>>> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
>>>>>> +			role, current_role);
>>>>>> +		ret = cdns3_role_start(cdns, current_role);
>>>>>> +		if (ret)
>>>>>> +			dev_err(cdns->dev, "back to %d failed too\n",
>>>>>> +				current_role);
>>>>>> +	}
>>>>>> +exit:
>>>>>> +	pm_runtime_put_sync(cdns->dev);
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct usb_role_switch_desc cdns3_switch_desc = {
>>>>>> +	.set = cdns3_role_switch_set,
>>>>>> +	.get = cdsn3_real_role_switch_get,
>>>>>> +	.allow_userspace_control = true,
>>>>>
>>>>> how does user initiated cdns3_role_switch_set() via sysfs co-exist with role
>>>>> changes done by hardware events. e.g. ID/VBUS?
>>>>>
>>>>
>>>> Do you expect any issues whit this,  have you seen any problem with this
>>>> on your  platform ?
>>>>
>>>> I assume that it should work in this way:
>>>> 1. user change role by sysfs
>>>> 2. Driver change the role according with user request.
>>>> 3. If we receive correct ID/VBUS then role should not be changed
>>>>     because new role is the same as current set in point 2.
>>>>
>>>
>>> I have not tested this series yet.
>>> My understanding is that if user sets role to "host" or "device" then it should
>>> remain in that role irrespective of ID/VBUS. Once user sets it to "none" then
>>> port should set role based on ID/VBUS.
>>
>> According with your understanding it works the same way as by debugfs. 
>> Now I have no doubts to remove debugfs.c file :)
> 
> Hold on! The role "none" means that the connector should not be
> connected to either the host nor device.

OK.
> 
> The sysfs file we expose from the class for the role switches is
> primarily meant for supporting proprietary protocols that require us
> to basically override the connector USB data role. The default role
> should always be selected in the drivers.

OK. Let's take this example
- Port is dual-role port micro AB.
- microAB to type-A adapter is connected which pulls ID low. port transitions
to "host" role by the controller driver.
- proprietary protocol want to switch role to device role so writes "device" to
mode switch sysfs. port transitions to "device" role.

Now, how does controller driver know to fall back to HW based role switching?

> 
> With USB Type-C connectors and alternate modes, the "none" role is
> used for example when the connector is put into "USB Safe State". In
> case you guys are not familiar with USB Safe State, then it is a state
> (defined in USB PD specifications) for the connector where the data
> lines on the connector should not be physically connected to anything.
> The connector needs to be put into safe state always when entering
> or exiting an alternate mode, before the final mode (USB or alternate)
> is actually being set for the connector.
> 
> 
> thanks,
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
