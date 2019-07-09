Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A62DC48BE7
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFED4214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aZUoCYjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfGILjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:39:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55779 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfGILjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:39:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so2707092wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YOQ/GCG+KtmJJJYXPhN1+uZC1uWfh6rqg2OW3RNJhCw=;
        b=aZUoCYjX0qi8OOGD3u8+SDakOXfcad8NlncaVfoEEOqLArMvCAYmlTfjxE4mPvMF9w
         GKlbTmoFa+qhb9+ELukjgtoCkGPi4i3n1VRohpkj8J/27yqjrjUpQNyrNGjlxwKZLtPn
         qJeykCTTqmjShYi4GpWTXIGYBnvCyiOiWYSj7VNMPOoykVgq2d2pmMoqAFXotLlh7MsU
         jEQdBnT8WrL1CyMbw021aAGw++5y6q6OOcKeHkwWCXe8rmWsFwnOLRzDis7KZs9VQ+K9
         JqJd258BQJEKlkqWxtTkDM9ofFg/FC3+QAswkzoEW9M3JjnhQXQUfCEe8sqjk8G9FTR6
         Q7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOQ/GCG+KtmJJJYXPhN1+uZC1uWfh6rqg2OW3RNJhCw=;
        b=ARfTLaLezIP8rMmc3B1aKeSZD42uXB+Lq+zFWnGBKCre3I5diQVtBN0Jwy6X8V4Sge
         O8ZxEp0Tzfrfcb9r7UHKmW/x/8eFtj3/YHARAVTv2qyp7rwspIi/iFBlMXH1s2WU/fpx
         vTzdFa5WV46n3KTc3DN65FLClaQv2Eb91Bv6SHdmk7b48mwA4hVZSuqVYubD0NNfMFPu
         whAr4910gKwKo/umkXnfj4bdhtRuzB0U59HL/pnmKj/Mr9eXHgHRkkzOddObu8QZIiqP
         8sq9DqxPY/sDNJlxhw1HKGrF2Mqd6OOZdIGbbZYMo67/SqZ2Y20JlIEiLk6dUa2ivsNN
         8fcQ==
X-Gm-Message-State: APjAAAVM3fBSUAAGIrFJG7wpWfR7C1olqDZo0PsCLvM9CRxc92/nOOMS
        hS9iuVqaasl5UIUE/uB47GwA7Ln3
X-Google-Smtp-Source: APXvYqyIVhRDopuKuELtqj+8M9R85MTDQRcrlwvad9E56bNgUYGbOMHvsYixS/tKsEvtyy6548wwxA==
X-Received: by 2002:a05:600c:114f:: with SMTP id z15mr22003774wmz.131.1562672379314;
        Tue, 09 Jul 2019 04:39:39 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.212.45])
        by smtp.googlemail.com with ESMTPSA id v204sm2610612wma.20.2019.07.09.04.39.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 04:39:38 -0700 (PDT)
Subject: Re: Warnings whilst building 5.2.0+
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>
References: <df7c7cfc-25cf-5b92-91ab-ac355b660233@googlemail.com>
 <d5f09396-a562-7989-8e5b-8337c9c9a036@metux.net>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <5276d608-e781-6190-e7df-bc22152b71c1@googlemail.com>
Date:   Tue, 9 Jul 2019 12:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d5f09396-a562-7989-8e5b-8337c9c9a036@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2019 11:37, Enrico Weigelt, metux IT consult wrote:
> On 09.07.19 08:06, Chris Clayton wrote:
> 
> Hi,
> 
>> I've pulled Linus' tree this morning and, after running 'make oldconfig', tried a build. During that build I got the
>> following warnings, which look to me like they should be fixed. 'git describe' shows v5.2-915-g5ad18b2e60b7 and my
>> compiler is the 20190706 snapshot of gcc 9.
> 
> Thanks for the report. I'm rebuilding right know anyways, so I'll look
> out for it.

Thanks for the reply.

>> In file included from arch/x86/kernel/head64.c:35:
>> In function 'sanitize_boot_params',
>>     inlined from 'copy_bootdata' at arch/x86/kernel/head64.c:391:2:
>> ./arch/x86/include/asm/bootparam_utils.h:40:3: warning: 'memset' offset [197, 448] from the object at 'boot_params' is
>> out of the bounds of referenced subobject 'ext_ramdisk_image' with type 'unsigned int' at offset 192 [-Warray-bounds]
>>    40 |   memset(&boot_params->ext_ramdisk_image, 0,
>>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    41 |          (char *)&boot_params->efi_info -
>>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    42 |    (char *)&boot_params->ext_ramdisk_image);
>>       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ./arch/x86/include/asm/bootparam_utils.h:43:3: warning: 'memset' offset [493, 497] from the object at 'boot_params' is
>> out of the bounds of referenced subobject 'kbd_status' with type 'unsigned char' at offset 491 [-Warray-bounds]
>>    43 |   memset(&boot_params->kbd_status, 0,
>>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    44 |          (char *)&boot_params->hdr -
>>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    45 |          (char *)&boot_params->kbd_status);
>>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Can you check older versions, too ? Maybe also trying older gcc ?
> 

I see the same warnings building linux-5.2.0 with gcc9. However, I don't see the warnings building linux-5.2.0 with the
the 20190705 of gcc8. So the warnings could result from an improvement (i.e. the problem was in the kernel, but
undiscovered by gcc8) or from a regression in gcc9.

> 
> --mtx
> 
