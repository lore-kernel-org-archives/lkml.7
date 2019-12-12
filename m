Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C70C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798EC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSCqjRGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfLLMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:45:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37324 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729092AbfLLMpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576154711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8XMXlSrioOnOfeDKPU+ZNQ5TUt5nM7tjeiQ2QQ5IRM=;
        b=iSCqjRGfiX5/SWnu6TMCnTbAqSRZmWV9ltl5eHhQ/tBNvzIILUEM/Xjh1554PDiFfYd30k
        vyshiW+IgL6J57o/0c2XMAsvorMcarnA5ttrECIPQ/d6NH/TBs1/xr8agNf3jXDTtkBU3O
        /D/vjrj9yr0nyjQUr9HLghlad0IhxRk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-PGn84JiZPtGN4KZQRNAEGg-1; Thu, 12 Dec 2019 07:45:09 -0500
X-MC-Unique: PGn84JiZPtGN4KZQRNAEGg-1
Received: by mail-wm1-f69.google.com with SMTP id y125so1622520wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 04:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I8XMXlSrioOnOfeDKPU+ZNQ5TUt5nM7tjeiQ2QQ5IRM=;
        b=f+r7GlA3ZiFxqVgsIpFmU3q3iR1AsqWDISsVv40leNJE5eVJGVSTYcGyiYJPhCEfRq
         8MYmrJcDCInDfbCX/4sHBmSCVV32rbsfgRZGA3V1LgW8DsaKH/0QBcJUT2030RLUAkoK
         0ce+fhB55l63bkWWtOxFB69x++1l6FTLDbaXhCahW/1H3Ygz4qL8N3xB1QsZMJ3ByOHH
         DC+8l20P5CwjuOn5Q8gbNWRKF9Hf9VG/1jRFO2/dTrdho74dyPGTnrBk9V/RrP+VeKSu
         M7A4E493hfcARXF7nsdcS9D6f4SHKRXRGEip9JOZ0mDFH7HhOEgIl1+k2sQt5dQIoYve
         BySQ==
X-Gm-Message-State: APjAAAUgcgpZ9nNu04lirPGS/zfrKDg6oH1kOS6Jdvl7DYNWCEp8jwxV
        rR9xUXPflOtCWUUsEg0xv4+aupMA88m3Jbx/lXq3eeF8zsSAuofUsJLZfpr27MOecdh3xDhfwR8
        c4npNo7QrvpyveRK7jX50Ch4w
X-Received: by 2002:a1c:e909:: with SMTP id q9mr6714342wmc.30.1576154706785;
        Thu, 12 Dec 2019 04:45:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVtZo9PoHdbcef4Py9AQSp4/jHgWN059LxqFaFtahljOu3LTi9o5jxbXjjmDp3FweDwy6Qmg==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr6714317wmc.30.1576154706605;
        Thu, 12 Dec 2019 04:45:06 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id x10sm5873465wrv.60.2019.12.12.04.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 04:45:06 -0800 (PST)
Subject: Re: [PATCH 5.5 regression fix 2/2] efi/libstub/helper: Initialize
 pointer variables to zero for mixed mode
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <20191212103158.4958-1-hdegoede@redhat.com>
 <20191212103158.4958-3-hdegoede@redhat.com>
 <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <82c65f05-1140-e10e-ba2f-0c4c5c85bbc8@redhat.com>
Date:   Thu, 12 Dec 2019 13:45:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9AjYVvLot9+enuwSWfyfzqgCWSuW3ioccm3FJ7KFA8eA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-12-2019 12:29, Ard Biesheuvel wrote:
> On Thu, 12 Dec 2019 at 11:32, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> When running in EFI mixed mode (running a 64 bit kernel on 32 bit EFI
>> firmware), we _must_ initialize any pointers which are returned by
>> reference by an EFI call to NULL before making the EFI call.
>>
>> In mixed mode pointers are 64 bit, but when running on a 32 bit firmware,
>> EFI calls which return a pointer value by reference only fill the lower
>> 32 bits of the passed pointer, leaving the upper 32 bits uninitialized
>> unless we explicitly set them to 0 before the call.
>>
>> We have had this bug in the efi-stub-helper.c file reading code for
>> a while now, but this has likely not been noticed sofar because
>> this code only gets triggered when LILO style file=... arguments are
>> present on the kernel cmdline.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> index e02579907f2e..6ca7d86743af 100644
>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>> @@ -365,7 +365,7 @@ static efi_status_t efi_file_size(efi_system_table_t *sys_table_arg, void *__fh,
>>                                    u64 *file_sz)
>>   {
>>          efi_file_handle_t *h, *fh = __fh;
> 
> What about h? Doesn't it suffer from the same problem?
> 
>> -       efi_file_info_t *info;
>> +       efi_file_info_t *info = NULL;
>>          efi_status_t status;
>>          efi_guid_t info_guid = EFI_FILE_INFO_ID;
>>          unsigned long info_sz;
> 
> And info_sz?

And "efi_file_io_interface_t *io" and "efi_file_handle_t *fh"
in efi_open_volume().

I think that is all of them.

Regards,

Hans

