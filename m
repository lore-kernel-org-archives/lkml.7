Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1244CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEDA2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vGjLPsbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408457AbfJXFmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:42:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54966 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406827AbfJXFmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:42:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9O5gIkr022099;
        Thu, 24 Oct 2019 00:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571895738;
        bh=1susFL8yyU6x2EwRsC8j65/nDn4hrAowuiYbWMpaMuY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vGjLPsbGlcEWZplp+8r5FLN+7MWiRO8hAhnXaE9bUnJq39QGNd3MueNjCRl6JuBZq
         ieGnRk8ovGM+Cqaj7dzSxh+ZRjriesQiqMw2YZDI8ED5bg4vyzzoIzx0lhMSw8IBV3
         7+8hyjBJlZno8MOISh+tN4bW1MaqdsrNIjWULN1o=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9O5gI9S110446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Oct 2019 00:42:18 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 24
 Oct 2019 00:42:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 24 Oct 2019 00:42:08 -0500
Received: from [10.250.98.116] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9O5gGc5059682;
        Thu, 24 Oct 2019 00:42:17 -0500
Subject: Re: [PATCH] phy: ti: gmii-sel: fix mac tx internal delay for
 rgmii-rxid
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20191023144744.1246-1-grygorii.strashko@ti.com>
 <45a6ffd4-c0bd-1845-cb71-9adbafde2dd8@gmail.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <98235ce5-a86b-46be-c390-18bbbfd1df03@ti.com>
Date:   Thu, 24 Oct 2019 08:42:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <45a6ffd4-c0bd-1845-cb71-9adbafde2dd8@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2019 05:41, Florian Fainelli wrote:
> 
> 
> On 10/23/2019 7:47 AM, Grygorii Strashko wrote:
>> Now phy-gmii-sel will disable MAC TX internal delay for PHY interface mode
>> "rgmii-rxid" which is incorrect.
>> Hence, fix it by enabling MAC TX internal delay in the case of "rgmii-rxid"
>> mode.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Should this have a:
> 
> Fixes: 92b58b34741f ("phy: ti: introduce phy-gmii-sel driver")
> 

Yes. it should.
Kishon, would you like me to re-submit or can you fix while applying?


-- 
Best regards,
grygorii
