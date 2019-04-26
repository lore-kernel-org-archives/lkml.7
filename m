Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF2CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FABC206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDZOYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:24:53 -0400
Received: from [110.188.70.11] ([110.188.70.11]:36783 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbfDZOYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:24:52 -0400
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam2.hygon.cn with ESMTP id x3QENTcC027711;
        Fri, 26 Apr 2019 22:23:29 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id x3QENMGQ012827;
        Fri, 26 Apr 2019 22:23:22 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 26 Apr
 2019 22:23:24 +0800
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
To:     Jean Delvare <jdelvare@suse.de>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
 <20190426113751.77befab1@endymion>
Message-ID: <0c895129-23af-2fc6-0c99-61348a69f961@hygon.cn>
Date:   Fri, 26 Apr 2019 22:23:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426113751.77befab1@endymion>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn x3QENTcC027711
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/26 17:38, Jean Delvare wrote:
> Sorry for the late answer.

Thanks for the reply!

>> Cc: <stable@vger.kernel.org> # v5.0+
> 
> I object to adding this to stable. It's not fixing any bug, and it's
> far from being a one-liner. I'd rather let distributions backport it as
> they see fit.

Okay, will not add this patch to stable.

>> +	     PIIX4_dev->revision >= 0x49) ||
>> +	    (PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON &&
>> +	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>>   	     PIIX4_dev->revision >= 0x49))
>>   		smb_en = 0x00;
> 
> Does the compatibility with the original AMD chipset include the
> revision number?

The revision number may not be needed here, although it indeed larger 
than 0x49 on Hygon platform.

>> -		if (dev->vendor == PCI_VENDOR_ID_AMD &&
>> +		if ((dev->vendor == PCI_VENDOR_ID_AMD ||
>> +		     dev->vendor == PCI_VENDOR_ID_HYGON) &&
>>   		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
>>   			u8 imc;
>>   
> 
> Patch looks good. I assume you have tested it on real hardware?

Yes, I have tested it on Hygon hardware. It works well.

> I would like you to also document the new supported chipset in
> drivers/i2c/busses/Kconfig and Documentation/i2c/busses/i2c-piix4 as
> well as in the header comment of i2c-piix4.c itself. I know it seems
> redundant but it helps the user know which driver they need.

Because Hygon uses the same PCI device ID of AMD's, so is it appropriate 
to document with the name "Hygon CZ" or just "Hygon"?

-- 
Regards,
Pu Wen
