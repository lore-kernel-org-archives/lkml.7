Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CD02070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l9xTYOq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410021AbfJYLjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:39:52 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37776 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfJYLjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:39:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9PBdp3j090721;
        Fri, 25 Oct 2019 06:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572003591;
        bh=TtOkjwPBoPyM5VIPZXm9zE0mKlSziofkfWXNj6bcDwE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l9xTYOq4CAazDACc6FEUJ7/oDWIbbFh7FrESwg53t9Lsvf62dAamf589mhg6YvqCa
         5hyMxFPr7gCujCU8l6LhYp/SsUcZ5SDj4RMasCoO0R2Uu8q7A1RIgWET22ZM/Q5MW7
         Iawy6HEi1gF2rpD8B/Us/1MG0V50qTaLtKGJH7vg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9PBdouE096419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Oct 2019 06:39:50 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 06:39:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 06:39:39 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9PBdlCa063355;
        Fri, 25 Oct 2019 06:39:48 -0500
Subject: Re: [PATCH] phy: ti: gmii-sel: fix mac tx internal delay for
 rgmii-rxid
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
References: <20191023144744.1246-1-grygorii.strashko@ti.com>
 <45a6ffd4-c0bd-1845-cb71-9adbafde2dd8@gmail.com>
 <98235ce5-a86b-46be-c390-18bbbfd1df03@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <55af0ece-be69-ae73-8b57-43cd6750664b@ti.com>
Date:   Fri, 25 Oct 2019 17:09:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <98235ce5-a86b-46be-c390-18bbbfd1df03@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/19 11:12 AM, Grygorii Strashko wrote:
> 
> 
> On 24/10/2019 05:41, Florian Fainelli wrote:
>>
>>
>> On 10/23/2019 7:47 AM, Grygorii Strashko wrote:
>>> Now phy-gmii-sel will disable MAC TX internal delay for PHY interface mode
>>> "rgmii-rxid" which is incorrect.
>>> Hence, fix it by enabling MAC TX internal delay in the case of "rgmii-rxid"
>>> mode.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Should this have a:
>>
>> Fixes: 92b58b34741f ("phy: ti: introduce phy-gmii-sel driver")
>>
> 
> Yes. it should.
> Kishon, would you like me to re-submit or can you fix while applying?


merged now, thanks!

-Kishon
