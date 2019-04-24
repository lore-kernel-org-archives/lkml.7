Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C251920656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fFJIwvWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfDXJUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:20:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49456 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfDXJUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:20:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3O9KICG058659;
        Wed, 24 Apr 2019 04:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556097618;
        bh=fLqbvIiTlwHatcsylozyk1LclE4cbdIrc/jXG/lUOY0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fFJIwvWxY2t/YjWpy7eFX3K2tL2JKXcvjwsUzYgAjZhE99lcB4H0RZq/+ENnmcGgn
         KrnTB4vY/Qiffx6zd6to3MEqP1yJ9veZc45+rNEYFPB2F/L6aBXvNueK3qafbuZ4cP
         i4Da4scUDONFPi/riV8D7BNbSorHOyRsmH0OHqMU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3O9KIgm063047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 04:20:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 04:20:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 04:20:17 -0500
Received: from [172.22.181.92] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3O9KCge002130;
        Wed, 24 Apr 2019 04:20:15 -0500
Subject: Re: [PATCH net-next 05/19] net: ethernet: ti: cpsw: use local var dev
 in probe
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-6-git-send-email-grygorii.strashko@ti.com>
 <20190423184015.GD28405@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <609549ef-a283-4b3e-db8f-eb64660f7340@ti.com>
Date:   Wed, 24 Apr 2019 12:20:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190423184015.GD28405@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.04.19 21:40, Andrew Lunn wrote:
>> On Tue, Apr 23, 2019 at 04:08:56PM +0300, Grygorii Strashko wrote:
>> Use local variable struct device *dev in probe to simplify code.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>  drivers/net/ethernet/ti/cpsw.c | 65 +++++++++++++++++-----------------
>>  1 file changed, 33 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>> index 13a339c64892..0b8cc4e6d9cd 100644
>> --- a/drivers/net/ethernet/ti/cpsw.c
>> +++ b/drivers/net/ethernet/ti/cpsw.c
>> @@ -3458,6 +3458,7 @@ static const struct soc_device_attribute cpsw_soc_devices[] = {
>>  
>>  static int cpsw_probe(struct platform_device *pdev)
>>  {
>> +	struct device *dev = &pdev->dev;
>>  	struct clk			*clk;
>>  	struct cpsw_platform_data	*data;
>>  	struct net_device		*ndev;
> 
> It seems odd not to keep with the column layout?
> Plus it would make it reverse Christmas tree.

It's has never been optimized for Christmas tree and
I'll keep cur layout for now.

-- 
Best regards,
grygorii
