Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F56C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EB320840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o14OiLgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfHMNS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:18:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38633 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfHMNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:18:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id e11so689597pga.5;
        Tue, 13 Aug 2019 06:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHh4gRVuTNEz/9Zouanj7QoExBSgjZ5iFTJ9fA5JXDw=;
        b=o14OiLgVHhcWhq6SW9DwPfghLvr5el3qyk4ClwdcQ+5mAlcCVFkDGYySK48ObliEJK
         P/H+xc3kvb49yZ1abKJxfvHgMM3QmkzHF007ZKV5jXOaV02Eo8rMjUFqYZ6sUVbaNL+8
         AfRjpkbY+wZZVwnxgCQYDiEYk7orhJhT150t8m6+RhH4d+pIcS/rInoxx3gFYHSAhyWA
         RopGtcLkC7UE1sBZcOls+yhMCLpLHsP60u93J+Rbmihuhj5NPst2XuOR8bLF/HYtgq/e
         drXVR6tNqgzYaJtqpMLQ2UggsNP4zyFsOK4PZduVG4Uz0Ap39lQ0PQNsMBx1YhRr4l13
         2a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHh4gRVuTNEz/9Zouanj7QoExBSgjZ5iFTJ9fA5JXDw=;
        b=Na0PhHQ8JmnGjN5wXwwBKxJBdM5RdzZXGRIhb5r5kZln+72lpBNFysPWkVWbr3UW1e
         RnouXcXglcedTI+1LTDLiwrlakAyChp0TEYNlSZU0d6lzbdTuLqwFAO/aEB2GnYTA1+n
         15iupN181it3Dyp9nyPQ0YgrH/mIWUeWYgR0u8tSD2wJYcxjHm85BK0+qNXj7QJ6sNmY
         puimSOx/krJYGlpohdJnLiFEH7tIfA5Q6LAhBfxS2HPO6kKZsgRKMa27nMR4umO+caXC
         tdXqil28NWgZlTKPZ0FudgQjvGFzl9pxJDOhc00NHZOEfgSfuJkEdVvrzhmjD/FQ5iV5
         fzSw==
X-Gm-Message-State: APjAAAXY/Jx0GKH+UJ+V6rLl8oyYtfTMcfjZlw5ByX9Q8IlECBlWI3pL
        xK/1T/6/q6mMS/KltKQaVLxRIALO
X-Google-Smtp-Source: APXvYqwhuO8K9gkkF7I++N05w2HGY66rdTVi4eaylF9KWizW+4rFGBAyk+LHvO3bPfOFKS6DYolCcw==
X-Received: by 2002:a62:1515:: with SMTP id 21mr24148021pfv.81.1565702337439;
        Tue, 13 Aug 2019 06:18:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y194sm120339536pfg.116.2019.08.13.06.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:18:56 -0700 (PDT)
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <87a7cdpi06.wl-ysato@users.sourceforge.jp>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ee8b2e37-643d-9b29-b7de-d83c7739c3a0@roeck-us.net>
Date:   Tue, 13 Aug 2019 06:18:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87a7cdpi06.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 1:49 AM, Yoshinori Sato wrote:
> On Mon, 05 Aug 2019 11:14:23 +0900,
> Guenter Roeck wrote:
>>
>> Since commit a035d552a93b ("Makefile: Globally enable fall-through
>> warning"), all sh builds fail with errors such as
>>
>> arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
>> arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
>>
>> Since this effectively disables all build and boot tests for the
>> architecture, let's drop -Werror from the sh kernel Makefile until
>> the problems are fixed.
>>
>> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/sh/kernel/Makefile | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
>> index 59673f8a3379..ef65f0625c6c 100644
>> --- a/arch/sh/kernel/Makefile
>> +++ b/arch/sh/kernel/Makefile
>> @@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
>>   obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
>>   obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
>>   obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
>> -
>> -ccflags-y := -Werror
>> -- 
>> 2.7.4
>>
> 
> Applied sh-next.
> Sorry too late replay.
> 

Please note that _mainline_ builds are currently broken.

Guenter
