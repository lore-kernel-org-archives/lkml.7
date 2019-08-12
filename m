Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1490C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4A20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pS3+xUTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfHLNFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:05:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58122 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:05:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CD4u6D069046;
        Mon, 12 Aug 2019 08:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565615096;
        bh=+0J8/dXNY2I0HxagR2J8izHTeBMCABSonsYQvwNG014=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pS3+xUTBTGRFVf8qelsL4jJSeeBrtWlEoPtzu2q8tGCzdlZC58FqK/jYyitJy2o47
         Kt2YTFPzWNnwXKc+x++l5XN+G9zNWE8EpXU/5lPiiJ3QhEHDbkcZKN+gSE66BxVWnf
         Sqjs23IL2LEBCzevVTFeoqDI7PPgtr5e011vexA4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CD4umB067487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 08:04:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 08:04:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 08:04:55 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CD4qFS074187;
        Mon, 12 Aug 2019 08:04:53 -0500
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <679b82bc-9f33-91ad-4acf-bf6a29e51bc1@ti.com>
Date:   Mon, 12 Aug 2019 16:04:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <874l2mtuu6.fsf@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/08/2019 15:46, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>>> The sysfs file we expose from the class for the role switches is
>>> primarily meant for supporting proprietary protocols that require us
>>> to basically override the connector USB data role. The default role
>>> should always be selected in the drivers.
>>
>> OK. Let's take this example
>> - Port is dual-role port micro AB.
>> - microAB to type-A adapter is connected which pulls ID low. port transitions
>> to "host" role by the controller driver.
>> - proprietary protocol want to switch role to device role so writes "device" to
>> mode switch sysfs. port transitions to "device" role.
>>
>> Now, how does controller driver know to fall back to HW based role switching?
> 
> Use a 'disconnect' or 'suspend' event to go reset it? But that should,
> probably, be done at kernel space, no?
> 

Yes that could be one option.
So after a disconnect, sysfs role should reflect actual hardware role. correct?

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
