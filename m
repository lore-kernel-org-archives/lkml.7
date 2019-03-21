Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5809C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBE021901
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWBWVRDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfCUPX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:23:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ObdQXwwrrxqNu5FhVu5toNeiAgOZo1dOVmsIIXV2kkI=; b=HWBWVRDz/4GEHqsultxDzkhf9
        x+QYar943ALu+3OsUMbyL70/2PQExrdsU50/RowT633AePVd5gjMJ9gxNWzs94VZizyTFNjddO2RA
        fTAMUAw04h+WHtZoxJWkrOHwLgch1SVyIRrV/Ezthvy3QwZUhRBvD4YB6dVxRcRNWNwCG9IAu/NvS
        cDBXu1Pcs7O/jds9jTUV1lygCndYrB4BIIyrQ/26JLMzfB3mXQof3Uxu7XhDAH0zQzu6vcT8N91Zy
        qMHYWmfJWAw5h6xIVXEBKqPqiMAe3eZ+fEvmNmutMQfARUle8r9FCrJmWK0aoggC5ZhwadlU6TatR
        pnXp/5viw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6zXR-0006Gp-AI; Thu, 21 Mar 2019 15:23:25 +0000
Subject: Re: [PATCH v2] EDAC, mellanox: Add ECC support for BlueField DDR4
To:     Junhan Zhou <Junhan@mellanox.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Liming Sun <lsun@mellanox.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1552934340-10103-1-git-send-email-Junhan@mellanox.com>
 <6a56e799-b5fd-8437-6339-9c88acb3bbe5@infradead.org>
 <DB6PR0501MB270922D61D8F228A31A664CDB3420@DB6PR0501MB2709.eurprd05.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb7939d0-2723-7d8c-2f9f-03c24f0cef77@infradead.org>
Date:   Thu, 21 Mar 2019 08:23:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DB6PR0501MB270922D61D8F228A31A664CDB3420@DB6PR0501MB2709.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 7:30 AM, Junhan Zhou wrote:
>>> +config EDAC_BLUEFIELD
>>> +	tristate "Mellanox BlueField Memory ECC"
>>> +	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) ||
>> COMPILE_TEST
>>
>> Hi,
>>
>> While I am in favor of using COMPILE_TEST whenever possible, I don't see
>> how that is possible here if:
>>
>> # MELLANOX_PLATFORM is not set
>> # ARM64 is not set
>> # ACPI is not set
>> COMPILE_TEST=y
>>
>> Can you please explain?
>>
>> Thanks.
>>
>> ~Randy
> 
> Good point. I tried compiling it against the x86 architecture and it fails because it can't find the definition for arm_smccc_smc(). But it would compile for the ARM64 architecture with both ACPI and MELLANOX _PLATFORM not set, so I'll change it to ARM64 && ((MELLANOX_PLATFORM && ACPI) || COMPILE_TEST) instead.
> The dependency on ACPI is because our BlueField SoC firmware only uses ACPI to pass the device mappings, and MELLANOX_PLATFORM because this device is only seen on the Mellanox BlueField SoC so it would be pointless to be used elsewhere, but these doesn't prevent it from being compiled.
> 
> -Junhan
> 

Sounds fine.  Thanks.

-- 
~Randy
