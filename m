Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3DEC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6468206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="htF+g3n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfDYOOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:14:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57922 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDYOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:14:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3PEEbfw103626;
        Thu, 25 Apr 2019 09:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556201677;
        bh=mnzOSiUdg09gG9afWMjshvm0a4M026nYgd6lwUOdW1Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=htF+g3n2wOQcYbt3H1ss606d2GCU+Rfzu5khH59hih8tnCuw8rNCgK17ytYZTUgoG
         u2oUjqv+RbsxiIk205Zk3areeuGCkNLZCBq4+4UpPL9jyoUnKfeIAFG2tNuXqzCxgj
         YPSRgNdkh17nxLpcCee+V1dpJ9pKPw9YggcbcOvU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3PEEbhW005749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Apr 2019 09:14:37 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 25
 Apr 2019 09:14:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 25 Apr 2019 09:14:36 -0500
Received: from [172.22.129.216] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3PEEXfn060365;
        Thu, 25 Apr 2019 09:14:34 -0500
Subject: Re: [PATCH net-next 16/19] net: ethernet: ti: cpsw: move common hw
 init code in separate func
To:     Murali Karicheri <m-karicheri2@ti.com>, <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-17-git-send-email-grygorii.strashko@ti.com>
 <71d13a87-a078-a49d-43b2-33beb19f0e46@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <0bec250e-7c16-4c5b-d56e-581e8d8ca46b@ti.com>
Date:   Thu, 25 Apr 2019 17:14:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <71d13a87-a078-a49d-43b2-33beb19f0e46@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.04.19 16:38, Murali Karicheri wrote:
> On 04/23/2019 09:09 AM, Grygorii Strashko wrote:
>> move common hw init code in separate function as preparation for adding new
>> switchdev driver.
> All of the changes indicates a better name for the file is cpsw_common.c; commit log,
 new function cpsw_init_common() etc. Any specific reason to use cpsw_priv.[ch]?

I've been thinking about this, but cpsw_coomon.c is used by davinici_emac also.
More over, I have a hope that it'd be possible to get rid of cpsw_common.c at all
by switching to nvmem.

Also, I'd be very appreciated if you'd be able to cut your replies.
It's a little bit hard to find your comments

> 
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/net/ethernet/ti/Makefile    |   2 +-
>>   drivers/net/ethernet/ti/cpsw.c      | 106 ++---------------------
>>   drivers/net/ethernet/ti/cpsw_priv.c | 128 ++++++++++++++++++++++++++++
>>   drivers/net/ethernet/ti/cpsw_priv.h |   3 +
>>   4 files changed, 137 insertions(+), 102 deletions(-)
>>   create mode 100644 drivers/net/ethernet/ti/cpsw_priv.c
>>
>> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
>> index 2f159a71f88e..de1561596646 100644
...

-- 
Best regards,
grygorii
