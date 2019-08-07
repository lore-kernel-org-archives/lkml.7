Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E41C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5620022305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ogFF0d2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbfHGTnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:43:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11240 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfHGTnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:43:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4b29ce0000>; Wed, 07 Aug 2019 12:43:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 07 Aug 2019 12:43:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 07 Aug 2019 12:43:09 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Aug
 2019 19:43:08 +0000
Subject: Re: [PATCH v2] x86/boot: save fields explicitly, zero out everything
 else
To:     David Laight <David.Laight@ACULAB.COM>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190731054627.5627-1-jhubbard@nvidia.com>
 <20190731054627.5627-2-jhubbard@nvidia.com>
 <531b38aaa15e4de79a5e27fd37c04351@AcuMS.aculab.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1ee72eca-1a09-0b71-f202-b1a909ca85b7@nvidia.com>
Date:   Wed, 7 Aug 2019 12:43:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <531b38aaa15e4de79a5e27fd37c04351@AcuMS.aculab.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565206990; bh=wV0TIhB96lEXdxg4ZAPSQCvLdj50VGvQwt3aeXxT47Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ogFF0d2ww1f1FI7jm+ek1zbUaul8cBYZf8dEYS5iLyy2PncViRJnI6L1paYfjr6WR
         vn8CvVZP1vTKFaOaL8GvV/v3Q8E/A9lH+b5gylKEUc2slbmFn6xqos9vSoZSdyfhrI
         ndDZ+2ulEbzXjsSld1Cac8vBKZpCJaoWC5m4MXuh2ql7Tvsp7NkGbO/ulZjolI9Nw7
         HSw5VWptsSNE0Cmtjpq8l8jL9x8b5G1UPf+CCDvlCyoy+v2baB+yy/PiR5FbSF+mm9
         MqN/SlZLGjUtAVt/y2on2Pf4rKSUc3916oMsRCwHjqyyPAiWBBeHNao5nDduU9Y5gh
         WMGv7AeZwDWqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 4:41 AM, David Laight wrote:
> From: john.hubbard@gmail.com
>> Sent: 31 July 2019 06:46
...
>>  	if (boot_params->sentinel) {
>> -		/* fields in boot_params are left uninitialized, clear them */
>> -		boot_params->acpi_rsdp_addr = 0;
>> -		memset(&boot_params->ext_ramdisk_image, 0,
>> -		       (char *)&boot_params->efi_info -
>> -			(char *)&boot_params->ext_ramdisk_image);
>> -		memset(&boot_params->kbd_status, 0,
>> -		       (char *)&boot_params->hdr -
>> -		       (char *)&boot_params->kbd_status);
>> -		memset(&boot_params->_pad7[0], 0,
>> -		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
>> -			(char *)&boot_params->_pad7[0]);
>> -		memset(&boot_params->_pad8[0], 0,
>> -		       (char *)&boot_params->eddbuf[0] -
>> -			(char *)&boot_params->_pad8[0]);
>> -		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
> ...
> 
> How about replacing the above first using:
> #define zero_struct_fields(ptr, from, to) memset(&ptr->from, 0, (char *)&ptr->to - (char *)&ptr->from)
> 	zero_struct_fields(boot_params, ext_ramdisk_image, efi_info);
> 	...
> Which is absolutely identical to the original code.
> 
> The replacing the define with:
> 	#define so(s, m) offsetof(typeof(*s), m)
> 	#define zero_struct_fields(ptr, from, to) memset((char *)ptr + so(ptr, from), 0, so(ptr, to) - so(ptr, from))
> which gcc probably doesn't complain about, but should generate identical code again.
> There might be an existing define for so().
> 

Hi David,

There was discussion about that [1], but preference ending up being to
flip this around, in order to more closely match the original intent
of this function (zero out everything except for certain carefully
selected fields), and to therefore be more likely to keep working if 
fields are added. 


[1] https://lore.kernel.org/lkml/alpine.DEB.2.21.1907252358240.1791@nanos.tec.linutronix.de/

thanks,
-- 
John Hubbard
NVIDIA
