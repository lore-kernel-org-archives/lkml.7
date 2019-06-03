Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48797C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CB927A2F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="JP4co7cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfFCOy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:54:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45416 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFCOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:54:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id w34so8410711pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6lhL0v3oBSXinZLkQu4SCQBSiJPYgQaRBquGwb8hr4s=;
        b=JP4co7cZmFmnKQk4jwMFldCrWamfwn0wrK2Zgum9GLuxfcGxIHwr+bK8btGXjtqkOQ
         INUU9IR3eDGonQOoBXToZmCjp0asrN5boxuVO/9LKETJgJ059b6Rz4AIsfWNcd6MRstF
         U4n2fJCnxwi9n/ASVbiLo8YDrw7/6Dp2bSKKcY2cB8P3YbIhO/KICn/o1TJ1bWxI1Otx
         rsuFDBSrdzd+d2SA9qUQVcNQiLOtWmrZWMf7QpRzp3Cdtw6sYuljY8SLCdqhgYPSNuZm
         0YIRlF4eoXKyeefYTcEDpuyXZEn9rPaHakIwCzdbhk2iC9jgtlDjsUVa9fHNT6dtJhf2
         iZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6lhL0v3oBSXinZLkQu4SCQBSiJPYgQaRBquGwb8hr4s=;
        b=sNSE+0aBw/+tPqPciJgqFnPYV1rjgBawUQvEpZq4kSgEKxKpRMThRAKfXXdTQXBMaI
         Td0HQ1W9KaC9gHwO+G4ALuUtGBeSgcjMzhB+I+njAiD+QUDhXHpxEXht3YpJORaUr95b
         z66e3RaX4kmkkSK+ocV7lMeqiPjGtati7e3RhqKCush/mLSkrKhPyHB3FOaf0y5Abyzp
         SQDxsDelTH2c3JYjE6lpkc6UyPjV4/qoR9OsP246/bxyyhIaRb4G6CSrHNYpkemSUMue
         xz0VnHpoaSDVDmmC1VxSAs4DmIlNF7SGxPSMH7TxJf8lcjewXypA/myjKgHmy63iISi4
         2HWA==
X-Gm-Message-State: APjAAAWV0OLdsdw1tqNrMvGSLdRi8piP2XKhUQF4w3Cv6eQ46MCONp9t
        OE9Th33Pun+9DGYQKWEYiNkqWA==
X-Google-Smtp-Source: APXvYqzDnrConxyCVmHEqEUUREoAEXInrsPuUrnuomzsJu558QdDsWXO0FVxu80xfw+MBrqY+K/lEQ==
X-Received: by 2002:a62:ac1a:: with SMTP id v26mr9082092pfe.184.1559573666749;
        Mon, 03 Jun 2019 07:54:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id n2sm13736019pgp.27.2019.06.03.07.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 07:54:26 -0700 (PDT)
Subject: Re: [PATCH v6 17/19] mips: Add support for generic vDSO
To:     Arnd Bergmann <arnd@arndb.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-18-vincenzo.frascino@arm.com>
 <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <200c39f5-3bff-cacb-57c9-e11c57df70f5@android.com>
Date:   Mon, 3 Jun 2019 07:54:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a29QXCP8nw7po06GeYEGvJ_y2GxjAvswFk3=Y6YCjbdDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/2019 01:34 AM, Arnd Bergmann wrote:
> On Thu, May 30, 2019 at 4:16 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>
>> --- a/arch/mips/vdso/vdso.lds.S
>> +++ b/arch/mips/vdso/vdso.lds.S
>> @@ -99,6 +99,10 @@ VERSION
>>          global:
>>                  __vdso_clock_gettime;
>>                  __vdso_gettimeofday;
>> +               __vdso_clock_getres;
>> +#if _MIPS_SIM != _MIPS_SIM_ABI64
>> +               __vdso_clock_gettime64;
>> +#endif
>>   #endif
>>          local: *;
>>          };
> Same comment as for the corresponding arm change: I'd leave the ABI
> changes to a separate patch, and probably not add __vdso_clock_getres
> at all.

Removing this would break ABI (would it really, it just replaces the 
syscall ... so it is more of a user space expectation)? already present 
in arm64 before this series.

-- Mark
