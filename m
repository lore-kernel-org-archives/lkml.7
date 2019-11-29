Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B57DC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D16E2158A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uLdsnhCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfK2R6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:58:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58644 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfK2R6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 12:58:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xATHwltV058119;
        Fri, 29 Nov 2019 11:58:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575050327;
        bh=zw3/H6QkElTXo6jVuCmTPMcqTN3zsUIuzuy9J4YYVWA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uLdsnhCaZR5O3m31XcK5d6zbqjOkZ3Q21VrPuG0DgnLwmNzvkMVRAWMmGRWiUELUT
         uEWym6cNl9kbKA2+CoN6zcngwpw9M2t7faEfIRySyFe0gveUmzGQsgYOEfhhWezygP
         gVWDgzJaBqgjrlv1sbkZWpUXG44ovrv8S/RyV3ZI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xATHwlnF027393;
        Fri, 29 Nov 2019 11:58:47 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 29
 Nov 2019 11:58:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 29 Nov 2019 11:58:47 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xATHwi1t101026;
        Fri, 29 Nov 2019 11:58:45 -0600
Subject: Re: [PATCH] net: ethernet: ti: ale: ensure vlan/mdb deleted when no
 members
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20191127155905.22921-1-grygorii.strashko@ti.com>
 <20191128082127.GA16359@apalos.home> <20191128093804.GA18633@apalos.home>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <9068bff5-1542-f19a-e947-3b0be332e8e5@ti.com>
Date:   Fri, 29 Nov 2019 19:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128093804.GA18633@apalos.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/2019 11:38, Ilias Apalodimas wrote:
> On Thu, Nov 28, 2019 at 10:21:27AM +0200, Ilias Apalodimas wrote:
>> On Wed, Nov 27, 2019 at 05:59:05PM +0200, Grygorii Strashko wrote:
>>> The recently updated ALE APIs cpsw_ale_del_mcast() and
>>> cpsw_ale_del_vlan_modify() have an issue and will not delete ALE entry even
>>> if VLAN/mcast group has no more members. Hence fix it here and delete ALE
>>> entry if !port_mask.
>>>
>>> The issue affected only new cpsw switchdev driver.
>>>
>>> Fixes: e85c14370783 ("net: ethernet: ti: ale: modify vlan/mdb api for switchdev")
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>>   drivers/net/ethernet/ti/cpsw_ale.c | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>>> index 929f3d3354e3..a5179ecfea05 100644
>>> --- a/drivers/net/ethernet/ti/cpsw_ale.c
>>> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
>>> @@ -396,12 +396,14 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
>>>   	if (port_mask) {
>>>   		mcast_members = cpsw_ale_get_port_mask(ale_entry,
>>>   						       ale->port_mask_bits);
>>> -		mcast_members &= ~port_mask;
>>> -		cpsw_ale_set_port_mask(ale_entry, mcast_members,
>>> +		port_mask = mcast_members & ~port_mask;
>>> +	}
>>> +
>>> +	if (port_mask)
>>> +		cpsw_ale_set_port_mask(ale_entry, port_mask,
>>>   				       ale->port_mask_bits);
>>> -	} else {
>>> +	else
>>>   		cpsw_ale_set_entry_type(ale_entry, ALE_TYPE_FREE);
>>> -	}
>>
>> The code assumed calls cpsw_ale_del_mcast() should have a port mask '0' when
>> deleting an entry. Do we want to have 'dual' functionality on it?
>> This will delete mcast entries if port mask is 0 or port mask matches exactly
>> what's configured right?
>>
> 
> Deleting the ALE entry if the port_mask matches execlty what's configured makes
> sense. Can we change it to something that doesn't change the function argument?
> 
> I think something like:
> mcast_members = 0;
> if (port_mask) {
> 	mcast_members = cpsw_ale_get_port_mask(ale_entry,
> 											ale->port_mask_bits);
> 	mcast_members &= ~port_mask;
> }
> if (mcast_members)
> 	cpsw_ale_set_port_mask(ale_entry, mcast_members, ....)
> else
> 	cpsw_ale_set_entry_type(....)
> 
> is more readable?
> 

Thank you. I've sent v2.	


-- 
Best regards,
grygorii
