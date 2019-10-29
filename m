Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EDCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4922087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T5xpMM0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfJ2Jhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:37:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36698 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ2Jhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:37:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9T9bZaK092543;
        Tue, 29 Oct 2019 04:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572341855;
        bh=qx0+Boyw2DO4/fAggbJagSOI/nOtPK72Y21e3pUEeAg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T5xpMM0ld45ZVNOOYNeji7q/Km5OIyOk1Gb56lArOS+LUzzQXHxrPOkqRKy/xgL6J
         efbsrEs7SlmMKJxedgv6KVmO2vZp6RadAuEkU317S2111BJr2yfQkwiZFtp1w8VuF9
         Qfe2Rj+ucAnM0e2oSgEMZ12/Ng/zqjgR0UOMSMkI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9T9bZHC030105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 04:37:35 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 04:37:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 04:37:34 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9T9bVO6119682;
        Tue, 29 Oct 2019 04:37:32 -0500
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
To:     Peter Chen <peter.chen@nxp.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191023090232.27237-1-rogerq@ti.com>
 <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <20191025031343.GA13392@b29397-desktop>
 <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
 <20191029031223.GA26815@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <0c2c901c-a6f2-a81b-f5b1-e3f442d7c1ae@ti.com>
Date:   Tue, 29 Oct 2019 11:37:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029031223.GA26815@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2019 05:12, Peter Chen wrote:
> On 19-10-25 12:59:17, Roger Quadros wrote:
>> Peter,
>>
>> On 25/10/2019 06:13, Peter Chen wrote:
>>> On 19-10-23 09:17:45, Pawel Laszczak wrote:
>>>> Hi,
>>>>
>>>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
>>>
>>> Hi Roger & Pawel,
>>>
>>> Assume gadget function has already enabled, if you switch host mode
>>> to device mode, with your changes, where the device mode will be enabled
>>> again?
>>
>> When it switches from device mode to host the UDC is removed. When we switch
>> back from host to device mode the UDC is added, so,
>>
>> usb_add_gadget_udc_release()-> check_pending_gadget_drivers()->
>> udc_bind_to_driver()->usb_udc_connect_control()->usb_gadget_connect()->
>> gadget->ops->pullup()
> 
> Thanks. I have another question how you decide when to store UDC name
> to /sys/kernel/config/usb_gadget/g1/UDC? Do you have a user daemon program
> to monitor VBUS or external connector? At host mode, the store operation
> will fail due to there is NO UDC.
> 

Yes, user space needs to monitor /sys/class/usb_role/6000000.usb-role-switch/role

When it becomes "device" the UDC is available and it can prepare to configure
the UDC.

Could you please give your Ack for this patch if it is OK? Thanks.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
