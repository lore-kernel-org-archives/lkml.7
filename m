Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE436C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C520859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 22:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smeStOpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbfFJWaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:30:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50329 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfFJWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:30:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so875419wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 15:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fbT63A8feDAWnRD9PwvyyhF5JzMpqdX42Kqafb2etr4=;
        b=smeStOpMIEjOJszONzm5ghukdYiF0kPlKus8RGmT1Y1yh8cKxUi9bRL8mms2v0CNSb
         CrrN6lwWkhmk6xpCcmtVhmiJsKvAszWCcT1e/KmfbJvYzhA0j4DeOW3/RpPrtwWQWqB+
         EJ/SnvPalP2PxiwOTCJstci/VHZ2OODdmwK3p+1zvIvQR79aE9L+/hP2WzmbG38r0/Aj
         ihbZm0Gg4/GbWfnVwKimQWM4+hL8kiCncc89YROevZVKNL60sye3lXmErL5j7aFigF+P
         Z07iPjGB0tSgb5/BQ8owtuV7fmK6nOtlZpIptXfcbivEECgO4rAtnEvtlD5b1dwqvwm0
         vfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fbT63A8feDAWnRD9PwvyyhF5JzMpqdX42Kqafb2etr4=;
        b=WvL51dc4KuEPIqSfx32s43KZBD2G2ZoH95KJLfJs3h5LCHlilDqVdkmd0oM99jVY7P
         fuLjMKF68pggqSwaG8M6btnPg4CU3QSfrYQNy/mV7JPz9f3ZOEhnMMq7mUcCpumi5Q54
         3uk/V1ouePScSamBGd8B4k5RaqVNXxk3IBCLw5TMpREMz8z5WIcxMvZVGWJrKTJ8x+Iv
         yo6CRTdXNIdlQzc+0Jp0ZTkvsaG3etNLc/mEJuYpUH5aJ+6f7ltU1a39LTlSJXJGjV0q
         cTUio7lV1S5aLpfiUNWQS3v8gBeAJHKxf+son1Mqx545qnNeRsT2veo8NO8/48u4VhhL
         WLyw==
X-Gm-Message-State: APjAAAXJDMpMOmSoMtdUnRZMmbbsNvPcL+54pTkP1+pWsSuliZYs4IZX
        qCfEeiJAr/PkP5r1LGstSw8=
X-Google-Smtp-Source: APXvYqyT8t/LhfIP/XtenFx+C5g4jPmOh4pN8plwXHVjpvKEns624RDN5ujHU2S+OxG9qwrrU+rpQg==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr12718454wmd.87.1560205813847;
        Mon, 10 Jun 2019 15:30:13 -0700 (PDT)
Received: from [10.67.49.123] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t6sm11785834wrp.14.2019.06.10.15.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 15:30:12 -0700 (PDT)
Subject: Re: [PATCH] lib/genalloc.c: Avoid de-referencing NULL pool
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Alexey Skidanov <alexey.skidanov@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Huang Shijie <sjhuang@iluvatar.ai>
References: <20190607234333.9776-1-f.fainelli@gmail.com>
 <20190610145141.332f9750fa986cd15586bb2d@linux-foundation.org>
 <d852c65a-f9fa-6be5-9cc2-683e0029fb03@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <138146b8-addb-9ed3-0222-8525223adb7f@gmail.com>
Date:   Mon, 10 Jun 2019 15:30:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d852c65a-f9fa-6be5-9cc2-683e0029fb03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 3:03 PM, Florian Fainelli wrote:
> On 6/10/19 2:51 PM, Andrew Morton wrote:
>> On Fri,  7 Jun 2019 16:43:31 -0700 Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>> With architectures allowing the kernel to be placed almost arbitrarily
>>> in memory (e.g.: ARM64), it is possible to have the kernel resides at
>>> physical addresses above 4GB, resulting in neither the default CMA area,
>>> nor the atomic pool from successfully allocating. This does not prevent
>>> specific peripherals from working though, one example is XHCI, which
>>> still operates correctly.
>>>
>>> Trouble comes when the XHCI driver gets suspended and resumed, since we
>>> can now trigger the following NPD:
>>>
>>> ...
>>>
>>> [   13.327884] f8c0: 0000000000000030 ffffffffffffffff
>>> [   13.332835] [<ffffff80083c0df8>] addr_in_gen_pool+0x4/0x48
>>> [   13.338398] [<ffffff80086004d0>] xhci_mem_cleanup+0xc8/0x51c
>>> [   13.344137] [<ffffff80085f9250>] xhci_resume+0x308/0x65c
>>> [   13.349524] [<ffffff80085e3de8>] xhci_brcm_resume+0x84/0x8c
>>> [   13.355174] [<ffffff80084ad040>] platform_pm_resume+0x3c/0x64
>>> [   13.360997] [<ffffff80084b91b4>] dpm_run_callback+0x5c/0x15c
>>> [   13.366732] [<ffffff80084b96bc>] device_resume+0xc0/0x190
>>> [   13.372205] [<ffffff80084baa70>] dpm_resume+0x144/0x2cc
>>> [   13.377504] [<ffffff80084bafbc>] dpm_resume_end+0x20/0x34
>>> [   13.382980] [<ffffff80080e0d88>] suspend_devices_and_enter+0x104/0x704
>>> [   13.389585] [<ffffff80080e16a8>] pm_suspend+0x320/0x53c
>>> [   13.394881] [<ffffff80080dfd08>] state_store+0xbc/0xe0
>>> [   13.400094] [<ffffff80083a89d4>] kobj_attr_store+0x14/0x24
>>> [   13.405655] [<ffffff800822a614>] sysfs_kf_write+0x60/0x70
>>> [   13.411128] [<ffffff80082295d4>] kernfs_fop_write+0x130/0x194
>>> [   13.416954] [<ffffff80081b5d10>] __vfs_write+0x60/0x150
>>> [   13.422254] [<ffffff80081b6b20>] vfs_write+0xc8/0x164
>>> [   13.427376] [<ffffff80081b7dd8>] SyS_write+0x70/0xc8
>>> [   13.432412] [<ffffff8008083180>] el0_svc_naked+0x34/0x38
>>> [   13.437800] Code: 92800173 97f6fb9e 17fffff5 d1000442 (f8408c03)
>>> [   13.444033] ---[ end trace 2effe12f909ce205 ]---
>>>
>>> The call path leading to this problem is xhci_mem_cleanup() ->
>>> dma_free_coherent() -> dma_free_from_pool() -> addr_in_gen_pool. If the
>>> atomic_pool is NULL, we can't possibly have the address in the atomic
>>> pool anyway, so guard against that.
>>>
>>
>> Arguably the caller shouldn't be pasing in a NULL pointer.  Perhaps we
>> couild do this as a convenience thing if addr_in_gen_pool(NULL) makes
>> some sort of semantic sense, but I'm having trouble convincing myself
>> that it does.
> 
> That is absolutely true, part of the problem is that there is a context
> imbalance here going on, which is why this condition can be triggered.
> The first time the XHCI descriptor memory is allocated, we are in
> sleepable context, but when we resume from system sleep, we are not. The
> allocation is checked properly against a NULL pool, but not the freeing.

On second thought it's probably fine to put the check in
dma_in_atomic_pool() to match what other parts of kernel/dma/remap.c do,
I will go ahead and do that.
-- 
Florian
