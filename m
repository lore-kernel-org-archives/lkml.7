Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345AE2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VjgOXv36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfHGGbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:31:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46063 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfHGGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:30:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1so3826268wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z8a+n4mRL103GwOLkv6UTaWbLAYpT2wk52qbgRYo5iY=;
        b=VjgOXv36egx/qZ+qiYY/PEzphP7jS9Jz+nlEykPJBrIht0TpdRjo0/KUuY04clAuBo
         zZ/9XoDrk3N2Kcq/nK5Aaee5AhdI8DEuO/3SSlDiviKXajIg+PTHQxgGzh9j1i6C5pVd
         xsM10Q6GT1rZLXtwmxAJ33ShiAOTrQF1jETiybPRn+sSONIdB0qo9vnxDQSJubHkVLOQ
         V5SJOPguV4IQ53Xg40lRHo6E6ZlHoiJ+oWzs2nO++pzKftJnET1YQ9Pp5bl218GOpB2J
         6bAhWq/F2Ea/+ihw6XlQWxPlC89ucL8S/oHlwYSs09y+kqjSts8ImqeEVWlrargijz+m
         DDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z8a+n4mRL103GwOLkv6UTaWbLAYpT2wk52qbgRYo5iY=;
        b=G95oodgzVQIa1d6qDBKF24RCDRYLHi+UpdN88mR3DpdO+pAujQfF2+5iD6APzUm2zP
         E+81xU2oEpPDXJbbqPPgKqNqExyffApmvG+L3hsnRh75GJ6T7hVZ/RjttnM+tkLpe8hh
         lXUcpkqNIpm5yM7/O/1vPkqrS3nlKBLiHlSYJFF9HxVu+wGojUnrM6I4BUrH9gD7HdZy
         f3aTu2QFlY2Qal43LqDYM74ZUqmmqkf7lePNtrVa5PMS3JfgL228TcazNbwn6OjwTE5Q
         qcMuIvyeVX9RkpcKdww8A6lnzxnK7tk0G2YrR4y6g0NVzI5rdJzIbI6i+fzcNXvKgK08
         p3eQ==
X-Gm-Message-State: APjAAAWTC/XUX1aYdEKagdCpNN00XMOLg6TJH76bzXuUHBsz2LaM15L8
        EBl00hwba3XnOlXzKE2SmLg=
X-Google-Smtp-Source: APXvYqxuh1qWMqtY6zrbnJ0nsx+rp9Iy/PQIdnYcpFKx0raPsARoia4fFOXd1KRnJUf7Z1Zfa9d8Mg==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr8297288wrp.116.1565159457174;
        Tue, 06 Aug 2019 23:30:57 -0700 (PDT)
Received: from [192.168.1.20] (host86-151-115-73.range86-151.btcentralplus.com. [86.151.115.73])
        by smtp.googlemail.com with ESMTPSA id 4sm209150684wro.78.2019.08.06.23.30.56
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 23:30:56 -0700 (PDT)
Subject: Re: Warnings whilst building 5.2.0+
From:   Chris Clayton <chris2553@googlemail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        jhubbard@nvidia.com, hpa@zytor.com
References: <df7c7cfc-25cf-5b92-91ab-ac355b660233@googlemail.com>
 <d5f09396-a562-7989-8e5b-8337c9c9a036@metux.net>
 <5276d608-e781-6190-e7df-bc22152b71c1@googlemail.com>
Message-ID: <e576372c-fda0-ef9f-346c-3e5c0e5fd4a3@googlemail.com>
Date:   Wed, 7 Aug 2019 07:30:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5276d608-e781-6190-e7df-bc22152b71c1@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2019 12:39, Chris Clayton wrote:
> 
> 
> On 09/07/2019 11:37, Enrico Weigelt, metux IT consult wrote:
>> On 09.07.19 08:06, Chris Clayton wrote:
>>
>> Hi,
>>
>>> I've pulled Linus' tree this morning and, after running 'make oldconfig', tried a build. During that build I got the
>>> following warnings, which look to me like they should be fixed. 'git describe' shows v5.2-915-g5ad18b2e60b7 and my
>>> compiler is the 20190706 snapshot of gcc 9.
>>
>> Thanks for the report. I'm rebuilding right know anyways, so I'll look
>> out for it.
> 
> Thanks for the reply.
> 
>>> In file included from arch/x86/kernel/head64.c:35:
>>> In function 'sanitize_boot_params',
>>>     inlined from 'copy_bootdata' at arch/x86/kernel/head64.c:391:2:
>>> ./arch/x86/include/asm/bootparam_utils.h:40:3: warning: 'memset' offset [197, 448] from the object at 'boot_params' is
>>> out of the bounds of referenced subobject 'ext_ramdisk_image' with type 'unsigned int' at offset 192 [-Warray-bounds]
>>>    40 |   memset(&boot_params->ext_ramdisk_image, 0,
>>>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    41 |          (char *)&boot_params->efi_info -
>>>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    42 |    (char *)&boot_params->ext_ramdisk_image);
>>>       |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ./arch/x86/include/asm/bootparam_utils.h:43:3: warning: 'memset' offset [493, 497] from the object at 'boot_params' is
>>> out of the bounds of referenced subobject 'kbd_status' with type 'unsigned char' at offset 491 [-Warray-bounds]
>>>    43 |   memset(&boot_params->kbd_status, 0,
>>>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    44 |          (char *)&boot_params->hdr -
>>>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    45 |          (char *)&boot_params->kbd_status);
>>>       |          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Can you check older versions, too ? Maybe also trying older gcc ?
>>
> 
> I see the same warnings building linux-5.2.0 with gcc9. However, I don't see the warnings building linux-5.2.0 with the
> the 20190705 of gcc8. So the warnings could result from an improvement (i.e. the problem was in the kernel, but
> undiscovered by gcc8) or from a regression in gcc9.
> 

From the discussion starting at https://marc.info/?l=linux-kernel&m=156401014023908, it would appear that the problem is
undiscovered by gcc8. Building a fresh pull of Linus' tree this morning (v5.3-rc3-282-g33920f1ec5bf), I see that the
warnings are still being emitted. Adding the participants in the other discussion to this one.

>>
>> --mtx
>>
