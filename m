Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D972C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B42C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjfFf6n2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfEHUIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:08:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55162 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEHUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:08:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203so164799wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XHPdkWRxQaTT0W2poXD/4Nd9Euk4dE5H/Tw5WQByqrs=;
        b=VjfFf6n2EMQeUpdmdrN17Tg4L+m36EugLxPu3MTfpAnBFMUTGrr/dgi4CbRcoSLEca
         iQo9hMnl+o5qMLPSmnbeJM9dH1qPTcVCjnPwNRz4564/EOWF3dleVGEdkqjZ+XGQSML4
         UIRbaGDg/MJRhBYmRP58M+3SGIgrRug6qKSB9i1ZCBvWWZYYtJlnix9O1d2Lb7vw+4Tq
         PbjsZ21y4uCv/N9EtwtpxbavUmmmCIVXlssaGG3kpmzCykoo44mJHVrmJU5BQIFLbe4z
         7dwjyT27Yks1hCR6zxjVZ4bCvNxPHFCjWBXI5AkYIe6/U+KHe/nXKyvsCDtCU9zZyGkY
         T+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XHPdkWRxQaTT0W2poXD/4Nd9Euk4dE5H/Tw5WQByqrs=;
        b=DWBogTzECQjH2eMAscbXNFonF2Uz3NfL+8esuwvfi85VuAh5an42cN+wL0pPn1ZA9L
         l6XKoLWDg2epkr5JK858pDuUJGl63wdS84h6mdxBlGBS6zYpPJKVFwRodTOnERduDFcp
         DGyHJwp0fPqfz20a0Fd7+5pkxxhQUiV1goP1QW+hms5BHqaLBDZK29v8dwAZBNvaWOWq
         Y60+F3LXj4RTFnlNP1sYBYfRdtmS2V/UFxAdGX3rJvwIEep2EeJMnMEt67ky0c1hAJsM
         SE8sSbQO0Y5uCp2orq53Z6t98ykODD8/gpnhHewh2CgV3Jcp8UJmdhFnY0nNkb+OPilr
         IJSA==
X-Gm-Message-State: APjAAAX+kwGuH8s0tUhfMtd3yo4IXQJg+r7v3DvLdWrx/xpAkcn6X2T2
        iqdciPSvMyzl0V7TDIteivPVgolw
X-Google-Smtp-Source: APXvYqyUywHaW97+LZaAN4d+xvJAjyUCjd6ncE9980ICZWBpFnOyJ+tp8I1twvpZPzHnQJnGbUfKxA==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr41764wmb.101.1557346094643;
        Wed, 08 May 2019 13:08:14 -0700 (PDT)
Received: from ?IPv6:2a02:8071:6a3:700:484e:b84e:2cd2:80c0? ([2a02:8071:6a3:700:484e:b84e:2cd2:80c0])
        by smtp.gmail.com with ESMTPSA id o4sm4186961wmc.38.2019.05.08.13.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 13:08:13 -0700 (PDT)
Subject: Re: [PATCH] arm: socfpga: execute cold reboot by default
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Dalon Westergreen <dalon.westergreen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20190503091507.6159-1-simon.k.r.goldschmidt@gmail.com>
 <fd18f55e-2e18-44a3-7e76-e5e59984b729@kernel.org>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Message-ID: <078b9c11-f4b1-0767-bebc-daa4de37b2be@gmail.com>
Date:   Wed, 8 May 2019 22:07:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fd18f55e-2e18-44a3-7e76-e5e59984b729@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.05.2019 um 03:37 schrieb Dinh Nguyen:
> 
> 
> On 5/3/19 4:15 AM, Simon Goldschmidt wrote:
>> This changes system reboot for socfpga to issue a cold reboot by
>> default instead of a warm reboot.
>>
>> Warm reboot can still be used by setting reboot_mode to
>> REBOOT_WARM (e.g. via kernel command line 'reboot='), but this
>> patch ensures cold reboot is issued for both REBOOT_COLD and
>> REBOOT_HARD.
>>
>> Also, cold reboot is more fail safe than warm reboot has some
>> issues at least fo CSEL=0 and BSEL=qspi, where the boot rom does
>> not set the qspi clock to a valid range.
>>
>> Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
>> ---
>>
>> See discussion in this thread on the u-boot ML:
>> https://lists.denx.de/pipermail/u-boot/2019-April/367463.html
>> ---
>>   arch/arm/mach-socfpga/socfpga.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
>> index 816da0eb6..6abfbf140 100644
>> --- a/arch/arm/mach-socfpga/socfpga.c
>> +++ b/arch/arm/mach-socfpga/socfpga.c
>> @@ -85,10 +85,10 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
>>   
>>   	temp = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
>>   
>> -	if (mode == REBOOT_HARD)
>> -		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
>> -	else
>> +	if (mode == REBOOT_WARM)
>>   		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
>> +	else
>> +		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
>>   	writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
>>   }
>>   
>> @@ -98,10 +98,10 @@ static void socfpga_arria10_restart(enum reboot_mode mode, const char *cmd)
>>   
>>   	temp = readl(rst_manager_base_addr + SOCFPGA_A10_RSTMGR_CTRL);
>>   
>> -	if (mode == REBOOT_HARD)
>> -		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
>> -	else
>> +	if (mode == REBOOT_WARM)
>>   		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
>> +	else
>> +		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
>>   	writel(temp, rst_manager_base_addr + SOCFPGA_A10_RSTMGR_CTRL);
>>   }
>>   
>>
> 
> Applied, thanks! I think this patch needs to get back-ported into stable
> kernel version as well, right?

Well, it's certainly wrong as it was.

But as I saw myself, switching from warm to cold reset might have some 
implications that would at least in some configurations require changes 
to existing configurations to keep the board booting.

So while this certainly fixes a bug (warm reboot is executed instead of 
cold reboot like standard/requested), I don't know what's the standard 
procedure for a backport regarding fix vs. breaking boards.

Regards,
Simon
