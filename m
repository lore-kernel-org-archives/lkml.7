Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5CEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2720685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 14:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WDKUOxmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfDVOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:30:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36747 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfDVOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 10:30:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck15so5917834plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ArldgXyAXu7r8SaMqXs/zXI4veqAyV+eA/nB9PbZS/s=;
        b=WDKUOxmZ+s+UMYz7/2matkO3h5JNNIeZBIR4EF0gbs08iTuma04lqp9OR0Uow7a9uK
         y3X+e98D7PlBsxT6y82ShVC4FT3QRsrSand1SOrKRqu7ovJhqN8CdQVZyZGdhnQcVcD/
         qo6LDz/7I/MkfwfHiX+YO6hzYfem6kMxIGs7rfXlif0pgsRLGtaedQsOZsTpbXHViD0/
         kQCDwU2vsYU+qMEUFcwbkrIbVkN1DGXb08PypdjAgid881lIUszjPiru1N7pnxgkiaqB
         ZJHRG89TFkIx6CA7Sk7Ep3pQrezexCvEkZL9A75ndFVxcebEfSR66UthSLHySWDga4pR
         //2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ArldgXyAXu7r8SaMqXs/zXI4veqAyV+eA/nB9PbZS/s=;
        b=fMfI+Ab4/MlBOSvPOXuGaZOvZ4g25lSpL7lXcptKMrT9bGzXPCa8b8Ply3dNUh/lkt
         ssun7UC16uLVn2eocftFc5RJU6zIGNf3XEl/7wIo/Q66tti80qWOug7/p71JvlwP4ybb
         9VqT+k0pAPHcKfDV7bFY4OQ1CYfhl+QN2juXTzYyuypPxdU6/wY53HkeH2TFa+FfbPg6
         LawRgwcQGnRafoNzjhfqwHi1eP6KYkweVfjigb73AuvMcoWM6+R0W/l/8qgP/aH7SfcB
         S8ze1y2dSKfabRmSluDUCO+W0srxnYODl4VvsgEfEDtKCgkZ71/Qs33R6OQq1eFGV9a/
         XLQQ==
X-Gm-Message-State: APjAAAXl2W7CPKTvjvd+bmxwCkXOGlBHdpWy76K2ax4kLqTo/h6CTn0U
        HFuHeiwPjXlVE14sJ79myhUDhw==
X-Google-Smtp-Source: APXvYqxD/qgxXc6ca83CQeYHe9AS8VTIaFnT2lZzeRMxI9KS4b/jF4kYvOzbapxCqAmdnS9Jz8uuNg==
X-Received: by 2002:a17:902:1103:: with SMTP id d3mr14373615pla.247.1555943444060;
        Mon, 22 Apr 2019 07:30:44 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c48c:1647:d18c:78c5? ([2601:646:c200:1ef2:c48c:1647:d18c:78c5])
        by smtp.gmail.com with ESMTPSA id j6sm16858630pfe.107.2019.04.22.07.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:30:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190422103449.GA75723@gmail.com>
Date:   Mon, 22 Apr 2019 07:30:40 -0700
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Transfer-Encoding: 7bit
Message-Id: <BFD71398-0BDC-4045-91E9-C70A22FF6E73@amacapital.net>
References: <20190421160600.GA31092@avx2> <20190421182842.GD35603@gmail.com> <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com> <20190421211007.GA30444@avx2> <20190422103449.GA75723@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2019, at 3:34 AM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> 
> * Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
>>>>> +++ b/arch/x86/kernel/task_size_64.c
>>>>> @@ -0,0 +1,9 @@
>>>>> +#include <linux/export.h>
>>>>> +#include <linux/sched.h>
>>>>> +#include <linux/thread_info.h>
>>>>> +
>>>>> +unsigned long _task_size(void)
>>>>> +{
>>>>> +    return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET :
>>>> TASK_SIZE_MAX;
>>>>> +}
>>>>> +EXPORT_SYMBOL(_task_size);
>>>> 
>>>> Good idea - but instead of adding yet another compilation unit, why not
>>>> 
>>>> stick _task_size() into arch/x86/kernel/process_64.c, which is the 
>>>> canonical place for process management related arch functions?
>>>> 
>>>> Thanks,
>>>> 
>>>>    Ingo
>>> 
>>> Better yet... since TIF_ADDR32 isn't something that changes randomly, 
>>> perhaps this should be a separate variable?
>> 
>> Maybe. I only thought about putting every 32-bit related flag under 
>> CONFIG_COMPAT to further eradicate bloat (and force everyone else to 
>> keep an eye on it, ha-ha).
> 
> Basically TIF_ADDR32 is only set for a task if set_personality_ia32() is 
> called, which function is called in the following circumstances:
> 
> - arch/x86/ia32/ia32_aout.c:load_aout_binary()
> 
>   This is in exec(), when a new binary is loaded for the current task, 
>   via search_binary_handler() and exec_binprm(). Ordering is 
>   synchronous, AFAICS there can be no race between TASK_SIZE users and 
>   the set_personality_ia32() call which is always for the current task.
> 
> - in COMPAT_SET_PERSONALITY(), which through macro detours ends up being 
>   in SET_PERSONALITY2(), which is used in fs/compat_binfmt_elf.c's 
>   load_elf_binary(), used in a similar fashion in exec() as the AOUT 
>   case above. One particular macro detour of note is that 
>   fs/compat_binfmt_elf.c #includes fs/binfmt_elf.c and re-defines the 
>   personality setting method to map to set_personality_ia32().
> 
> When set_personality_ia32() is called then TIF_ADDR32 is set 
> unconditionally, without any Kconfig variations.
> 
> TIF_ADDR32 is cleared:
> 
> - In set_personality_64bit(), when a 64-bit binary is loaded via 
>   fs/binfmt_elf.c.
> 
> - It also defaults to clear in the init task, which is inherited by the 
>   initial kernel threads and any user-space task they might end up 
>   executing.
> 
> So the conclusion is that IMO we can safely put TASK_SIZE into a new 
> thread_info()->task_size field, and:
> 
> - change ->task_size to the 32-bit address space in 
>   set_personality_ia32()
> 
> - change ->task_size to teh 64-bit address space in the init task and in 
>   set_personality_64bit().
> 
> This should cover it I think, unless I missed something.
> 

Are there really enough TASK_SIZE users to justify any of this?
